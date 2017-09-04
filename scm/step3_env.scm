(import (scheme base))
(import (scheme write))

(import (lib util))
(import (lib reader))
(import (lib printer))
(import (lib types))
(import (lib env))

(define (READ input)
  (read-str input))

(define (eval-ast ast env)
  (let ((type (and (mal-object? ast) (mal-type ast)))
        (value (and (mal-object? ast) (mal-value ast))))
    (case type
      ((symbol) (env-get env value))
      ((list) (mal-list (map (lambda (item) (EVAL item env)) value)))
      ((vector) (mal-vector (vector-map (lambda (item) (EVAL item env)) value)))
      ((map) (mal-map (alist-map (lambda (key value) (cons key (EVAL value env))) value)))
      (else ast))))

(define (EVAL ast env)
  (let ((type (and (mal-object? ast) (mal-type ast))))
    (if (not (eq? type 'list))
        (eval-ast ast env)
        (let ((items (mal-value ast)))
          (if (null? items)
              ast
              (case (mal-value (car items))
                ((def!)
                 (let ((symbol (mal-value (cadr items)))
                       (value (EVAL (list-ref items 2) env)))
                   (env-set env symbol value)
                   value))
                ((let*)
                 (let* ((env* (make-env env))
                        (binds (mal-value (cadr items)))
                        (binds (if (vector? binds) (vector->list binds) binds))
                        (form (list-ref items 2)))
                   (let loop ((binds binds))
                     (when (pair? binds)
                       (let ((key (mal-value (car binds))))
                         (when (null? (cdr binds))
                           (error "unbalanced list"))
                         (let ((value (EVAL (cadr binds) env*)))
                           (env-set env* key value)
                           (loop (cddr binds))))))
                   (EVAL form env*)))
                (else
                 (let* ((items (mal-value (eval-ast ast env)))
                        (op (car items))
                        (ops (cdr items)))
                   (apply op ops)))))))))

(define (PRINT ast)
  (pr-str ast #t))

(define repl-env (make-env #f))
(env-set repl-env '+ (lambda (a b) (mal-number (+ (mal-value a) (mal-value b)))))
(env-set repl-env '- (lambda (a b) (mal-number (- (mal-value a) (mal-value b)))))
(env-set repl-env '* (lambda (a b) (mal-number (* (mal-value a) (mal-value b)))))
(env-set repl-env '/ (lambda (a b) (mal-number (/ (mal-value a) (mal-value b)))))

(define (rep input)
  (PRINT (EVAL (READ input) repl-env)))

(define (readline prompt)
  (display prompt)
  (flush-output-port)
  (let ((input (read-line)))
    (if (eof-object? input)
        #f
        input)))

(define (main)
  (let loop ()
    (let ((input (readline "user> ")))
      (when input
        (guard
         (ex ((error-object? ex)
              (when (not (memv 'empty-input (error-object-irritants ex)))
                (display "[error] ")
                (display (error-object-message ex))
                (newline))))
         (display (rep input))
         (newline))
        (loop))))
  (newline))

(main)

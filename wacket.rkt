#lang racket

(provide wat-compile
         wat-module
         wat-export-func)

(define (wat-module expr)
  `(module ,expr))

(define (wat-export-func name body)
  `(func (export ,name) (result i32)
         ,@body))

(define (wat-number x)
  `(i32.const ,x))

(define (wat-compile-op op xs)
  (append
   (append* (for/list ([x xs]) (wat-compile x)))
   (for/list ([_ (in-range (sub1 (length xs)))])
     op)))

(define (wat-compile-func-args args)
  (for/list ([_ args])
    ;; TODO(#7): all of the arguments are hardcoded to i32
    '(param i32)))

(define (wat-compile-func name args body)
  ;; TODO(#8): all compiled functions are exported
  `(func (export ,(symbol->string name))
         ,@(wat-compile-func-args args)
         ;; TODO(#9): function result is hardcoded to i32
         (result i32)
         ,@(append*
            (for/list ([x body])
              (wat-compile x)))))

(define (wat-compile expr)
  (match expr
    [(list (quote +) xs ...)
     (wat-compile-op 'i32.add xs)]
    [(list (quote -) xs ...)
     (wat-compile-op 'i32.sub xs)]
    [(list (quote *) xs ...)
     (wat-compile-op 'i32.mul xs)]
    [(list (quote /) xs ...)
     (wat-compile-op 'i32.div_s)]
    [(list (quote define) (list name args ...) body ...)
     (wat-compile-func name args body)]
    [x #:when (integer? x) (list (wat-number x))]
    ;; TODO: compilation of local function variables is not support
    [unsupported (error "Cannot compile expression:" unsupported)]))


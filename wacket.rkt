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
    [x #:when (integer? x) (list (wat-number x))]
    [unsupported (error "Cannot compile expression:" unsupported)]))

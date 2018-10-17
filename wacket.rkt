#lang racket

(provide wat-compile
         wat-module
         wat-export-func
         wat-add)

(define (wat-module expr)
  `(module ,expr))

(define (wat-export-func name body)
  `(func (export ,name) (result i32)
         ,@body))

(define (wat-add . xs)
  xs)

(define (wat-compile expr)
  (define (wat-compile-impl expr acc)
    (match expr
      [(list (quote +) xs ...)
       (append
        (for/list ([_ (in-range (sub1 (length xs)))])
          'i32.add)
        (foldl wat-compile-impl
               acc
               xs))]
      [(list (quote -) xs ...)
       (append
        (for/list ([_ (in-range (sub1 (length xs)))])
          'i32.sub)
        (foldl wat-compile-impl
               acc
               xs))]
      [(list (quote *) xs ...)
       (append
        (for/list ([_ (in-range (sub1 (length xs)))])
          'i32.mul)
        (foldl wat-compile-impl
               acc
               xs))]
      [(list (quote /) xs ...)
       (append
        (for/list ([_ (in-range (sub1 (length xs)))])
          'i32.div_s)
        (foldl wat-compile-impl
               acc
               xs))]
      [x #:when (integer? x) (cons `(i32.const ,x) acc)]
      [unsupported (error "Cannot compile expression:" unsupported)]))
  (reverse (wat-compile-impl expr null)))

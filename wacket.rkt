#lang racket

(provide wat-compile
         wat-module
         wat-export-func
         wat-add
         wat-sub)

(define (wat-module expr)
  `(module ,expr))

(define (wat-export-func name body)
  `(func (export ,name) (result i32)
         ,@body))

(define (wat-op op xs)
  (append
   (for/list ([x xs])
     `(i32.const ,x))
   (for/list ([_ (in-range (sub1 (length xs)))])
     op)))

(define (wat-add xs)
  (wat-op 'i32.add xs))

(define (wat-sub xs)
  (wat-op 'i32.sub xs))

(define (wat-mul xs)
  (wat-op 'i32.mul xs))

(define (wat-number x)
  `(i32.const ,x))

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
      [x #:when (integer? x) (cons (wat-number x) acc)]
      [unsupported (error "Cannot compile expression:" unsupported)]))
  (reverse (wat-compile-impl expr null)))

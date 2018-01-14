#!/usr/bin/env racket
#lang racket

(require racket/pretty)

(define (wat-arith-func-value expr)
  (define (wat-arith-func-value-impl expr acc)
    (match expr
      [(list (quote +) xs ...)
       (append
        (for/list ([_ (in-range (- (length xs) 1))])
          'i32.add)
        (foldl wat-arith-func-value-impl
               acc
               xs))]
      [(list (quote -) xs ...)
       (append
        (for/list ([_ (in-range (- (length xs) 1))])
          'i32.sub)
        (foldl wat-arith-func-value-impl
               acc
               xs))]
      [(list (quote *) xs ...)
       (append
        (for/list ([_ (in-range (- (length xs) 1))])
          'i32.mul)
        (foldl wat-arith-func-value-impl
               acc
               xs))]
      [(list (quote /) xs ...)
       (append
        (for/list ([_ (in-range (- (length xs) 1))])
          'i32.div_s)
        (foldl wat-arith-func-value-impl
               acc
               xs))]
      [x (cons `(i32.const ,x) acc)]))
  (reverse (wat-arith-func-value-impl expr null)))

(pretty-write `(module
                   (func (export "foo") (result i32)
                         ,@(wat-arith-func-value (read)))))

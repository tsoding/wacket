#!/usr/bin/env racket
#lang racket

(require racket/pretty)
(require "wacket.rkt")

;;; TODO(#6): compiler only compiles first expresion from stdin
(pretty-write (wat-module
               (wat-compile (read))))

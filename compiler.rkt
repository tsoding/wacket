#!/usr/bin/env racket
#lang racket

(require racket/pretty)
(require "wacket.rkt")

(pretty-write (wat-module
               (wat-export-func
                "foo"
                (wat-compile (read)))))

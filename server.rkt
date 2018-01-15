#!/usr/bin/env racket
#lang racket

(require web-server/servlet-env
         web-server/http
         web-server/dispatchers/dispatch)

(serve/servlet (lambda (_) (next-dispatcher))
               #:servlet-path "/"
               #:extra-files-paths (list "./")
               #:port 3001
               #:launch-browser? #f)

# wacket

Racket to WebAssembly "compiler".

## Quick Start

1. Install [wabt][wabt]
2. Install [racket][racket]
3. `$ make`
4. `$ python -m SimpleHTTPServer 3001` for python 2.x or `python3 -m http.server 3001` for python 3.x
5. `$ <browser> http://localhost:3001/index.html`
8. Change math expression in the `foo.rkt` file and `make` again.

[wabt]: https://github.com/WebAssembly/wabt
[racket]: https://racket-lang.org/

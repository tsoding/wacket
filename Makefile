foo.wasm: foo.wat
	wat2wasm foo.wat

foo.wat: input.rkt wacket.rkt
	./wacket.rkt < input.rkt > foo.wat

.PHONY: clean

clean:
	rm -f foo.wat foo.wasm

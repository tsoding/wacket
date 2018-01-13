foo.wasm: foo.wat
	wat2wasm foo.wat

foo.wat: input.rkt main.rkt
	./main.rkt < input.rkt > foo.wat

.PHONY: clean

clean:
	rm -f foo.wat foo.wasm

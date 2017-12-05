.PHONY: run clean

run: with_input.asm
	spim -file with_input.asm
	@echo

with_input.asm: solution.asm input
	cat solution.asm input > with_input.asm

clean:
	rm with_input.asm

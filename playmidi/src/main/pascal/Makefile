
PROGRAM := playmidi

$(PROGRAM): $(PROGRAM).pas
	fpc -Mobjfpc -Sh -ghl $<

test: $(PROGRAM)
	./$< sarabande.mid 2> $@.err

clean:
	rm -fv $(PROGRAM) *.o *.ppu

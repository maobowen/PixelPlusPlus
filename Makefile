.PHONY : all
all : top.native

.PHONY : top.native
top.native :
	rm -f *.o
	ocamlbuild top.native

.PHONY : clean
clean :
	ocamlbuild -clean
	rm -rf top scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe

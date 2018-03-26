.PHONY : all
all : toplevel.native

.PHONY : toplevel.native
toplevel.native :
	rm -f *.o
	ocamlbuild -use-ocamlfind -pkgs llvm,llvm.analysis -cflags -w,+a-4 \
		toplevel.native

.PHONY : clean
clean :
	ocamlbuild -clean
	rm -rf toplevel scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe

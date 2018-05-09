# Author: Jiayang (jl4305), Yilan (yh2961), Bowen (bm2734), Nana (np2630), Yunxuan (ys3065)

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
	rm -rf toplevel.native scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe

	.text
	.file	"MicroC"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	$.L.str, %edi
	callq	load
	movq	%rax, 8(%rsp)
	movl	$.L.str.3, %edi
	callq	load
	movq	%rax, 16(%rsp)
	movq	8(%rsp), %rdi
	movq	%rax, %rsi
	callq	collage
	movq	%rax, 24(%rsp)
	movl	$.L.str.4, %esi
	movq	%rax, %rdi
	callq	save
	movq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	close
	movq	16(%rsp), %rdi
	xorl	%esi, %esi
	callq	close
	xorl	%eax, %eax
	addq	$56, %rsp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.Lfmt,@object           # @fmt
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt:
	.asciz	"%d\n"
	.size	.Lfmt, 4

	.type	.Lfmt.1,@object         # @fmt.1
.Lfmt.1:
	.asciz	"%g\n"
	.size	.Lfmt.1, 4

	.type	.Lfmt.2,@object         # @fmt.2
.Lfmt.2:
	.asciz	"%s\n"
	.size	.Lfmt.2, 4

	.type	.L.str,@object          # @.str
.L.str:
	.asciz	"./img2.png"
	.size	.L.str, 11

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"./img2.png"
	.size	.L.str.3, 11

	.type	.L.str.4,@object        # @.str.4
	.section	.rodata.str1.16,"aMS",@progbits,1
	.p2align	4
.L.str.4:
	.asciz	"./img3_collaged.png"
	.size	.L.str.4, 20


	.section	".note.GNU-stack","",@progbits

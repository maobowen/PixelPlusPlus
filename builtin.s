	.text
	.file	"MicroC"
	.globl	exp                     # -- Begin function exp
	.p2align	4, 0x90
	.type	exp,@function
exp:                                    # @exp
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -12(%rsp)
	movl	%esi, -16(%rsp)
	movl	$1, -24(%rsp)
	movl	$0, -20(%rsp)
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_2:                                # %while_body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	-24(%rsp), %eax
	imull	-16(%rsp), %eax
	movl	%eax, -24(%rsp)
	incl	-20(%rsp)
.LBB0_1:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rsp), %eax
	cmpl	-12(%rsp), %eax
	jl	.LBB0_2
# %bb.3:                                # %merge
	movl	-24(%rsp), %eax
	retq
.Lfunc_end0:
	.size	exp, .Lfunc_end0-exp
	.cfi_endproc
                                        # -- End function
	.globl	exp2                    # -- Begin function exp2
	.p2align	4, 0x90
	.type	exp2,@function
exp2:                                   # @exp2
	.cfi_startproc
# %bb.0:                                # %entry
	movsd	%xmm0, -24(%rsp)
	movl	%edi, -28(%rsp)
	movabsq	$4607182418800017408, %rax # imm = 0x3FF0000000000000
	movq	%rax, -40(%rsp)
	movl	$0, -44(%rsp)
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_2:                                # %while_body
                                        #   in Loop: Header=BB1_1 Depth=1
	movsd	-40(%rsp), %xmm0        # xmm0 = mem[0],zero
	mulsd	-24(%rsp), %xmm0
	movsd	%xmm0, -40(%rsp)
	incl	-44(%rsp)
.LBB1_1:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	-44(%rsp), %eax
	cmpl	-28(%rsp), %eax
	jl	.LBB1_2
# %bb.3:                                # %merge
	movsd	-40(%rsp), %xmm0        # xmm0 = mem[0],zero
	retq
.Lfunc_end1:
	.size	exp2, .Lfunc_end1-exp2
	.cfi_endproc
                                        # -- End function
	.globl	transpose               # -- Begin function transpose
	.p2align	4, 0x90
	.type	transpose,@function
transpose:                              # @transpose
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 8(%rsp)
	movl	$1, 60(%rsp)
	movl	$2, 28(%rsp)
	movl	$3, 24(%rsp)
	movl	$4, %edi
	callq	malloc
	movl	$1, init_arr_bn(%rip)
	movabsq	$8589934595, %rcx       # imm = 0x200000003
	movq	%rcx, init_arr_bn+4(%rip)
	movq	%rax, init_arr_bn+16(%rip)
	movq	$init_arr_bn, 32(%rsp)
	movl	$0, 4(%rsp)
	jmp	.LBB2_1
	.p2align	4, 0x90
.LBB2_5:                                # %merge
                                        #   in Loop: Header=BB2_1 Depth=1
	incl	4(%rsp)
.LBB2_1:                                # %while
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_3 Depth 2
	movl	4(%rsp), %eax
	cmpl	28(%rsp), %eax
	jge	.LBB2_6
# %bb.2:                                # %while_body
                                        #   in Loop: Header=BB2_1 Depth=1
	movl	$0, (%rsp)
	jmp	.LBB2_3
	.p2align	4, 0x90
.LBB2_4:                                # %while_body18
                                        #   in Loop: Header=BB2_3 Depth=2
	movl	4(%rsp), %eax
	movl	24(%rsp), %ecx
	imull	%eax, %ecx
	movl	(%rsp), %edx
	addl	%edx, %ecx
	leal	(%rcx,%rcx,2), %ecx
	movl	%ecx, 20(%rsp)
	imull	28(%rsp), %edx
	addl	%eax, %edx
	leal	(%rdx,%rdx,2), %eax
	movl	%eax, 16(%rsp)
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movslq	20(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	32(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	16(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	16(%rsp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, 52(%rsp)
	movl	20(%rsp), %ecx
	leal	1(%rcx), %edx
	movl	%edx, 56(%rsp)
	addl	$2, %eax
	movl	%eax, 44(%rsp)
	addl	$2, %ecx
	movl	%ecx, 48(%rsp)
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movslq	56(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	32(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	52(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	8(%rsp), %rax
	movq	16(%rax), %rax
	movslq	48(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	32(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	44(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	(%rsp)
.LBB2_3:                                # %while17
                                        #   Parent Loop BB2_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rsp), %eax
	cmpl	24(%rsp), %eax
	jl	.LBB2_4
	jmp	.LBB2_5
.LBB2_6:                                # %merge111
	movq	8(%rsp), %rdi
	movl	$1, %esi
	callq	close
	movq	8(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	(%rcx), %rdx
	movl	8(%rcx), %esi
	movq	16(%rcx), %rcx
	movq	%rdx, (%rax)
	movl	%esi, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	8(%rsp), %rax
	addq	$120, %rsp
	retq
.Lfunc_end2:
	.size	transpose, .Lfunc_end2-transpose
	.cfi_endproc
                                        # -- End function
	.globl	mtimes                  # -- Begin function mtimes
	.p2align	4, 0x90
	.type	mtimes,@function
mtimes:                                 # @mtimes
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rdi, 32(%rsp)
	movq	%rsi, 24(%rsp)
	movl	(%rsi), %eax
	movl	%eax, 4(%rsp)
	movl	(%rdi), %eax
	movl	%eax, 44(%rsp)
	movl	4(%rsi), %ecx
	movl	%ecx, 12(%rsp)
	movl	8(%rsi), %eax
	movl	%eax, 8(%rsp)
	cmpl	4(%rdi), %ecx
	jne	.LBB3_7
# %bb.1:                                # %entry
	cmpl	8(%rdi), %eax
	jne	.LBB3_7
# %bb.2:                                # %merge
	movl	4(%rsp), %ebx
	movl	12(%rsp), %ebp
	movl	8(%rsp), %r14d
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.12(%rip)
	movl	%ebp, init_arr_bn.12+4(%rip)
	movl	%r14d, init_arr_bn.12+8(%rip)
	movq	%rax, init_arr_bn.12+16(%rip)
	movq	$init_arr_bn.12, 16(%rsp)
	movl	$0, (%rsp)
	jmp	.LBB3_3
	.p2align	4, 0x90
.LBB3_4:                                # %while_body
                                        #   in Loop: Header=BB3_3 Depth=1
	movq	24(%rsp), %rax
	movq	16(%rax), %rax
	movslq	(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	32(%rsp), %rdx
	movq	16(%rdx), %rdx
	imull	(%rdx,%rcx,4), %eax
	movq	16(%rsp), %rdx
	movq	16(%rdx), %rdx
	movl	%eax, (%rdx,%rcx,4)
	incl	(%rsp)
.LBB3_3:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	(%rsp), %eax
	cmpl	4(%rsp), %eax
	jl	.LBB3_4
# %bb.5:                                # %merge73
	movq	16(%rsp), %rax
	jmp	.LBB3_6
.LBB3_7:                                # %then
	movl	$.Lfmt.11, %edi
	movl	$.L.str, %esi
	xorl	%eax, %eax
	callq	printf
	movq	24(%rsp), %rax
.LBB3_6:                                # %merge73
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end3:
	.size	mtimes, .Lfunc_end3-mtimes
	.cfi_endproc
                                        # -- End function
	.globl	collage                 # -- Begin function collage
	.p2align	4, 0x90
	.type	collage,@function
collage:                                # @collage
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rdi, 40(%rsp)
	movq	%rsi, 32(%rsp)
	movl	(%rsi), %eax
	movl	%eax, 12(%rsp)
	movl	(%rdi), %eax
	movl	%eax, 28(%rsp)
	movl	(%rsi), %ebx
	movl	4(%rsi), %ebp
	addl	(%rdi), %ebx
	addl	4(%rdi), %ebp
	movl	8(%rsi), %r14d
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.16(%rip)
	movl	%ebp, init_arr_bn.16+4(%rip)
	movl	%r14d, init_arr_bn.16+8(%rip)
	movq	%rax, init_arr_bn.16+16(%rip)
	movq	$init_arr_bn.16, 16(%rsp)
	movl	$0, 8(%rsp)
	jmp	.LBB4_1
	.p2align	4, 0x90
.LBB4_2:                                # %while_body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	8(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	16(%rsp), %rdx
	movq	16(%rdx), %rdx
	movl	%eax, (%rdx,%rcx,4)
	incl	8(%rsp)
.LBB4_1:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	8(%rsp), %eax
	cmpl	12(%rsp), %eax
	jl	.LBB4_2
# %bb.3:                                # %merge
	movl	$0, 8(%rsp)
	jmp	.LBB4_4
	.p2align	4, 0x90
.LBB4_5:                                # %while_body57
                                        #   in Loop: Header=BB4_4 Depth=1
	movq	40(%rsp), %rax
	movslq	8(%rsp), %rcx
	movq	16(%rax), %rax
	movl	(%rax,%rcx,4), %eax
	movq	16(%rsp), %rdx
	movl	12(%rsp), %esi
	addl	%ecx, %esi
	movq	16(%rdx), %rcx
	movslq	%esi, %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	8(%rsp)
.LBB4_4:                                # %while56
                                        # =>This Inner Loop Header: Depth=1
	movl	8(%rsp), %eax
	cmpl	28(%rsp), %eax
	jl	.LBB4_5
# %bb.6:                                # %merge86
	movq	16(%rsp), %rax
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end4:
	.size	collage, .Lfunc_end4-collage
	.cfi_endproc
                                        # -- End function
	.globl	rotate                  # -- Begin function rotate
	.p2align	4, 0x90
	.type	rotate,@function
rotate:                                 # @rotate
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$128, %rsp
	.cfi_def_cfa_offset 160
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rdi, 32(%rsp)
	movl	%esi, 68(%rsp)
	movl	(%rdi), %eax
	movl	%eax, 64(%rsp)
	movl	4(%rdi), %eax
	movl	%eax, 16(%rsp)
	movl	8(%rdi), %eax
	movl	%eax, 12(%rsp)
	cmpl	$180, %esi
	jne	.LBB5_4
# %bb.1:                                # %then
	movl	64(%rsp), %ebx
	movl	16(%rsp), %ebp
	movl	12(%rsp), %r14d
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.20(%rip)
	movl	%ebp, init_arr_bn.20+4(%rip)
	movl	%r14d, init_arr_bn.20+8(%rip)
	movq	%rax, init_arr_bn.20+16(%rip)
	movq	$init_arr_bn.20, 24(%rsp)
	movl	$0, 8(%rsp)
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_3:                                # %while_body
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	8(%rsp), %eax
	leal	(%rax,%rax,2), %ecx
	movl	%ecx, 60(%rsp)
	movl	64(%rsp), %ecx
	leal	3(%rax,%rax,2), %edx
	movl	%ecx, %esi
	subl	%edx, %esi
	negl	%edx
	movl	%esi, 56(%rsp)
	leal	1(%rax,%rax,2), %edi
	movl	%edi, 52(%rsp)
	incl	%esi
	movl	%esi, 44(%rsp)
	leal	2(%rax,%rax,2), %eax
	movl	%eax, 48(%rsp)
	leal	2(%rcx,%rdx), %eax
	movl	%eax, 40(%rsp)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	56(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	60(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	44(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	52(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	40(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	48(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	8(%rsp)
.LBB5_2:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	8(%rsp), %eax
	leal	2(%rax,%rax,2), %eax
	cmpl	64(%rsp), %eax
	jl	.LBB5_3
	jmp	.LBB5_18
.LBB5_4:                                # %else
	cmpl	$90, 68(%rsp)
	jne	.LBB5_11
# %bb.5:                                # %then117
	movl	64(%rsp), %ebx
	movl	12(%rsp), %ebp
	movl	16(%rsp), %r14d
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.21(%rip)
	movl	%ebp, init_arr_bn.21+4(%rip)
	movl	%r14d, init_arr_bn.21+8(%rip)
	movq	%rax, init_arr_bn.21+16(%rip)
	movq	$init_arr_bn.21, 24(%rsp)
	movl	$0, 8(%rsp)
	jmp	.LBB5_6
	.p2align	4, 0x90
.LBB5_10:                               # %merge218
                                        #   in Loop: Header=BB5_6 Depth=1
	incl	8(%rsp)
.LBB5_6:                                # %while124
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_8 Depth 2
	movl	8(%rsp), %eax
	cmpl	16(%rsp), %eax
	jge	.LBB5_18
# %bb.7:                                # %while_body125
                                        #   in Loop: Header=BB5_6 Depth=1
	movl	$0, 20(%rsp)
	jmp	.LBB5_8
	.p2align	4, 0x90
.LBB5_9:                                # %while_body127
                                        #   in Loop: Header=BB5_8 Depth=2
	movl	8(%rsp), %eax
	movl	12(%rsp), %ecx
	imull	%eax, %ecx
	movl	20(%rsp), %edx
	addl	%edx, %ecx
	leal	(%rcx,%rcx,2), %esi
	movl	%esi, 60(%rsp)
	movl	16(%rsp), %esi
	imull	%esi, %edx
	subl	%eax, %esi
	addl	%edx, %esi
	leal	(%rsi,%rsi,2), %eax
	movl	%eax, 56(%rsp)
	leal	1(%rcx,%rcx,2), %eax
	movl	%eax, 52(%rsp)
	leal	1(%rsi,%rsi,2), %eax
	movl	%eax, 44(%rsp)
	leal	2(%rcx,%rcx,2), %eax
	movl	%eax, 48(%rsp)
	leal	2(%rsi,%rsi,2), %eax
	movl	%eax, 40(%rsp)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	60(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	56(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	52(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	44(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	48(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	40(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	20(%rsp)
.LBB5_8:                                # %while126
                                        #   Parent Loop BB5_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	20(%rsp), %eax
	cmpl	12(%rsp), %eax
	jl	.LBB5_9
	jmp	.LBB5_10
.LBB5_11:                               # %else225
	cmpl	$-90, 68(%rsp)
	jne	.LBB5_18
# %bb.12:                               # %then229
	movl	64(%rsp), %ebx
	movl	12(%rsp), %ebp
	movl	16(%rsp), %r14d
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.22(%rip)
	movl	%ebp, init_arr_bn.22+4(%rip)
	movl	%r14d, init_arr_bn.22+8(%rip)
	movq	%rax, init_arr_bn.22+16(%rip)
	movq	$init_arr_bn.22, 24(%rsp)
	movl	$0, 8(%rsp)
	jmp	.LBB5_13
	.p2align	4, 0x90
.LBB5_17:                               # %merge330
                                        #   in Loop: Header=BB5_13 Depth=1
	incl	8(%rsp)
.LBB5_13:                               # %while236
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_15 Depth 2
	movl	8(%rsp), %eax
	cmpl	16(%rsp), %eax
	jge	.LBB5_18
# %bb.14:                               # %while_body237
                                        #   in Loop: Header=BB5_13 Depth=1
	movl	$0, 20(%rsp)
	jmp	.LBB5_15
	.p2align	4, 0x90
.LBB5_16:                               # %while_body239
                                        #   in Loop: Header=BB5_15 Depth=2
	movl	8(%rsp), %eax
	movl	12(%rsp), %ecx
	movl	%eax, %edx
	imull	%ecx, %edx
	movl	20(%rsp), %esi
	addl	%esi, %edx
	leal	(%rdx,%rdx,2), %edi
	movl	%edi, 60(%rsp)
	subl	%esi, %ecx
	imull	16(%rsp), %ecx
	addl	%eax, %ecx
	leal	(%rcx,%rcx,2), %eax
	movl	%eax, 56(%rsp)
	leal	1(%rdx,%rdx,2), %eax
	movl	%eax, 52(%rsp)
	leal	1(%rcx,%rcx,2), %eax
	movl	%eax, 44(%rsp)
	leal	2(%rdx,%rdx,2), %eax
	movl	%eax, 48(%rsp)
	leal	2(%rcx,%rcx,2), %eax
	movl	%eax, 40(%rsp)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	60(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	56(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	52(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	44(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	movslq	48(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	24(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	40(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	20(%rsp)
.LBB5_15:                               # %while238
                                        #   Parent Loop BB5_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	20(%rsp), %eax
	cmpl	12(%rsp), %eax
	jl	.LBB5_16
	jmp	.LBB5_17
.LBB5_18:                               # %merge
	movq	32(%rsp), %rdi
	movl	$1, %esi
	callq	close
	movq	32(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	(%rcx), %rdx
	movl	8(%rcx), %esi
	movq	16(%rcx), %rcx
	movq	%rdx, (%rax)
	movl	%esi, 8(%rax)
	movq	%rcx, 16(%rax)
	addq	$128, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end5:
	.size	rotate, .Lfunc_end5-rotate
	.cfi_endproc
                                        # -- End function
	.globl	scifi_filter            # -- Begin function scifi_filter
	.p2align	4, 0x90
	.type	scifi_filter,@function
scifi_filter:                           # @scifi_filter
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, 16(%rsp)
	movl	(%rdi), %ebx
	movl	%ebx, 4(%rsp)
	movq	4(%rdi), %r14
	leal	(,%rbx,4), %edi
	callq	malloc
	movl	%ebx, init_arr_bn.26(%rip)
	movq	%r14, init_arr_bn.26+4(%rip)
	movq	%rax, init_arr_bn.26+16(%rip)
	movq	$init_arr_bn.26, 8(%rsp)
	movl	$0, (%rsp)
	jmp	.LBB6_1
	.p2align	4, 0x90
.LBB6_2:                                # %while_body
                                        #   in Loop: Header=BB6_1 Depth=1
	movl	4(%rsp), %eax
	decl	%eax
	subl	(%rsp), %eax
	movl	%eax, 28(%rsp)
	movq	16(%rsp), %rax
	movq	16(%rax), %rax
	movslq	28(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	8(%rsp), %rcx
	movq	16(%rcx), %rcx
	movslq	(%rsp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	(%rsp)
.LBB6_1:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	(%rsp), %eax
	cmpl	4(%rsp), %eax
	jl	.LBB6_2
# %bb.3:                                # %merge
	movq	8(%rsp), %rdi
	movl	$180, %esi
	callq	rotate
	movq	16(%rsp), %rdi
	movl	$1, %esi
	callq	close
	movq	16(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	(%rcx), %rdx
	movl	8(%rcx), %esi
	movq	16(%rcx), %rcx
	movq	%rdx, (%rax)
	movl	%esi, 8(%rax)
	movq	%rcx, 16(%rax)
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end6:
	.size	scifi_filter, .Lfunc_end6-scifi_filter
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function apply_conv_filter
.LCPI7_0:
	.quad	4643176031446892544     # double 255
	.text
	.globl	apply_conv_filter
	.p2align	4, 0x90
	.type	apply_conv_filter,@function
apply_conv_filter:                      # @apply_conv_filter
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdi, -80(%rbp)
	movq	%rsi, -96(%rbp)
	movl	$0, -84(%rbp)
	movl	$0, -44(%rbp)
	jmp	.LBB7_1
	.p2align	4, 0x90
.LBB7_2:                                # %while_body
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	-96(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movq	16(%rax), %rax
	movl	(%rax,%rcx,4), %eax
	addl	%eax, -84(%rbp)
	leal	1(%rcx), %eax
	movl	%eax, -44(%rbp)
.LBB7_1:                                # %while
                                        # =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	movq	-96(%rbp), %rcx
	cmpl	(%rcx), %eax
	jl	.LBB7_2
# %bb.3:                                # %merge
	movq	%rsp, %rax
	leaq	-16(%rax), %r14
	movq	%r14, %rsp
	movq	-96(%rbp), %rcx
	movl	4(%rcx), %ecx
	movl	%ecx, -16(%rax)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rbx
	movq	%rbx, %rsp
	movq	-96(%rbp), %rdx
	movl	8(%rdx), %edx
	movl	%edx, -16(%rcx)
	movq	%rsp, %rdx
	leaq	-16(%rdx), %r15
	movq	%r15, %rsp
	movl	-16(%rax), %eax
	leal	-1(%rax), %esi
	shrl	$31, %esi
	leal	-1(%rax,%rsi), %eax
	sarl	%eax
	movl	%eax, -16(%rdx)
	movq	%rsp, %rax
	leaq	-16(%rax), %r12
	movq	%r12, %rsp
	movl	-16(%rcx), %ecx
	leal	-1(%rcx), %edx
	shrl	$31, %edx
	leal	-1(%rcx,%rdx), %ecx
	sarl	%ecx
	movl	%ecx, -16(%rax)
	movq	-80(%rbp), %rax
	movl	(%rax), %r13d
	movl	%r13d, -140(%rbp)
	movl	4(%rax), %ecx
	movl	%ecx, -124(%rbp)        # 4-byte Spill
	movl	%ecx, -88(%rbp)
	movl	8(%rax), %ecx
	movl	%ecx, -52(%rbp)
	movl	8(%rax), %eax
	movl	%eax, -120(%rbp)        # 4-byte Spill
	leal	(,%r13,4), %edi
	callq	malloc
	movl	%r13d, init_arr_bn.30(%rip)
	movl	-124(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, init_arr_bn.30+4(%rip)
	movl	-120(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, init_arr_bn.30+8(%rip)
	movq	%rax, init_arr_bn.30+16(%rip)
	movq	$init_arr_bn.30, -72(%rbp)
	movl	$0, -44(%rbp)
	jmp	.LBB7_4
	.p2align	4, 0x90
.LBB7_19:                               # %merge335
                                        #   in Loop: Header=BB7_4 Depth=1
	incl	-44(%rbp)
.LBB7_4:                                # %while71
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_6 Depth 2
                                        #       Child Loop BB7_12 Depth 3
                                        #         Child Loop BB7_14 Depth 4
	movl	-44(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jge	.LBB7_20
# %bb.5:                                # %while_body72
                                        #   in Loop: Header=BB7_4 Depth=1
	movl	$0, -48(%rbp)
	jmp	.LBB7_6
	.p2align	4, 0x90
.LBB7_18:                               # %else
                                        #   in Loop: Header=BB7_6 Depth=2
	movq	-80(%rbp), %rax
	movq	16(%rax), %rax
	movslq	-56(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-72(%rbp), %rdx
	movq	16(%rdx), %rdx
	movl	%eax, (%rdx,%rcx,4)
	movq	-80(%rbp), %rax
	movq	16(%rax), %rax
	movslq	-116(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-72(%rbp), %rdx
	movq	16(%rdx), %rdx
	movl	%eax, (%rdx,%rcx,4)
	movq	-80(%rbp), %rax
	movq	16(%rax), %rax
	movslq	-112(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-72(%rbp), %rdx
	movq	16(%rdx), %rdx
	movl	%eax, (%rdx,%rcx,4)
	incl	-48(%rbp)
.LBB7_6:                                # %while73
                                        #   Parent Loop BB7_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_12 Depth 3
                                        #         Child Loop BB7_14 Depth 4
	movl	-48(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jge	.LBB7_19
# %bb.7:                                # %while_body74
                                        #   in Loop: Header=BB7_6 Depth=2
	movl	-52(%rbp), %eax
	movl	-44(%rbp), %edx
	movl	%eax, %esi
	imull	%edx, %esi
	movl	-48(%rbp), %ecx
	addl	%ecx, %esi
	leal	(%rsi,%rsi,2), %edi
	movl	%edi, -56(%rbp)
	leal	1(%rsi,%rsi,2), %edi
	movl	%edi, -116(%rbp)
	leal	2(%rsi,%rsi,2), %esi
	movl	%esi, -112(%rbp)
	movl	(%r15), %esi
	cmpl	%esi, %edx
	js	.LBB7_18
# %bb.8:                                # %while_body74
                                        #   in Loop: Header=BB7_6 Depth=2
	addl	%esi, %edx
	cmpl	-88(%rbp), %edx
	jge	.LBB7_18
# %bb.9:                                # %while_body74
                                        #   in Loop: Header=BB7_6 Depth=2
	movl	(%r12), %edx
	movl	%ecx, %esi
	subl	%edx, %esi
	js	.LBB7_18
# %bb.10:                               # %while_body74
                                        #   in Loop: Header=BB7_6 Depth=2
	addl	%edx, %ecx
	cmpl	%eax, %ecx
	jge	.LBB7_18
# %bb.11:                               # %then
                                        #   in Loop: Header=BB7_6 Depth=2
	movl	$0, -108(%rbp)
	movl	$0, -104(%rbp)
	movl	$0, -100(%rbp)
	movl	$0, -64(%rbp)
	jmp	.LBB7_12
	.p2align	4, 0x90
.LBB7_16:                               # %merge221
                                        #   in Loop: Header=BB7_12 Depth=3
	incl	-64(%rbp)
.LBB7_12:                               # %while107
                                        #   Parent Loop BB7_4 Depth=1
                                        #     Parent Loop BB7_6 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB7_14 Depth 4
	movl	-64(%rbp), %eax
	cmpl	(%r14), %eax
	jge	.LBB7_17
# %bb.13:                               # %while_body108
                                        #   in Loop: Header=BB7_12 Depth=3
	movl	$0, -60(%rbp)
	jmp	.LBB7_14
	.p2align	4, 0x90
.LBB7_15:                               # %while_body110
                                        #   in Loop: Header=BB7_14 Depth=4
	movl	-64(%rbp), %eax
	movl	-44(%rbp), %ecx
	addl	%eax, %ecx
	subl	(%r15), %ecx
	imull	-52(%rbp), %ecx
	addl	-48(%rbp), %ecx
	movl	-60(%rbp), %edx
	addl	%edx, %ecx
	subl	(%r12), %ecx
	leal	(%rcx,%rcx,2), %esi
	movl	%esi, -136(%rbp)
	leal	1(%rcx,%rcx,2), %esi
	movl	%esi, -132(%rbp)
	leal	2(%rcx,%rcx,2), %ecx
	movl	%ecx, -128(%rbp)
	movq	-96(%rbp), %rcx
	imull	(%rbx), %eax
	addl	%edx, %eax
	movq	16(%rcx), %rcx
	cltq
	movl	(%rcx,%rax,4), %eax
	movq	-80(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-136(%rbp), %rdx
	imull	(%rcx,%rdx,4), %eax
	addl	%eax, -108(%rbp)
	movq	-96(%rbp), %rax
	movl	-64(%rbp), %ecx
	imull	(%rbx), %ecx
	addl	-60(%rbp), %ecx
	movq	16(%rax), %rax
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-80(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-132(%rbp), %rdx
	imull	(%rcx,%rdx,4), %eax
	addl	%eax, -104(%rbp)
	movq	-96(%rbp), %rax
	movl	-64(%rbp), %ecx
	imull	(%rbx), %ecx
	addl	-60(%rbp), %ecx
	movq	16(%rax), %rax
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-80(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-128(%rbp), %rdx
	imull	(%rcx,%rdx,4), %eax
	addl	%eax, -100(%rbp)
	incl	-60(%rbp)
.LBB7_14:                               # %while109
                                        #   Parent Loop BB7_4 Depth=1
                                        #     Parent Loop BB7_6 Depth=2
                                        #       Parent Loop BB7_12 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-60(%rbp), %eax
	cmpl	(%rbx), %eax
	jl	.LBB7_15
	jmp	.LBB7_16
	.p2align	4, 0x90
.LBB7_17:                               # %merge227
                                        #   in Loop: Header=BB7_6 Depth=2
	movl	-108(%rbp), %eax
	cltd
	idivl	-84(%rbp)
	movq	-72(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-56(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-104(%rbp), %eax
	cltd
	idivl	-84(%rbp)
	movq	-72(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-116(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-100(%rbp), %eax
	cltd
	idivl	-84(%rbp)
	movq	-72(%rbp), %rcx
	movq	16(%rcx), %rcx
	movslq	-112(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-48(%rbp)
	jmp	.LBB7_6
.LBB7_20:                               # %merge341
	movq	-80(%rbp), %rdi
	movl	$1, %esi
	callq	close
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rax
	movq	%rax, %rsp
	movl	$0, -16(%rcx)
	movsd	.LCPI7_0(%rip), %xmm0   # xmm0 = mem[0],zero
	cmpl	$2, (%rax)
	jle	.LBB7_22
	jmp	.LBB7_38
	.p2align	4, 0x90
.LBB7_37:                               # %merge459
                                        #   in Loop: Header=BB7_22 Depth=1
	incl	(%rax)
	cmpl	$2, (%rax)
	jg	.LBB7_38
.LBB7_22:                               # %while_body345
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_23 Depth 2
                                        #       Child Loop BB7_25 Depth 3
                                        #     Child Loop BB7_32 Depth 2
                                        #       Child Loop BB7_34 Depth 3
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rcx
	movq	%rcx, %rsp
	movl	$255, -16(%rdx)
	movq	%rsp, %rsi
	leaq	-16(%rsi), %rdx
	movq	%rdx, %rsp
	movl	$0, -16(%rsi)
	movl	$0, -44(%rbp)
	jmp	.LBB7_23
	.p2align	4, 0x90
.LBB7_30:                               # %merge389
                                        #   in Loop: Header=BB7_23 Depth=2
	incl	-44(%rbp)
.LBB7_23:                               # %while348
                                        #   Parent Loop BB7_22 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_25 Depth 3
	movl	-44(%rbp), %esi
	cmpl	-88(%rbp), %esi
	jge	.LBB7_31
# %bb.24:                               # %while_body349
                                        #   in Loop: Header=BB7_23 Depth=2
	movl	$0, -48(%rbp)
	jmp	.LBB7_25
	.p2align	4, 0x90
.LBB7_28:                               # %merge380
                                        #   in Loop: Header=BB7_25 Depth=3
	incl	-48(%rbp)
.LBB7_25:                               # %while350
                                        #   Parent Loop BB7_22 Depth=1
                                        #     Parent Loop BB7_23 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-48(%rbp), %esi
	cmpl	-52(%rbp), %esi
	jge	.LBB7_30
# %bb.26:                               # %while_body351
                                        #   in Loop: Header=BB7_25 Depth=3
	movq	-72(%rbp), %rsi
	movl	-44(%rbp), %edi
	imull	-52(%rbp), %edi
	addl	-48(%rbp), %edi
	leal	(%rdi,%rdi,2), %edi
	addl	(%rax), %edi
	movq	16(%rsi), %rsi
	movslq	%edi, %rdi
	movl	(%rsi,%rdi,4), %esi
	movl	%esi, -56(%rbp)
	cmpl	%esi, (%rcx)
	jle	.LBB7_27
# %bb.39:                               # %then374
                                        #   in Loop: Header=BB7_25 Depth=3
	movl	-56(%rbp), %esi
	movl	%esi, (%rcx)
.LBB7_27:                               # %merge373
                                        #   in Loop: Header=BB7_25 Depth=3
	movl	(%rdx), %esi
	cmpl	-56(%rbp), %esi
	jge	.LBB7_28
# %bb.29:                               # %then381
                                        #   in Loop: Header=BB7_25 Depth=3
	movl	-56(%rbp), %esi
	movl	%esi, (%rdx)
	incl	-48(%rbp)
	jmp	.LBB7_25
	.p2align	4, 0x90
.LBB7_31:                               # %merge395
                                        #   in Loop: Header=BB7_22 Depth=1
	movq	%rsp, %rdi
	leaq	-16(%rdi), %r8
	movq	%r8, %rsp
	movl	(%rdx), %edx
	subl	(%rcx), %edx
	movl	%edx, -16(%rdi)
	movl	$0, -44(%rbp)
	jmp	.LBB7_32
	.p2align	4, 0x90
.LBB7_36:                               # %merge453
                                        #   in Loop: Header=BB7_32 Depth=2
	incl	-44(%rbp)
.LBB7_32:                               # %while400
                                        #   Parent Loop BB7_22 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_34 Depth 3
	movl	-44(%rbp), %edx
	cmpl	-88(%rbp), %edx
	jge	.LBB7_37
# %bb.33:                               # %while_body401
                                        #   in Loop: Header=BB7_32 Depth=2
	movl	$0, -48(%rbp)
	jmp	.LBB7_34
	.p2align	4, 0x90
.LBB7_35:                               # %while_body403
                                        #   in Loop: Header=BB7_34 Depth=3
	movq	-72(%rbp), %rdx
	movl	-44(%rbp), %edi
	imull	-52(%rbp), %edi
	addl	-48(%rbp), %edi
	leal	(%rdi,%rdi,2), %edi
	movl	(%rax), %ebx
	addl	%edi, %ebx
	movq	16(%rdx), %rsi
	movslq	%ebx, %rbx
	movl	(%rsi,%rbx,4), %esi
	movl	%esi, -56(%rbp)
	subl	(%rcx), %esi
	xorps	%xmm1, %xmm1
	cvtsi2sdl	%esi, %xmm1
	xorps	%xmm2, %xmm2
	cvtsi2sdl	(%r8), %xmm2
	divsd	%xmm2, %xmm1
	mulsd	%xmm0, %xmm1
	cvttsd2si	%xmm1, %esi
	addl	(%rax), %edi
	movq	16(%rdx), %rdx
	movslq	%edi, %rdi
	movl	%esi, (%rdx,%rdi,4)
	incl	-48(%rbp)
.LBB7_34:                               # %while402
                                        #   Parent Loop BB7_22 Depth=1
                                        #     Parent Loop BB7_32 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-48(%rbp), %edx
	cmpl	-52(%rbp), %edx
	jl	.LBB7_35
	jmp	.LBB7_36
.LBB7_38:                               # %merge464
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rcx
	movq	(%rcx), %rdx
	movl	8(%rcx), %esi
	movq	16(%rcx), %rcx
	movq	%rdx, (%rax)
	movl	%esi, 8(%rax)
	movq	%rcx, 16(%rax)
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end7:
	.size	apply_conv_filter, .Lfunc_end7-apply_conv_filter
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

	.type	.Lfmt.3,@object         # @fmt.3
.Lfmt.3:
	.asciz	"%d\n"
	.size	.Lfmt.3, 4

	.type	.Lfmt.4,@object         # @fmt.4
.Lfmt.4:
	.asciz	"%g\n"
	.size	.Lfmt.4, 4

	.type	.Lfmt.5,@object         # @fmt.5
.Lfmt.5:
	.asciz	"%s\n"
	.size	.Lfmt.5, 4

	.type	.Lfmt.6,@object         # @fmt.6
.Lfmt.6:
	.asciz	"%d\n"
	.size	.Lfmt.6, 4

	.type	.Lfmt.7,@object         # @fmt.7
.Lfmt.7:
	.asciz	"%g\n"
	.size	.Lfmt.7, 4

	.type	.Lfmt.8,@object         # @fmt.8
.Lfmt.8:
	.asciz	"%s\n"
	.size	.Lfmt.8, 4

	.type	init_arr_bn,@object     # @init_arr_bn
	.bss
	.globl	init_arr_bn
	.p2align	4
init_arr_bn:
	.zero	24
	.size	init_arr_bn, 24

	.type	.Lfmt.9,@object         # @fmt.9
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt.9:
	.asciz	"%d\n"
	.size	.Lfmt.9, 4

	.type	.Lfmt.10,@object        # @fmt.10
.Lfmt.10:
	.asciz	"%g\n"
	.size	.Lfmt.10, 4

	.type	.Lfmt.11,@object        # @fmt.11
.Lfmt.11:
	.asciz	"%s\n"
	.size	.Lfmt.11, 4

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.16,"aMS",@progbits,1
	.p2align	4
.L.str:
	.asciz	"error! arr shape not equal!"
	.size	.L.str, 28

	.type	init_arr_bn.12,@object  # @init_arr_bn.12
	.bss
	.globl	init_arr_bn.12
	.p2align	4
init_arr_bn.12:
	.zero	24
	.size	init_arr_bn.12, 24

	.type	.Lfmt.13,@object        # @fmt.13
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt.13:
	.asciz	"%d\n"
	.size	.Lfmt.13, 4

	.type	.Lfmt.14,@object        # @fmt.14
.Lfmt.14:
	.asciz	"%g\n"
	.size	.Lfmt.14, 4

	.type	.Lfmt.15,@object        # @fmt.15
.Lfmt.15:
	.asciz	"%s\n"
	.size	.Lfmt.15, 4

	.type	init_arr_bn.16,@object  # @init_arr_bn.16
	.bss
	.globl	init_arr_bn.16
	.p2align	4
init_arr_bn.16:
	.zero	24
	.size	init_arr_bn.16, 24

	.type	.Lfmt.17,@object        # @fmt.17
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt.17:
	.asciz	"%d\n"
	.size	.Lfmt.17, 4

	.type	.Lfmt.18,@object        # @fmt.18
.Lfmt.18:
	.asciz	"%g\n"
	.size	.Lfmt.18, 4

	.type	.Lfmt.19,@object        # @fmt.19
.Lfmt.19:
	.asciz	"%s\n"
	.size	.Lfmt.19, 4

	.type	init_arr_bn.20,@object  # @init_arr_bn.20
	.bss
	.globl	init_arr_bn.20
	.p2align	4
init_arr_bn.20:
	.zero	24
	.size	init_arr_bn.20, 24

	.type	init_arr_bn.21,@object  # @init_arr_bn.21
	.globl	init_arr_bn.21
	.p2align	4
init_arr_bn.21:
	.zero	24
	.size	init_arr_bn.21, 24

	.type	init_arr_bn.22,@object  # @init_arr_bn.22
	.globl	init_arr_bn.22
	.p2align	4
init_arr_bn.22:
	.zero	24
	.size	init_arr_bn.22, 24

	.type	.Lfmt.23,@object        # @fmt.23
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt.23:
	.asciz	"%d\n"
	.size	.Lfmt.23, 4

	.type	.Lfmt.24,@object        # @fmt.24
.Lfmt.24:
	.asciz	"%g\n"
	.size	.Lfmt.24, 4

	.type	.Lfmt.25,@object        # @fmt.25
.Lfmt.25:
	.asciz	"%s\n"
	.size	.Lfmt.25, 4

	.type	init_arr_bn.26,@object  # @init_arr_bn.26
	.bss
	.globl	init_arr_bn.26
	.p2align	4
init_arr_bn.26:
	.zero	24
	.size	init_arr_bn.26, 24

	.type	.Lfmt.27,@object        # @fmt.27
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lfmt.27:
	.asciz	"%d\n"
	.size	.Lfmt.27, 4

	.type	.Lfmt.28,@object        # @fmt.28
.Lfmt.28:
	.asciz	"%g\n"
	.size	.Lfmt.28, 4

	.type	.Lfmt.29,@object        # @fmt.29
.Lfmt.29:
	.asciz	"%s\n"
	.size	.Lfmt.29, 4

	.type	init_arr_bn.30,@object  # @init_arr_bn.30
	.bss
	.globl	init_arr_bn.30
	.p2align	4
init_arr_bn.30:
	.zero	24
	.size	init_arr_bn.30, 24


	.section	".note.GNU-stack","",@progbits

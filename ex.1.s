	.file	"ex.c"
	.text
	.globl	x
	.data
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	2
	.globl	b
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	3
	.text
	.globl	ff
	.type	ff, @function
ff:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	%edi, -4(%rbp)

	movl	$3, %eax

	popq	%rbp
	ret
	.cfi_endproc

	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	movq	%rsp, %rbp

	movl	x(%rip), %eax
	movl	%eax, %edi
	call	ff
	movl	%eax, x(%rip)
	
	movl	$0, %eax

	popq	%rbp
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-16ubuntu3) 7.3.0"
	.section	.note.GNU-stack,"",@progbits

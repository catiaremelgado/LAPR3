.section .data

        .global inc
        .global state

.section .text
.global pcg32_random_r     #unsigned int pcg32_random_r(void)

pcg32_random_r:
	#prologue
        pushq %rbp                          # save the original value of %rbp
        movq %rsp, %rbp         	    # copy the current stack pointer to %rbp
        subq $8, %rsp           	    # allocate 8 bytes for local variables

        movq state(%rip), %rax
        movq %rax, -8(%rbp)		    #creation of oldstate
        movq inc(%rip), %rsi

        movabsq $6364136223846793005, %rcx  #prepares for multiplication
        imulq %rcx			    #A oldstate * 6364136223846793005UL
        orq $1, %rsi			    #B (inc|1)
        addq %rsi, %rax			    #A+B
        movq %rax, state(%rip)		    #updates the value of state

        movq -8(%rbp), %rax		    #copies the value of oldstate to %rax
        shrq $18, %rax			    #shift right 18 bits
	xor -8(%rbp), %rax		    #oldstate calculated previously xor original olstate
	shrq $27, %rax			    #shift right 27 bits (xorshifted %eax)

	movq -8(%rbp), %r8		    #copies the value of oldstate to %r8
	shrq $59, %r8			    #shift right 59 bits (rot %r8d)

	movl %r8d, %ecx			    #copies the value of rot to %ecx
	movl %eax, %edi		     	    #copies the value of xorshifted to %edi
	negl %ecx			    #C ~rot
	andl $31, %ecx			    #D rot and 31
	shll %ecx, %edi                     #E shift left D bits
	movl %r8d, %ecx
	shrl %ecx, %eax			    #F shift  rigth rot bits
	orl %edi, %eax			    #F or E

        #epilogue
        movq %rbp, %rsp         #retrieve the original rsp value
        popq %rbp               #restore the original rbp value

	ret

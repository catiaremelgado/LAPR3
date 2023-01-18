.section .data

.section .text
	.global sens_velc_vento

sens_velc_vento:

        pushq %rdi
    	pushq %rsi

    	movq $0,%rax

    	cmpb $-40, %sil 	#-2
        jle velc1

        cmpb $45,%sil 		#-1
        jle velc2

        cmpb $110,%sil 		#3
        jle velc3

        cmpb $190,%sil 		#4
        jle velc4

        jmp velc0

end:

	popq %rsi
	popq %rdi


    ret

velc0:
	movb $0,%r8b
    jmp adder


velc1:
    movb $-2, %r8b
    jmp adder

velc2:
    movb $-1, %r8b
    jmp adder

velc3:
    movb $3, %r8b
    jmp adder

velc4:
    movb $4, %r8b

adder:
    movb %r8b, %al
    addb %dil, %al

    cmpb $40,%al
    jg max

    cmpb $0,%al
    jl min

	jmp end

max:
    movb $40,%al
    jmp end

min:
    movb $0,%al
    jmp end

.section .data

.section .text
	.global sens_temp

sens_temp:

	pushq %rdi
	pushq %rsi
						#-127,128
	movq $0,%rax

	cmpb $-80, %sil 	#-2
    jle temp1

    cmpb $-30,%sil 		#-1
    jle temp2

    cmpb $30,%sil 		#0
    jle temp3

    cmpb $100,%sil 		#1
    jle temp4

    jmp temp0


end:

	popq %rsi
	popq %rdi


    ret

temp0:
	movb $0,%r8b
    jmp adder


temp1:
    movb $-2, %r8b
    jmp adder

temp2:
    movb $-1, %r8b
    jmp adder

temp3:
    movb $0, %r8b
    jmp adder

temp4:
    movb $2, %r8b

adder:
    movb %r8b, %al
    addb %dil, %al

    cmpb $37,%al
    jg max

    cmpb $-2,%al
    jl min
	jmp end

max:
    movb $37,%al
    jmp end

min:
    movb $-2,%al
    jmp end


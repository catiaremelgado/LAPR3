.section .data

.section .text
	.global sens_dir_vento

sens_dir_vento:

        pushq %rdi
    	pushq %rsi

    	movq $0,%rax

        cmpw $5730, %si     #-6
        jle dir1

        cmpw $10100,%si     #-4
        jle dir2

        cmpw $25000,%si     #4
        jle dir3

        cmpw $40535,%si     #7
        jle dir4

        jmp dir0

end:

	popq %rsi
	popq %rdi


    ret

dir0:
	movw $0,%r8w
    jmp adder

dir1:
    movw $-6, %r8w
    jmp adder

dir2:
    movw $-4, %r8w
    jmp adder

dir3:
    movw $4, %r8w
    jmp adder

dir4:
    movw $7, %r8w

adder:
    movw %r8w, %ax
    addw %di, %ax

    cmpw $360,%ax #se for 360 muda o valor da direção para 0 graus e não mantem no 360
        jg min

     cmpw $0,%ax
        jl max
	jmp end

min:
    movw $0,%ax
    jmp end

max:
    movw $359,%ax
    jmp end


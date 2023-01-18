

.section .text
	.global sens_humd_atm #global function

sens_humd_atm: //first argument %rdi = ult_hmd_atm,second argument %rsi=ult_pluv, %rdx=comp_rand ALWAYS RESERVE 8bytes in stack for any variable type

	#prologo
	pushq %rbp
	movq %rsp,%rbp
	
	subq $16,%rsp
	
	movb %dl,%al		#preparing random component for division by number (to allow better regulation of values)
	
	cmpb $0,%sil		#check if ult_pluv is zero (means no drastic changes)
	
	je notDrastic
	
	cmpb $0,%dl			#check value of random component
	
	jle negativeRand
	
	cbw
	
	movl $10, -16(%rbp)	#mod=((comp_rand/10)+ult_pluv)/5;
	
	idivb -16(%rbp)
	
	addb %sil,%al
	
	movb $5,-16(%rbp)
	
	cbw
	
	idivb -16(%rbp)
	
	jmp modify
	
negativeRand:			#mod=(comp_rand/5)/ult_pluv;
	
	cbw
	
	movl $5, -16(%rbp)
	
	idivb -16(%rbp)
	
	cbw
	
	idivb %sil
	
	jmp modify
	
notDrastic:			#mod=comp_rand/50

	cbw
	
	movb $50, -16(%rbp)
	
	idivb -16(%rbp)
	
	
modify:				#know final value and verify if the value is not over possible limits

	addb %dil,%al
	
	cmpb $0,%al			
	
	jle checkZero
	
	cmpb $100,%al
	
	jle end
	
	movb $100,%al			
	
	jmp end
	
checkZero:

	movb $0,%al
	
end:
	#epilogo
	
	movq %rbp,%rsp
	popq %rbp
			
	
	ret

	
	
	

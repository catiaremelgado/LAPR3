
.section .text
	.global sens_pluvio #global function

sens_pluvio: //first argument %rdi = ult_pluvio,second argument %rsi=ult_temp, %rdx=comp_rand ALWAYS RESERVE 8bytes in stack for any variable type

	#prologo
	pushq %rbp
	movq %rsp,%rbp
	
	subq $16,%rsp
	
	
	movb %dl,%al		#preparing random component for division by 2 (to allow better regulation of values)
	
	cmpb $0,%dl
	
	jle negativeRand
	
	cbw
	
	movl $2, -16(%rbp)
	
	idivb -16(%rbp)
	
	cbw
	
	cmpb $0,%sil
	
	je end
	
	idivb %sil
	
	jmp modify
	
negativeRand:
	
	cbw
	
	movl $10, -16(%rbp)
	
	idivb -16(%rbp)
	
	movb %al, -8(%rbp)		#saving comp_rand/10
	
	movb %sil,%al			#prepare division of last temperature
	
	cbw
	
	movl $10, -16(%rbp)
	
	idivb -16(%rbp)
	
	imulb -8(%rbp)		#multiply comp_rand/10 by ult_temp/10
		
	cmpb $0,%dil		#ult_pluvio==0?
	
	jne modify
	
	movb $0,%al
	
	jmp end
	
modify:

	addb %dil,%al
	
	cmpb $0,%al			#check if result of calculations is not negative (there is no such thing as negative precipitation)
	
	jge end
	
	movb $0,%al			#if so, that means there is no precipitation
	
end:
	
	#epilogo
	
	movq %rbp,%rsp
	popq %rbp
			
	
	ret

	
	
	

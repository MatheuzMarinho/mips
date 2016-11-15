# matriz = a0 vetor= a1 i = a2 j = a3

addi $t0,$zero,2 # a= 2
addi $t1,$zero,3# b= 3



while:
	lw $t2,32($a0) # t2 = matriz[8]
	lw $t3,12($a1) # t3= vetor[3]
	add $t3,$t2,$t2 # t3 x 2
	slt $t4,$t2,$t3 # t2>t3 -> 0
	beq $t4,$zero,operacao # se t2>t3 -> entra no while
	slt $t4,$t0,$a2 # se a<i -> 1
	beq $t4,$zero,exit # se a>i -> exit
	slt $t4,$t1,$a3 # se b>j -> 0
	bne $t4,$zero,exit # se b<j -> exit
operacao:
	sw $a2,20($a1) # vet[5] = i
	addi $sp,$sp,-8 #aloca 2 espaços na pilha
	sw $a1,0($sp) # salva vet na posição 0
	sw $ra,4($sp) # salva ra na posição 3
	add $a1,$a2,$zero # a1 = i
	jal proc2
	lw $a1, 0($sp) # a1 = vet
	lw $ra, 4($sp) # ra= ra da pilha
	add $a3,$v0,$zero # j = proc2
	addi $sp,$sp,16 # balanceamento da pilha
	j while

exit:
	slt $t4,$t1,$t0 # se b>a -> 0
	bne $t4,$zero,return2
	lw $v0,16($a0) # v0 = matriz[4]
	jr $ra #fim
return2: 
	lw $v0, $t0 # v0= a
	jr $ra #fim
 	
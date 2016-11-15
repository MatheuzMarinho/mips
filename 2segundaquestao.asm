proc1:
	add $t5,$a1,$zero #add em t5 o valor de a0 = vetor A
	add $t6,$a2,$zero #add em t6 o valor de a1 = vetor B
	add $t7,$a3,$zero #add em t7 o valor de a2 = vetor C
	addi $t4,$zero,5 #add em t4= 5
	addi $t8,$zero,0 #add t8 = 0 = cont
	
while:
	lw $t0,0($t5) # carrega o valor de A[]
	beq $t0,$t4,exit # se t0 = 5 exit
	lw $t1,0($t6) #carrega o valor de B[]
	beq $t1,$t4,exit #se t1 = 5 exit
	slt $t2,$t0,$t1 # se t0<t1 ->1
	beq $t2,$zero,adicionaA
	sw $t1,0($t7) # add B em C
	j out
	
adicionaA:
	sw $t0,0($t7) #add A em C
out:
	addi $t8,$t8,1 #cont++
	addi $t5,$t5,4 # A++
	addi $t6,$t6,-4 #B--
	addi $t7,$t7,4 # C++
	j while
exit:
	jr $ra
	
	

		
	
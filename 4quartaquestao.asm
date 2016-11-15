
#s0 = save s1 = teste s2= i s3 = j

while:
	add $t1,$s2,$s2 # i * 2
	add $t1,$t1,$t1 # I*4
	add $t1,$t1,$s0 # add i + o endereço do save
	add $t2,$s3,$s3 #j * 2
	add $t2,$t2,$t2 # j*4
	add $t2,$t2,$s1 # add j + o endereço do test
	lw $t3,0($t1) # save [i]
	lw $t4,0($t2) # test [j]
	beq $t3,$t4,fim # se t3=t4 -> fim
	lw $t5,4($t3) # t5 = save i+1
	bne $s2,$s3,else # se i != j
	addi $t5,$t5,2 # t5 + 2
	j fim_while
else:	
	addi $t5,$t5,-2 # t5 + 2
fim_while:
	sw $t5,0($t3) # save[i] = t5
	add $s2,$s2,$s3 # i = i +j
	j while
fim:
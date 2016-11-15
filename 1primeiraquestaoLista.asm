primeira questão da lista.

# i = $a0 j $a1 matriz a2 vetor a3

proc1: 
lw $t0,32($a3) # carrega o vetor[8] - > t0
lw $t1,16($a2) # carrega a matriz [4] -> t1

slt $t2,$t1,$t0 # t1<t0 -> 1
beq $t2,$zero,fim # se t2= 0 vai pro fim.
addi $sp,$sp,-20 # volta a pilha

sw $a0,0($sp)
sw $a1,4($sp)
sw $a2,8($sp)
sw $a3,12($sp)
sw $ra,16($sp)

add $a2,$zero,$t0 # a2 = vetor[8]
jal proc2
lw $a2,12($sp) #a2= vetor[]
add $t1,$v0,$zero # matriz[4] = proc 2(vetor[8]
sw $t1,16($a2) # salva na matriz o valor de t1
add $a0,$a1,$zero # a0 = j
jal proc3
lw $a1,4($sp) # a1= j
lw $a0,0($sp) #a0 = i
add $a1,$v0,$a0 # j = proc3[j] + i
lw $a3,12($sp) # a3 recebe o valor da pilha
lw $ra,16($sp) # ra recebe o valor da pilha

addi $sp,$sp,20 #balancear a pilha

j proc1

fim: 
	lw $v0,$a1 #carrega no v0 o valor de J
	jr $ra



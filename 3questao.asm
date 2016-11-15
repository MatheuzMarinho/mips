# a0 = matriz a1 = vetor  a2 = i a3 = j

j proc1

func_mult: # recebe a0 e a1
add $t0,$zero,$zero #t0= cont = 0
add $t1,$zero,$zero # acumulador = 0

while_mult:
slt $t2,$t0,$a1 # se cont<a1 ->1
beq $t2,$zero,fim_while_mult #se cont>a1
add $t1,$t1,$a0 # acumulador= acumulador+a0
addi $t0,$t0,1 # cont++
j while_mult

fim_while_mult:
add $v0,$t1,$zero
jal $ra

fim_func_mult:


func_div:
add $t0,$zero,$zero #t0= cont = 0
add $t1,$zero,$a0 # acumulador = a0

while_div:
slt $t2,$t1,$a1 # se acumulador<a1 (divisor) ->1
bne $t2,$zero,fim_while_div #se acumulador menor que divisor fim
sub $t1,$t1,$a1 # acumulado= acumulador-a1
addi $t0,$t0,1 #cont++
j while_div

fim_while_div:
add $v0,$t0,$zero #v0 = cont




proc1:

addi $t0,$zero,3 # A
addi $t1,$zero,6 # B

lw $t2,16($a1) # t2=vet[4]

slt $t3,$t1,$t2 # B>Vet ->0
bne $t3,$zero,fimproc # se B<vet -> fim

addi $sp,$sp,-28
sw $a0,0($sp)
sw $a1,4($sp)
sw $a2,8($sp)
sw $a3,12($sp)
sw $t1,16($sp)# B
sw $t0,20($sp)# A
sw $ra,24($sp)

add $a0,$t1,$zero # a0 =B
jal proc3
addi $sp,$sp,-4
sw $v0,0($sp) # guarda proc3


 

while:
lw $a3,24($sp) # carrega A
lw $a2,16($sp) # carrega J
jal proc2 
add $a0,$v0,$zero # carrega proc2
lw $a1,0($sp)# carrega proc3
jal func_mult
lw $t0,4($sp) # carrega matriz
lw $t0,20($t0) # carrega matriz[5]
slt $t2,$t0,$v0 # se matriz>multi -> 0
bne $t2,$zero,fimwhile # se matriz<mult -> fim while
lw $t1,20($sp) # carrega B
add $t1,$t1,$t0 # B+mat[5]
sw $t1,24($sp) # salva A na pilha
j while
fimwhile:
lw $a3,24($sp) # carrega A
lw $a2,16($sp) # carrega J
jal proc2
lw $a0,0($sp)# carrega proc3
add $a1,$zero,$v0 # carrega proc2
jal func_div
lw $a1,8($sp) #carrega vetor
sw $v0,16($t0) #salva div em vetor[4]
addi $sp,$sp,4 # passa 4 na pilha
lw $t0,20($sp) # carrega A
lw $ra,24($sp) # carrega RA
addi $sp,$sp,28 # balancea a pilha

fimproc:
add $v0,$t0,$zero # v0=A
lw $v1,16($a1) # v1= vet[4]
jr $ra



	 



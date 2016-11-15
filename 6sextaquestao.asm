#calculo da media aritimetrica de um vetor com 10 posicoes

.data
vetor: .space 40 # criando o vetor de 10 posições
.text


j inicio

preencher_vetor:
addi $t1,$zero,0 # t1 = cont = 0

while_proc:

slt $t4,$t1,$a1 # se cont<10 ->1
beq $t4,$zero,exit_preencher_vetor # se cont>10 -> while
addi $sp,$sp,-4 # volta a pilha
sw $ra,0($sp)
jal le_inteiro_do_teclado  # chama função para ler
la  $t7, 0($v0)		   # carrega o inteiro lido em $t7
sw $t7,0($a0) # dado lido para posicao atual do vetor
addi $t1,$t1,1 # cont++
addi $a0,$a0,4 # anda a posicao do vetor
lw $ra,0($sp)
addi $sp,$sp,4 # volta a pilha
j while_proc 

exit_preencher_vetor:
	jr $ra


le_inteiro_do_teclado:
		li $v0, 5	# código para ler um inteiro
		syscall		# executa a chamada do SO para ler
		jr $ra		# volta para o lugar de onde foi chamado 



somatorio_vetor:
add $t0,$zero,$zero #t0 = acumulador =0
add $t1,$zero,$zero # t1 = cont = 0

while:
slt $t4,$t1,$a1 # cont<10 -> 1
beq $t4,$zero,fim_somatorio_vetor # se cont > 10 exit
lw $t5,0($a0) # t5 = vet[posicaoatual]
add $t0,$t0,$t5 # acumulador = acumulador + t5
addi $t1,$t1,1 # cont++
addi $a0,$a0,4 # anda a posicao do vetor
j while



fim_somatorio_vetor:
	add $v0,$t0,$zero
	jr $ra






inicio:
la $s0,vetor # s0 = vetor
addi $s1,$zero,10 # s1= 10
add $a0,$zero,$s0 # a0 = vetor
add $a1,$zero,$s1 # a1 = 10

jal preencher_vetor

add $a0,$zero,$s0 # a0 = vetor
add $a1,$zero,$s1 # a1 = 10

jal somatorio_vetor

add $t2,$v0,$zero # carrega em t2 o valor de v0 = somatorio
addi $t1,$zero,0 # cont = 0


divisao:	
	slt $t4,$t2,$s1 # se acumulador<10 -> 1
	bne $t4,$zero,exit
	addi $t2,$t2,-10 # t4 = t4 - 10
	addi $t1,$t1,1 # cont ++
	j divisao
exit:
		li $v0, 1	# código para imprimir um inteiro
		la $a0, ($t1)	# $a0 é o registrador que irá conter o valor a ser impresso
		syscall		# executa a chamado do SO para imprimir
	
	
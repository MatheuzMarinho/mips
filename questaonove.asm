.data
vetor: .space 40
vetor_totais: .space 12
$msg1: .asciiz  "Bem vindo! \nEscolha a opcao desejada\n1 - Para cadastrar\n2 - Relatorios\nDigite a opcao:  " #declara variavel msg
$msg2: .asciiz  "Escolha a cor do computador:\n1 - Azul\n2 - Amarelo\n3 - Verde\n" #declara variavel msg2 
$msg3: .asciiz  "Digite o numero da cor: " #declara variavel msg3 
$msg4: .asciiz  "Cor Invalida!\n" #declara variavel msg4 
$msg5: .asciiz  "\n" #declara variavel msg5 
.text



j main

le_inteiro_do_teclado:
		li $v0, 5	# código para ler um inteiro
		syscall		# executa a chamada do SO para ler
		jr $ra		# volta para o lugar de onde foi chamado 


proc_cadastrar:
addi $t1,$zero,0 # t1 = cont = 0
addi $sp,$sp,-4 # volta a pilha
sw $a0,0($sp)
li $v0,4 #comando de impressão de string na tela
la $a0, $msg2 #coloca o texto para ser impresso
syscall # efetua a chamada ao sistema
lw $a0,0($sp)
addi $sp,$sp,4 # volta a pilha

while_proc:

slt $t4,$t1,$a1 # se cont<10 ->1
beq $t4,$zero,exit_preencher_vetor # se cont>10 -> while
addi $sp,$sp,-8 # volta a pilha
sw $ra,0($sp)
sw $a0,4($sp)
validacao_loop:
	li $v0,4 #comando de impressão de string na tela
	la $a0, $msg3 #coloca o texto para ser impresso
	syscall # efetua a chamada ao sistema
	lw $a0,4($sp)
	jal le_inteiro_do_teclado  # chama função para ler
	la  $t7, 0($v0)		   # carrega o inteiro lido em $t7
	beq $t7,$zero,validacao #se for = 0 -> validacao
	slti $t4,$t7,4 # t7<=3
	beq $t4,$zero,validacao# se for > 3 ->validacao
fim_validacao_loop:
sw $t7,0($a0) # dado lido para posicao atual do vetor
addi $t1,$t1,1 # cont++
addi $a0,$a0,4 # anda a posicao do vetor
lw $ra,0($sp)
addi $sp,$sp,8 # volta a pilha
j while_proc 

exit_preencher_vetor:
	jr $ra
validacao:
li $v0,4 #comando de impressão de string na tela
la $a0, $msg4 #coloca o texto para ser impresso
syscall # efetua a chamada ao sistema
j validacao_loop

fim_proc_cadastrar:

proc_relatorio:
la $t0,vetor_totais # t0 = vetor_totais
sw $zero,0($t0) #adiciona no vetor
sw $zero,4($t0) #adiciona no vetor
sw $zero,8($t0) #adiciona no vetor
add $t3,$a0,$zero #t3 = vetor
addi $t4,$zero,0 # cont
while:
	slt $t5,$t4,$a1 # cont < 10
	beq $t5,$zero,fim_proc_relatorio
	lw $t6,0($t3) # t4= vetor[]
	beq $t6,1,cont1
	beq $t6,2,cont2
	beq $t6,3,cont3
cont1:
lw $t1,0($t0) # ler posicao 0
add $t1,$t1,1 # vet++
sw $t1,0($t0) #adiciona no vetor
j fim_while
cont2:
lw $t1,4($t0) # ler posicao 1
add $t1,$t1,1 # vet++
sw $t1,4($t0) #adiciona no vetor
j fim_while
cont3:
lw $t1,8($t0) # ler posicao 2
add $t1,$t1,1 # vet++
sw $t1,8($t0) #adiciona no vetor
j fim_while

fim_while:
	addi $t3,$t3,4 #proximo elemento
	addi $t4,$t4,1 # cont++ 
	j while

fim_proc_relatorio:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	add $a0,$zero,$t0
	jal proc_pc1 # a0=vetor_total
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra


proc_pc1:
add $t0,$zero,$zero # t0= cont
add $t3,$zero,$zero # i= 0
add $t4,$zero,$zero # t4= cont_geral
add $t1,$zero,$zero # t1= acumulador

comeco_while:
add $t3,$t4,$t4
add $t3,$t3,$t3
add $t3,$t3,$a0
lw $t6,0($t3)
while_proc_pc1:
	slt $t2,$t0,$t6 # t0<a0 ->1
	beq $t2,$zero,fim_proc_pc1
	addi $t1,$t1,500 # acumulador = acumulador + 500
	addi $t0,$t0,1 #cont++
	
	j while_proc_pc1
fim_proc_pc1:
	#EXIBIR VALORES
	addi $sp,$sp,-4
	sw $a0,0($sp) #salva a0
	li $v0, 1	# código para imprimir um inteiro
	la $a0, ($t1)	# $a0 é o registrador que irá conter o valor a ser impresso
	syscall		# executa a chamado do SO para imprimir
	li $v0,4 #comando de impressão de string na tela
	la $a0, $msg5 #coloca o texto para ser impresso
	syscall # efetua a chamada ao sistema
	lw $a0,0($sp) #recupera a0
	addi $sp,$sp,4 #volta pilha
	#FIM EXIBIR VALORES
	
	sw $t1,0($t3)
	addi $t4,$t4,1
	add $t0,$zero,$zero # t0= cont
	add $t1,$zero,$zero # t1= acumulador
	slti $t2,$t4,3 # rodar o vetor
	beq $t2,$zero,exit_proc_pc1
	j comeco_while
exit_proc_pc1:
	jr $ra

main:
la $s0,vetor # s0 = vetor
addi $s1,$zero,10 # s1= 10
switch:
li $v0,4 #comando de impressão de string na tela
la $a0, $msg1 #coloca o texto para ser impresso
syscall # efetua a chamada ao sistema
jal le_inteiro_do_teclado  # chama função para ler
add $t0,$v0,$zero
beq $t0,1,cadastrar
beq $t0,2,relatorios

cadastrar:
add $a0,$zero,$s0 # a0 = vetor
add $a1,$zero,$s1 # a1 = 10
jal proc_cadastrar
j switch

relatorios:
add $a0,$zero,$s0 # a0 = vetor
add $a1,$zero,$s1 # a1 = 10
jal proc_relatorio



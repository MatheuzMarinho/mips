
addi $t0,$zero,48 # numero de bytes a serem copiados
addi $t1,$zero,0 # cont = 0

add $t3,$zero,$s0 # add o endereço base no t3
add $t4,$zero,$s1 # add o endereço destino no t4

while:
	slt $t5,$t1,$t0 # se t1<48 ->1
	beq $t5,$zero,fim # se t1>48 -> fim
	lb $t6,0($t3) # ler a posicao atual de t3 e copia para t6
	slti $t5,$t6,10 #t6<10 -> 1
	bne $t5,$zero,prox # se t6<10-> prox
	sb $t6,0($t4) # guarda t6 na posicao atual do t4
	addi $t4,$t4,1 # proximo byte do destino
prox:
	addi $t1,$t1,1 #cont++
	addi $t3,$t3,1 # proximo byte do fonte
fim: 

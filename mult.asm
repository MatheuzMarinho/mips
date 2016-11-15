func_mult: # recebe a0 e a1
addi $a0,$zero,12
addi $a1,$zero,3
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
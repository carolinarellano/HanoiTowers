#Ana Carolina Arellano Valdez 	Alicia Sofia Gomez Galvez
#include <stdio.h>

#// Función recursiva para resolver las Torres de Hanoi
#void hanoi(int n, char origen, char auxiliar, char destino) {
#    if (n == 1) {
#        printf("Mover disco 1 de %c a %c\n", origen, destino);
#        return;
#    }

#    hanoi(n - 1, origen, destino, auxiliar);
#    printf("Mover disco %d de %c a %c\n", n, origen, destino);
#    hanoi(n - 1, auxiliar, origen, destino);
#}

#int main() {
#    int n;
#    printf("Ingrese el número de discos: ");
#    scanf("%d", &n);
#    hanoi(n, 'A', 'B', 'C');
#    return 0;
#}
 
.text
main: 
		lui s1, 0x10010 #Torre 1 -> Origen
		addi t2, zero, 1 # default
		addi t3, zero, 2 # n -> cantidad de discos
		mul s0, t3, 4	   #n * 4 -> apuntadores a cada torre (offset) 
		addi s2, s1, s0  #Torre 2 -> auxiliar
		addi s3, s2, s0  #Torre 3 -> destino
		addi t5, zero, 0 #Temporal
		
hanoi:
#almacenar la direccion de ra en otra variable para no perderla
		addi t4, zero, ra

if: 	bne t3, t2, next #n != 1
		jalr ra			#return
		
next:
		# push -> n, ra
		addi, sp, sp, -8
		sw t3, 4(sp)
		sw ra, 0(sp)
		
		# hanoi(n - 1, origen, destino, auxiliar);
		jal ra, hanoi	
		#Se hace el swap
		
swap:
		add t5, zero, s1	#temp = tower1
		add s1, zero, s2 #tower1 = tower2
		add s2, zero, t5 #tower2= temp

		#pop <- n, ra
		lw ra, 0(sp)
		lw t3, 4(sp)
		addi sp, sp, 8
		
		# push -> n, ra
		addi, sp, sp, -8
		sw t3, 4(sp)
		sw ra, 0(sp)
		
		# hanoi(n - 1, auxiliar, origen, destino);
		jal ra, hanoi
		
swap:
		
		
		#pop <- n, ra
		lw ra, 0(sp)
		lw t3, 4(sp)
		addi sp, sp, 8

 
		
		

		
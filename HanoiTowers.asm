#Ana Carolina Arellano Valdez 	Alicia Sofia Gomez Galvez

.text
main: 
		lui s1, 0x10010 # Torre 1 -> source
		addi t2, zero, 1 # default
		addi t3, zero, 2 # n -> cantidad de discos
		slli s0, t3, 2	 # n * 4 -> apuntadores a cada torre (offset) no se puede usar mul
		addi s2, s1, s0  # Torre 2 -> auxiliary
		addi s3, s2, s0  # Torre 3 -> destination
		addi t5, zero, 0 # Temporal -> almacena el apuntador inicial de la torre FOR POP
		addi t6, zero, 0 # Movimientos		
		addi s4, zero, 0 # i -> ciclo 

#
addi t7, t7, s1 # Apuntador a s1 -> Se define afuera para poder hacerla como una funcion global
pop:
	forpop:
		addi t7, t7, s1 # Apuntador a s1
		lw t5, t7 # valor del disco actual
		bge s4, t3, endfor # for(int i = 0; i < n; i++)
		beq s4, zero, elsepop # if(s4 == 0)
		sw zero, t7 # se borra lo leido de la torre origen -> t5 tiene el valor borrado
		jalr ra
	elsepop:
		addi t7, t7, 4 # t7 = s1 + 4 
		addi s4, s4, 1 # i++
		jal forpop

push:
	forpush: 


		
hanoi:
if: 	bne t3, t2, else # n != 1
		addi s5, zero, ra
		
		# moveDisk(source, destination)
		# buscar el disco for -> para buscar != 0
			
	# push
		sw t5, 0(s3)		
		jalr ra			# return
		
		
else:
		# push -> n, ra
		addi, sp, sp, -8
		sw t3, 4(sp)
		sw ra, 0(sp)
		addi t3, t3, -1 # n-1	
		
# hanoi(n - 1, source, destination, auxiliary);		
		# temp = tower3		
		# tower3 = tower2
		# tower2 = temp
		
		jal  hanoi


		# pop <- n, ra
		lw ra, 0(sp)
		lw t3, 4(sp)
		addi sp, sp, 8
		
		# moveDisk(source, destination)
		# temp = tower1 
		# tower1 = tower3 (destination)
		# tower3 = temp (source)
		
		# push -> n, ra
		addi, sp, sp, -8
		sw t3, 4(sp)
		sw ra, 0(sp)
		addi t3, t3, -1 #n-1
		
		# hanoi(n - 1, auxiliary, source, destination);
		jal ra, hanoi
		
# hanoi(n - 1, auxiliary, source, destination);		
# se hace la segunda llamada a hanoi
hanoi2:
		add t5, zero, s2 # temp = tower2 (auxiliary)
		add s2, zero, s1 # tower2 = tower1(source)
		add s1, zero, t5 # tower1 = temp (destination)
		
		# pop <- n, ra
		lw ra, 0(sp)
		lw t3, 4(sp)
		addi sp, sp, 8

 
		
		

		

# Ana Carolina Arellano Valdez 	Alicia Sofia Gomez Galvez

.text
	lui s1, 0x10010 # Torre 1 -> source
	addi t2, zero, 1 # default
	addi t3, zero, 3 # n -> cantidad de discos 
	slli s0, t3, 2	 # n * 4 -> apuntadores a cada torre (offset) no se puede usar mul
	add s2, s1, s0  # Torre 2 -> auxiliary
	add s3, s2, s0  # Torre 3 -> destination
	addi t6, zero, 0 # Movimientos		
	addi s4, zero, 0 # i -> ciclo 
	addi s5, zero, 0 # Para almacenar ra en el if
	
main: 
	# Aqui se inicializan los discos en la memoria
	addi s4, s4, 1 # i inicia en 1
	
	addi s2, s2, -4
	addi s3, s3, -4
	
		forinit:
			blt t3, s4, endforinit # for(int i = 1; i <  n; i++) 
			sw s4, 0(s1)
			addi s1, s1, 4 # avanza 4 bits
			addi s2, s2, 4
			addi s3, s3, 4
			addi s4, s4, 1 # i++
			jal forinit
			
		endforinit:
			addi s1, s1, -4
			
		# Luego de haber inicializado los discos, se llama a hanoi
			jal hanoi
		# Despues de ejecutar todo el algoritmo, se sale del algoritmo
			jal exit
	
hanoi:
		# caso default
 		bne t3, t2, else # n != 1
		add s5, zero, ra
				
		# moveDisk(source, destination)
		sw zero, 0(s1) # pop disk
		sw t3, 0(s3)   # push disk
		addi t6, t6, 1 # movements count
		
		add ra, zero, s5
		jalr ra
		nop
						
	else:
			# 1st Hanoi call: 
			# antes de entrar a la recursividad, se hace el push de memoria
			
			# push memory -> n, ra and towers
			addi sp, sp, -20 
			sw t3, 0(sp)
			sw ra, 4(sp)
			sw s1, 8(sp)
			sw s2, 12(sp)
			sw s3, 16(sp)
			
			addi t3, t3, -1 # n - 1
			
			 # se mueve la posicion respecto a n
			addi s1, s1, -4
			addi s2, s2, -4
			addi s3, s3, -4
			
			# hanoi(n - 1, source, destination, auxiliary);		
			addi s9, s2, 0 # temp = tower2
			addi s2, s3, 0 # tower2 = tower3 (destination)
			addi s3, s9, 0 # tower3 = temp (auxiliary)
			
			jal hanoi
			
			# pop memory -> n, ra and towers
			lw t3, 0(sp)
			lw ra, 4(sp)
			lw s1, 8(sp)
			lw s2, 12(sp)
			lw s3, 16(sp)
			addi sp, sp, 20
			
			# moveDisk(source, destination);
			sw zero, 0(s1) # pop disk
			sw t3, 0(s3) 	 # push disk
			addi t6, t6, 1 # movements count
			
			# 2nd Hanoi call:
			# push -> n, ra and towers
			addi sp, sp, -20
			sw t3, 0(sp)
			sw ra, 4(sp)
			sw s1, 8(sp)
			sw s2, 12(sp)
			sw s3, 16(sp)
			
			# hanoi(n - 1, auxiliary, source, destination);
 			addi s9, s1, 0 # temp = tower1
  			addi s1, s2, 0 # tower1 = tower2 (source)
  			addi s2, s9, 0 # tower2 = temp (destination)
  			
  			addi t3, t3, -1 # n - 1
  			
  			# se mueve la posicion respecto a n
  			addi s1, s1, -4 
			addi s2, s2, -4
			addi s3, s3, -4
			
			# hanoi(n - 1, auxiliary, source, destination);
			jal hanoi
  			
			# pop <- n, ra and towers
			lw t3, 0(sp)
			lw ra, 4(sp)
			lw s1, 8(sp)
			lw s2, 12(sp)
			lw s3, 16(sp)
			addi sp, sp, 20
			
			jalr ra
			
exit: nop			

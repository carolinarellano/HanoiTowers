# Ana Carolina Arellano Valdez 	Alicia Sofia Gomez Galvez

.text
	lui s1, 0x10010 # Torre 1 -> source
	addi t2, zero, 1 # default
	addi t3, zero, 2 # n -> cantidad de discos
	addi s11, t3, 0 # registro para n constante 
	slli s0, t3, 2	 # n * 4 -> apuntadores a cada torre (offset) no se puede usar mul
	add s2, s1, s0  # Torre 2 -> auxiliary
	add s3, s2, s0  # Torre 3 -> destination
	addi t5, zero, 0 # Temporal -> almacena el apuntador inicial de la torre USAR SOLO PARA FOR POP
	addi t6, zero, 0 # Movimientos		
	addi s4, zero, 0 # i -> ciclo 
	addi s5, zero, 0 # Para almacenar ra en el if
	addi s6, zero, 0 # Count para saber cuantos slli hacer en el push
	addi s7, zero, 0 # Apuntador para almacenar temporalmente el inicio de cada torre
	addi s8, zero, 0 # Almacena la direccion de ra
	addi s9, zero, 0 # Temporal para el swap
main: 
	# Aqui se inicializan los discos en la memoria
	addi s4, s4, 1 # i inicia en 1
		forinit:
			blt t3, s4, endforinit # for(int i = 1; i <  n; i++) 
			sw s4, 0(s1)
			addi s1, s1, 4 # avanza 4 bits
			addi s4, s4, 1 # i++
			jal forinit
			
		endforinit:
			sub s1, s1, s0 # para regresarlo al inicio del arreglo
			
		# Luego de haber inicializado los discos, se llama a hanoi
			jal hanoi
		# Despues de ejecutar todo el algoritmo, se sale del algoritmo
			jal exit
			
	# POP -> hace el pop de la torre de origen para despues hacer el PUSH a la torre destino
pop:
		addi sp, sp, -4
		sw ra, 0(sp)
		add s7, s1, zero # Copia del apuntador a s1
		addi s4, zero, 0 # i
	forpop:
		# for(int i = 0; i < n; i++)
			blt s11, s4, endforpop 
			lw t5, 0(s7) # valor del disco actual
			
		# if(t5 == 0)
			beq t5, zero, elsepop
#			lw s0, 0(s7)
			sw zero, 0(s7) # se borra lo leido de la torre source -> t5 tiene el valor borrado
			jal endforpop
				
	elsepop:
			addi s7, s7, 4 # s7 = s1 + 4 
			addi s4, s4, 1 # i++
			jal forpop
				
		endforpop:
			lw ra, 0(sp)
			addi sp, sp, 4 
			jal zero, returnPop

	# t5 se utiliza como la variable que tiene el valor almacenado para hacer el push
	
# PUSH -> hace push del valor obtenido de la torre origen hacia la torre destino
push:
    addi sp, sp, -4
    sw ra, 0(sp)
    add s7, s3, zero # Copia del apuntador a s3
    addi s4, zero, 0 # i
forpush:
    # for (int i = 0; i < n; i++)
    bge s4, s11, endforpush
    lw s10, 0(s7) # Valor del disco actual

    # if (s10 == 0)
    beq s10, zero, elsepush
	addi s7, s7, -4 # s7 = s7 - 4 -> regresa un lugar atras y coloca el disco
    sw t5, 0(s7) # Se agrega el valor de t5 a la torre destination
    jal endforpush

elsepush: 
    addi s7, s7, 4 # s7 = s7 + 4
    addi s4, s4, 1 # i++
    jal forpush # Salta al forloop (se almacena ra y regresa al for)

endforpush:
    lw ra, 0(sp)
    addi sp, sp, 4
    jal returnPush

    addi s4, zero, 0 # Reinicia la variable i

			
hanoi:
		# caso default
 		bne t3, t2, else # n != 1
		add s5, zero, ra
				
		# moveDisk(source, destination)
		jal pop
		jal push
			
		add ra, zero, s5
		jalr ra
		nop
						
	else:
			# 1st Hanoi call: 
			# antes de entrar a la recursividad, se hace el push de memoria
			
			# push -> n, ra
			addi sp, sp, -8
			sw t3, 0(sp)
			sw ra, 4(sp)
			
			addi t3, t3, -1 # n - 1
			
		# hanoi(n - 1, source, destination, auxiliary);		
			addi s9, s2, 0 # temp = tower2
			addi s2, s3, 0 # tower2 = tower3 (destination)
			addi s3, s9, 0 # tower3 = temp (auxiliary)
	
			jal hanoi
			
		# se regresan los apuntadores al lugar original
			addi s9, s2, 0 # temp = tower2
			addi s2, s3, 0 # tower2 = tower3 (destination)
			addi s3, s9, 0 # tower3 = temp (auxiliary)
			
			# pop <- n, ra
			lw ra, 0(sp)
			lw t3, 4(sp)
			addi sp, sp, 8
			
			addi sp, sp, -4 # Guardar ra en el sp
			sw ra, 0(sp)
				
			# moveDisk(source, destination);
			jal pop
			
returnPop:
	
			jal push		
		
returnPush:
	
			addi s6, s6, 1 # count de movimientos
			
			lw ra, 0(sp)
			addi sp, sp, 4 # Recuperar ra 
			
			# 2nd Hanoi call:
			# push -> n, ra
			addi sp, sp, -8
			sw t3, 0(sp)
			sw ra, 4(sp)
			
			# hanoi(n - 1, source, destination, auxiliary);
 			addi s9, s2, 0 # temp = tower2
  			addi s2, s1, 0 # tower2 = tower1 (source)
  			addi s1, s9, 0 # tower1 = temp (destination)
  			addi t3, t3, -1 # n - 1
			
			# hanoi(n - 1, auxiliary, source, destination);
			jal hanoi
					
 			addi s9, s2, 0 # temp = tower2
  			addi s2, s1, 0 # tower2 = tower1 (source)
  			addi s1, s9, 0 # tower1 = temp (destination)
  			
			# pop <- n, ra
			lw ra, 0(sp)
			lw t3, 4(sp)
			addi sp, sp, 8
			jalr ra
			
exit: nop			
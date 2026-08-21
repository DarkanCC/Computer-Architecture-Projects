.data

file_in: .asciiz "D:\\Universidad\\Arquitectura de Computadores y Laboratorio\\Laboratorio 2\\wordsearch.txt"
Ask_Word: .asciiz "Ingrese la palabra que desea buscar:"
Not_Found: .asciiz "La palabra no se encuentra en la sopa de letras"
Ask_Ending: .asciiz "Desea continuar buscando palabras?"
Ask_Exit: .asciiz "Desea terminar la ejecución del programa?"
Invalid: .asciiz "Opción inválida, seleccione SI o NO"
Empty: .asciiz "Ninguna palabra fue ingresada, intente nuevamente"
Row: .asciiz "La palabra está en la Fila: \n"
Column: .asciiz "La palabra está en la Columna: \n"
String_Up: .asciiz "La palabra se lee de abajo hacia arriba"
String_Down: .asciiz "La palabra se lee de arriba hacia abajo"
String_Right: .asciiz "La palabra se lee de izquierda a derecha"
String_Left: .asciiz "La palabra se lee de derecha a izquierda"
.align 2
input_buffer: .space 5048
end_file: .space 1
word_in: .space 51

.text
Main:
	# Open File
	li $v0, 13
	la $a0, file_in
	li $a1, 0
	syscall
	move $s0, $v0
	
	# Read File
	li $v0, 14
	move $a0, $s0
	la $a1, input_buffer
	li $a2, 5048
	syscall
	sw $zero, end_file	# Indicador final del recorrido
	
Read:	li $v0, 54
	la $a0, Ask_Word
	la $a1, word_in
	li $a2, 52
	syscall
	beq $a1, -2, Exit2
	beq $a1, -3, Error2
	
	jal Step_1
For:	slti $s4, $s3, 5048
	beq $s4, $zero, End_For
	beq $s1, $s2, Step_2
Resume:	addi $a0, $a0, 2
	addi $s3, $s3, 2
KeepAl:	lb $s1, 0($a0)
	beq $s1, 0x0A, Align	# Alineamiento en caso de encontrarse un \n=0x0A
	j For
Align:	addi $a0, $a0, 1
	addi $s3, $s3, 1
	j KeepAl
End_For:la $a0, Not_Found
	li $a1, 1
	li $v0, 55
	syscall
	j Continue

Exit:	li $v0, 10
	syscall

##----------------------------------FUNCTIONS-----------------------------##

Step_1:
	la $a0, input_buffer	# Dirección para recorrer la sopa
	lb $s1, ($a0)		# Primera letra de la sopa
	lb $s2, word_in		# Primera letra de palabra a buscar
	li $s3, 1		# Contador para conocer la posición en la sopa
	jr $ra
	
Step_2:
	addi $t0, $zero, 1	# Contador para recorrer la palabra
	la $a2, word_in($t0)
	lb $t2, 0($a2)
	la $a1, 2($a0)
	lb $t1, 0($a1)
	beq $t1, $t2, Right
KRight:	la $a1, -2($a0)
	lb $t1, 0($a1)
	beq $t1, $t2, Left
KLeft:	la $a1, -101($a0)
	la $t3, input_buffer	#
	slt $t4, $a1, $t3	# Si estamos recorriendo la primera fila, no se comprueba arriba
	bne $t4, $zero, KUp	#
	lb $t1, 0($a1)
	beq $t1, $t2, Up
KUp:	la $a1, 101($a0)
	la $t3, end_file	#
	slt $t4, $a1, $t3	# Si estamos recorriendo la ultima fila, no se comprueba abajo
	beq $t4, $zero, Resume	#
	lb $t1, 0($a1)
	beq $t1, $t2, Down
	j Resume

Step_3:	
Right:	jal Store
	jal Next
	beq $t2, 0x0A, FRight
	la $a1, 2($a1)
	lb $t1, ($a1)
	beq $t1, $t2, Right
	jal Load
	j KRight
Left:	jal Store
	jal Next
	beq $t2, 0x0A, FLeft
	la $a1, -2($a1)
	lb $t1, ($a1)
	beq $t1, $t2, Left
	jal Load
	j KLeft
Up:	jal Store
	jal Next
	beq $t2, 0x0A, FUp
	la $a1, -101($a1)
	lb $t1, ($a1)
	beq $t1, $t2, Up
	jal Load
	j KUp
Down:	jal Next
	beq $t2, 0x0A, FDown
	la $a1, 101($a1)
	lb $t1, ($a1)
	beq $t1, $t2, Down
	j Resume

Step_4:
FRight:	jal Pos
	jal Result
	la $a0, String_Right
	li $a1, 1
	li $v0, 55
	syscall
	j Continue
FLeft:	jal Pos
	jal Result
	la $a0, String_Left
	li $a1, 1
	li $v0, 55
	syscall
	j Continue
FUp:	jal Pos
	jal Result
	la $a0, String_Up
	li $a1, 1
	li $v0, 55
	syscall
	j Continue
FDown:	jal Pos
	jal Result
	la $a0, String_Down
	li $a1, 1
	li $v0, 55
	syscall
	j Continue
	
Continue:	la $a0, Ask_Ending
		li $v0, 50
		syscall
		beq $a0, 0, Read
		beq $a0, 1, Exit
		beq $a0, 2, Error1

Error1:	la $a0, Invalid
	li $a1, 1
	li $v0, 55
	syscall
	j Continue

Error2:	la $a0, Empty
	li $a1, 0
	li $v0, 55
	syscall
	j Read

Pos:	li $t3, 101	# Numero de caracteres por fila
	div $s3, $t3
	mflo $s6	# Cociente = Fila
	mfhi $t5	# Residuo = Columna
	addi $s6, $s6, 1
	li $t3, 2
	div $t5, $t3
	mflo $t6
	sub $t5, $t5, $t6
	move $s7, $t5
	jr $ra

Store:	addi $sp, $sp, -8	# Guarda $t0 y $t2 en la pila
	sw $t0, 0($sp)
	sw $t2, 4($sp)
	jr $ra

Load:	lw $t0, ($sp)		# Restaura los valores de $t0 y $t2
	lw $t2, 4($sp)
	addi $sp, $sp, 8
	jr $ra

Next:	addi $t0, $t0, 1
	la $a2, word_in($t0)
	lb $t2, ($a2)
	jr $ra
	
Result:	la $a0, Row
	move $a1, $s6
	li $v0, 56
	syscall
	la $a0, Column
	move $a1, $s7
	li $v0, 56
	syscall
	jr $ra

Exit2:	la $a0, Ask_Exit
	li $v0, 50
	syscall
	beq $a0, 0, Exit
	beq $a0, 1, Read
	beq $a0, 2, Exit2
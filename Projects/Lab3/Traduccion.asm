.data

matriz: .word -18, 76, 39, 51, 13, -75, -81, 8, 96, 14, 99, -57, -49, 7, 5, 40, -28, 64, -99, -3, 88, 95, 31, -87, -65
length: .word 5
max_nums: .space 40
min_nums: .space 40

.text

	add $a0, $zero, $zero
	lw $a1, 100
	addi $s0, $zero, 1
	addi $s1, $zero, 1
	lw $s2, 0($a0)
	add $v0, $zero, $s2
	add $v1, $zero, $s2
loop:	slt $t0, $s0, $a1
	beq $t0, $zero, done
	addi $a0, $a0, 4
	lw $s2, 0($a0)
	slt $t0, $s2, $v0
	beq $t0, $zero, update_max
	slt $t0, $v1, $s2
	beq $t0, $zero, update_min
update:	addi $s0, $s0, 1
	j loop
done:	sw $v0, 104($a2)
	sw $v1, 144($a2)
	addi $a2, $a2, 4
	addi $s1, $s1, 1
	add $s0, $zero, 0
	lw $v0, 4($a0)
	lw $v1, 4($a0)
	slt $t0, $a1, $s1
	beq $t0, $zero, loop

	add $a0, $zero, $zero
	addi $a3, $zero, 4
	addi $s0, $zero, 1
	addi $s1, $zero, 1
	lw $s2, 0($a0)
	add $v0, $zero, $s2
	add $v1, $zero, $s2
	
loop2:	slt $t0, $s0, $a1
	beq $t0, $zero, done2
	addi $a0, $a0, 20
	lw $s2, 0($a0)
	slt $t0, $s2, $v0
	beq $t0, $zero, update_max2
	slt $t0, $v1, $s2
	beq $t0, $zero, update_min2
upda:	addi $s0, $s0, 1
	j loop2
done2:	sw $v0, 104($a2)
	sw $v1, 144($a2)
	addi $a2, $a2, 4
	addi $s1, $s1, 1
	addi $s0, $zero, 1
	lw $v0, 0($a3)
	lw $v1, 0($a3)
	add $a0, $zero, $a3
	addi $a3, $a3, 4
	slt $t0, $a1, $s1
	beq $t0, $zero, loop2

update_max:
	add $v0, $zero, $s2
	j update

update_min:
	add $v1, $zero, $s2
	j update

update_max2:
	add $v0, $zero, $s2
	j upda

update_min2:
	add $v1, $zero, $s2
	j upda
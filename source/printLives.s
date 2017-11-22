.section  .init
.globl	printLives
.globl	totalLives
.globl	decLives
.globl  addLife
.section  .text
decLives:
    push {r4, lr}
    ldr r0, =totalLives
    ldr r4, [r0]
    sub r4, #1
    str r4, [r0]
    cmp r4, #0
    moveq r0, #0
    bleq drawScoreLost
    b  reset
    pop {r4, lr}
    mov pc, lr

addLife:
    push {r4, lr}
    ldr r0, =totalLives
    ldr r4, [r0]
    add r4, #1
    str r4, [r0]
    pop {r4, lr}
    mov pc, lr

printLives:
	push {r4, r6, lr}
	ldr	r0, =totalLives
	ldr	r4, [r0]	// r4 = totalLives
	ldr	r6, =imgLives 	// 59x59 image
	cmp	r4, #0		// If lives == 0,
	beq	 endd		// terminate program

	printFirst:
		ldr	r0, =954
		ldr	r1, =698
		ldr r2, =1013
		ldr	r3, =757
		bl	draw
		cmp r4, #2
		blt	endd

	printSecond:
		ldr	r0, =895
		ldr	r1, =698
		ldr r2, =954
		ldr	r3, =757
		bl	draw
		cmp r4, #3
		blt	endd

	printThird:
		ldr	r0, =836
		ldr	r1, =698
		ldr r2, =895
		ldr	r3, =757
    bl	draw
		cmp r4, #4
		blt	endd

  printFourth:
		ldr	r0, =777
		ldr	r1, =698
		ldr r2, =836
		ldr	r3, =757
    bl	draw
		b	  endd

	endd:
		pop {r4, r6, lr}
		mov	pc, lr

.section	.data
totalLives:	.int	3	// Initalizes lives to be 3, decrementing each death

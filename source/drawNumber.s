.section	.data
score:		.int 	0

.section .text 
.globl	score
.globl	drawNumber

drawNumber:// Draws the numbers representing the score for the win/lose screen
	push {r6, r7, lr}
	ldr		r0, =score		// Loads the score address into r0
	ldr		r7, [r0]			// Loads the decimal value of score into r7
	no0:
		cmp	r7, #0			// Compares r7 (score) with decimals 0
		bgt no1					// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img0		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no1:
		cmp		r7, #1		// Compares r7 (score) with decimals 1
		bgt   no2				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img1		// Image location
		ldr	r2,	=497		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no2:
		cmp		r7, #2		// Compares r7 (score) with decimals 2
		bgt   no3				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img2		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
		mov	pc, lr			// return back
	no3:
		cmp		r7, #3		// Compares r7 (score) with decimals 3
		bgt   no4				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img3		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
		mov	pc, lr			// return back
	no4:
		cmp		r7, #4		// Compares r7 (score) with decimals 4
		bgt   no5				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img4		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no5:
		cmp		r7, #5		// Compares r7 (score) with decimals 5
		bgt   no6				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img5		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no6:
		cmp		r7, #6		// Compares r7 (score) with decimals 6
		bgt   no7				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img6		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no7:
		cmp		r7, #7		// Compares r7 (score) with decimals 7
		bgt   no8				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img7		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no8:
		cmp		r7, #8		// Compares r7 (score) with decimal 8
		bgt   no9				// continues if greater than decimal ^
		ldr	r0,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6, =img8		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back
	no9:
		ldr	r7,	=481		// Start x coordinate
		ldr	r1,	=366		// Start y coordinate
		ldr	r6,	=img9		// Image location
		ldr	r2,	=505		// Final x coordinate
		ldr	r3,	=402		// Final y coordinate
		bl	draw				// Draw the image, &
		pop {r6, r7, lr}
	    mov	pc, lr			// return back


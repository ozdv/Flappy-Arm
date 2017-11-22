.section .init
.globl  drawScoreWon
.globl	drawScoreLost

.section	.data
drawScoreWon:	// Draws the score board for if you WIN
		push {r6, lr}
		ldr	r0,	=345		// Start X position of menu
		ldr	r1,	=156		// Start Y position of menu
		ldr	r6,	=imgScoreWon// Loads image
		ldr	r2,	=689		// Final X position of menu
		ldr	r3,	=612		// Final Y position of menu
		bl	draw			// Draws the image
		pop {r6, lr}
		bl	drawNumber		// Prints the score on the men
		bl	resetAll
		mov	pc, lr

drawScoreLost:	// Draws the score board for if you LOSE
		push {r6, lr}
		ldr	r0,	=345			// Start X position of menu
		ldr	r1,	=156			// Start Y position of menu
		ldr	r6,	=imgScoreLost	// Loads the image
		ldr	r2,	=689			// Final X position of menu
		ldr	r3,	=612			// Final Y position of menu
		bl	draw				// Draws the image
		pop {r6, lr}
		bl	drawNumber			// Prints the score on the menu
		bl	resetAll
		mov	pc, lr

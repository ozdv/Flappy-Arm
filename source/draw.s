.section .init
.globl	draw
.section .text
draw:
	push {r4-r9, lr}
    mov	r4,	r0	  //Start X position of your picture
	mov	r5,	r1    //Start Y position of the picture
	mov	r7,	r2	  //Width of your picture
	mov	r8,	r3	  //Height of your picture 
    mov r9, r4    //The reset value used in drawPicture
    b drawPictureLoop


DrawPixel:	// Generic drawPixel and drawloop taken from tutorial & slightly modified
	push	{r4}
	offset	.req	r4
	add		offset,	r0, r1, lsl #10
	lsl		offset, #1
	ldr	r0, =FrameBufferPointer
	ldr	r0, [r0]
	strh	r2, [r0, offset]
	pop		{r4}
	bx		lr


drawPictureLoop:
	mov	r0,	r4  //passing x for ro which is used by the Draw pixel function
	mov	r1,	r5	//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6],#2	//setting pixel color by loading it from the data section.
    cmp r2, #000000     //if pixel is black...
    beq Black    
	bl	DrawPixel

	Black:
		add	r4,	#1			//increment x position
		cmp	r4,	r7			//compare with image with
		blt	drawPictureLoop
		mov	r4,	r9			//reset x
		add	r5,	#1			//increment Y
		cmp	r5,	r8			//compare y with image height
		blt	drawPictureLoop	//continue looping
		
    pop {r4-r9, lr}
	mov	pc,	lr

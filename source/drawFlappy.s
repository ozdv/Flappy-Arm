.section .init
.globl drawFlappy
.globl dimensions
.globl eraseAfter
.globl previous
.section    .data
drawFlappy:                // Draws flappy to screen
   	push {r4-r9, lr}
    mov r4, r0             //catching x position
    mov r5, r1             //catching y position
    ldr r0, =dimensions    // loads address of dimensions ino r0
    ldr r1, =previous      //Loads the address of the previous into r1
    str r4, [r1]           //
    str r5, [r1, #4]       //
    str r4, [r0]           // stores inputed x value (r4) into dimensions
    str r5, [r0, #4]       // stores inputed y value (r5) into dimensions
    ldr	r6, =imgMidFlap    // loads image into r6
    add r7, r4, #90        // loads width value into r7
    add r8, r5, #65        // loads height value into r8
    str r7, [r0, #8]       // stores final xvalue (r7) into dimensions
    str r8, [r0, #12]      // stores final y value (r8) into dimensions
    mov r9, r4            

    drawPictureLoop:
        mov	r0,	r4	        //passing x for ro which is used by the Draw pixel function
        mov	r1,	r5	        //passing y for r1 which is used by the Draw pixel formula
        ldrh	r2,	[r6], #2  //setting pxl clr by load @ data section
        cmp   r2, #0        //if pixel is black
        beq   Black         //branch to black label (meaning dont draw pixel)
        bl	DrawPixel1

        Black:
            add	r4,	#1	//increment x position
            cmp	r4,	r7	//compare with image width
            blt	drawPictureLoop
            mov	r4,	r9	//reset x
            add	r5,	#1	//increment Y
            cmp	r5,	r8	//compare y with image height
            blt	drawPictureLoop
            pop {r4-r9, lr}
            mov	pc,	lr	//return

DrawPixel1:
  	push {r4}
  	add	r4,	r0, r1, lsl #10 // offset *= 2 (for 16 bits per pixel = 2 bytes per pixel)
  	lsl	r4, #1              // store the colour  at framebuffer pointer + offset
  	ldr	r0, =FrameBufferPointer
  	ldr	r0, [r0]
  	strh	r2, [r0, r4]
  	pop		{r4}
  	bx		lr
.section .data
.align 4
dimensions:
    .int        10      // Start x value
    .int        300     // Start y value
    .int        0       // Final x value
    .int        0       // Final y value
previous:
    .int        0       // Previous x value
    .int        0       // Previous y value
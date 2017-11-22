.section .init
.global updateScore
.global resetScore
.global drawScore
.global incrementScore

// Call "bl resetScore" when you die
// Call "bl updateScore" when flappy passes a pipe
.section .text
resetScore:
    push {lr}
    ldr r0, =score
    ldr r1, [r0]
    mov r1, #0
    str r1, [r0]
    pop {lr}
    mov pc, lr

incrementScore:
    push {lr}
    ldr r0, =score
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]
    pop {lr}
    mov pc, lr

updateScore:
    push {lr}
    ldr r0, =score
    ldr r2, [r0]
    add r2, #1
    str r2, [r0]
    pop {lr}
    mov pc, lr

drawScore:                // Draws the score in the top left corner of screen
    push {r4, lr}
    bl  clearScore
    ldr r0, =score
    ldr r4, [r0]
    // Simply loops to see what value the score is (in r4), and prints accordingly
    ch9:
        cmp r4, #9
        blt ch8
        mov r3, #'9'
        bl  drawChar
        b donee
    ch8:
        cmp r4, #8
        blt ch7
        mov r3, #'8'
        bl  drawChar
        b donee
    ch7:
        cmp r4, #7
        blt ch6
        mov r3, #'7'
        bl  drawChar
        b donee
    ch6:
        cmp r4, #6
        blt ch5
        mov r3, #'6'
        bl  drawChar
        b donee
    ch5:
        cmp r4, #5
        blt ch4
        mov r3, #'5'
        bl  drawChar
        b donee
    ch4:
        cmp r4, #4
        blt ch3
        mov r3, #'4'
        bl  drawChar
        b donee
    ch3:
        cmp r4, #3
        blt ch2
        mov r3, #'3'
        bl  drawChar
        b donee
    ch2:
        cmp r4, #2
        blt ch1
        mov r3, #'2'
        bl  drawChar
        b donee
    ch1:
        cmp r4, #1
        blt ch0
        mov r3, #'1'
        bl  drawChar
        b donee
    ch0:
        cmp r4, #0
        bne donee
        mov r3, #'0'
        bl  drawChar
        b donee
    donee:
        pop {r4, lr}
        mov pc, lr


drawScorePixel:
  	push	{r4}
  	add		r4,	r0, r1, lsl #10
  	lsl		r4, #1
  	ldr	r0, =FrameBufferPointer
  	ldr	r0, [r0]
  	strh	r2, [r0, r4]
  	pop		{r4}
  	bx		lr

drawChar:             // Generic draw function
    push	{r4-r8, lr}
    ldr		r4,	=font		// load the address of the font map
    add		r4,	r3, lsl #4	// char address = font base + (char * 16)
    mov		r6,	#10			// init the Y coordinate (pixel coordinate)

    charLoop$:
        mov		r5,	#10			// init the X coordinate
        mov		r8,	#0x01		// set the bitmask to 1 in the LSB
        ldrb	r7,	[r4], #1	// load the r7 byte, post increment chAdr

        rowLoop$:
            tst		r7,	r8		// test r7 byte against the bitmask
            beq		noPixel$
            mov		r0,	r5
            mov		r1,	r6
            ldr		r2,	=0xFFFF    // White
            bl		drawScorePixel			// draw red pixel at (r5, r6)

    noPixel$:
        add		r5,	#1			// increment x coordinate by 1
        lsl		r8,	#1			// shift bitmask left by 1
        tst		r8,	#0x100		// test if the bitmask has shifted 8 times (test 9th bit)
        beq		rowLoop$
        add		r6,	#1			// increment y coordinate by 1
        tst		r4,	#0xF
        bne		charLoop$			// loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)


        pop		{r4-r8, pc}
        bx  lr


clearScore:
    push {r4-r8, lr}
  	mov	r4,	#0			//x value
  	mov	r5,	#0			//Y value
  	ldr	r6,	=imgSky	//black color
  	ldr	r7,	=32		//Width of screen
  	ldr	r8,	=32		//Height of the screen

    Looping:
    mov	r0,	r4			//passing x for ro which is used by the Draw pixel function
  	mov	r1,	r5			//passing y for r1 which is used by the Draw pixel formula

	      ldrh	r2,	[r6],#2
        bl  drawScorePixel
        add	r4,	#1			//increment x by 1
      	cmp	r4,	r7			//compare with width
      	blt	Looping
      	mov	r4,	#0			//reset x
      	add	r5,	#1			//increment Y by 1
      	cmp	r5,	r8			//compare with height
      	blt	Looping

        pop {r4-r8, lr}
      	mov	pc,	lr			//return


.section .data

.align 4
font:		.incbin	"font.bin"

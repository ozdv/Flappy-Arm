.section  .init
.global redrawBG
.section  .text
redrawBG:
    push {r4-r9, lr}
    ldr r0, =currentScreen  // LOads the address to currentScreen into r0
    ldr r4, [r0]			// Loads the decimal value of screen into r4

    cmp r4, #1
    beq scr1
    cmp r4, #2
    beq scr2
    cmp r4, #3
    beq scr3
    cmp r4, #4
    beq scr4

    scr1:
       	ldr	r6, =imgGamePlay1         // loads image into r6
        b continue
    scr2:
        ldr	r6, =imgGamePlay2         // loads image into r6
        b continue
    scr3:
        ldr	r6, =imgGamePlay3         // loads image into r6
        b continue
    scr4:
        ldr	r6, =imgGamePlay4         // loads image into r6

    continue:
        ldr     r1, =previous           //Loads the address of the previous into r1
        ldr     r4, [r1]                //FIGURE THIS OUT SIM
        ldr     r5, [r1, #4]            //AND THIS TOO
        add     r7, r4, #90            // loads width value into r7
        add     r8, r5, #65             // loads height value into r8
        mov     r9, r4

        drawPictureLoop1:
            mov	r0,	r4	                 //passing x for ro which is used by the Draw pixel function
            mov	r1,	r5	                //passing y for r1 which is used by the Draw pixel formula
            add	r3, r0, r1, lsl #10             // offset *= 2 (for 16 bits per pixel = 2 bytes per pixel)
            lsl	r3, #1                          // store the colour (half word) at framebuffer pointer + offset
            ldrh	r2, [r6, r3]                    //FIGURE THIS SHIT OUT, I COULDN'T
            ldr	r0, =FrameBufferPointer
            ldr	r0, [r0]
            strh	r2, [r0, r3]

            add	r4,	#1	        //increment x position
            cmp	r4,	r7	        //compare with image width
            blt	drawPictureLoop1
            mov	r4,	r9	        //reset x
            add	r5,	#1	        //increment Y
            cmp	r5,	r8	        //compare y with image height
            blt	drawPictureLoop1
            pop {r4-r9, lr}
            mov	pc,	lr	        //return

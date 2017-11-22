/*
.global	InstallIntTable
.global interrupt 


InstallIntTable:
	push	{r0-r12, lr}
	ldr		r0, =IntTable
	mov		r1, #0x00000000

	// load the first 8 words and store at the 0 address
	ldmia	r0!, {r2-r9}
	stmia	r1!, {r2-r9}

	// load the second 8 words and store at the next address
	ldmia	r0!, {r2-r9}
	stmia	r1!, {r2-r9}

	// switch to IRQ mode and set stack pointer
	mov		r0, #0xD2
	msr		cpsr_c, r0
	mov		sp, #0x8000

	// switch back to Supervisor mode, set the stack pointer
	mov		r0, #0xD3
	msr		cpsr_c, r0
	mov		sp, #0x8000000

	bx		lr

//Function will wait 30 seconds before calling drawValue to draw a new value pack.
interrupt:
    push {r0-r12, lr}
    ldr  r4, =0x3F003004    //address of CLO
    ldr  r5, [r4]           //value read from CLO
    
    ldr r6, =0x1C9C380      //30,000,000 micro seconds
    add r6, r6, r5          //update timer value = current time + delay
    
    ldr r7, =0x3F003010
    str r6, [r7]            //storing timer value back to address specified in handout
    
    //For IRQ....
    ldr r4, =0x3F00B210
    ldr r5, =0xA            //make all bits zero except bit two and four 
    str r5, [r4]            //store back into the same address

    //Disable all other interrupts 
    ldr r0, =0x3F00B214
    mov r1, #0
    str r1, [r0]
    
    //For cpsr_c register 
    mrs r0, cpsr
    bic r0, #0x80
    msr cpsr_c, r0
    
    pop {r0-r12, lr}
    bx lr

//IRQ function should be executed when the interrupt function is executed 

IRQ:
    push {r0-r12, lr}

    ldr r0, =0x3F00B204
    ldr r1, [r0]        //load contents from address above to r1
    ldr r3, =0x2        //second bit 
    tst r1, r3          //tst with the second bit  
   
    beq clear

    //check if user is in gamePlay, if not do not draw
    ldr r0, =enterGameCheck 
    ldr r1, [r0]
    cmp r1, #1          //if game has not started (=1)...
    beq clear           ...then it will branch off to clear 

    //check if changing screens, if not do not draw
    ldr r0, =changingScreens  
    ldr r1, [r0]
    cmp r1, #1          //if screen is being changed (=1)...
    beq clear           ...then it will branch off to clear 
     
drawValuePack:
    push {lr}
    
    // when program first run, avoid printing value pack immediately
	ldr		r0, =IsItFirstTimeDraw
	ldr   r1, [r0]
	cmp   r1, #0
	beq   ItIsNot

	// if the value pack already exists and player didn't eat it in the past 30s, don't generate another value pack
	ldr		r0, =valuePackExist
	ldr		r0, [r0]
	cmp		r0, #1
	beq		ItIsNot

	// The following code will calculate the offset and generate a value pack on the offset of the map
	ldr     r8, =valuePackXPosition
	ldr     r4, [r8]
	ldr     r9, =valuePackYPosition
	ldr     r5, [r9]

    


clear:
    //Enable timer control
    ldr r4, =0x3F003000
    ldr r5, =0x2
    str r5, [r4]
    bl interrupt 
    ldr r4, =0x3F003000
    ldr r3, [r4]
    ldr r5, =0x2
    orr r3, r5
    str r3, [r4]

    pop {r0-r12, lr}
    subs pc, lr, #4         //not sure about this line but lets try :)

*/

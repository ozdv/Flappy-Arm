.section .init
.global initialization
.global readSNES
.global Print_Message

.section .text
initialization:
        push {lr}
        //GPIO Line 9 - LATCH LINE
        mov r0, #9               //r0 = line number
        mov r1, #0b001           //r1 = function code
        bl  Init_GPIO

        //GPIO Line 10 - DATA LINE
        mov r0, #10              //r0 = line number
        mov r1, #0b000           //r1 = function code
        bl Init_GPIO

        //GPIO Line 11 - CLOCK LINE
        mov r0, #11              //r0 = line number
        mov r1, #0b001           //r1 = function code
        bl Init_GPIO


        //bl readSNES                     //branch off to readSNES
        //bl Print_Message
        pop {lr}
        bx lr
///////////////////////////////END OF MAIN////////////////////////////////////////////
        
///////////////////////////READ SNES/////////////////////////////////////////////////////
readSNES: // main SNES subroutine that reads input from a SNES controller
    push {r5, r6, r9, lr}
    mov r9, #0                    //used to hold all the buttons that were pressed
    //Enable Clock
    mov r0, #1                    //Set clock to 1
    bl writeClock
    //Enable Latch
    mov r0, #1                    //Set latch to 1
    bl writeLatch
    mov r0, #12                   //wait 12 micro seconds
    bl wait
    //Disable Latch
    mov r0, #0                    //set latch to zero
    bl writeLatch
    mov r5, #0                    //register to count 16 loops (0 to 15 -inclusive)
////////////////////////////WAIT6 INNER LOOP///////////////////////////////////////////////
    wait6:    // snes innerloop, waits/delays 6 cycles
        mov r0, #6
        bl wait

        //Disable clock
        mov r0, #0                      //Set clock to zero
        bl writeClock

        mov r0, #6
        bl wait
        bl readData
        cmp r0, #0
        bne notPressed
    pressed:                     // moves on when pressed
        mov r6, #1
        lsl r6, r5               //shifts the output of the read data i times to move the bit to its placement
        orr r9, r6               //r9 is orred with the shifted r0 bit and stores all the values of the 16 bit in the final iteration.
        b nextStep

    notPressed:
        mov r6, #1
        lsl r6, r5               //shifts the output of the read data i times to move the bit to its placement
       

    nextStep:                    //
        //Enable Clock
        mov r0, #1               //Set clock to 1
        bl writeClock
        add r5, r5, #1           //incrementing loop counter
        cmp r5, #16
        blt wait6
    //////////////////////END OF WAIT6 INNER LOOP///////////////////////////////////////////////////
        mov r0, r9                      //holds which buttons were pressed
        pop {r5, r6, r9, lr}
        bx lr
      
    /////////////////////////END OF PAUSE FUNCTION///////////////////////////////////////////


    /////////////////////////////////INIT_GPIO/////////////////////////////////////////////
    Init_GPIO:
            push {r4, r5, r6, r7, r8, r9}    //Setting up memory in the stack
            mov r4, r0                      //saving the line #
            mov r5, r1                      //saving the function #
            ldr r8, =0x3F200000             //address for GPFSELO base
            cmp r4, #10                     // See if less than 10
            blt line9                       //line # is less than 10
            ldr r8, =0x3F200004             //Changes GPFSELO address when line # is 10 or 11
            sub r4, #10

    line9:  ldr r9, [r8]                    //copy GPFSELO into r9
            mov r2, #7                      //(b0111)
            mov r7, #3                      //helps calculate offsets
            mul r6, r4, r7                  //calculates the pin number
            lsl r2, r6                      //calculates the index of the pin number
            bic r9, r9, r2                  //clear the pin's bits
            lsl r5, r6                      //
            orr r9, r9, r5                  //set the pin #'s function
            str r9, [r8]                    //saving the pin #'s function

            pop {r4, r5, r6, r7, r8, r9}    // pop used registers
            mov pc, lr                      // return statement
//////////////////////////////END OF GPIO FUNCTION///////////////////////////////////

/////////////////////////////WRITE LATCH/////////////////////////////////////////////
writeLatch:  // WriteLatch subroutine, generic stuff from slides
    push {r4, r5}              // Push registers
    cmp r0, #0                 //if passed variable is equal to zero....
    beq clear
    ldr r4, =0x3F20001C        //sets register to zero
    b set                      //

    clear:
        ldr r4, =0x3F200028    // Clearing the bit

    set:
        mov r5, #0x00000200     //line
        str r5, [r4]

        pop {r4, r5}            // pops the registers
        mov pc, lr              // return statement
///////////////////////////////END OF WRITELATCH/////////////////////////////////////////


////////////////////////////////WRITE CLOCK//////////////////////////////////
writeClock:         // write clock subroutine
    push {r4, r5}   // push registers
    cmp r0, #0      //if passed variable is equal to zero....
    beq clear2      //
    ldr r4, =0x3F20001C          //sets register to zero
    b set2

    clear2:
        ldr r4, =0x3F200028         //address for clear register zero

    set2:
        mov r5, #0x00000800        //Line number for clock is 11
        str r5, [r4]               // stores it in r5
        pop {r4, r5}               // pop registers
        mov pc, lr                 // return statement
/////////////////END OF WRITE CLOCK////////////////////////////////////////////////

/////////////////////READ DATA////////////////////////////////////////////////////
readData:                // Readdata subroutine
    ldr r0, =0x3F200034  //address for level register 0
    ldr r1, [r0]         //loading contents...

    mov r3, #1           // set 1
    lsl r3, #10          // left shift 10 bits
    tst r1, r3           // ANDS * store in r1

    moveq r0, #0         //
    movne r0, #1         //
    mov pc, lr           // return statement

//////////////////END OF READ DATA///////////////////////////////////////////////////


/////////////////////////WAIT FUNCTION////////////////////////////////////////////////
wait:                   // Generic wait in slides
    mov r4, r0          //r0 is the passing time interval
    push {r4}           //allocate memory in stack for r4 and link register
  	ldr	r0, =0x3F003004 //Address of the timer counter
  	ldr	r1, [r0]		    //Copy the address
  	add	r1, r4			    //Add the passing time interval to the address

	waitLoop:             // generic waitLoop in slides
  		ldr	r2, [r0]      //
  		cmp	r1, r2        // stop when clock = r1
  		bhi	waitLoop      //

  	  pop {r4}			    // pop registers
      mov pc, lr        // return statement
//////////////////////////END OF WAIT FUNCTION/////////////////////////////////////////////

////////////////////////////////////////////////////PRINTING///////////////////////////////////////////////////
Print_Message:        // The print messagesubroutines
    push {r4}           // push the registers
    mov r4, r0                 // catch the inputs r0 and r1    

    checkUp:
        tst r4, #16
        beq checkLeft
        b   haltloop$2

    checkLeft:
        tst r4, #64
        beq checkRight
        b   haltloop$3

    checkRight:
        tst r4, #128
        beq checkA
        b   haltloop$4

    checkA:
        tst r4, #256
        beq checkSTART
        b   haltloop$1
        
    checkSTART:
        tst r4, #8
        beq checkDown 
        b   haltloop$5

    checkDown:
        tst r4, #32
        beq nothing 
        b haltloop$6
        
     
        b nothing

    

haltloop$1:                    // Terminates the program
        mov     r0, #1
        pop {r4}
        bx lr
haltloop$2:                    // Terminates the program
        mov     r0, #2
        pop {r4}
        bx lr
haltloop$3:                    // Terminates the program
        mov     r0, #3
        pop {r4}
        bx lr
haltloop$4:                    // Terminates the program
        mov     r0, #4
        pop {r4}
        bx lr

//If START button is pressed
haltloop$5:                     //Terminates the program 
        mov     r0, #5
        pop {r4}
        bx lr

//if down button is pressed
haltloop$6:
        mov     r0, #6
        pop {r4}
        bx lr

nothing: 
        mov r0, #0                     // If nothing was pressed,
        pop {r4}                         // pops the stack
    	bx lr

.section .init

.globl  incrementScreen
.globl  printScreen
.globl  changingScreens
.section .text
incrementScreen:
    push {r4, r6, lr}
    ldr r0, =currentScreen      // Loads the currentScreen address
    ldr r4, [r0]                // Loads the value of currentScreen
    add r4, #1                  // Increments the value by 1
    str r4, [r0]                // Stores it
    ldr r0, =xPos               // Loads the xPosition of flappy
    mov r1, #10                 // Resets it to 10
    str r1, [r0]                // Storem the new x coordinate

printScreen:
    ldr r0, =currentScreen  // Loads the address to currentScreen into r0
    ldr r4, [r0]			// Loads the decimal value of screen into r4
    screen4:
        cmp r4, #4          // Compares r4 (currentScreen) with decimal 4
        blt screen3         // if less than, move to next conditional
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgGamePlay4  //passing address of image
        bl draw             //calling draw function
        pop {r4, r6, lr}
	    mov	pc, lr			// return back

    screen3:
        cmp r4, #3          // Compares r4 (currentScreen) with decimal 0
        blt screen2
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgGamePlay3  //passing address of image
        bl draw             //calling draw function
        pop {r4, r6, lr}
	    mov pc, lr			// return back

    screen2:
        cmp r4, #2          // Compares r4 (currentScreen) with decimal 0
        blt screen1         // if less than, move to next conditional
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgGamePlay2  //passing address of image
        bl draw             //calling draw function
        pop {r4, r6, lr}
	    mov pc, lr			    // return back

    screen1:
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgGamePlay1  //passing address of image
        bl draw             //calling draw function    
        pop {r4, r6, lr}
	    mov pc, lr			// return back

.section .data 
changingScreens: .int   1 

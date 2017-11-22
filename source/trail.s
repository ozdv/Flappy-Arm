.section  .init
.global checkpipe
.global loc_update
.section  .text
checkpipe://////////////////////////////This subroutine loads the correct dimensions of the pipes depending on where the bird on the screen and which screen it is on///
    push {r4, lr}
    /////Load  the constant that stores which screen is being printed////////
    ldr r0, =currentScreen
    ldr r4, [r0]
    cmp r4, #1
    beq firstScreen                 //If the screen constant is 1, branch to firstScreen
    cmp r4, #2
    beq secondScreen                //If the screen constant is 2, branch to secondScreen
    cmp r4, #3
    beq thirdScreen                 //If the screen constant is 3, branch to thirdScreen
    cmp r4, #4
    beq fourthScreen                //if the screen constant is 4, branch to fourthScreen

    firstScreen:
        ldr r0, =dimensions       //Has the address of the dimensions of the bird
        ldr r4, [r0], #4          //Init x Value of where the picture starts to draw [top left x]
        cmp r4, #500              //Compares the position of the bird on the scree to find which pipe is is most likely to collide with
        bge secondPipe            //if the x coordinate of the bird is greater than 500, then it tests for collisions with the second pipe
        blt firstPipe             //if the x coordinate of the bird is less than 500, then it tests for collisions with the first pipe

        secondPipe:
            ldr r1, =scr1pipes2      //has the address of the Array of the second pipe in the first screen
            ldr r0, =925
            cmp r4, r0             //Checks if the bird is at the ending of a screen
            blt else
            bl incrementScreen     //Changes Screen if Bird is at the end of the screen
            mov r0, #10         //x starting position

            ldr r4, =yPos
            ldr r1, [r4]
            bl update         //branch to update function
        else:
            b fin                    //Finishes this Subroutine

        firstPipe:
            ldr r1, =scr1pipes1       //has the address of the array that stores the x values of the pipe range  NEEDS TO BE PARAMETERS
            b fin                     //Finishes this Subroutine

    secondScreen:
        ldr r0, =dimensions       //Has the address of the dimensions of the bird
        ldr r4, [r0], #4          //Init x Value of where the picture starts to draw [top left x]
        cmp r4, #500              //Compares the position of the bird on the scree to find which pipe is is most likely to collide with
        bge secondPipe2           //if the x coordinate of the bird is greater than 500, then it tests for collisions with the second pipe
        blt firstPipe2            //if the x coordinate of the bird is less than 500, then it tests for collisions with the first pi

        secondPipe2:
            ldr r1, =scr2pipes2      //has the address of the array that stores the y values of the pipe range
            ldr r0, =900
            cmp r4, r0             //Checks if the bird is at the ending of a screen
            blt else
            bl incrementScreen     //Changes Screen if Bird is at the end of the screen
            mov r0, #10         //x starting position

            ldr r4, =yPos
            ldr r1, [r4]
            bl update         //branch to update function

        firstPipe2:
            ldr r1, =scr2pipes1      //has the address of the array that stores the x values of the pipe range
            b fin                    //Finishes this Subroutine

    thirdScreen:
        ldr r0, =dimensions       //Has the address of the dimensions of the bird
        ldr r4, [r0], #4          //Init x Value of where the picture starts to draw [top left x]
        cmp r4, #500              //Compares the position of the bird on the scree to find which pipe is is most likely to collide with
        bge secondPipe3           //if the x coordinate of the bird is greater than 500, then it tests for collisions with the second pipe
        blt firstPipe3            //if the x coordinate of the bird is less than 500, then it tests for collisions with the first pi

        secondPipe3:
            ldr r1, =scr3pipes2      //has the address of the array that stores the y values of the pipe range  NEEDS TO BE PARAMETERS
            ldr r0, =900
            cmp r4, r0             //Checks if the bird is at the ending of a screen
            blt else
            bl incrementScreen     //Changes Screen if Bird is at the end of the screen
            mov r0, #10         //x starting position

            ldr r4, =yPos
            ldr r1, [r4]
            bl update         //branch to update function

        firstPipe3:
            ldr r1, =scr3pipes1      //has the address of the array that stores the x values of the pipe range  NEEDS TO BE PARAMETERS
            b fin                    //Finishes this Subroutine

    fourthScreen:
        ldr r0, =dimensions       //Has the address of the dimensions of the bird
        ldr r4, [r0], #4          //Init x Value of where the picture starts to draw [top left x]
        cmp r4, #500              //Compares the position of the bird on the scree to find which pipe is is most likely to collide with
        bge secondPipe4           //if the x coordinate of the bird is greater than 500, then it tests for collisions with the second pipe
        blt firstPipe4            //if the x coordinate of the bird is less than 500, then it tests for collisions with the first pi

        secondPipe4:
            ldr r1, =scr4pipes2      //has the address of the array that stores the y values of the pipe range  NEEDS TO BE PARAMETERS
            ldr r0, =850
            cmp r4, r0               //Checks if the bird is at the ending of a screen
            blge drawScoreWon     //Changes Screen if Bird is at the end of the screen
            b fin                    //Finishes this Subroutine

        firstPipe4:
            ldr r1, =scr4pipes1      //has the address of the array that stores the x values of the pipe range  NEEDS TO BE PARAMETERS

    fin:                           //Finishes this Subroutine
          pop {r4, lr}
          bx lr

loc_update:
    push {r4, r5, r6, r7, lr}
    ldr r0, =dimensions      //Has the address of the dimensions of the bird
    ldr r4, [r0], #4         //Init x Value of where the picture starts to draw [top left x]
    ldr r5, [r0]             //Init y value [top left y]
    ldr r7, [r1, #12]
    cmp r4, r7
    bne testFront

upScore:
    bl updateScore

testFront:      ///Front Coordinates comparisons////
    mov r6, #0
    add r3, r4, #90          //the birds beak x values
    add r6, r5, #33          //birds beak y values
    ldr r7, [r1]              //loading pipe dimensions
    cmp r3, r7                //if birds beak is touching x - pipe boundary...
    beq cmpFrnt_y             //...branches off to compare y pipe boundaries
    b   testTop

cmpFrnt_y:
    ldr r7, [r1, #4]
    cmp r6, r7
    ble die           //if bird is touching the y-value of the top pipe, it dies
    ldr r7, [r1, #8]
    cmp r6, r7        //if bird is touching the y-value of the bottom pipe, it dies
    bge die

testTop: ///Top coordinates comparisons////
    ldr r7, [r1, #4]
    cmp r5, r7              //compared this coordinate to the range of where the pipe is starting
    beq cmpTop_x
    b   testBottom

cmpTop_x: //checks the if bird is less than the max x-value of top pipe
    add r3, r4, #45          //this adds half of the width to the inital x value to get the middle of the x coordinate of the top of the bird
    ldr r7, [r1, #12]
    cmp r3, r7
    ble range1
    b   testBottom

//Checks if the top of the bird is greater than the min x-value of top pipe
range1:
    ldr r7, [r1]
    cmp r3, r7
    bge die           //if yes, it dies

//checks if bird is at the y-value of bottom pipe
testBottom://Botton coordinates testing////
    add r3, r4, #45
    add r6, r5, #65
    ldr r7, [r1, #8]
    cmp r6, r7
    beq cmpBottom_x
    b   testBack

//checks if bird is less than the max x-value of bottom pipe
cmpBottom_x:
    add r6, r5, #65
    ldr r7, [r1, #12]
    cmp r6, r7              //Comares to the y value of where the bottom pipe starts
    ble range2                  //if it is equal, bird dies
    b testBack

//checks if bird is greater than the max x-value of bottom pipe
range2:
    ldr r7, [r1]
    cmp r6, r7
    bge die                   //bird dies when its in between the top and bottom pipe and is touching the top or the bottom of the pipe

testBack:
    ///Back coordinates testing////
    add r6, r5, #33
    ldr r7, [r1, #12]
    cmp r4, r7
    beq cmpBack_y
    b   checkGround

cmpBack_y:
    ldr r7, [r1, #4]
    cmp r6, r7
    ble die
    ldr r7, [r1, #8]
    cmp r6, r7
    bge die

checkGround:
    ldr r1, =dimensions
    ldr r5, [r1, #4]                  //Load the y coordinate of the top of the bird in r5
    ldr r1, =656                      //loads 656 in r1
    cmp r5, r1                        //compares to see if the bird is on the ground
    beq die                           //if the bird is on the ground DIE BIRD DIIIIEEEEEE
    bne doNothing                     //If bird is not, come fly with me, lets fly, lets fly away

die:
    bl  decLives
    mov r4, r0
    b   endFunction


doNothing:
    mov r4, #0        //Boolean value for bird is still alive

endFunction:
    mov r0, r4
    pop {r4, r5, r6, r7, lr}
    bx lr

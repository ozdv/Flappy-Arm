.section    .init
.global _start
.global loc_update
.global checkpipe
.global scr1pipes1
.global scr1pipes2
.global scr2pipes1
.global scr2pipes2
.global scr3pipes1
.global scr3pipes2
.global scr4pipes1
.global scr4pipes2
.global currentScreen
.global startReading
.global enterGameCheck
.global main

_start: b       main

.section  .text
main:
    mov		sp, #0x8000000
    bl		EnableJTAG
    bl		InitFrameBuffer
    bl    initialization          //Calling for buttons pressed in the controller

    printMenu:
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgBGStart //passing address of image
        bl draw              //calling draw function
/*
//Game status update. Let know game has not started yet.
    ldr r0, =enterGameCheck
    mov r1, #1
    str r1, [r0]

*/
//Initializing infinite loop
    mov r10, #1

startReading:
    cmp r10, #1
    bne haltLoop$
    bl readSNES
    bl Print_Message
    mov r4, r0                  //catching button pressed
    mov r5, #1                  //Current button position. By default, position always starts on the START game button
    cmp r4, #0                  //bug fix...
    beq startReading

//Right Button
    cmp r4, #4         //If not pressed right...
    bne notRight        //... branch to notRight
    mov r5, #0          //update position to be on the STOP game button
    b stopMenu          //branch to stopMenu screen

//Left Button
notRight:
    cmp r4, #3          //if pressed left...
    bne notLeft             //...branch to notLeft
    mov r5, #1          //update position to be on the START game button
    b startMenu         //branch to startMenu screen

//A Button
notLeft:
    cmp r4, #1          //if not pressed A...
    bne haltLoop$            //branch to done
    cmp r5, #1          //Checks to see if the curent position of button is on START
    bne haltLoop$       //...branch off to terminating screen
    b startGAME         //..branch off to start gameplay screen

//Calls to print startMenu
startMenu:
    mov r0, #0          //passing x starting position of image
    mov r1, #0          //passing y starting position of image
    mov r2, #1024       //passing width of picture
    mov r3, #768        //passing height of picture
    ldr r6, =imgBGStart //passing address of image
    bl draw              //calling draw function
    b  startReading

//Calls to print stopMenu
stopMenu:
    mov r0, #0          //passing x starting position of image
    mov r1, #0          //passing y starting position of image
    mov r2, #1024       //passing width of picture
    mov r3, #768        //passing height of picture
    ldr r6, =imgBGStop  //passing address of image
    bl draw              //calling draw function
    b  startReading

//Calls to print startGame
startGAME:
    mov r0, #0          //passing x starting position of image
    mov r1, #0          //passing y starting position of image
    mov r2, #1024       //passing width of picture
    mov r3, #768        //passing height of picture
    ldr r6, =imgGamePlay1  //passing address of image
    bl draw             //calling draw function
    mov r0, #10         //x starting position
    mov r1, #300        //y starting position
    b update            //branch to update function

haltLoop$:  b		haltLoop$

.section .data
enterGameCheck: .int  1 // This label tells Interrupt when to stop
currentScreen:  .int  1 //This label tells program which screen it is currently on

scr1pipes1:     .int 400
                .int 130
                .int 340
                .int 470

scr1pipes2:     .int 830
                .int 250
                .int 390
                .int 900

scr2pipes1:     .int 270
                .int 250
                .int 450
                .int 340

scr2pipes2:     .int 720
                .int 180
                .int 380
                .int 790

scr3pipes1:     .int 300
                .int 350
                .int 550
                .int 370

scr3pipes2:     .int 790
                .int 240
                .int 450
                .int 860

scr4pipes1:     .int 306
                .int 350
                .int 550
                .int 370

scr4pipes2:     .int 630
                .int 280
                .int 480
                .int 705

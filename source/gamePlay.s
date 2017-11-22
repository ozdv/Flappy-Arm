.section .init
.globl update
.globl haltloop
.section .text
update:
        push {r4, lr}
        bl drawFlappy
        bl drawScore
        bl printLives

start:
        bl readSNES
        bl Print_Message
        mov r4, r0         //catching buttons pressed

        cmp r4, #5         //if START button is pressed...
        beq pauseButton    //...branch pause button

UP:     
        cmp r4, #2       //if UP is not pressed...
        bne start        //then bird stays still until UP is pressed

jump:
        bl      redrawBG
        mov r0, #1      //sets the isJump function to true. hence jumping
        bl isJump       //calls isJump function
        bl drawFlappy   //updates birds position graphically
        bl drawScore
        bl checkpipe
        bl loc_update
        cmp r0, #1      //if bird is dead...
        beq haltloop    //... end program

read:   
        bl readSNES
        bl Print_Message
        mov r4, r0         //catching buttons pressed

        cmp r4, #5         //if START button is pressed...
        beq pauseButton    //...branch pause button

        cmp r4, #2       //if UP is not pressed...
        beq jump         //loops back to take more input

falling:
        bl      redrawBG
        mov r0, #0      //sets the isJump function to false. Hence falling
        bl isJump
        bl drawFlappy
        bl drawScore
        bl checkpipe
        bl loc_update
        cmp r0, #1      //if bird is dead...
        beq haltloop    //... end program
        b  read

pauseButton:
        bl pauseON        //branch to the pause subroutine
        b  read

haltloop:
        pop {r4, lr}
        mov pc, lr
        b	haltloop

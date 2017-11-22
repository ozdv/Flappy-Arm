.section .init
.globl   pauseON
.globl   pauseOFF
.section  .text
pauseON:
        push {r4-r6, lr}

printStop:
        mov r0, #344             //x position
        mov r1, #156            //y position
        mov r2, #344            //width of picture
        add r2, r0
        mov r3, #456            //height of picture
        add r3, r1
        ldr r6, =imgPauseStop
        bl draw
        mov r5, #0              //button position on STOP

readON:
        bl readSNES
        bl Print_Message
        mov r4, r0              //capture button that is pressed

        cmp r4, #6              //if user does not press down...
        bne notDown             //... branch off to not down
        mov r5, #1              //update button position to be on restart
        bl printRestart        //branch to printRestart
        b  readON

notDown:
        cmp r4, #2              //if user does not press up...
        bne notUP         //...branch out of PauseON function
        mov r5, #0              //update button position to be on stop
        b printStop            //branch to printStop

printRestart:
        mov r0, #344             //x position
        mov r1, #156            //y position
        mov r2, #344            //width of picture
        add r2, r0
        mov r3, #456            //height of picture
        add r3, r1
        ldr r6, =imgPauseRestart
        bl draw

notUP:
        cmp r4, #1              //if user does not press A
        bne notA
        cmp r5, #0              //if button position is on STOP button...
        bne onRestart
        pop {r4-r6, lr}
        b main                 //branch back to Game Menu

onRestart:
        pop {r4-r6, lr}
        bl resetAll

notA:
        cmp r4, #5              //if user does not press pause while in pause mode...
        bne notPause            //...keep on reading until either user presses down, up, A or start
        b pauseOFF             //user pressed pause while in pause mode

notPause:
        b readON             //...keep on reading until either user presses down, up or start


pauseOFF:
        ldr r0, =dimensions
        ldr r4, [r0]            //saves current x-position
        ldr r5, [r0, #4]        //saves current y-position
        mov r0, #0          //passing x starting position of image
        mov r1, #0          //passing y starting position of image
        mov r2, #1024       //passing width of picture
        mov r3, #768        //passing height of picture
        ldr r6, =imgGamePlay1  //passing address of image
        bl draw              //calling draw function
        mov r0, r4         //passing current x-position of flappy
        mov r1, r5         //passing current y-position of flappy
        bl drawFlappy

end:
        pop {r4-r6, lr}
        mov pc, lr

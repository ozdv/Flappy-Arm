.section .init
.globl menuOperations
.globl startGAME
.section  .text

menuOperations: 
    push {r4, r5, r6, lr}
    mov r4, r0         //Catching the value of the button that was pressed by user
    mov r5, #1         //Current button position. By default, position always starts on the START game button 

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
    bne done            //branch to done
    cmp r5, #1          //Checks to see if the curent position of button is on START
    bne done        //...branch off to terminating screen     
    b startGAME         //..branch off to start gameplay screen 
    
//Calls to print startMenu
startMenu:   
    mov r0, #0          //passing x starting position of image 
    mov r1, #0          //passing y starting position of image 
    mov r2, #1024       //passing width of picture 
    mov r3, #768        //passing height of picture 
    ldr r6, =imgBGStart //passing address of image 
    bl draw              //calling draw function
    b done 

//Calls to print stopMenu
stopMenu:  
    mov r0, #0          //passing x starting position of image 
    mov r1, #0          //passing y starting position of image 
    mov r2, #1024       //passing width of picture
    mov r3, #768        //passing height of picture 
    ldr r6, =imgBGStop  //passing address of image 
    bl draw              //calling draw function
    b done 

//Calls to print startGame 
startGAME:
    mov r0, #0          //passing x starting position of image 
    mov r1, #0          //passing y starting position of image 
    mov r2, #1024       //passing width of picture
    mov r3, #768        //passing height of picture 
    ldr r6, =imgGamePlay1  //passing address of image 
    bl draw              //calling draw function
    mov r0, #10         //x starting position
    mov r1, #300        //y starting position 
    bl update         //branch to update function 
    b done 

done:
    pop {r4, r5, r6, lr}                   //exiting menuOperations function
    bx lr


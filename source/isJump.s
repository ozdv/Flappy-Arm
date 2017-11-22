.section .init
.globl   isJump
.globl  xPos
.globl  yPos

.section    .data
isJump:
    push {r4, r5, r6, r8, r9, r10, lr}
    mov r4, r0            //catching isJump boolean register
    cmp r4, #1           //if isJump is TRUE...
    beq Jump

no_Jump:
    ldr r0, =GRAVITY //loading address of constant GRAVITY
    ldr r1, [r0]     //grabbing contents from address

    ldr r2, =YVelocity
    ldr r3, [r2]

    add r3, r3, r1   //y_velocity += GRAVITY
    mov r8, r3       //saving y-velocity
    str r8, [r2]      //stroing y-velocity into the offset

    ldr r0, =X_VELOCITY //loading address of constant X_VELOCITY
    ldr r1, [r0]        //grabbing contents from address

    ldr r2, =xPos       //loading address of current x position
    ldr r3, [r2]        //grabbing contents from address

    add r3, r3, r1       //current_x += X_VELOCITY
    mov r9, r3          //saving current x-position
    str r9, [r2]

    ldr r0, =yPos       //loading address of current y-position
    ldr r1, [r0]        //grabbing contents from address

    add r1, r1, r8      //current_y += y_velocity
    mov r10, r1         //saving current y-position
    str r10, [r0]
    b   passValue

Jump:
    ldr r0, =JUMP   //loading address of constant JUMP
    ldr r1, [r0]    //grabbing contents from address

    ldr r2, =YVelocity  //loading adress of y-velocity
    ldr r3, [r2]        //grabbing contents from address

    add r3, r3, r1      //y-velocity += JUMP
    mov r8, r3          //saving y-velocity
    str r8, [r2]        //stored it in the offset of y-velocity

    mov r4, #0        //resetting isJUMP flag to false

    ldr r0, =X_VELOCITY //loading address of constant X_VELOCITY
    ldr r1, [r0]        //grabbing contents from address

    ldr r2, =xPos       //loading address of current x position
    ldr r3, [r2]        //grabbing contents from address

    add r3, r3, r1       //current_x += X_VELOCITY
    mov r9, r3          //saving current x-position
    str r9, [r2]        //stored it in the offset of x-position

    ldr r0, =yPos       //loading address of current y-position
    ldr r1, [r0]        //grabbing contents from address

    add r1, r1, r8      //current_y += y_velocity

    cmp r1, #40
    bge dontChange      //if bird is not at the top of the screen...
    mov r1, #40         //Otherwise, store 50 as its current y-value

dontChange:
    mov r10, r1         //saving current y-position
    str r10, [r0]       //storing current y-position in the offset of y-position
    b go

passValue:
    go:
    ldr r2, =656
    cmp r10, r2
    ldr r1, =656
    movle r1, r10          //returning y velocity
    mov r0, r9             //reutrning x velocity

    pop {r4, r5, r6, r8, r9, r10, lr}
    bx lr

.section    .data
GRAVITY:    .int 1     //setting gravity constant
X_VELOCITY: .int 5   //setting constant x_velocity
JUMP:       .int -3    //setting constant Jump value

YVelocity:  .int 0
xPos:       .int 10
yPos:       .int 300
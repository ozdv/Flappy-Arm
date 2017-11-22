.section  .init
.globl    reset
.globl    resetAll

.section  .data
reset:
    push {lr}

    ldr r0, =score
    ldr r1, [r0]
    mov r1, #0
    str r1, [r0]

    ldr r0, =currentScreen
    ldr r1, [r0]
    mov r1, #1
    str r1, [r0]

    ldr r0, =dimensions
    mov r4, #10
    mov r5, #300
    str r4, [r0]                // stores inputed x value (r4) into dimensions
    str r5, [r0, #4]            // stores inputed y value (r5) into dimensions

    ldr r0, =xPos
    ldr r1, [r0]
    mov r1, #10
    str r1, [r0]

    ldr r0, =yPos
    ldr r1, [r0]
    mov r1, #300
    str r1, [r0]
    b startGAME

    pop {lr}
    mov pc, lr

resetAll:
    push {lr}

    ldr r0, =score
    ldr r1, [r0]
    mov r1, #0
    str r1, [r0]

    ldr r0, =currentScreen
    ldr r1, [r0]
    mov r1, #1
    str r1, [r0]

    ldr r0, =totalLives
    ldr r1, [r0]
    mov r1, #3
    str r1, [r0]

    ldr r0, =dimensions
    mov r4, #10
    mov r5, #300
    str r4, [r0]                // stores inputed x value (r4) into dimensions
    str r5, [r0, #4]            // stores inputed y value (r5) into dimensions

    ldr r0, =xPos
    ldr r1, [r0]
    mov r1, #10
    str r1, [r0]

    ldr r0, =yPos
    ldr r1, [r0]
    mov r1, #300
    str r1, [r0]
    b startGAME

    pop {lr}
    mov pc, lr

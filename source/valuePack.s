.section .init
.globl valuePack
.globl firstValuePack
.globl valueExists 
.globl val_YPosition
.globl val_XPosition

.section .text
valuePack:



.section .data
//check to see if it is the first value pack drawn 
firstValuePack:  .int 0

//check to see if value pack already exists within the past 30s that has not been eaten 
valueExists:     .int 0 

//Value pack x position
val_XPosition:   .int 600

//Value pack y position
val_YPosition:   .int 300

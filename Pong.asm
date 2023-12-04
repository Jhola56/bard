; Define the game screen size
WIDTH equ 32
HEIGHT equ 24

; Define player coordinates
playerX equ 16
playerY equ 12

; Define ball coordinates
ballX equ 15
ballY equ 10

; Define ball movement direction
ballDirectionX equ 1
ballDirectionY equ 1

; Define game loop
start:
    ; Clear the screen
    mov ax, 0BH
    int 10H

    ; Draw the player
    mov dx, playerX
    mov dy, playerY
    mov al, 255
    int 13H

    ; Draw the ball
    mov dx, ballX
    mov dy, ballY
    mov al, 255
    int 13H

    ; Check if the ball hit the top or bottom wall
    cmp ballY, 1
    jl bounceTop
    cmp ballY, HEIGHT - 1
    jg bounceBottom

    ; Check if the ball hit the left or right wall
    cmp ballX, 1
    jl bounceLeft
    cmp ballX, WIDTH - 1
    jg bounceRight

    ; Move the ball
    mov ballX, ballX + ballDirectionX
    mov ballY, ballY + ballDirectionY

    ; Check for player input
    in al, 0
    cmp al, 0E0h ; check if the up arrow key is pressed
    jne skipUp
    dec ballY ; move the ball up
skipUp:
    cmp al, 0D0h ; check if the down arrow key is pressed
    jne skipDown
    inc ballY ; move the ball down
skipDown:
    cmp al, 0DEh ; check if the right arrow key is pressed
    jne skipRight
    inc ballX ; move the ball right
skipRight:
    cmp al, 0DFh ; check if the left arrow key is pressed
    jne skipLeft
    dec ballX ; move the ball left
skipLeft:

    ; Wait for a key press before continuing
    in al, 0
    jnz start

; Ball bounce functions
bounceTop:
    mov ballDirectionY, -ballDirectionY
    jmp start

bounceBottom:
    mov ballDirectionY, -ballDirectionY
    jmp start

bounceLeft:
    mov ballDirectionX, -ballDirectionX
    jmp start

bounceRight:
    mov ballDirectionX, -ballDirectionX
    jmp start

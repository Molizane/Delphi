
	org $8000

	xor a
	ld (message), a

	; Initialize value to be the number to convert
	ld a, (number)
	ld (value), a
	ld a, (number + 1)
	ld (value + 1), a

divide:
	; Initialize the reminder to zero
	xor a
	ld (mod10), a
	ld (mod10 + 1), a

	ld b, 16
divloop:
	; Rotate quotient and remaind
	ld hl, value
	rlc (hl)
	inc hl	; value + 1
	rlc (hl)

	inc hl ; ld hl, mod10
	rlc (hl)
	inc hl	; mod10 + 1
	rlc (hl)

	; a, c = dividend - divisor
	ld a, (mod10)
	sub a, 10
	ld c, a ; save low byte in c
	ld a, (mod10 + 1)
	sbc a, 0
	jr nc, ignore_result ; branch if dividend < divisor
	push af
	ld a, c
	ld (mod10), a
	pop af
	ld (mod10 + 1), a

ignore_result:
	dec b
	ld a, b
	and a
	jr nz, divloop

    scf
	ld hl, value
	rlc (hl) ; shift in the last bit of the quotient
	inc hl	; value +  1
	rlc (hl)

	ld a, (mod10)
	add a, "0"
	call push_char

	; if value != 0, then continue dividing
	ld a, (value)
	ld hl, value + 1
	or (hl)
	jr nz, divide ; branch if value not zero

	ld hl, message
print:
	ld a, (hl)
	and a
	jr z, loop
	call print_char
	inc hl
	jr print

	loop:
	jr loop

	; Add the character in the A register to the beginning of the
	; null-terminated string 'message'
push_char:
	push af ; Push the new char onto stack
	ld hl, message

char_loop:
	ld a, (hl) ; Get char on string and put into b
	ld b, a
	pop af
	ld (hl), a  ; Pull char off stack and add it to the string
	inc hl
	ld a, b
	push af            ; Push char from string onto stack
	jr nz, char_loop

	pop af
	ld (hl), a  ; Pull teh null off the stack and add to the end of the string
	ret

	print_char:
	ret

number: dw 1729
value: dw 0 ; 2 bytes
mod10: dw 0 ; 2 bytes
message: dw 0, 0, 0 ; 6 bytes


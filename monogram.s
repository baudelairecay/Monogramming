.global _start 
.data
.blank: .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
        .short 0,0,0,0,0,0,0,0
.text
_start:
	bl 	openfb
	cmp	x0, #0
	b.lt	EXIT 
	mov 	x8, x0

	# Get the color I want
	mov 	x0, #0
	mov 	x1, #0
	mov 	x2, #31
	bl	getColor
	mov 	x6, x0

	# Prepare registers for loops
	mov	x0, #1
	mov	x1, #2

TOP_C_LOOP:
	cmp	x1, #5
	b.eq	TOP_C_EXIT
	bl	setPixel
	
	add	x1, x1, #1
	b 	TOP_C_LOOP

TOP_C_EXIT:
	mov	x0, #2
	mov	x1, #5
	b	MID_C_LOOP

MID_C_LOOP:
	cmp 	x0, #6
	b.eq	MID_C_EXIT
	bl	setPixel

	add	x0, x0, #1
	b	MID_C_LOOP

MID_C_EXIT:
	mov	x0, #6
	mov	x1, #2
	b	BOTTOM_C_LOOP

BOTTOM_C_LOOP:
	cmp	x1, #5
	b.eq	PAUSE
	bl	setPixel
	
	add	x1, x1, #1
	b	BOTTOM_C_LOOP
PAUSE:
	sub	sp,sp,#16
	mov	x0, #1
	str	x0, [sp,#0]
	
	mov 	x0, #0
	str	x0, [sp,#8]

	mov	x0, sp
	mov	x1, #0
	mov	x8, #101
	svc	#0

	add	sp,sp,#16
	b 	CLEAR
	
CLEAR:	
	cmp 	x0, #0
	b.lt	CLEAR_EXIT
	ldr 	x0, =.blank
	bl	setGrid
CLEAR_EXIT:
	mov	x0, #1
	mov	x1, #5
	b	LEFT_H_LOOP
LEFT_H_LOOP:
	cmp	x0, #7
	b.eq	LEFT_H_EXIT
	bl	setPixel

	add	x0,x0,#1	
	b	LEFT_H_LOOP

LEFT_H_EXIT:
	mov	x0, #4
	mov	x1, #3
	b	MID_H_LOOP
	
MID_H_LOOP:
	cmp	x1, #5
	b.eq	MID_H_EXIT
	bl	setPixel	

	add	x1,x1,#1
	b	MID_H_LOOP

MID_H_EXIT:
	mov	x0, #1
	mov	x1, #2
	b	RIGHT_H_LOOP

RIGHT_H_LOOP:
	cmp	x0, #7
	b.eq	PAUSE2
	bl	setPixel

	add	x0,x0,#1
	b	RIGHT_H_LOOP
	
PAUSE2:
	sub     sp,sp,#16
        mov     x0, #1
        str     x0, [sp,#0]

        mov     x0, #0
        str     x0, [sp,#8]

        mov     x0, sp
        mov     x1, #0
        mov     x8, #101
        svc     #0

        add     sp,sp,#16
        b       CLEAR2
CLEAR2:
        cmp     x0, #0
        b.lt    EXIT
        ldr     x0, =.blank
        bl      setGrid	
		bl	closefb
	
EXIT:	
	mov	x0, #0
	mov 	x8, #94
	svc	#0
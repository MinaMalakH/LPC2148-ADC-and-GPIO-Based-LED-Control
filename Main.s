; LPC2148 ADC and GPIO-based LED control program
; Fully commented and rearranged for clarity
		AREA RESET, CODE, READONLY
        ENTRY
		
		
; ADC and GPIO Registers
PINSEL1     EQU 0xE002C004 ; PINSEL1 register address
IO0DIR      EQU 0xE0028008 ; GPIO direction register (P0)
IO0SET      EQU 0xE0028004 ; GPIO set register (P0)
IO0CLR      EQU 0xE002800C ; GPIO clear register (P0)
AD0CR       EQU 0xE0034000 ; ADC control register
AD0DR1      EQU 0xE0034014 ; ADC data register for Channel 0
	

; Main Program Entry Point
main 
		BL LED_INIT  ; Initialize LEDs (GPIO)
		BL ADC_INIT  ; Initialize ADC
		B loop       ; Enter main loop
		
	
; Main Loop	
loop
		BL ADC_START ; Start ADC conversion
		B loop 		 ; Repeat forever
		
; LED Initialization Subroutine
; Configures GPIO P0.0 to P0.9 as output for LEDs
LED_INIT
		LDR R0, =IO0DIR    ; Load address of GPIO direction register
		LDR R1 , [R0]	   ; Read current GPIO direction configuration
		LDR R2,=0x000003FF ; Mask for P0.0 to P0.9 (LED pins)
		ORR R1, R1, R2	   ; Set P0.0 to P0.9 as output (IO0DIR |= 0x3FF)
		STR R1, [R0]       ; Store updated direction configuration
		BX  LR			   ; Return from subroutine
		
; ADC Initialization Subroutine
; Configures P0.28 as AD0.1 and sets up ADC for 10-bit conversion
ADC_INIT
		LDR R0, =PINSEL1    ; Load address of PINSEL1 register
		LDR R1, =0x01000000 ; Configure P0.28 as AD0.1
		STR R1, [R0]        ; Store pin configuration
		
		; AD0CR --> ADC operational, 10-bits, 11 clocks for conversion 
		LDR R0, =AD0CR		; Load address of ADC control register	
		LDR R1, =0x00200402 ; Enable ADC, 10-bit resolution, 11 clock cycles
		STR R1, [R0] 		; Store ADC configuration
		BL loop    			; Return from subroutine

; ADC Start Subroutine
; Starts the ADC conversion process
ADC_START
		; Start Conversion
		LDR R0, =AD0CR           ; Load address of ADC control register
		LDR	R1, [R0]        	 ; Read current ADC control configuration
		ORR R1, R1, #(1 << 24)   ; Set START bit (bit 24) to initiate conversion
		STR R1, [R0]			 ; Wait for conversion to complete
		
		BL  wait_adc			 ; Wait for conversion to complete


; ADC Wait Subroutine
; Polls ADC until conversion is complete
ADC_READ
		LSR R0, R0, #6          ; result = (result>>6);
		
		
		LDR R1,=0x000003FF		; result = (result & 0x000003FF);
		AND R0, R1				;R0 Store result
		LDR R3 ,=0xE002800C	 
		LDR R1,=0x3FF
		STR R1 , [R3]			; CLEAR IO PINS 
		LDR R2, =IO0SET
		STR R0,[R2]				; SET NEW VALUE 
		BL ADC_START
		
	
wait_adc
		LDR	 R0,=0xE0034004	  ; Load address of AD0GDR (global ADC data register)
		LDR	 R0 , [R0] 		  ; Read current value of AD0GDR
        TST  R0, #0x80000000  ; Test if conversion complete (bit 31 is set)
        BEQ  wait_adc  		  ; If not complete, keep polling
		;Make START Bit 0
		LDR	R1 , =AD0CR       ; Load address of ADC control registe
		LDR	R2, [R1]		  ; Read current ADC control configuration
		LDR R3,=0xFEFFFFFF    ; Clear START bit (bit 24)
		AND R2,R3
		STR	R2,[R1]			  ; Store updated configuration
		BNE  ADC_READ		  ; Proceed to read ADC value
		
        END

;Deniz Burak


INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester BYTE "String Example",0
	vAssignment BYTE "String Example 2",0
	vName BYTE "Deniz Burak",0
	vPropmt BYTE"Please enter your MP3 frame header in hex format:",0

	vMPEG25 BYTE "MPEG version 2.5",0
	VMPEG20 BYTE "MPEG Version 2.0",0
	VMPEG10 BYTE "MPEG Version 1.0",0
	vMPEGRES BYTE "MPEG version Reserved",0

	vLayerDescription00 BYTE "RESERVED LAYER",0
	vLayerDescription11 BYTE "Layer 1",0
	vLayerDescription10 BYTE "Layer 2",0
	vLayerDescription01 BYTE "Layer 3",0

	vSamplingRateMPEG100 BYTE "Sampling Rate: 44100Hz",0
	vSamplingRateMPEG101 BYTE "Sampling Rate: 48000Hz",0
	vSamplingRateMPEG110 BYTE "Sampling Rate: 32000Hz",0
	;vSamplingRateMPEG111 BYTE "Sampling Rate: RESERVED",0

	vSamplingRateMPEG200 BYTE "Sampling Rate:22050Hz",0
	vSamplingRateMPEG201 BYTE "Sampling Rate:24000Hz",0
	vSamplingRateMPEG210 BYTE "Sampling Rate:16000Hz",0
	;vSamplingRateMPEG211 BYTE "Sampling Rate:RESERVED",0

	vSamplingRateMPEG2500 BYTE "Sampling Rate:11025",0
	vSamplingRateMPEG2501 BYTE "Sampling Rate:12000",0
	vSamplingRateMPEG2510 BYTE "Sampling Rate:8000",0
	vSamplingRateMPEGRESERVED BYTE "Sampling Rate:RESERVED",0


.code
main PROC

	;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	call clrscr

		mov dh, 12
		mov dl, 12
		call Gotoxy

		mov edx, OFFSET vSemester
		call writeString

	
		mov dh, 13
		mov dl, 12
		call Gotoxy

		mov edx, OFFSET vAssignment
		call writeString

	
		mov dh, 14
		mov dl, 12
		call Gotoxy

		mov edx, OFFSET vName
		call writeString


		mov dh, 16
		mov dl, 12
		call Gotoxy

		mov edx, OFFSET vPropmt
		call writeString


		call readhex
		mov ecx, eax


	;call displaySemester
	;call displayAssignment
	;call displayName
	;call displayPrompt
	;call displayVersion
	call displayVersion

	mov dh, 19
	mov dl, 0
	call gotoxy
	call displayVersion

	mov eax, ecx
	mov dh, 18
	mov dl, 0
	call Gotoxy
	call displayLayer

	mov eax, ecx
	mov dh, 19
	mov dl, 0
	call Gotoxy
	call displaySamplingRate
 


	jmp theEnd
	
		displayVersion:

			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM

	and eax, 00000000000110000000000000000000b
	shr eax, 19
	
	cmp eax, 00b
	jz dMPEG25

	cmp eax, 01b
	jz dMPEGRES

	cmp eax, 10b
	jz dMPEG20

	dMPEG10:
	mov edx, offset vMPEG10
	jmp DisplayString

	dMPEG25:
	mov edx, offset vMPEG25
	jmp DisplayString

	dMPEGRES:
	mov edx, offset vMPEGRES
	jmp DisplayString

	dMPEG20:
	mov edx, offset vMPEG20
	jmp DisplayString

		displayLayer:
		;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM

		 and eax, 00000000000001100000000000000000b
			shr eax, 17

	cmp eax, 00b
	jz dLayerDescription00

	cmp eax, 01b
	jz dLayerDescription01

	cmp eax, 10b
	jz dLayerDescription10

	dLayerDescription11:
	mov edx, offset vLayerDescription11
	jmp DisplayString

	dLayerDescription00:
	mov edx, offset vLayerDescription00
	jmp DisplayString

	dLayerDescription01:
	mov edx, offset vLayerDescription01
	jmp DisplayString

	dLayerDescription10:
	mov edx, offset vLayerDescription10
	jmp DisplayString



		displaySamplingRate:

	;	and eax, 00000000000110000000000000000000b
	; shr eax, 19
	; cmp eax, 01b
	; jz dSamplingRateMPEGRESERVED  ;<============ this one gives you a result when Verison is RESERVED, Sampling Rate is also RESERVED

		
		;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM

	and eax, 00000000000110000000110000000000b
	shr eax, 10


	cmp eax, 11000000000b
	jz dSamplingRateMPEG100


	cmp eax, 10000000000b
	jz dSamplingRateMPEG200

	cmp eax, 00000000000b
	jz dSamplingRateMPEG2500


	cmp eax, 11000000001b
	jz dSamplingRateMPEG101

	cmp eax, 10000000001b
	jz dSamplingRateMPEG201

	cmp eax, 00000000001b
	jz dSamplingRateMPEG2501

	cmp eax, 11000000010b
	jz dSamplingRateMPEG110


	cmp eax, 10000000010b 
	jz dSamplingRateMPEG210

	cmp eax, 00000000010b
	jz dSamplingRateMPEG2510

	cmp eax, 11000000011b
	jz dSamplingRateMPEGRESERVED

	cmp eax, 10000000011b
	jz dSamplingRateMPEGRESERVED

	cmp eax, 00000000011b
	jz dSamplingRateMPEGRESERVED


	dSamplingRateMPEG100:
	mov edx, offset vSamplingRateMPEG100
	jmp DisplayString


	dSamplingRateMPEG200:
	mov edx, offset vSamplingRateMPEG200
	jmp DisplayString


	dSamplingRateMPEG2500:
	mov edx, offset vSamplingRateMPEG2500
	jmp DisplayString
	
	dSamplingRateMPEG101:
	mov edx, offset vSamplingRateMPEG101
	jmp DisplayString


	dSamplingRateMPEG201:
	mov edx, offset vSamplingRateMPEG201
	jmp DisplayString


	dSamplingRateMPEG2501:
	mov edx, offset vSamplingRateMPEG2501
	jmp DisplayString


	dSamplingRateMPEG110:
	mov edx, offset vSamplingRateMPEG110
	jmp DisplayString


	dSamplingRateMPEG210:
	mov edx, offset vSamplingRateMPEG210
	jmp DisplayString


	dSamplingRateMPEG2510:
	mov edx, offset vSamplingRateMPEG2510
	jmp DisplayString

	
	dSamplingRateMPEGRESERVED:
	mov edx, offset vSamplingRateMPEGRESERVED
	jmp DisplayString
	

	DisplayString:
	call writeString

	ret

theEnd:
	xor ecx, ecx
	call readchar
	 

	exit
main ENDP

END main

_main:

;adc.c,23 :: 		void main() {
;adc.c,24 :: 		chs0_bit=0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;adc.c,25 :: 		chs1_bit=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;adc.c,26 :: 		chs2_bit=0;
	BCF        CHS2_bit+0, BitPos(CHS2_bit+0)
;adc.c,28 :: 		trisa=0xff;
	MOVLW      255
	MOVWF      TRISA+0
;adc.c,29 :: 		ADC_init();
	CALL       _ADC_Init+0
;adc.c,30 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
	NOP
;adc.c,31 :: 		lcd_init();
	CALL       _Lcd_Init+0
;adc.c,32 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;adc.c,33 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;adc.c,34 :: 		while(1)
L_main1:
;adc.c,36 :: 		a=ADC_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;adc.c,37 :: 		b=(float)(a*5)/1024;
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+4
	MOVF       R0+1, 0
	MOVWF      FLOC__main+5
	MOVF       R0+2, 0
	MOVWF      FLOC__main+6
	MOVF       R0+3, 0
	MOVWF      FLOC__main+7
	MOVF       FLOC__main+4, 0
	MOVWF      _b+0
	MOVF       FLOC__main+5, 0
	MOVWF      _b+1
	MOVF       FLOC__main+6, 0
	MOVWF      _b+2
	MOVF       FLOC__main+7, 0
	MOVWF      _b+3
;adc.c,38 :: 		Resistance=(long)((10000*b)/(5-b));
	MOVLW      0
	MOVWF      R0+0
	MOVLW      64
	MOVWF      R0+1
	MOVLW      28
	MOVWF      R0+2
	MOVLW      140
	MOVWF      R0+3
	MOVF       FLOC__main+4, 0
	MOVWF      R4+0
	MOVF       FLOC__main+5, 0
	MOVWF      R4+1
	MOVF       FLOC__main+6, 0
	MOVWF      R4+2
	MOVF       FLOC__main+7, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVF       FLOC__main+4, 0
	MOVWF      R4+0
	MOVF       FLOC__main+5, 0
	MOVWF      R4+1
	MOVF       FLOC__main+6, 0
	MOVWF      R4+2
	MOVF       FLOC__main+7, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      129
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	CALL       _double2longint+0
	MOVF       R0+0, 0
	MOVWF      _Resistance+0
	MOVF       R0+1, 0
	MOVWF      _Resistance+1
	MOVF       R0+2, 0
	MOVWF      _Resistance+2
	MOVF       R0+3, 0
	MOVWF      _Resistance+3
;adc.c,39 :: 		if (Resistance > 1000) { Resistance/=1000; lcd_out(1,5,"K"); }
	MOVLW      128
	MOVWF      R4+0
	MOVLW      128
	XORWF      R0+3, 0
	SUBWF      R4+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVF       R0+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVF       R0+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVF       R0+0, 0
	SUBLW      232
L__main7:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _Resistance+0, 0
	MOVWF      R0+0
	MOVF       _Resistance+1, 0
	MOVWF      R0+1
	MOVF       _Resistance+2, 0
	MOVWF      R0+2
	MOVF       _Resistance+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _Resistance+0
	MOVF       R0+1, 0
	MOVWF      _Resistance+1
	MOVF       R0+2, 0
	MOVWF      _Resistance+2
	MOVF       R0+3, 0
	MOVWF      _Resistance+3
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_adc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main4
L_main3:
;adc.c,40 :: 		else lcd_out(1,10,"E");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_adc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main4:
;adc.c,41 :: 		floattostr_fixlen(Resistance,txt,5);
	MOVF       _Resistance+0, 0
	MOVWF      R0+0
	MOVF       _Resistance+1, 0
	MOVWF      R0+1
	MOVF       _Resistance+2, 0
	MOVWF      R0+2
	MOVF       _Resistance+3, 0
	MOVWF      R0+3
	CALL       _longint2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      5
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;adc.c,42 :: 		lcd_out(1,1,"R= ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_adc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;adc.c,43 :: 		lcd_out(1,3,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;adc.c,45 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;adc.c,46 :: 		}
	GOTO       L_main1
;adc.c,47 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

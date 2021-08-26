#line 1 "C:/Users/Mufaddal Darbar/Desktop/Project dumps/mikroc/adc/adc.c"
sbit lcd_rs at rc0_bit;
sbit lcd_en at rc1_bit;
sbit lcd_d4 at rc2_bit;
sbit lcd_d5 at rc3_bit;
sbit lcd_d6 at rc4_bit;
sbit lcd_d7 at rc5_bit;

sbit lcd_rs_direction at trisc0_bit;
sbit lcd_en_direction at trisc1_bit;
sbit lcd_d4_direction at trisc2_bit;
sbit lcd_d5_direction at trisc3_bit;
sbit lcd_d6_direction at trisc4_bit;
sbit lcd_d7_direction at trisc5_bit;
int a;


float b;
long Resistance;
char txt[7];



void main() {
chs0_bit=0;
chs1_bit=1;
chs2_bit=0;

trisa=0xff;
ADC_init();
delay_ms(100);
lcd_init();
lcd_cmd(_lcd_clear);
lcd_cmd(_lcd_cursor_off);
while(1)
{
a=ADC_read(2);
b=(float)(a*5)/1024;
Resistance=(long)((10000*b)/(5-b));
if (Resistance > 1000) { Resistance/=1000; lcd_out(1,5,"K"); }
else lcd_out(1,10,"E");
floattostr_fixlen(Resistance,txt,5);
lcd_out(1,1,"R= ");
lcd_out(1,3,txt);

delay_ms(500);
}
}

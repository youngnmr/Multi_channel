// sequence work well
#include <stdio.h>
#include "xil_types.h"
#include "xio.h"
#include "xparameters.h"
#include "xiomodule_l.h"
#include "si5340_registers.h"
#include "microblaze_sleep.h"

#define GPO2 XPAR_IOMODULE_SINGLE_BASEADDR+XGO_OUT_OFFSET+4


 //void delay(int value) {	MB_Sleep(value); }

volatile int x,y,z;

int spi_delay() {
	for (y=0;y<1;y++) {	z++;
	}
	return z;
	}

u32 spi_cs_bit;
int spi_cs(u8 value){
	if(value){spi_cs_bit = 0x00000004;}
	else {spi_cs_bit = 0x00000000;}
	return spi_cs_bit;
					}

u32 spi_clk_bit;
int spi_sclk(u8 value){
	if(value){spi_clk_bit = 0x00000001;}
	else {spi_clk_bit = 0x00000000;}
	return spi_clk_bit;
  //XIo_Out32(GPO1, spi_clk_bit);
}

u32 spi_sdo_bit;
int spi_sdo(u8 value){
	if(value){spi_sdo_bit = 0x00000002;}
	else {spi_sdo_bit = 0x00000000;}
	return spi_sdo_bit;
  }


//u32 cs_shadow;
void cs_high(u8 value)
{
  unsigned char i;
  for(i = 0; i <= value; i++)
  {
    /*if(i == value){
    	spi_sclk(0);
		spi_cs(1);
		XIo_Out32(GPO1, spi_clk_bit | spi_cs_bit);
		spi_delay();
		spi_delay();
		spi_sclk(1);
		XIo_Out32(GPO1, spi_clk_bit);
    }
    else */

        spi_sclk(0);
        spi_cs(1);
        XIo_Out32(GPO2, spi_clk_bit | spi_cs_bit);
        spi_delay();
        spi_delay();
        spi_sclk(1);
        spi_cs(1);
        XIo_Out32(GPO2, spi_clk_bit | spi_cs_bit);
        spi_delay();
        spi_delay();

  }
}

//delay
void delay(u32 value)
{
	int k, m;
	for (k = 0; k <= value; k++){
		for(m = 0; m <= 200; m++){
			spi_cs(1);
			spi_sclk(0);
			XIo_Out32(GPO2, spi_clk_bit | spi_cs_bit);
			spi_delay();
			spi_delay();

			spi_cs(1);
			spi_sclk(1);
			XIo_Out32(GPO2, spi_clk_bit | spi_cs_bit);
			spi_delay();
			spi_delay();
		}
	}
}


//spi_run
void spi_run(u8 command, u8 val)
{
  //transfer command
spi_cs(0);
int i;
for(i = 0; i < 8; i++){
  spi_sclk(0);

  spi_sdo((command >> 7)&1);
  XIo_Out32(GPO2, spi_sdo_bit | spi_clk_bit | spi_cs_bit);
  spi_delay();
  spi_delay();
  //spi_delay();
  spi_sclk(1);
  //spi_sdo((command >> 7)&1);
  XIo_Out32(GPO2, spi_sdo_bit | spi_clk_bit | spi_cs_bit);
  spi_delay();
  command = command << 1;
}

int j;
for (j =0; j < 8; j++){
  //transfer val
  spi_sclk(0);
  spi_sdo((val >> 7)&1);
  XIo_Out32(GPO2, spi_sdo_bit | spi_clk_bit | spi_cs_bit);
  spi_delay();
  spi_delay();
  spi_sclk(1);
  //spi_sdo((val >> 7)&1);
  XIo_Out32(GPO2, spi_sdo_bit | spi_clk_bit | spi_cs_bit);
  spi_delay();
  val = val <<1;
}
}

int si5340_init(){
	int cnt;
	si5340_revd_register_t reg_map;

	for(cnt = 0; cnt <= SI5340_REVD_REG_CONFIG_NUM_REGS; cnt++){
		if (cnt == 6)
			{
			delay(800);
			reg_map = si5340_revd_registers[cnt];
			cs_high(4);
			spi_run(0x00, 0x01); // point to page register address
			cs_high(4);
			spi_run(0x40, reg_map.address >> 8); // write address to page register
			cs_high(4);
			spi_run(0x00, reg_map.address &0x00ff); // point to resister address
			cs_high(4);
			spi_run(0x40, reg_map.value); // write data to the address
			}

		else if (cnt == SI5340_REVD_REG_CONFIG_NUM_REGS)
		{
			cs_high(1);
			XIo_Out32(GPO2, spi_cs_bit);
			cnt = 400;
		}
		else{
			reg_map = si5340_revd_registers[cnt];
			cs_high(4);
			spi_run(0x00, 0x01); // point to page register address
			cs_high(4);
			spi_run(0x40, reg_map.address >> 8); // write address to page register
			cs_high(4);
			spi_run(0x00, reg_map.address &0x00ff); // point to resister address
			cs_high(4);
			spi_run(0x40, reg_map.value); // write data to the address
		}
	}
	return 0;
}


#include <stdio.h>
#include "xil_types.h"
#include "xparameters.h"
#include "xio.h"
#include "xiomodule_l.h"
#include "si5340.h"

#define set_address 0x00
#define write_data 0x40
#define GPO1 XPAR_IOMODULE_SINGLE_BASEADDR+XGO_OUT_OFFSET

/*u32 GPO1_shadow; */
void spi_cs(u8 value){
	if(value){XIo_Out32(GPO1, 0x00000001);}
	else {XIo_Out32(GPO1, 0x00000000);}
}

void spi_sclk(u8 value){
	if(value){XIo_Out32(GPO1, 0x00000002);}
		else {XIo_Out32(GPO1, 0x00000000);}
}

void spi_sdo(u8 value){
	if(value){XIo_Out32(GPO1, 0x00000004);}
		else {XIo_Out32(GPO1, 0x00000000);}
}

// clock loop
void clock_loop(u8 period){
	int i;
	for(i = 0; i < period; i++)
		{
		 spi_cs(1);
		 spi_sclk(1);
		 spi_sclk(0);
		}
}

void spiWriteReg(const unsigned char regAddr, const unsigned char regData)
{
  unsigned char SPICount;                               // Counter used to clock out the data
  unsigned char SPIData;                                // Define a data structure for the SPI data.
  spi_cs(1);                                           // Make sure we start with /CS high
  spi_sclk(0);                                           // and CK low
  clock_loop(5);
  // procedure: 'set address' >> address[7:0] >> 'write data'  >> Data[7:0]
  //....................................................................
  //set address
  //....................................................................
  SPIData = set_address;
  spi_cs(0);

    for (SPICount = 0; SPICount < 8; SPICount++)
      {
    	if (SPIData & 0x80)
    		spi_sdo(1);
    	else
    		spi_sdo(0);
    	spi_sclk(1);                                         // Toggle the clock line
    	spi_sclk(0);
    	SPIData <<= 1;                                      // Rotate to get the next bit
      }

  // write address
  SPIData = regAddr;

  for (SPICount = 0; SPICount < 8; SPICount++)          // Prepare to clock out the Address byte
  {
	if (SPIData & 0x80)                                 // Check for a 1
		spi_sdo(1);                                     // and set the MOSI line appropriately
	else
		spi_sdo(0);
	spi_sclk(1);                                         // Toggle the clock line
	spi_sclk(0);
	SPIData <<= 1;                                      // Rotate to get the next bit
  }

  clock_loop(5);

  //set write	  	  	  	  	  	  	  	  	  	  	  	  	  	 // Repeat for the Data byte
  SPIData = write_data;
  for (SPICount = 0; SPICount < 8; SPICount++)          // Prepare to clock out the Data
    {
  	if (SPIData & 0x80)
  		spi_sdo(1);
  	else
  		spi_sdo(0);
  	spi_sclk(1);                                         // Toggle the clock line
  	spi_sclk(0);
  	SPIData <<= 1;
    }

  //write data
  SPIData = regData;                                    // Preload the data to be sent with Data
  for (SPICount = 0; SPICount < 8; SPICount++)          // Prepare to clock out the Data
  {
	if (SPIData & 0x80)
		spi_sdo(1);
	else
		spi_sdo(0);
	spi_sclk(1);                                         // Toggle the clock line
	spi_sclk(0);
	SPIData <<= 1;
  }
  	  spi_cs(1);
  	  spi_sdo(0);
}

int si5340_init(){

	int counter;
	//unsigned char

	/*start configuration preamble */

	si5340_revd_register_t cur;

	for (counter=0;counter < 6; counter++){
		cur = si5340_register[counter];
		spiWriteReg(cur.address, cur.value);
	}
	/* End configuration preamble */



	//delay(300);
	/* Start configuration registers */

	for(counter=6;counter < SI5340_REVD_REG_CONFIG_NUM_REGS; counter++){
		cur = si5340_register[counter];
		spiWriteReg(cur.address, cur.value);
	}

return 0;

}


int main()
{

  si5340_init();
  return 0;
}

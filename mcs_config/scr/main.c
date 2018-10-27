#include <stdio.h>


#include "xil_types.h"
#include "xparameters.h"


#include "xio.h"
#include "microblaze_sleep.h"

#include "xiomodule_l.h"

u32 GPO1_shadow;

int si5338_init();
int si5340_init();
/*
 *
 *
 *
 *
 */
#define GPO1 XPAR_IOMODULE_SINGLE_BASEADDR+XGO_OUT_OFFSET

int main()
{
	GPO1_shadow = 0x00000003;

	si5340_init();

	MB_Sleep(50);

    si5338_init();


    XIo_Out32(GPO1, 0x80000003);

    return 0;
}

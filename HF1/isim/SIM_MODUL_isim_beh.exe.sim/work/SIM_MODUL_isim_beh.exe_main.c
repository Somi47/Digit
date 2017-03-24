/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001698170089_3175008490_init();
    work_m_00000000004291548587_2473895152_init();
    work_m_00000000000404930446_4070000269_init();
    work_m_00000000003330570008_2335345304_init();
    work_m_00000000003447601098_2777409936_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000003447601098_2777409936");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}

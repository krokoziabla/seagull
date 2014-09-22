void test(void)
{
    volatile unsigned        * rcc_cr = 0x40023800;
    *rcc_cr = 0x0;
}

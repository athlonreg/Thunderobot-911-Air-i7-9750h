/*
 * Find _CRS:          5F 43 52 53
 * Replace XCRS:       58 43 52 53
 * Target Bridge TPD0: 54504430
 */
DefinitionBlock("", "SSDT", 2, "hack", "I2Cpatch", 0)
{
    External(_SB.PCI0.I2C1.TPD0, DeviceObj)
    External(_SB.PCI0.I2C1.TPD0.SBFB, IntObj)
    Scope(_SB.PCI0.I2C1.TPD0)
    {
        Name (SBFZ, ResourceTemplate ()
        {
            GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
               "\\ _SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x2F // Try this if the first one doesn't work: 0x12F
                }
        })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFZ))
            }
    }
}
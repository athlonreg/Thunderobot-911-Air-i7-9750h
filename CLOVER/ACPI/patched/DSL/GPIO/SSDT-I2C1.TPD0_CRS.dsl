/*
 * In ACPI -> Patch:
 * Comment: I2C:_CRS to XCRS in TPD0
 * Find:    115F4352 5300A484 53
 * Replace: 11584352 5300A484 53
 */
DefinitionBlock ("", "SSDT", 2, "hack", "CRSpatch", 0x00000000)
{
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)

    Scope (_SB.PCI0.I2C1.TPD0)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (XBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0020, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (XBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
                {
                    0x00000000,
                }
            })
            Name (XBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x002F //0x003F
                    }
            })

            Return (ConcatenateResTemplate (XBFB, XBFG))
        }
    }
}


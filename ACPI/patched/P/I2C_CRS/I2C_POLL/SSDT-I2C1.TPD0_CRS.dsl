// CRS for Thunderobot 911 Air2 9750h
// In config ACPI, TPD0:_CRS to XCRS
// Find:     5F 43 52 53
// Replace:  58 43 52 53
// TgtBridge:54 50 44 30
//
DefinitionBlock ("", "SSDT", 2, "hack", "_CRS", 0x00000000)
{
    External (_SB_.PCI0.GPI0._STA, MethodObj)    // 0 Arguments (from opcode)
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)    // (from opcode)

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
                        0x002F
                    }
            })
            Store (\_SB.PCI0.GPI0._STA (), Local0)
            If (LNotEqual (Local0, Zero))
            {
                Return (ConcatenateResTemplate (XBFB, XBFG))
            }
            Else
            {
                Return (ConcatenateResTemplate (XBFB, XBFI))
            }
        }
    }
}


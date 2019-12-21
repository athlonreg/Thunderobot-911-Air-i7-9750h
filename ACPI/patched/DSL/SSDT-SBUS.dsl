//
DefinitionBlock ("", "SSDT", 2, "hack", "SBUS", 0)
{
    External (_SB_.PCI0.SBUS, DeviceObj)

    Scope (_SB.PCI0.SBUS)
    {
        Device (BUS0)
        {
            Name (_CID, "smbus")
            Name (_ADR, Zero)
            Device (BUS0)
            {
                Name (_CID, "smbus")  // _CID: Compatible ID
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (BUS1)
            {
                Name (_CID, "smbus")  // _CID: Compatible ID
                Name (_ADR, One)  // _ADR: Address
            }
            
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
}


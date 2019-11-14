// BrightKey for TP
// In config ACPI, _Q60 to XQ60(TP-up)
// Find:     5F 51 36 30
// Replace:  58 51 36 30

// In config ACPI, _Q6E to XQ6E(TP-down)
// Find:     5F 51 36 45
// Replace:  58 51 36 45
//
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.XQ60, MethodObj)
    External(_SB.PCI0.LPCB.EC0.XQ6E, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q60, 0, Serialized)//up
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ60()
            }
        }

        Method (_Q6E, 0, Serialized)//down
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ6E()
            }
        }
    }
}
//EOF
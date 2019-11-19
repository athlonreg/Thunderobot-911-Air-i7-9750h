// GPI0 for Thunderobot 911 Air2 9750h
// In config ACPI, GPI0:_STA to XSTA
// Find:     5F 53 54 41
// Replace:  58 53 54 41
// TgtBridge:47 50 49 30
//
DefinitionBlock ("", "SSDT", 2, "hack", "GPI0", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.GPI0.XSTA, MethodObj)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PCI0.GPI0.XSTA ())
            }
        }
    }
}


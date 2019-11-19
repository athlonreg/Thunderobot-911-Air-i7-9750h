// In config ACPI, GPI0:_STA to XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:47504930
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "GPI0", 0x00000000)
{
#endif
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.GPI0.XSTA, MethodObj)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.GPI0.XSTA ())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

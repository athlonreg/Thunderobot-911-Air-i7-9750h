// In config ACPI, _Q60 to XQ60(Thunderobot-911-Air2-9750h-FnF1)
// Find:     5F 51 36 30
// Replace:  58 51 36 30
//
DefinitionBlock("", "SSDT", 2, "hack", "FnF4", 0)
{
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ60, MethodObj)
    External(_SB.PCI9.FNOK, IntObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q60, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                \_SB.PCI9.FNOK =1
            }
            \_SB.PCI0.LPCB.EC.XQ60()
        }
    }
}
//EOF
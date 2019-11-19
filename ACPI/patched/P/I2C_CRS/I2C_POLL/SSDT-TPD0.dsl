// GPI0 for Thunderobot 911 Air2 9750h
// In config ACPI, TPD0:_STA to XSTA
// Find:     5F 53 54 41
// Replace:  58 53 54 41
// TgtBridge:54 50 44 30
//
DefinitionBlock ("", "SSDT", 2, "hack", "TPD0", 0x00000000)
{
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C1.TPD0.XSTA, MethodObj)    // 0 Arguments (from opcode)

    Scope (_SB.PCI0.I2C1.TPD0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.TPD0.XSTA ())
            }
        }
    }
}


// In config ACPI, _Q60 to XQ60
// Find:     5F 51 36 30
// Replace:  58 51 36 30
//
DefinitionBlock("", "SSDT", 2, "ACDT", "TEST", 0)
{
    External(XQ60, MethodObj)
    External(RMDT.P1, MethodObj)
    
    Method (_Q60, 0, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            \RMDT.P1("AAA001")
        }
        \XQ60()
    }
}
//EOF
//
DefinitionBlock("", "SSDT", 2, "ACDT", "PNLF", 0)
{
    External (_SB.PCI0.GFX0, DeviceObj)
    
    Scope(_SB.PCI0.GFX0)
    {
        Device(PNLF)
        {
            Name(_ADR, Zero)
            Name(_HID, EisaId ("APP0002"))
            Name(_CID, "backlight")
            //CoffeeLake+
            Name(_UID, 19)
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }        
    }
}
//EOF
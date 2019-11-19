//Disables DGPU
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "NDGP", 0)
{
#endif
    External(_SB.PCI0.PEG0.PEGP._ON, MethodObj)
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    
    Device(DGPU)
    {
        Name(_HID, "DGPU1000")
        Method(_INI)
        {
            _OFF()
        }
         
        Method(_ON)
        {
            If (CondRefOf (\_SB.PCI0.PEG0.PEGP._ON)){\_SB.PCI0.PEG0.PEGP._ON()}
        }
        
        Method(_OFF)
        {
            If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF)){\_SB.PCI0.PEG0.PEGP._OFF()}
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
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
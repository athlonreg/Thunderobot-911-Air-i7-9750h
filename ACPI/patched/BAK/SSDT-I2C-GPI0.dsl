/* 
 * Find _STA:          5F 53 54 41
 * Replace XSTA:       58 53 54 41
 * Target Bridge GPI0: 47 50 49 30
 */
DefinitionBlock("", "SSDT", 2, "hack", "GPI0", 0)
{
    External(_SB.PCI0.GPI0, DeviceObj)
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

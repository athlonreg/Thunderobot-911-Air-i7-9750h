//
// PS2N
//
DefinitionBlock ("", "SSDT", 2, "ACDT", "PS2N", 0)
{
    External (_SB.PCI0.LPCB, DeviceObj)
    
    Scope (_SB.PCI0.LPCB)
    {
        Device (PS2N)
        {
            Method (_HID, 0, NotSerialized)
            {
                Return ("PS2N")
            }
            
            Name (_CID, Package ()
            {
                EisaId ("PNP030B"),
                EisaId ("PNP0320")
            })
            
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

            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0060,
                    0x0060,
                    0x01,
                    0x01,
                    )
                IO (Decode16,
                    0x0064,
                    0x0064,
                    0x01,
                    0x01,
                    )
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {1}
            })
            Name (_PRS, ResourceTemplate ()
            {
                StartDependentFn (0x00, 0x00)
                {
                    FixedIO (
                        0x0060,
                        0x01,
                        )
                    FixedIO (
                        0x0064,
                        0x01,
                        )
                    IRQNoFlags ()
                        {1}
                }
                EndDependentFn ()
            })
        }
    }
}
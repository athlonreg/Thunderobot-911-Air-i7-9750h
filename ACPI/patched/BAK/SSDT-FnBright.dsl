//
DefinitionBlock ("", "SSDT", 2, "hack", "RMCF", 0)
{
    External(_SB.PCI0.LPCB.PS2L, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2L)
    {
        Name (RMCF,Package() 
        {
            "Mouse", Package ()
            {
                "ActLikeTrackpad", 
                ">y"
            }, 
            
            "Keyboard", Package()
            {
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e03e=76", // fnf4 to f4
                    "e03f=60"  // fnf5 to f5
                },
            }
        })
    }
}
//EOF
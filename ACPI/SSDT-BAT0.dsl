//// battery
// In config ACPI, UPBI to XPBI
// Find:     5550424900
// Replace:  5850424900
//
// In config ACPI, UPBS  to XPBS
// Find:     5550425300
// Replace:  5850425300
//
// In config ACPI, IVBI to XVBI
// Find:     4956424900
// Replace:  5856424900
//
DefinitionBlock ("", "SSDT", 2, "hack", "BAT0", 0x00000000)
{
    External (_SB_.BAT0, DeviceObj)
    External (_SB_.BAT0.BTUR, IntObj)
    External (_SB_.BAT0.PBIF, PkgObj)
    External (_SB_.BAT0.PBST, PkgObj)
    External (_SB_.BAT0.XPBI, MethodObj)
    External (_SB_.BAT0.XPBS, MethodObj)
    External (_SB_.BAT0.XVBI, MethodObj)
    External (_SB_.BATM, MutexObj)
    External (_SB_.PCI0.LPCB.EC0, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0.BACR, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.MBST, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.ECWT, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.ECRD, MethodObj)
    External (POSW, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, One)
            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE)
        }

        Method (RECB, 2, Serialized)
        {
            ShiftRight (Arg1, 0x03, Arg1)
            Name (TEMP, Buffer (Arg1){})
            Add (Arg0, Arg1, Arg1)
            Store (Zero, Local0)
            While (LLess (Arg0, Arg1))
            {
                Store (RE1B (Arg0), Index (TEMP, Local0))
                Increment (Arg0)
                Increment (Local0)
            }

            Return (TEMP)
        }
    }

    Scope (_SB.BAT0)
    {
        Method (UPBI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Acquire (BATM, 0xFFFF)
                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), Index (PBIF, One))
                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x72, 32)), Index (PBIF, 0x02))
                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x74, 48)), Index (PBIF, 0x04))
                Divide (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), 0x0A, , Index (PBIF, 0x05))
                Divide (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), 0x64, , Index (PBIF, 0x06))
                Store ("MWL32b", Index (PBIF, 0x09))
                If (LLess (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), 0x1770))
                {
                    Store ("MWL32b", Index (PBIF, 0x09))
                }

                If (LLess (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), 0x0BB8))
                {
                    Store ("MWL31b", Index (PBIF, 0x09))
                }

                Release (BATM)
            }
            Else
            {
                    \_SB.BAT0.XPBI()
            }
        }

        Method (UPBS, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x85, 40)), Zero))
                {
                    Store (One, BTUR)
                }
                ElseIf (LEqual (BTUR, One))
                {
                    Notify (BAT0, 0x81)
                    Notify (BAT0, 0x80)
                    Store (Zero, BTUR)
                }

                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x83, 24)), Local5)
                Store (POSW (Local5), Index (PBST, One))
                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x85, 40)), Local5)
                If (LEqual (^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.BACR)), One))
                {
                    Add (Divide (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x70, 16)), 0x32, ), ^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x85, 40)), Local5)
                }

                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x85, 40)), Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    If (LNotEqual (Local5, DerefOf (Index (PBST, 0x02))))
                    {
                        Store (Local5, Index (PBST, 0x02))
                    }
                }

                Store (^^PCI0.LPCB.EC0.ECRD (^^PCI0.LPCB.EC0.RECB (0x87, 56)), Index (PBST, 0x03))
                Store (^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBST)), Index (PBST, Zero))
            }
            Else
            {
                \_SB.BAT0.XPBS()
            }
        }

        Method (IVBI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Store (0xFFFFFFFF, Index (PBIF, One))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("Bad", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
                ^^PCI0.LPCB.EC0.ECWT (Zero, ^^PCI0.LPCB.EC0.RECB (0x77, 64))
            }
            Else
            {
                \_SB.BAT0.XVBI()
            }
        }
    }
}
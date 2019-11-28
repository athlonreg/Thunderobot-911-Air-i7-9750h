/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190703 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLahyfqk.aml, Thu Nov 28 21:36:28 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000116 (278)
 *     Revision         0x02
 *     Checksum         0x0D
 *     OEM ID           "hack"
 *     OEM Table ID     "CRSpatch"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20190703 (538511107)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "CRSpatch", 0x00000000)
{
    External (_SB_.PCI0.GPI0._STA, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)

    Scope (_SB.PCI0.I2C1.TPD0)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (XBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0020, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (XBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
                {
                    0x00000000,
                }
            })
            Name (XBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0027
                    }
            })
            Local0 = \_SB.PCI0.GPI0._STA ()
            If ((Local0 != Zero))
            {
                Return (ConcatenateResTemplate (XBFB, XBFG))
            }
            Else
            {
                Return (ConcatenateResTemplate (XBFB, XBFI))
            }
        }
    }
}


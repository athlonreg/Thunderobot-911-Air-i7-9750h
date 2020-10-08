// SSDT-UIAC-ALL.dsl
//
// This SSDT can be used as a template to build your own
// customization for USBInjectAll.kext.
//
// This SSDT contains all ports, so using it is the same as without
// a custom SSDT.  Delete ports that are not connected or ports you
// do not need.
//
// Change the UsbConnector or portType as needed to match your
// actual USB configuration.
//
// Note:
// portType=0 seems to indicate normal external USB2 port (as seen in MacBookPro8,1)
// portType=2 seems to indicate "internal device" (as seen in MacBookPro8,1)
// portType=4 is used by MacBookPro8,3 (reason/purpose unknown)
//

DefinitionBlock ("", "SSDT", 2, "ACDT", "UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            "8086_a36d", Package()
            {
                "port-count", Buffer() { 14, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package()
                    {
                        "name", Buffer (0x05) { "HS01" },
                        "UsbConnector", 0,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    "HS02", Package()
                    {
                        "name", Buffer (0x05) { "HS02" },
                        "UsbConnector", 0,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },
                    "HS04", Package()
                    {
                        "name", Buffer (0x05) { "HS04" },
                        "UsbConnector", 10,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                    "HS06", Package()
                    {
                        "name", Buffer (0x05) { "HS06" },
                        "UsbConnector", 0xFF,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                    "HS07", Package()
                    {
                        "name", Buffer (0x05) { "HS07" },
                        "UsbConnector", 0xFF,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    "HS14", Package()
                    {
                        "name", Buffer (0x05) { "HS14" },
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                    "SS01", Package()
                    {
                        "name", Buffer (0x05) { "SS01" },
                        "UsbConnector", 3,
                        "port", Buffer() { 17, 0, 0, 0 },
                    },
                    "SS02", Package()
                    {
                        "name", Buffer (0x05) { "SS02" },
                        "UsbConnector", 3,
                        "port", Buffer() { 18, 0, 0, 0 },
                    },
                    "SS04", Package()
                    {
                        "name", Buffer (0x05) { "SS04" },
                        "UsbConnector", 10,
                        "port", Buffer() { 20, 0, 0, 0 },
                    }
                },
            },
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
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
}
//EOF

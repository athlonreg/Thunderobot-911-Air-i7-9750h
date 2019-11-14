## 文件说明

| 文件                                              |                  功能                  |
| :------------------------------------------------ | :------------------------------------: |
| SSDT-AWAC.aml                                     |         预置变量禁用 I2C 设备          |
| SSDT-DMAC.aml                                     |          注入丢失的 DMAC 设备          |
| SSDT-EC.aml                                       |                仿冒 EC                 |
| SSDT-FnF1-_Q60-Thunderobot-911-Air2-9750h-EC.aml  |        PNP0C0E 强制睡眠修改 EC         |
| SSDT-FnF1-_Q60-Thunderobot-911-Air2-9750h-EC0.aml |        PNP0C0E 强制睡眠原始 EC0        |
| SSDT-MEM2.aml                                     |          注入丢失的 MEM2 设备          |
| SSDT-OCI2C-TPXX-Thunderobot-911-Air2-9750h.aml    |             OC 的 I2C 补丁             |
| SSDT-PLUG-_SB.PR00.aml                            |                注入 X86                |
| SSDT-PNLF-CFL.aml                                 |           CFL 平台注入 PNLF            |
| SSDT-PPMC.aml                                     |          注入丢失的 PPMC 设备          |
| SSDT-PTSWAK.aml                                   |       PTSWAK 综合补丁和扩展补丁        |
| SSDT-PWRB.aml                                     |          注入丢失的 PWRB 设备          |
| SSDT-SBUS.aml                                     |               SBUS 补丁                |
| 综合补丁更名.plist                                | _PTS -> ZPTS(1, N), _WAK -> ZWAK(1, S) |
| Fn 按键更名.plist                                 |       _Q60 -> XQ60, _Q6E -> XQ6E       |
| SSDT-BKeyQ60Q6E-Thunderobot-911-Air2-9750h.aml    |              Fn亮度快捷键              |
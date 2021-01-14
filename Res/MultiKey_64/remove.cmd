cd /d %~dp0
@ECHO OFF
> "%Temp%.\DefOpen.reg" ECHO REGEDIT4
>>"%Temp%.\DefOpen.reg" ECHO.
>>"%Temp%.\DefOpen.reg" ECHO [-HKEY_LOCAL_MACHINE\System\CurrentControlSet\MultiKey]
>>"%Temp%.\DefOpen.reg" ECHO.
>>"%Temp%.\DefOpen.reg" ECHO.
>>"%Temp%.\DefOpen.reg" ECHO.
START /WAIT REGEDIT /S "%Temp%.\DefOpen.reg"
DEL "%Temp%.\DefOpen.reg"

@devcon remove root\multikey
@if exist %systemroot%\system32\drivers\multikey.sys del %systemroot%\system32\drivers\multikey.sys
@pause
cd /d %~dp0
@regedit /s RAPT.reg
@devcon remove root\multikey
@devcon install multikey.inf root\multikey
@Pause
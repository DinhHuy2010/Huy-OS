@echo off
:setvar
set dir=%~dp0
set defaltconfig=kernelboot.runcore(bootload)
set version=dev-1.0.0/test1
goto checkfolder
:checkfolder
echo Checking kernel, please wait...
if not exist %dir%bootkernel md bootkernel && goto checkfolder
if exist %dir%bootkernel goto kernelfile
:kernelfile
if exist %dir%bootkernel\core.kernelboot goto config
if not exist %dir%bootkernel\core.kernelboot goto create
:create
echo %defaltconfig%> %dir%bootkernel\core.kernelboot && goto kernelfile
goto kernelfile
:config
for /f %%a in ('type %dir%bootkernel\core.kernelboot') do set fileboot=%%a
if %fileboot% == %defaltconfig% goto boot
if not %fileboot% == %defaltconfig% echo %defaltconfig%> %dir%bootkernel\core.kernelboot
goto kernelfile
:boot
timeout 3 /nobreak > nul
echo.
echo Loading info system hardware...
systeminfo
echo Press any key to start setup.
pause > nul
title HuyOS Setup
mode con: cols=120 lines=30
echo Starting setup...
timeout 2 /nobreak > nul
goto setup
:setup
cls
echo -------------------------------------------------
echo Welcome to HuyOS!
echo Version: %version%
echo This setup will guide you to install HuyOS.
echo -------------------------------------------------
echo.
echo To start setup, press any key to start
echo To exit setup, press Ctrl + C or close this windows.
pause > nul
goto s1
:s1
cls
echo (Step 1 of 5)
echo -------------------------------------------------
echo What your username to call you?
echo -------------------------------------------------
echo.
echo.
set /p userset=Username: 
if not exist %dir%user\ md user
if exist %dir%user\ goto userset
:userset 
echo %userset%>> %dir%user\userfile.user
goto s2
:s2
cls
echo (Step 2 of 5)
echo -------------------------------------------------
echo Pick your color for foreground.
echo You can change this in the system.
echo 1) Black       9) Gray
echo 2) Blue        10) Light Blue
echo 3) Green       11) Light Green
echo 4) Aqua        12) Light Aqua
echo 5) Red         13) Light Red
echo 6) Purple      14) Light Purple
echo 7) Yellow      15) Light Yellow
echo 8) White       16) Bright White
echo -------------------------------------------------
set /p choicefore=Pick your option: 
if %choicefore% == 1 set foreground=00 && goto setupcolor
if %choicefore% == 2 set foreground=01 && goto setupcolor
if %choicefore% == 3 set foreground=02 && goto setupcolor
if %choicefore% == 4 set foreground=03 && goto setupcolor
if %choicefore% == 5 set foreground=04 && goto setupcolor
if %choicefore% == 6 set foreground=05 && goto setupcolor
if %choicefore% == 7 set foreground=06 && goto setupcolor
if %choicefore% == 8 set foreground=07 && goto setupcolor
if %choicefore% == 9 set foreground=08 && goto setupcolor
if %choicefore% == 10 set foreground=09 && goto setupcolor
if %choicefore% == 11 set foreground=0a && goto setupcolor
if %choicefore% == 12 set foreground=0b && goto setupcolor
if %choicefore% == 13 set foreground=0c && goto setupcolor
if %choicefore% == 14 set foreground=0d && goto setupcolor
if %choicefore% == 15 set foreground=0e && goto setupcolor
if %choicefore% == 16 set foreground=0f && goto setupcolor
echo Error!
pause
goto s2
:setupcolor
color %foreground%
set /p colorsetcorrect=You like it (y/n)?: 
if %colorsetcorrect% == y goto colorsettings
if %colorsetcorrect% == n goto s2
:colorsettings
if not exist %dir%settings\ md settings
if exist %dir%settings\ goto setcolorsettings
:setcolorsettings
echo %foreground%> %dir%settings\colorsettings.settings
goto s3
:s3
cls
echo (Step 3 of 5)
echo -------------------------------------------------
echo Creating boot file...
echo.
echo -------------------------------------------------
timeout 3 /nobreak > nul
goto createboot
:createboot
if not exist %dir%bootfile\ md bootfile && goto createboot
if exist %dir%bootfile\ goto filecreate
:filecreate
if not exist %dir%bootfile\boot.core echo bootfile.load()>> %dir%bootfile\boot.core && goto createboot
if exist %dir%bootfile\boot.core goto continue
:continue
cls
echo (Step 3 of 5)
echo -------------------------------------------------
echo Creating boot file...
echo Create file sucessfully!
echo.
echo.
echo.
echo.
echo Creating log...
echo.
echo -------------------------------------------------
timeout 3 /nobreak > nul
goto logcreate
:logcreate
if not exist %dir%systemlog\ md systemlog && goto logcreate
if exist %dir%systemlog\ goto log
:log
if not exist %dir%systemlog\systemlog.txt goto write
if exist %dir%systemlog\systemlog.txt goto continue2
:write
(
    echo [Log: Date: %date%, Time: %time%]: System Log Created
) >> %dir%systemlog\systemlog.txt
goto log
:continue2
cls
echo (Step 3 of 5)
echo -------------------------------------------------
echo Creating boot file...
echo Create file sucessfully!
echo.
echo.
echo.
echo.
echo Creating log...
echo Create Log sucessfully!
echo -------------------------------------------------
pause
goto s4
:s4
cls
echo (Step 4 of 5)
echo -------------------------------------------------
echo Creating system...
echo.
echo -------------------------------------------------
md infocredit
timeout 5 /nobreak > nul
goto createsys
:createsys
(
    echo dev-1.0.0/test1
) > %dir%infocredit\version.credit
goto movefile
:movefile
ren %dir%runtemp\reset.tempins reset.bat
ren %dir%runtemp\start.tempins start.bat
ren %dir%runtemp\console.tempins console.systemfile
move %dir%runtemp\reset.bat %dir%
move %dir%runtemp\start.bat %dir%
move %dir%runtemp\console.systemfile %dir%
goto complete
:complete
cls
echo (Step 4 of 5)
echo -------------------------------------------------
echo Creating system...
echo Create complete!
echo -------------------------------------------------
pause
goto s5
:s5
cls
echo (Step 5 of 5)
echo -------------------------------------------------
echo Finishing installtion...
echo.
echo -------------------------------------------------
timeout 3 /nobreak > nul
md terms
move %dir%runtemp\terms.tempins %dir%terms\
ren %dir%terms\terms.tempins terms.termsread
goto inscom
:inscom
cls
echo (Step 5 of 5)
echo -------------------------------------------------
echo Finishing installtion...
echo Installtion complete!
echo The system will start automatically.
echo -------------------------------------------------
timeout 5 /nobreak > nul
start %dir%start.bat
exit
@echo off
cd /d "%~dp0"
if "%~1"=="--added" goto next
reg export HKCU\Console "%TMP%\HKCU_Console.reg" /y > nul
reg add HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe /v FaceName /t REG_SZ /f > nul
reg add HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe /v FontSize /t REG_DWORD /d 0 /f > nul
reg add HKEY_CURRENT_USER\Console /v ColorTable05 /t REG_DWORD /d 8388736 /f > nul
start cmd.exe /c %0 --added
exit /B
:next
if not exist "%TMP%\HKCU_Console.reg" (call :msg regcorrupt)
reg import "%TMP%\HKCU_Console.reg" > nul
chcp 65001 > nul
if "%~1"=="repair" (goto repair)
if "%~1"=="play" goto next_fsprog
cd /d "%cd%\Core"
if errorlevel==1 (goto repair)
:next_fsprog
cd /d "%cd%\Core"
if exist "%cd%\batbox.exe" goto startprog
for %%b in (
4D5343460000000007040000000000002C000000000000000301010001000000000000004700000001000100000800000000000000006546B1B62000626174626F782E65786500CD6A9177B8030008434BBD555D681C55143E936443FFCC6EB3196D91E214DA3EF421A06D404B03539368AA1B5D76B70D9442BA9B9DDD99CDEECC323B3129BE44362BD4BCF820F86011438A08BE06D452D1BA292DA5A13E14A95AA58AC82C2DD887D4F6A1CDF89D3B93660BC1F6C17A77BF3BE77CE7DC73BFFBB3B34347A64822A2368A90E711A9ECA0A9F4E83605743C77BA83E6D72F6EFF528A2D6E4FE9464529DB56DE4E9794D1B4695A8E92D1147BDC540C53E97F33A994ACACD6FDD4861D2B35E203443149A2D87777532BDC750A4B1B25E9156A87D31E909126B03A7EB6100572A13F688ACFE7EF13B5368F7B9019B841DB16257AA6E53116FB1FB7EE5C31EDE0A9870241EDBEEEE6768CB7E20937BD5F56A9E03FF417B9DB8BCE93AF77A9545DE82ADCF6E46B5195E6544EFB3B70F6C3711350DBF75E74EAA2F2BC97FB6A13EDFB703D62E1E93DE05FCDFF7EABF193E779EE667871AF471545FF4042A30E7AEA6D69245CEBC0FC9EEC62A6DAB7E1E9CFC1A33EBC5E5E75B8B651849908E162D2DC561EBD846374CFA06B0D2D7442CA2574B9B94116F4A9602F30FBBD605FE3497B0645EF0B70B9C4CBACEB3892CF87AE74FAF77C8E0D5D745F7472E255CCDAD8CA8963484C36B1D585750DE2C0258CBB133A8ABAF7E1866B37D0CFA6647F31BF72C64D6434AE2CC3FA0496FB0BBBE7D8BDC717DF936FB19A79266EB0065E8FFB1B5BBC86C64708E8C79AC4DF45BA7B96E3593EA7E6D012572A70A559C44F9CF7E47B608631C7498EC411F142BC29B3ABFB35BBBA498D1F9050D8E2F5ECF7CF1E63FC7B21E931318BCFDF045FEDE5008E79112573D55E8EB7846BDFC0ABCFF4C6E19D583EFB57E49D3FF965D22AB6273E7C583FDDB47F91BAFB345416F049A2A8E036D5BD1D5FFF88A46A882F61DBCC367ECC3C5BFB393CCD3FDCBAD7C3C78F2B24D2DB76566867769FF86E58FB62BF1551691EB8038C00CA66955E026A80037C0C5C0634A0018CE5D3A3D99235A1978F9BDD998CA871A66BB55E092F8AABF0E7A3ABDC24EC6BC0074DDCBBB04F46D7D634943CDC974875F7C762F4FA40E28D81D89E17844387920389159BE85430FCD4833249DD9A1836CCAC3521DE7590D105EC0254E02850062681F781CF02D98F9B87DFABE6249DEC60DACC1635319FE6F45966C52A6A43785F3FCCA4B449E780E3D84666DCD11E8AF48DDB15CB8E5B15C3312C934725B47436081E34CBE3CE01CE2F6A5A798D7107CD9C15687904BFB2134BD0BF0CAC9389B6000AB05BF657F46F31EC826D984E8EAD91BCE68CEAC262B39436CCB49DAFC0D7260D47F06319DDB72A8EED58C5FFFFBFE249B67F00
) Do >>t.dat (Echo.For b=1 To len^("%%b"^) Step 2
ECHO WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)
Cscript /b /e:vbs t.dat>batbox.ex_
Expand -r batbox.ex_ >nul 2>&1
del "batbox.ex_" /q
del "t.dat" /q


:startprog


@echo off
setlocal EnableDelayedExpansion

mode con: cols=56 lines=12

:nextchkfnt
echo Carregant...
title Carregant...

start WScript.exe "StartMusic.vbs"
batbox /w 200
if exist TMP\StartMusic.ini (del TMP\StartMusic.ini /Q>NUL)

::Buscar l'arxiu BATBOX.exe
if not exist BATBOX.exe (call :msg batboxnotfound)

title Pac-Man!
:gameover
set score=0
set level=1

color 09
set initx=17
set inity=5
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set winver=%%i.%%j
endlocal
cls
::Config
set score=0
batbox /h 0
set dif=11
mode con: rate=300 delay=0
set waitdif=1

:start_game

for /l %%a in (0,1,34) do (
	for /l %%A in (1,1,9) do (
		set _%%a_%%A=n
	)
	for /l %%A in (0,1,0) do (
		set _%%a_%%A=w
	)
	for /l %%A in (10,1,10) do (
		set _%%a_%%A=w
	)
	for /l %%A in (4,1,4) do (
		set _%%a_%%A=w
	)
	for /l %%A in (2,1,2) do (
		set _%%a_%%A=w
	)


)



cls

::Escenari
echo ################################### &::0
echo #                                 # &::1
echo ### ###### ###### ###### ###### ### &::2
echo #                                 # &::3
echo ####### ################### ####### &::4
echo             #    ☻    #             &::5
echo # # ####### #         # ####### # # &::6
echo # #       # ##       ## #...... # # &::7
echo # # ##### #    #####    # ##### # # &::8
echo #                                 # &::9
echo ################################### &::10
::35 llarg 11 alt


::Pac-Man

batbox /g 39 5 /c 0x07 /d "Score: 0" /g 17 5 /c 0x0e /a 2

::Generar punts

::Línies horitzontals grans
batbox /g 1 9 /c 0x0e /d "................................." /g 1 3 /c 0x0e /d "................................." /g 1 1 /c 0x0e /d "................................."
::Costat del túnels

::Dreta i esquerra
batbox /g 22 5 /c 0x0e /d "............." /g 0 5 /c 0x0e /d "............."
::Columna 1 Baix Esquerra i dreta
batbox /g 1 8 /c 0x0e /d "." /g 1 7 /c 0x0e /d "." /g 1 6 /c 0x0e /d "." /g 33 8 /c 0x0e /d "." /g 33 7 /c 0x0e /d "." /g 33 6 /c 0x0e /d "."

::Columna 2 Baix Esquerra i dreta
batbox /g 3 8 /c 0x0e /d "." /g 3 7 /c 0x0e /d "." /g 3 6 /c 0x0e /d "." /g 31 8 /c 0x0e /d "." /g 31 7 /c 0x0e /d "." /g 31 6 /c 0x0e /d "."
::Línia 2 Baix Dreta + esquerra
batbox /g 25 7 /c 0x0e /d "......." /g 3 7 /c 0x0e /d "......."

::Columna 3 Baix Esquerra + Dreta
batbox /g 11 6 /c 0x0e /d "." /g 11 7 /c 0x0e /d "." /g 11 8 /c 0x0e /d "."

::Columna 3 Baix Dreta
batbox /g 23 6 /c 0x0e /d "." /g 23 7 /c 0x0e /d "."
::Línia 2 Baix Centre-Esquerra
batbox /g 12 8 /c 0x0e /d "..." /g 20 8 /c 0x0e /d "...."


::Punts sols
batbox /g 25 8 /c 0x0e /d "." /g 9 8 /c 0x0e /d "." /g 31 2 /c 0x0e /d "." /g 3 2 /c 0x0e /d "." /g 10 2 /c 0x0e /d "." /g 24 2 /c 0x0e /d "." /g 17 2 /c 0x0e /d "."



batbox /g 1 1 /c 0x0b /a 1
batbox /g 33 1 /c 0x0c /a 1
batbox /g 1 9 /c 0x05 /a 1
batbox /g 33 9 /c 0x02 /a 1

set x1=1
set y1=1
set x2=33
set y2=1
set x3=1
set y3=9
set x4=33
set y4=9


:move
pause>nul
if not defined %initx%%inity% (
	set /a score=%score%+20
	set %initx%%inity%=Eated
	batbox /g 39 5 /c 0x07 /d "Score: %SCORE%" /g %initx% %inity%
)

if exist "TMP\StartMusic.ini" (
	del "TMP\StartMusic.ini" /q>nul
)

if not exist BATBOX.exe (
	cls
	color 07
	mode con: cols=63 lines=3
	echo FATAL: No s'ha trobat BATBOX.exe. El joc no pot continuar
	pause>nul
	exit /B
)


::Sintaxi: (set %%P%_%p_Position_passed=0)



::Moviment del personatge
batbox /g %initx% %inity% /c 0x0e /a 2

if "%initx%"=="%x1%" (
	if "%inity%"=="%y1%" goto lost
)
if "%initx%"=="%x2%" (
	if "%inity%"=="%y2%" goto lost
)
if "%initx%"=="%x3%" (
	if "%inity%"=="%y3%" goto lost
)
if "%initx%"=="%x4%" (
	if "%inity%"=="%y4%" goto lost
)


::Detector passes pel túnel

if %initx%==34 if %inity%==5 (
	batbox /g 34 5 /c 0x07 /d " " /g 1 5

	set initx=1
	set inity=5
	goto move
)

if %initx%==0 if %inity%==5 (
	batbox /g 0 5 /c 0x07 /d " "
	batbox /g 33 5 /d " "
	set initx=33
	set inity=5
	goto move
)





::Detector de pressió de tecla
batbox /k


:move_key


::Receptor de tecles
if %errorlevel%==0 (
	call :phantom1
	call :phantom2
	call :phantom3
	call :phantom4

	goto move
)
if %errorlevel%==327 goto Dalt
if %errorlevel%==335 goto Baix
if %errorlevel%==332 goto Dreta
if %errorlevel%==330 goto Esquerra
if %errorlevel%==112 goto Pause
if %errorlevel%==80 goto Pause
if %errorlevel%=27 goto Quit
call :phantom1
call :phantom2
call :phantom3
call :phantom4

goto move




::Tecles de direcció de moviment
:Dreta
call :phantom1
call :phantom2
call :phantom3
call :phantom4

batbox /g %initx% %inity% /c 0x07 /d " "
set /a initx=%initx%+1
goto move

:Esquerra
call :phantom1
call :phantom2
call :phantom3
call :phantom4

batbox /g %initx% %inity% /c 0x07 /d " "
set /a initx=%initx%-1
goto move

:Dalt
call :phantom1
call :phantom2
call :phantom3
call :phantom4

batbox /g %initx% %inity% /c 0x07 /d " "
set /a inity=%inity%-1
goto move

:Baix
call :phantom1
call :phantom2
call :phantom3
call :phantom4

batbox /g %initx% %inity% /c 0x07 /d " "
set /a inity=%inity%+1
goto move



:Pause
title Press any key to resume Pac-Man
pause>nul
title Pac-Man
goto move

:Lost
batbox /g %initx% %inity% /c 0x00 /d " " /g %x1% %y1% /c 0x00 /d " " /g %x2% %y2% /c 0x00 /d " " /g %x3% %y3% /c 0x00 /d " " /g %x4% %y4% /c 0x00 /d " "
chcp 850 > nul
cls
color 07
batbox /d "You lost!" /w 1300
exit

:quit
chcp 850 > nul
echo Have a nice day...
exit /B


:phantom1
if %x1% gtr %initx% set /a _x1=%x1%-1
if %x1% lss %initx% set /a _x1=%x1%+1
if %y1% gtr %inity% set /a _y1=%y1%-1
if %y1% lss %inity% set /a _y1=%y1%+1
if %x1% equ %initx% set /a _x1=%x1%-0
if %y1% equ %inity% set /a _y1=%y1%-0


::set _%%a_%%A=w

batbox /g %x1% %y1% /c 0x00 /d " " /g %_x1% %_y1% /c 0x0b /a 1 /g %initx% %inity%

if %x1%==%initx% if %y1%==%inity% goto Lost
goto :EOF



:phantom2
if %x2% gtr %initx% set /a _x2=%x2%-1
if %x2% equ %initx% set /a _x2=%x2%-0
if %y2% equ %inity% set /a _y2=%y2%-0

if %x2% lss %initx% set /a _x2=%x2%+1
if %y2% gtr %inity% set /a _y2=%y2%-1
if %y2% lss %inity% set /a _y2=%y2%+1
batbox /g %x2% %y2% /c 0x00 /d " " /g %_x2% %_y2% /c 0x0c /a 1 /g %initx% %inity%
set x2=%_x2%
set y2=%_y2%
if %x2%==%initx% if %y2%==%inity% goto Lost
goto :EOF

:phantom3
if %x3% gtr %initx% set /a _x3=%x3%-1
if %x3% lss %initx% set /a _x3=%x3%+1
if %y3% gtr %inity% set /a _y3=%y3%-1
if %y3% lss %inity% set /a _y3=%y3%+1

if %x3% equ %initx% set /a _x3=%x3%-0
if %y3% equ %inity% set /a _y3=%y3%-0

batbox /g %x3% %y3% /c 0x00 /d " " /g %_x3% %_y3% /c 0x05 /a 1 /g %initx% %inity%
set x3=%_x3%
set y3=%_y3%
if %x3%==%initx% if %y3%==%inity% goto Lost

:phantom4
if %x4% gtr %initx% set /a _x4=%x4%-1
if %x4% lss %initx% set /a _x4=%x4%+1
if %y4% gtr %inity% set /a _y4=%y4%-1
if %y4% lss %inity% set /a _y4=%y4%+1
if %x4% equ %initx% set /a _x4=%x4%-0
if %y4% equ %inity% set /a _y4=%y4%-0

batbox /g %x4% %y4% /c 0x00 /d " " /g %_x4% %_y4% /c 0x02 /a 1 /g %initx% %inity%
set x4=%_x4%
set y4=%_y4%
if %x4%==%initx% if %y4%==%inity% goto Lost
goto :EOF



:repair
	cls
	title FATAL: Cannot find .\Core\ - Game cannot start.
	echo FATAL: Cannot find .\Core\ - Game cannot start.
	echo.
	echo Attempting to repair...

	if exist "Core" ren "Core" "Core.---"
	md Core
	md Core\TMP
	md Core\Sounds
	echo.
	powershell [Text.Encoding]::Utf8.GetString^([Convert]::FromBase64String^('RGltIG9QbGF5ZXIsIEZTTw0KU2V0IG9QbGF5ZXIgPSBDcmVhdGVPYmplY3QoIldNUGxheWVyLk9DWCIpDQpTZXQgRlNPID0gY3JlYXRlT2JqZWN0KCJTY3JpcHRpbmcuRmlsZVN5c3RlbU9iamVjdCIpDQpTZXQgdG1wc21TTkQgPSBGU08uY3JlYXRldGV4dGZpbGUoIlRNUFxTdGFydE11c2ljLmluaSIsdHJ1ZSkNCnRtcHNtU05ELndyaXRlbGluZSAiU3RhcnQ9MSINCnRtcHNtU05ELmNsb3NlDQoNCg0KSWYgTm90IEZTTy5GaWxlRXhpc3RzKCJTb3VuZHNcU3RhcnRNdXNpYy53YXYiKSBUaGVuDQoJbXNnYm94ICJDYW5ub3QgZmluZCAuXENvcmVcU291bmRzXFN0YXJ0TXVzaWMud2F2OiImdmJDckxmJiJBdWRpbyBjYW5ub3QgYmUgZGlzcGxheWVkIiw0MTEyLCJDYW5ub3QgZmluZCAuXENvcmVcU291bmRzXFN0YXJ0TXVzaWMud2F2Ig0KCVdTY3JpcHQuUXVpdCgpDQpFbmQgSWYNCm9QbGF5ZXIuVVJMID0gIlNvdW5kc1xTdGFydE11c2ljLndhdiINCmRvDQonUGxheSBzdGFydCBtdXNpYw0Kb1BsYXllci5jb250cm9scy5wbGF5IA0KV2hpbGUgb1BsYXllci5wbGF5U3RhdGUgPD4gMSAnIDEgPSBTdG9wcGVkDQogIFdTY3JpcHQuU2xlZXAgMTAwDQpXZW5kDQoNCklmIE5vdCBGU08uRmlsZUV4aXN0cygiVE1QXFN0YXJ0TXVzaWMuaW5pIikgVGhlbg0KCW9QbGF5ZXIuQ2xvc2UNCglXU2NyaXB0LlF1aXQoKQ0KRW5kIElmDQoNCmxvb3ANCm9QbGF5ZXIuY2xvc2UNCg=='^)^) > "Core\StartMusic.vbs"
	powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/anic17/Games/pac-man/sounds.cab" -OutFile "%CD%\Core\TMP\Sounds.zip"
	powershell -Command Expand-Archive "%CD%\Core\TMP\Sounds.zip" "%CD%\Core\TMP\Sounds"
	move "%CD%\Core\TMP\Sounds\Sounds\*" "%CD%\Core\Sounds">nul
	if errorlevel 1 (echo Error while repairing sounds) else (echo Sounds have been successfully repaired)
	echo.
	echo Please restart Pac-Man!
	echo.
	echo.
	echo Press any key to restart Pac-Man game...
	pause>nul
	start cmd.exe /c %0 play
	timeout /t 1 /nobreak>nul
	exit /B




:msg
if "%~1"=="batboxnotfound" (
	echo FATAL: No s'ha trobat BATBOX.exe. El joc no pot iniciar
	pause>nul
	exit /B
)

if "%~1"=="runningbaboxnotfound" (
	cls
	color 07
	mode con: cols=63 lines=3
	echo FATAL: No s'ha trobat BATBOX.exe. El joc no pot continuar
	pause>nul
	exit /B
)

if "%~1"=="regcorrupt" (
	cls
	mode con: cols=80 lines=25

	:corrupt_loop
	title Error: HKCU\Console corrupted
	echo Error: HKCU\Console corrupted
	echo.
	echo What has happened?
	echo.
	echo When configuring the game with registry, the operation
	echo has been aborted, but we're working with some important
	echo registry keys.
	echo.
	echo May this corrupt my operating system?
	echo.
	echo No, this only may corrupt your console
	echo.
	echo Why it's a fatal error?
	echo.
	echo It's a fatal error because it can make one of the following things
	echo.
	echo   - Change your color palette to strange colors
	echo   - Changing the font
	echo   - Changing your settings
	echo What to do:
	echo.
	echo - Backup the registry if you have a backup
	echo - Run Pac-Man again to try to fix the error
	pause>nul
	exit

)
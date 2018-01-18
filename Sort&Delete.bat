@echo off
setlocal EnableDelayedExpansion
set title=Sort and Delete v.1.2 by KaptenIT
title %title%
color 0a

:MENU
cls
title %title%
ECHO This software is created by KaptenIT
ECHO USE SOFTWARE ON YOUR OWN RISK
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - Set Source path (%source%)
ECHO 2 - Set Destination path (%destination%)
ECHO 3 - Sort standard files (ex .mp3 .jpeg)
ECHO 4 - delete system files (ex .tmp .p5p .mum)
ECHO 5 - BOTH (delete files first then run the sort)
ECHO 6 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, 4, 5 or 6 then press ENTER:
IF %M%==1 GOTO SOURCE
IF %M%==2 GOTO DEST
IF %M%==3 GOTO SORT
IF %M%==4 GOTO DELETE
IF %M%==5 GOTO BOTH
IF %M%==6 exit

:SOURCE
set /p source="source folder path: (ex c:\Recovered data\)"
GOTO MENU

:DEST
set /p destination="destination folder path: (ex c:\Recovered data\)"
GOTO MENU

:SORT
if %source% !=
title %title% - sorting
setlocal EnableDelayedExpansion
for /f "tokens=*" %%i in ('dir /b /a:-d "%source%"') do (
    set ext=%%~xi
    if "!ext!"=="" set ext=FileWithNoExtension
    	echo !extlist! | find "!ext!" > nul
    if not !ERRORLEVEL! == 0 set extlist=!extlist!!ext!:
	mkdir %destination%!ext!
move %source%*!ext! %destination%!ext!
) 
GOTO MENU

:DELETE
title %title% - deleting
setlocal EnableDelayedExpansion
set n=0
for %%a in (.xml .htm .man .cab .old .browser .cfg .bak .inf .compare .sys .ico .html .blf .automaticDestinations-ms .idx .id2 .css .xcf .json .js .blf .msg .dat .hlp .ini .p5p .cat .dll .cdf-ms .mum .manifest .rbf .sst .mof .mfl .winmd .pf .tmp .pak .p7x .pri .woff .mui .md .mtx .eot .npmignore .log .XSL .svg .xrm-ms_e171af06 .mui_72e8994f .nls_72f6d1a9 .xrm-ms_efcf539a .mui_64c0a23c .zsd .zfs .yes .yml .xul .xst .xsn .rsrc) do (
   set FileTypeToDelete[!n!]=%%a
   set /A n+=1
)
echo %source%
cd %source%
(for /L %%i in (0,1,63) do ( 
   del /S %source%*!FileTypeToDelete[%%i]!
)) 
GOTO MENU

:BOTH
set title= %title% - Deleting files step 1 of 2
GOTO DELETE
set title= %title% - Sorting files step 2 of 2
GOTO SORT
GOTO MENU

@echo off
:MENU
echo This software is created by KaptenIT
echo Assign where the recovered data is placed.
set /p source="source folder path: (ex c:\Recovered data\)"
echo Assign where the sorted data will be placed.
set /p destination="destination folder path: (ex c:\Recovered data\)"
ECHO.
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - Sort standard files (ex .mp3 .jpeg)
ECHO 2 - delete system files (ex .tmp .p5p .mum)
ECHO 3 - BOTH
ECHO 4 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO SORT
IF %M%==2 GOTO DELETE
IF %M%==3 GOTO BOTH
IF %M%==4 GOTO EOF

:SORT
setlocal EnableDelayedExpansion
set n=0
set numbersofFiles=19
for %%a in (.mp3 .jpg .jpeg .mp2 .mov .avi .png .bmp .doc .docx .gif .txt .zip .ods .xls .xlsx .cab .csv .pptx .psd ) do (
   set FileTypeToMove[!n!]=%%a
   set /A n+=1
)

(for /L %%i in (0,1,%numbersofFiles%) do ( 
   mkdir %destination%!FileTypeToMove[%%i]!
   echo %destination%!FileTypeToMove[%%i]!
)) 
(for /L %%i in (0,1,%numbersofFiles%) do ( 
   move %source%*!FileTypeToMove[%%i]! %destination%!FileTypeToMove[%%i]!
   echo %source%*!FileTypeToMove[%%i]! %destination%!FileTypeToMove[%%i]!
   
)) 
GOTO MENU

:DELETE
setlocal EnableDelayedExpansion
set n=0
for %%a in (.html .blf .automaticDestinations-ms .idx .id2 .css .xcf .json .js .blf .msg .dat .hlp .ini .p5p .cat .dll .cdf-ms .mum .manifest .rbf .sst .mof .mfl .winmd .pf .tmp .pak .p7x .pri .woff .mui .md .mtx .eot .npmignore .log .XSL .svg .xrm-ms_e171af06 .mui_72e8994f .nls_72f6d1a9 .xrm-ms_efcf539a .mui_64c0a23c .zsd .zfs .yes .yml .xul .xst .xsn .rsrc) do (
   set FileTypeToDelete[!n!]=%%a
   set /A n+=1
)
echo %source%
cd %source%
(for /L %%i in (0,1,48) do ( 
   del /S %source%*!FileTypeToDelete[%%i]!
)) 
GOTO MENU

:BOTH
GOTO DELETE
GOTO SORT
GOTO MENU

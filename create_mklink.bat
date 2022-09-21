@echo off
@REM Благодарность dark123us
@REM название аддона
set NAMECUSTOM=the_grinder
@REM гит папка вашего аддона
set PATHGIT=C:\Users\b0150\Documents\GitHub\the_grinder
@REM путь к доте
set PATHGAME=C:\Program Files (x86)\Steam\steamapps\common\dota 2 beta
@REM добавочный путь для папки доты
set SUFFIX=\content\dota_addons\
set SUFFIX2=\game\dota_addons\
@REM добавочный путь для папки гита
set PREFIX=\content\
set PREFIX2=\game\
@REM вывод инфо
echo %PATHGIT%
echo %PATHGAME%
echo -----------
echo %PATHGAME%%SUFFIX%%NAMECUSTOM%
echo %PATHGAME%%SUFFIX2%%NAMECUSTOM%
echo -----------
@REM создаем структуру в гит папке
mkdir "%PATHGIT%%PREFIX%"
mkdir "%PATHGIT%%PREFIX2%"
@REM связываем папку гит и аддон
mklink /J "%PATHGIT%%PREFIX%%NAMECUSTOM%" "%PATHGAME%%SUFFIX%%NAMECUSTOM%"
mklink /J "%PATHGIT%%PREFIX2%%NAMECUSTOM%" "%PATHGAME%%SUFFIX2%%NAMECUSTOM%"

pause

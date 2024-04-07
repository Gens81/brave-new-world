@echo off
rem ----------------------------------------------------------------------------
set ROM="scripts\bnw_2.2.smc"
rem ----------------------------------------------------------------------------
set SCRIPTS="scripts"
set GFX="gfx"
rem ----------------------------------------------------------------------------
set DD="tools\dd.exe"

rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
if not exist "%SCRIPTS%" mkdir %SCRIPTS%
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
echo Extracting Scripts...
rem %DD% skip=295360 count=4096 if=%ROM% of=%GFX%\047FC0_menu_font.bin bs=1 2>NUL
rem %DD% skip=299456 count=5376 if=%ROM% of=%GFX%\048FC0_dialog_font.bin bs=1 2>NUL
rem %DD% skip=57760 count=256 if=%ROM% of=%SCRIPTS%\DTE_table.bin bs=1 2>NUL
rem %DD% skip=845824 count=133887 if=%ROM% of=%SCRIPTS%\town_dialog.bin bs=1 2>NUL
rem %DD% skip=1040864 count=5231 if=%ROM% of=%SCRIPTS%\short_battle_dialog.bin bs=1 2>NUL
rem %DD% skip=1102336 count=11519 if=%ROM% of=%SCRIPTS%\long_battle_dialog.bin bs=1 2>NUL
rem %DD% skip=1017344 count=15440 if=%ROM% of=%SCRIPTS%\monster_scripts.bin bs=1 2>NUL

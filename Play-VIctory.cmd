@echo off
setlocal EnableExtensions DisableDelayedExpansion
rem Where the dump is: VICTORY_GAME_DIR if it holds the game, else a "game" folder
rem beside this file, else the folder this one sits in.
if defined VICTORY_GAME_DIR if not exist "%VICTORY_GAME_DIR%\game_scarlett_master.exe" set "VICTORY_GAME_DIR="
if not defined VICTORY_GAME_DIR if exist "%~dp0game\game_scarlett_master.exe" set "VICTORY_GAME_DIR=%~dp0game"
if not defined VICTORY_GAME_DIR if exist "%~dp0..\game_scarlett_master.exe" set "VICTORY_GAME_DIR=%~dp0.."
if not defined VICTORY_GAME_DIR (
  echo No game_scarlett_master.exe found.
  echo Set VICTORY_GAME_DIR to your dump folder, or put this folder inside the dump folder.
  pause
  exit /b 2
)
for %%I in ("%VICTORY_GAME_DIR%") do set "VICTORY_GAME_DIR=%%~fI"
rem DLSS (the clean picture) needs NVIDIA's files, which each person gets from NVIDIA once.
if not exist "%~dp0nvidia-sdk\Streamline\bin\x64\sl.interposer.dll" if not defined VICTORY_STREAMLINE_DIR (
  echo NVIDIA's DLSS files are not here yet. Without them the game uses its own, much rougher upscaling.
  choice /C YN /M "Download them now from NVIDIA's GitHub (about 70 MB)"
  if not errorlevel 2 powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\get-nvidia-sdks.ps1"
)
rem Frame generation, asked at every start (it needs the DLSS files). Not asked when the
rem options below already say -FrameGen or -NoFrameGen, or when VICTORY_ASK_FRAMEGEN=0.
set "dlss="
if exist "%~dp0nvidia-sdk\Streamline\bin\x64\sl.interposer.dll" set "dlss=1"
if defined VICTORY_STREAMLINE_DIR set "dlss=1"
set "fg="
echo(%*| findstr /i "framegen" >nul && set "fg=given"
if "%VICTORY_ASK_FRAMEGEN%"=="0" set "fg=given"
if defined dlss if not defined fg (
  echo.
  echo Frame generation: DLSS adds a frame between each two the game draws. Motion looks
  echo smoother, but the game itself does not run faster and input lags a little more.
  echo It needs an RTX 40 card or newer. On a PC with 16 GB of RAM it also takes some
  echo memory from the game.
  choice /C YN /M "Use frame generation this time"
  if errorlevel 2 (set "fg=-NoFrameGen") else set "fg=-FrameGen"
)
if "%fg%"=="given" set "fg="
rem Extra options for play.ps1 can follow, e.g.  Play-VIctory.cmd -Dlss balanced
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0play.ps1" -Exe "%VICTORY_GAME_DIR%\game_scarlett_master.exe" %fg% %*
if errorlevel 1 pause
exit /b %errorlevel%

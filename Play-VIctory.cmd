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
rem Extra options for play.ps1 can follow, e.g.  Play-VIctory.cmd -Dlss balanced
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0play.ps1" -Exe "%VICTORY_GAME_DIR%\game_scarlett_master.exe" %*
if errorlevel 1 pause
exit /b %errorlevel%

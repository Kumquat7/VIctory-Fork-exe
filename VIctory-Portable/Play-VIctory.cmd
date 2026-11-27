@echo off
setlocal EnableExtensions DisableDelayedExpansion
rem VIctory, NVIDIA build, for GTA VI from your own Xbox dump. See README.txt.

rem Where the dump is: VICTORY_GAME_DIR if it holds the game, else a "game" folder
rem beside this file, else the folder this one sits in.
if defined VICTORY_GAME_DIR if not exist "%VICTORY_GAME_DIR%\game_scarlett_master.exe" set "VICTORY_GAME_DIR="
if not defined VICTORY_GAME_DIR if exist "%~dp0game\game_scarlett_master.exe" set "VICTORY_GAME_DIR=%~dp0game"
if not defined VICTORY_GAME_DIR if exist "%~dp0..\game_scarlett_master.exe" set "VICTORY_GAME_DIR=%~dp0.."
if not defined VICTORY_GAME_DIR (
  echo game_scarlett_master.exe was not found.
  echo Set VICTORY_GAME_DIR to your dump folder, or put this folder inside the dump folder.
  pause
  exit /b 2
)
if not exist "%~dp0victory-nvidia.exe" (
  echo victory-nvidia.exe is missing from this folder.
  pause
  exit /b 2
)

rem Fast load: the game's startup reads are kept in one file in the order it needs them
rem (recorded on the first launch, into "loadpack" here; later launches read from it).
if not defined VICTORY_LOAD_PACK set "VICTORY_LOAD_PACK=%~dp0loadpack"
rem The game's own hang check waits 300 s instead of 30 (slow disks, low memory).
if not defined VICTORY_TITLE_HANG_S set "VICTORY_TITLE_HANG_S=300"

rem The NVIDIA launcher's settings (measured on an RTX 4060 8 GB with 16 GB of RAM).
if not defined VICTORY_AMBIENT_AIR set "VICTORY_AMBIENT_AIR=1.5"
if not defined VICTORY_CACHE_DIR set "VICTORY_CACHE_DIR=%LOCALAPPDATA%\VIctory\cache-nvidia"
if not defined VICTORY_TEXTURE_NO_WAIT set "VICTORY_TEXTURE_NO_WAIT=1"
if not defined VICTORY_RELAY set "VICTORY_RELAY=2"
if not defined VICTORY_WIDE_BACK set "VICTORY_WIDE_BACK=1"
if not defined VICTORY_CARD_REHASH_RUNS set "VICTORY_CARD_REHASH_RUNS=1"
if not defined VICTORY_JOIN_COPIES set "VICTORY_JOIN_COPIES=1"
if not defined VICTORY_INDIRECT_WINDOW set "VICTORY_INDIRECT_WINDOW=1"
if not defined VICTORY_RELAY_COPY set "VICTORY_RELAY_COPY=1"
if not defined VICTORY_CARD_STEPS set "VICTORY_CARD_STEPS=2"
if not defined VICTORY_INDIRECT_BATCH set "VICTORY_INDIRECT_BATCH=2"
if not defined VICTORY_MAP_THREADS set "VICTORY_MAP_THREADS=1"
if not defined VICTORY_CARD_AWAKE set "VICTORY_CARD_AWAKE=1"
if not defined VICTORY_SHOW_AFTER set "VICTORY_SHOW_AFTER=1"
if not defined VICTORY_AMBIENT set "VICTORY_AMBIENT=0.8"
if not defined VICTORY_THIN set "VICTORY_THIN=1"
if not defined VICTORY_JOIN_PARTS set "VICTORY_JOIN_PARTS=8"
if not defined VICTORY_UPLOAD_AHEAD set "VICTORY_UPLOAD_AHEAD=1"
if not defined VICTORY_LEVELS_ON_DEMAND set "VICTORY_LEVELS_ON_DEMAND=0"
if not defined VICTORY_CARD_BUFFERS_MB set "VICTORY_CARD_BUFFERS_MB=2048"
if not defined VICTORY_CARD_BUFFERS_MIN_KB set "VICTORY_CARD_BUFFERS_MIN_KB=64"
rem The TV size the game renders for.
if not defined VICTORY_DISPLAY_MODE set "VICTORY_DISPLAY_MODE=1920x1080"
if not defined VICTORY_LOG if not defined RUST_LOG set "VICTORY_LOG=warn"

"%~dp0victory-nvidia.exe" run "%VICTORY_GAME_DIR%\game_scarlett_master.exe" --console series-s --execute
set "code=%errorlevel%"
if not "%code%"=="0" (
  echo VIctory ended with code %code%.
  pause
)
exit /b %code%

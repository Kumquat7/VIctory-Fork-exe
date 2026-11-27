VIctory (NVIDIA build) for GTA VI on Windows
============================================

You need
--------
- Your own complete dump of the game: the folder with game_scarlett_master.exe and its
  data and title DLLs. Nothing from the game is included here, and none should be shared.
- Windows 10 or 11 x64 and a CPU with AVX2.
- An NVIDIA card with Direct3D 12, Shader Model 6.6 and mesh shaders (RTX 20 series or
  newer), with a recent driver. This build is tuned for NVIDIA. The settings in
  Play-VIctory.cmd were measured on an 8 GB card with 16 GB of RAM.

Start
-----
1. Put this folder anywhere. Then do one of these:
   - put it inside your dump folder, or
   - put your dump in a folder named "game" beside Play-VIctory.cmd, or
   - set VICTORY_GAME_DIR to your dump folder.
2. Double-click Play-VIctory.cmd.

The first launches are slow, later ones fast
--------------------------------------------
- The first launch translates the game's shaders and builds a cache in
  %LOCALAPPDATA%\VIctory\cache-nvidia (about 2.5 GB). Expect this launch to be slow.
- It also records the "load pack" (in the loadpack folder here, about 2-3 GB): the
  startup reads in the order the game needs them. From the next launch on they come from
  that one file, which matters most on a hard disk. On the PC it was tuned on (a 5400 rpm
  disk), that took the world from 9+ minutes to about 3.3 minutes.
- In the world, expect about 15+ fps on an RTX 4060 class PC, with a slower first minute (I was locked to about 15 due to being stuck on an SSD)
  while the scene streams in. Work on the frame rate is ongoing.
- F11 or Alt+Enter switches fullscreen.

Change a setting
----------------
Every setting in Play-VIctory.cmd only applies if it is not set already, so set your own
before launching. For example, to render for 1280x720, in PowerShell:
    $env:VICTORY_DISPLAY_MODE = '1280x720'; .\Play-VIctory.cmd

Files
-----
- victory-nvidia.exe   VIctory, built from the source in source.zip
- vcruntime140.dll     Microsoft's x64 Visual C++ runtime (Microsoft Corporation)
- Play-VIctory.cmd     the launcher
- LICENSE              GNU General Public License v3 (VIctory's license)
- asset-policy.md      upstream's rule that nothing from the game is stored or shared
- source.zip           the complete source of this exact build

License and source
------------------
VIctory is GPL-3.0-or-later. This build is codec-d/cool_fox at commit f4b48ad
(https://github.com/codec-d/cool_fox/tree/f4b48ad766ddbec1a1867022cd42f7645b0dd55e) with
local changes: the load pack, a block cache for the game's small reads, trimming the
NVIDIA driver's shader-cache pages from memory, and others. source.zip holds all of it.
Build it with: cargo build --release --locked -p victory

VIctory (NVIDIA, merged build) for GTA VI on Windows
====================================================

This replaces the earlier portable build: textures are no longer "deep-fried", it uses
DLSS, and it reaches the world in a few minutes even on a hard disk.

You need
--------
- Your own complete dump of the game: the folder with game_scarlett_master.exe and its
  data and title DLLs. Nothing from the game is included here, and none should be shared.
- Windows 10 or 11 x64 and a CPU with AVX2.
- An NVIDIA RTX card (20 series or newer) with a recent driver, and Resizable BAR on if
  your PC has it.
- The Microsoft Visual C++ 2015-2022 x64 runtime (most PCs have it; if Windows says
  msvcp140.dll is missing, install it from Microsoft).

Start
-----
1. Put this folder anywhere. Then do one of these:
   - put it inside your dump folder, or
   - put your dump in a folder named "game" beside Play-VIctory.cmd, or
   - set VICTORY_GAME_DIR to your dump folder.
2. Double-click Play-VIctory.cmd.
3. The first time, it offers to download NVIDIA's DLSS files from NVIDIA's own GitHub
   (about 70 MB, into nvidia-sdk here). Say Y: without them the game falls back to its
   own upscaling, which looks much rougher. Get-NVIDIA-DLSS.cmd does the same later.
4. At every start it asks "Use frame generation this time [Y,N]?". Frame generation
   adds a frame between each two the game draws, so motion looks smoother, but input
   lags a little more. It needs an RTX 40 card or newer, and on a 16 GB PC it takes
   some memory from the game. Your answer counts for that start, over what the F1 menu
   saved. To skip the question, set VICTORY_ASK_FRAMEGEN=0; the F1 menu's choice then
   counts.

The first launch is slow, later ones fast
-----------------------------------------
- The first launch translates the game's shaders and builds a cache in
  %LOCALAPPDATA%\VIctory\cache. Expect it to be slow, and the first minutes in the
  world to stutter while pipelines are built.
- It also records the "load pack" (the loadpack folder here, about 4 GB): the game's
  startup reads, in the order it asks for them, in one file. From the next launch on
  they come from that file. On a 5400 rpm hard disk that takes the world from about
  12 minutes to about 2.5.

What to expect
--------------
- With less than 24 GB of RAM, the launcher picks the low-memory settings on its own:
  the Series S profile (1920x1080 output, DLSS from 1280x720), no frame generation,
  and copies placed in the card's memory through Resizable BAR. On an RTX 4060 8 GB
  with 16 GB of RAM: about 8-13 fps walking around the first scene, with hitches when
  new areas stream in. 16 GB of RAM is the limit: close your browser and other big
  programs before playing.
- With 24 GB or more, it picks the Series X profile at 2560x1440 with DLSS Quality,
  and frame generation can be switched on in the F1 menu (RTX 40 or newer).

In the game
-----------
- F1: settings menu (arrow keys pick and change, Enter does it). Its choices are saved
  in victory-settings.txt here; delete that file to go back to the defaults.
- F3: stats panel (frame rate, draws, memory).
- F11 or Alt+Enter: fullscreen.
- Each run writes a log to %LOCALAPPDATA%\victory\logs.

Change a setting
----------------
Options go after Play-VIctory.cmd in a Command Prompt, for example:
    Play-VIctory.cmd -Dlss balanced
    Play-VIctory.cmd -NoLow            the settings for PCs with more memory
    Play-VIctory.cmd -FrameGen         frame generation on, without the question
    Play-VIctory.cmd -NoFrameGen       frame generation off, without the question
play.ps1 lists every option at its top.

Files
-----
- victory.exe            VIctory, built from the source in source.zip
- play.ps1               the launcher (Play-VIctory.cmd starts it)
- Play-VIctory.cmd       double-click this
- Get-NVIDIA-DLSS.cmd    downloads NVIDIA's DLSS files (scripts\get-nvidia-sdks.ps1)
- vcruntime140.dll       Microsoft's x64 Visual C++ runtime (Microsoft Corporation)
- LICENSE                GNU General Public License v3 (VIctory's license)
- asset-policy.md        the rule that nothing from the game is stored or shared
- source.zip             the complete source of this exact build

License and source
------------------
VIctory is GPL-3.0-or-later. This build is the "VIctory on NVIDIA" fork (based on
https://github.com/readmet3xt-lab/foxhound at 02fc18a, with DLSS, frame generation
and the picture fixes) with these local changes: the load pack and a block cache for hard
disks, the longer hang watch, trimming the NVIDIA driver's shader-cache pages from
memory, and the low-memory launcher settings. source.zip holds all of it. Build it
with: cargo build --release --locked -p victory
NVIDIA's DLSS and Streamline files are not included; they are downloaded from NVIDIA
under NVIDIA's licences, which are saved beside them.

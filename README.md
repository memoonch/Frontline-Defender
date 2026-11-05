# Frontline Defender recovery

## Open and play
Open `source/game/Frontline Defender - game.fla` in Adobe Animate 2024 and press Ctrl+Enter. Keep all adjacent ActionScript and `_assets` files with the FLA.

The rebuilt `source/game/Frontline Defender - game.swf` also runs with Ruffle in a browser. Run `node tools/preview.cjs` from this repository, then open http://127.0.0.1:8765/ . The preview uses Ruffle from unpkg, so initial loading needs internet access.

## Repairs
- Moved fog's miniLogo instance initialization into its constructor to fix compiler error 1061.
- Added deferred standalone startup in src.Main. The original game depended on its publisher wrapper calling LoadAPI; without that call, the rebuilt SWF remained black.
- Guarded initialization against duplicate calls, preserving wrapper-provided startup when it happens first.
- Supplied local coin-menu compatibility methods for standalone mode. Online publisher coin exchange is unavailable; disconnected score submission already completes locally through its callback.

## Verification
Compiled the recovered FLA in Adobe Animate 2024 and loaded the resulting SWF in the local Ruffle preview. Verified the main menu, Play transition, wave 1, enemy spawning, camera keyboard input, firing, ammo decrement, score changes, wave 1 completion, and the between-wave shop screen. A full multi-wave playthrough and all shop/upgrade paths have not been verified.

## Recovered originals
- `original/Frontline Defender.swf`: unchanged supplied SWF.
- `original/Frontline Defender - game.swf`: embedded game extracted from the publisher wrapper.
- `source/publisher-wrapper/Frontline Defender.fla`: reconstructed publisher wrapper.
- `source/game/`: reconstructed game FLA, decompiled ActionScript, and embedded assets (JPEXS 26.3.0, CC format).

This is reconstructed authoring source, not the original FLA. `logs/` contains decompiler logs; `tools/publish.jsfl` is an optional Animate automation script. Browser compatibility still depends on Ruffle.


## Display size and fullscreen
The FLA and compiled SWF stage are 960 x 540 at 30 fps. The 640 x 480 logical game layout and gameplay coordinates are retained and scaled as a complete display to fill the stage. This removes the former 50-pixel banner strip; scaling is independent on each axis, so artwork proportions change with the viewport aspect ratio. Gameplay rules, HUD contents, and UI placement are retained.

The browser preview is 960 x 540 when space permits, fits smaller windows at 16:9, and fills the available screen under browser F11 without cropping. It resizes the existing player, preserving the running session. Press F11 again to return. The page also supports document fullscreen as a fallback when an embedded browser delivers F11 to page JavaScript.

Resize build verification: Animate published with 0 errors (one pre-existing unresolved optional Flex SDK library-path warning). FFDec verified the SWF stage at 960 x 540. Browser F11 testing filled a 1680 x 1050 viewport exactly and returned to the fitted 16:9 preview. Menu controls remained visible. Full gameplay playtesting is left to the user.

## Menu cleanup
Removed the FOG link, Credits, and Host Game buttons and their event handlers from MainMenu; Play and Help retain their original positions. Also removed the shop's FOG link. Rebuilt the two classes directly into the existing compiled SWF with JPEXS importScript; exported them again to verify that the removed fields and link handlers are absent. The adjacent ActionScript sources used by the FLA contain the same changes. The browser preview loads the updated SWF successfully.

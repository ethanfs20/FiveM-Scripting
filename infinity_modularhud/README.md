# infinity_modularhud

Key Features:
* FRFUEL+ and LegacyFuel support.
* Moveable HUD items. 
* Save positions for HUD items. 
* Reactive progress using SVG/JS/CSS. Fuel, Health, Armor, and saveable.

Usage:
* /healthedit | Allows you to move the health div.
* /armoredit | Allows you to move the armor div.
* /fueledit | Allows you to move the fuel div.
* /sbedit | Allows you to move the seat-belt div.
* /resetui | Resets the UI locations and saves.
* /healthtoggle | Toggle the visibility of the health div.
* /armortoggle | Toggle the visibility of the armor div.
* /uiall| Toggle the visibility of the armor, and health div.

Developer API:
* exports.infinity_hud:ToggleDisp(case) | case: 'health', 'armor', 'reset', 'all'
* exports.infinity_hud:HealthEdit(), ArmorEdit(), FuelEdit(), SeatBeltEdit()

Installation:

1. Download the resource (https://github.com/1NF1N17Y20/infinity_modularhud/) **<===DOWNLOAD**
2. Just insert the resource into your data folder.
3. insert into your cfg `ensure infinity_hud`

I took inspiration from this script and completely re-worked it. (https://forum.cfx.re/t/esx-circle-hud-status-speed-fuel/1628966)

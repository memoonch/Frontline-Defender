from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text().replace('value=="NEXT WAVE"?1.6:1','value=="NEXT WAVE"?2:1').replace('if(value=="NEXT WAVE"){var weight:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);weight.x=0.4;weight.alpha=0.65;t.addChild(weight);}','');p.write_text(s)
p=Path('source/game/src/interfaces/components/TroopSelection.as');s=p.read_text();s=s.replace('instruction.alpha=0.7;','instruction.alpha=1;this._background.graphics.beginFill(0x080d0e,0.92);this._background.graphics.drawRect(instruction.x-6,43,instruction.width+12,15);this._background.graphics.endFill();');p.write_text(s)
for file in ['src/interfaces/ShopMenu.as','src/interfaces/components/TroopSelection.as']:
 target=Path('tools/shop-polish-patch')/file;shutil.copy2(Path('source/game')/file,target)

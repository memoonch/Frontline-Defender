from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text().replace('upgradeAction.x=449','upgradeAction.x=443').replace('_wallLevel<2&&_money>=upgradeCost,42,18','_wallLevel<2&&_money>=upgradeCost,48,18');p.write_text(s)
p=Path('source/game/src/interfaces/components/TroopSelection.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite;import com.hcLibrary.managers.FontManager;');s=s.replace('this._background.addChild(this._imageManager.getImage("shop_hover_prompt"));','''this._background.graphics.beginFill(0x020706,0.25);this._background.graphics.drawRect(0,0,235,101);this._background.graphics.endFill();
         var instruction:Sprite=FontManager.getInstance().getString("HOVER TO PLACE TROOPS","SHOP",1,0);instruction.x=(235-instruction.width)/2;instruction.y=47;instruction.alpha=0.7;instruction.mouseEnabled=false;instruction.mouseChildren=false;this._background.addChild(instruction);''');p.write_text(s)
for file in ['src/interfaces/ShopMenu.as','src/interfaces/components/TroopSelection.as']:
 target=Path('tools/shop-polish-patch')/file;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(Path('source/game')/file,target)

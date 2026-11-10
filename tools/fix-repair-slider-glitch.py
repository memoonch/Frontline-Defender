from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text();a=s.index('      private function updateRepairCost(param1:Event) : void');start=s.index('         switch(this._activeWeapon)',a);end=s.index('         this._wallUpgradeButton.enabled = true;',start);s=s[:start]+s[end:];end=s.index('\n      }',a);s=s[:end]+'''\n         this._wallCostText.visible=false;
         this.refreshPurchaseActions();'''+s[end:];p.write_text(s)
Path('tools/repair-glitch-patch/src/interfaces').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/repair-glitch-patch/src/interfaces/ShopMenu.as')

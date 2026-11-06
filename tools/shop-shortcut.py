from pathlib import Path
import shutil
p=Path('source/game/src/Main.as');s=p.read_text();needle='      private function keyPressed(param1:KeyboardEvent) : void\n      {'
s=s.replace(needle,needle+'\n         if(param1.keyCode==83){if(this._game!=null)this._game.openShopShortcut();return;}');p.write_text(s)
p=Path('source/game/src/components/Game.as');s=p.read_text();pos=s.index('      private function OpenShop() : void');s=s[:pos]+'''      public function openShopShortcut():void
      {
         if(this._paused || this._isShopping || this._health<=0 || this._gameoverMenu.visible)return;
         this._isShopping=true;
         this.OpenShop();
      }

'''+s[pos:];p.write_text(s)
Path('tools/shortcut-patch/src/components').mkdir(parents=True,exist_ok=True)
shutil.copy2('source/game/src/Main.as','tools/shortcut-patch/src/Main.as');shutil.copy2(p,'tools/shortcut-patch/src/components/Game.as')

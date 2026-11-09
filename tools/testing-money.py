from pathlib import Path
import shutil
p=Path('source/game/src/Main.as');s=p.read_text();s=s.replace('      private function keyPressed(param1:KeyboardEvent) : void','      private var testingMoneyKeyHeld:Boolean=false;\n      private function keyPressed(param1:KeyboardEvent) : void');s=s.replace('if(param1.keyCode==83){','if(param1.ctrlKey && param1.keyCode==75){param1.preventDefault();if(!testingMoneyKeyHeld && this._game!=null)this._game.grantTestingMoney();testingMoneyKeyHeld=true;return;}\n         if(param1.keyCode==83){');s=s.replace('      private function keyReleased(param1:KeyboardEvent) : void\n      {','      private function keyReleased(param1:KeyboardEvent) : void\n      {\n         if(param1.keyCode==75 || param1.keyCode==17)testingMoneyKeyHeld=false;');p.write_text(s)
p=Path('source/game/src/components/Game.as');s=p.read_text();pos=s.index('      public function openShopShortcut()');s=s[:pos]+'''      public function grantTestingMoney():void {
       if(this._gameoverMenu.visible)return;
       if(this._isShopping && this._shopMenu.visible)this._shopMenu.grantTestingMoney();else this._money+=2000;
      }
'''+s[pos:];p.write_text(s)
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text();pos=s.index('      private function refreshRepairLabel');s=s[:pos]+'''      public function grantTestingMoney():void {
       this._money+=2000;
       var weapons:Array=[_pistolButton,_smgButton,_shotgunButton,_assaultRifleButton,_sniperButton,_rpgButton,_railgunButton,_chaingunButton,_photonCannonButton,_grenadeButton,_payloadButton];
       if(_activeWeapon>=0)weapons[_activeWeapon].dispatchEvent(new GameEvent(GameEvent.CLICKED));
       var troops:Array=[_quickDrawButton,_gungHoButton,_buckshotButton,_eagleEyeButton,_heavyArmsButton,_bbqueButton];
       if(_activeTroop>=0)troops[_activeTroop].dispatchEvent(new GameEvent(GameEvent.CLICKED));
       if(_activeUpgrade==1)updateRepairCost(null);else wallButtonHandler(null);
      }
'''+s[pos:];p.write_text(s)
for file in ['src/Main.as','src/components/Game.as','src/interfaces/ShopMenu.as']:
 target=Path('tools/testing-money-patch')/file;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(Path('source/game')/file,target)
p=Path('tools/preview.html');s=p.read_text();s=s.replace('</body>','<script>window.addEventListener("keydown",function(e){if(e.ctrlKey && e.code==="KeyK")e.preventDefault();},true);</script>\n</body>');p.write_text(s)

from pathlib import Path
import re,shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text().replace('"TOTAL AMMO","STOCK"','"AMMO","STOCK"')
s=s.replace('this._classified.x = 127;','this._classified.scaleX=this._classified.scaleY=0.4;\n         this._classified.x = 153;').replace('this._classified.y = 75;','this._classified.y = 62;')
s=re.sub(r'(this\._(?:power|accuracy|clip|ammo|stock)Text)\.x = 237 - \1\.width;',r'if(\1.width>53)\1.width=53; \1.x = 237 - \1.width;',s)
s=s.replace('"SHOP",1,3','"SHOP",1,0')
for v in ['_arsenalCostText','_troopCostText','_wallCostText']:
 s=s.replace('_background.addChild(this.'+v+');','priceMark(this.'+v+'); _background.addChild(this.'+v+');')
s=s.replace('      private var _repairBar:RepairBar;','      private var _repairBar:RepairBar;\n      private var _repairHealthLabel:Sprite;')
s=s.replace('         _background.addChild(this._repairBar);','         _background.addChild(this._repairBar);\n         this.addEventListener(Event.ENTER_FRAME,refreshRepairLabel,false,0,true);')
# Keep disabled labels readable: button text is generated in white already.
s=s.replace('i==0?0x101815:(i==1?0x263623:0x35452d)','i==0?0x17201b:(i==1?0x263623:0x35452d)')
helper='''
      private function refreshRepairLabel(e:Event):void {
       if(!visible||!_repairBar)return;
       if(_repairHealthLabel)_background.removeChild(_repairHealthLabel);
       _repairHealthLabel=_fontManager.getString("HP "+String(_wallHealth)+" > "+String(_repairBar.health),"SHOP",1,0);
       _repairHealthLabel.x=320;_repairHealthLabel.y=369;_background.addChild(_repairHealthLabel);
      }
      private function priceMark(p:Sprite):void {
       var mark:Sprite=new Sprite();var rows:Array=["01110","11000","11000","01110","00011","00011","11110"];
       mark.graphics.beginFill(0xcbd5c4);for(var y:int=0;y<7;y++)for(var x:int=0;x<5;x++)if(String(rows[y]).charAt(x)=="1")mark.graphics.drawRect(x,y,1,1);
       mark.graphics.drawRect(2,-1,1,9);mark.graphics.endFill();mark.x=-8;mark.y=2;p.addChild(mark);
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s);shutil.copy2(p,'tools/shop-patch/src/interfaces/ShopMenu.as')
p=Path('source/game/src/interfaces/components/TroopSelection.as');s=p.read_text().replace('         this.InitializeParts();','''         this.InitializeParts();
         var hints:Sprite=new Sprite();hints.mouseEnabled=false;hints.mouseChildren=false;
         for(var hintIndex:int=0;hintIndex<this._slots.length;hintIndex++){
          var slot:Sprite=this._slots[hintIndex];hints.graphics.lineStyle(1,0x8d9d79,0.75);hints.graphics.drawRect(slot.x+5,slot.y+2,56,9);
         }this.addChildAt(hints,0);''');p.write_text(s)
Path('tools/shop-patch/src/interfaces/components').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/shop-patch/src/interfaces/components/TroopSelection.as')

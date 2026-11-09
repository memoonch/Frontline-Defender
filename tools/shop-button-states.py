from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('this._arsenalUpgradeButton.disabledState = 3;','this._arsenalUpgradeButton.disabledState = 1;').replace('this._wallUpgradeButton.idleState = 1;','this._wallUpgradeButton.idleState = 2;').replace('this._wallUpgradeButton.overState = 2;','this._wallUpgradeButton.overState = 3;').replace('this._wallUpgradeButton.disabledState = 2;','this._wallUpgradeButton.disabledState = 1;')
s=s.replace('p.graphics.beginFill(i==0?0x080d0e:(i==1?0x30442b:0x26352c))','p.graphics.beginFill(i==0?0x080d0e:(i==1?0x1e2c23:0x30442b))').replace('if(i==1){p.graphics.beginFill(0x9ac76a)','if(i==2){p.graphics.beginFill(0x9ac76a)')
s=s.replace('value=="NEXT WAVE"?(i==0?0x30442b:0x405937):(i==0?0x17201b:(i==1?0x263623:0x35452d))','value=="NEXT WAVE"?(i==0?0x4c6b33:0x648b43):(i==0?0x111715:(i==1?0x3c592e:0x597b3c))')
s=s.replace('p.addChild(t);}\n        else if(w>70)', 'if(i==0 && value!="NEXT WAVE")t.alpha=0.4;p.addChild(t);}\n        else if(w>70)')
# Add action border emphasis after generated frame; rows keep only selection marker.
s=s.replace('        if(value.length>0){var size:', '''        if(!(value.length==0 && w>70)) {p.graphics.lineStyle(1,i==0 && value!="NEXT WAVE"?0x29332c:(i==2?0xb7d796:0x86a66b));p.graphics.drawRect(0.5,0.5,w-1,h-1);}
        if(value.length>0){var size:''')
s=s.replace('private var _repairHealthLabel:Sprite;','private var _arsenalMax:Sprite;private var _wallMax:Sprite;private var _repairFull:Sprite;\n      private var _repairHealthLabel:Sprite;')
s=s.replace('if(!visible||!_repairBar)return;','if(!visible||!_repairBar)return;\n       refreshActionStates();')
helper='''
      private function statusCard(value:String,x:Number,y:Number,w:Number,h:Number):Sprite {
       var p:Sprite=new Sprite();p.x=x;p.y=y;p.mouseEnabled=false;p.mouseChildren=false;shopFrame(p,0,0,w,h,0x111715);
       var t:Sprite=_fontManager.getString(value,"SHOP",0,0);t.x=(w-t.width)/2;t.y=(h-t.height)/2;t.alpha=0.5;p.addChild(t);_background.addChild(p);return p;
      }
      private function refreshActionStates():void {
       if(!_arsenalMax){_arsenalMax=statusCard("MAXED",127,230,114,23);_wallMax=statusCard("MAXED",258,365,51,18);_repairFull=statusCard("FULL",449,340,42,18);}
       _arsenalMax.visible=_activeWeapon>=0 && _activeWeapon<9 && _shopStats[_activeWeapon].level>=2;
       _wallMax.visible=_wallLevel>=2;
       _repairFull.visible=_activeUpgrade==1 && _wallHealth>=_wallLevel*50+100;
       _upgradeText.alpha=_wallUpgradeButton.enabled?1:0.4;
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/shop-state-patch/src/interfaces').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/shop-state-patch/src/interfaces/ShopMenu.as');shutil.copy2(p,'tools/shop-patch/src/interfaces/ShopMenu.as')

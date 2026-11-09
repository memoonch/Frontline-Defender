from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text().replace('import flash.events.Event;','import flash.events.Event;import flash.events.MouseEvent;')
s=s.replace('_background.setChildIndex(this._classified,_background.numChildren - 1);','''_background.setChildIndex(this._classified,_background.numChildren - 1);
         if(_activeWeapon<9 && _weaponStats.purchased && _shopStats[_activeWeapon].level<2)updateArsenalUpgrade(null);''')
s=s.replace('new CustomButton(shopButton(42,18,3,"BUY"),42,18,3);\n         this._arsenalBuyButton','new CustomButton(shopButton(114,23,3,"BUY"),114,23,3);\n         this._arsenalBuyButton')
s=s.replace('this._arsenalBuyButton.x = 199;','this._arsenalBuyButton.x = 127;').replace('this._arsenalBuyButton.y = 260;','this._arsenalBuyButton.y = 258;')
s=s.replace('private var _arsenalMax:Sprite;','private var repairAction:Sprite;private var upgradeAction:Sprite;private var weaponActionText:Sprite;private var repairPriceText:Sprite;private var upgradePriceText:Sprite;\n      private var _arsenalMax:Sprite;')
s=s.replace('       refreshActionStates();','       refreshActionStates();\n       refreshPurchaseActions();')
# Repair feedback moves to its own position to leave room for upgrade price.
s=s.replace('_repairHealthLabel.x=320;_repairHealthLabel.y=369;','_repairHealthLabel.x=375;_repairHealthLabel.y=369;')
helper='''
      private function actionFace(b:Sprite,value:String,available:Boolean,w:Number,h:Number):void {
       b.graphics.clear();b.graphics.beginFill(available?0x3c592e:0x111715);b.graphics.drawRect(0,0,w,h);b.graphics.endFill();b.graphics.lineStyle(1,available?0x86a66b:0x29332c);b.graphics.drawRect(0.5,0.5,w-1,h-1);
       while(b.numChildren>0)b.removeChildAt(0);
       var t:Sprite=_fontManager.getString(value,"SHOP",0,0);t.x=(w-t.width)/2;t.y=(h-t.height)/2;t.alpha=available?1:0.4;t.mouseEnabled=false;t.mouseChildren=false;b.addChild(t);b.buttonMode=available;b.mouseChildren=false;
      }
      private function refreshPurchaseActions():void {
       _arsenalUpgradeButton.visible=false;if(_arsenalMax)_arsenalMax.visible=false;
       if(_activeWeapon>=0){
        var owned:Boolean=_activeWeapon<9 && _weaponStats.purchased;
        var maxed:Boolean=owned && _shopStats[_activeWeapon].level>=2;
        var name:String=maxed?"MAXED":(_activeWeapon==9?"BUY GRENADE":(_activeWeapon==10?"BUY PAYLOAD":(owned?"UPGRADE TO TIER "+String(_shopStats[_activeWeapon].level+2):"BUY WEAPON")));
        _arsenalBuyButton.visible=true;
        _arsenalBuyButton.getChildAt(0).visible=false;
        if(weaponActionText)_arsenalBuyButton.removeChild(weaponActionText);
        _arsenalBuyButton.graphics.clear();_arsenalBuyButton.graphics.beginFill(!maxed&&_arsenalBuyButton.enabled?0x3c592e:0x111715);_arsenalBuyButton.graphics.drawRect(0,0,114,23);_arsenalBuyButton.graphics.endFill();_arsenalBuyButton.graphics.lineStyle(1,!maxed&&_arsenalBuyButton.enabled?0x86a66b:0x29332c);_arsenalBuyButton.graphics.drawRect(0.5,0.5,113,22);
        weaponActionText=_fontManager.getString(name,"SHOP",0,0);weaponActionText.x=(114-weaponActionText.width)/2;weaponActionText.y=8;weaponActionText.alpha=!maxed&&_arsenalBuyButton.enabled?1:0.4;weaponActionText.mouseEnabled=false;weaponActionText.mouseChildren=false;_arsenalBuyButton.addChild(weaponActionText);
        if(maxed)_arsenalBuyButton.enabled=false;
        _arsenalCostText.y=239;
       }
       _wallUpgradeButton.visible=false;_wallBuyButton.visible=false;_upgradeText.visible=false;if(_wallMax)_wallMax.visible=false;if(_repairFull)_repairFull.visible=false;if(_wallCostText)_wallCostText.visible=false;
       if(!repairAction){repairAction=new Sprite();repairAction.x=449;repairAction.y=340;_background.addChild(repairAction);repairAction.addEventListener(MouseEvent.CLICK,repairPurchase);upgradeAction=new Sprite();upgradeAction.x=258;upgradeAction.y=365;_background.addChild(upgradeAction);upgradeAction.addEventListener(MouseEvent.CLICK,wallPurchase);}
       var repairCost:Number=Math.max(0,_repairBar.health-_wallHealth)*(_wallLevel==0?1:(_wallLevel==1?3:6));
       actionFace(repairAction,_wallHealth>=_wallLevel*50+100?"FULL":"REPAIR",repairCost>0&&_money>=repairCost,42,18);
       var upgradeCost:Number=_wallLevel==0?1000:2000;
       actionFace(upgradeAction,_wallLevel>=2?"MAXED":"UPGRADE",_wallLevel<2&&_money>=upgradeCost,51,18);
       if(repairPriceText)_background.removeChild(repairPriceText);repairPriceText=_fontManager.getString(String(repairCost),"SHOP_DIGITS",1,_money>=repairCost?0:1);repairPriceText.x=384;repairPriceText.y=343;priceMark(repairPriceText);_background.addChild(repairPriceText);
       if(upgradePriceText)_background.removeChild(upgradePriceText);upgradePriceText=_fontManager.getString(_wallLevel>=2?"--":String(upgradeCost),"SHOP",1,_money>=upgradeCost?0:2);upgradePriceText.x=320;upgradePriceText.y=371;priceMark(upgradePriceText);_background.addChild(upgradePriceText);
      }
      private function repairPurchase(e:MouseEvent):void {var cost:Number=Math.max(0,_repairBar.health-_wallHealth)*(_wallLevel==0?1:(_wallLevel==1?3:6));if(cost<=0||_money<cost)return;updateRepairCost(null);buyWallUpgrade(null);}
      private function wallPurchase(e:MouseEvent):void {var cost:Number=_wallLevel==0?1000:2000;if(_wallLevel>=2||_money<cost)return;wallButtonHandler(null);buyWallUpgrade(null);}
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/purchase-actions-patch/src/interfaces').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/purchase-actions-patch/src/interfaces/ShopMenu.as')

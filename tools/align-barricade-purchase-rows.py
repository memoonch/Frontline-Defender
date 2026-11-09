from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('shopText(p,"BARRICADE",335,213,1.3);','shopText(p,"BARRICADE",335,213,1.3);shopText(p,"REPAIR",259,346);')
s=s.replace('var value:String=String(_wallHealth)+"/"+String(_wallLevel*50+100)+" HP";','var value:String=_wallLevel>=2?"MAXIMUM TIER":"UPGRADE TO TIER "+String(_wallLevel+2);')
s=s.replace('_repairHealthLabel.x=258;_repairHealthLabel.y=346;_background.addChild(_repairHealthLabel);','''_repairHealthLabel.x=258;_repairHealthLabel.y=365;
       var hpText:Sprite=_fontManager.getString(_wallLevel>=2?"HP "+String(_wallLevel*50+100):"HP "+String(_wallLevel*50+100)+" > "+String(_wallLevel*50+150),"SHOP",1,0);hpText.y=11;_repairHealthLabel.addChild(hpText);_background.addChild(_repairHealthLabel);''')
s=s.replace('upgradeAction.x=258','upgradeAction.x=449')
s=s.replace('actionFace(repairAction,_wallHealth>=_wallLevel*50+100?"FULL":"REPAIR",','actionFace(repairAction,"REPAIR",')
s=s.replace('_wallLevel<2&&_money>=upgradeCost,76,18','_wallLevel<2&&_money>=upgradeCost,42,18')
s=s.replace('_fontManager.getString(_wallLevel>=2?"--":String(upgradeCost),"SHOP",1,_money>=upgradeCost?0:2)','_fontManager.getString(_wallLevel>=2?"--":String(upgradeCost),"SHOP_DIGITS",1,_money>=upgradeCost?0:1)').replace('upgradePriceText.x=348;upgradePriceText.y=371','upgradePriceText.x=384;upgradePriceText.y=368')
p.write_text(s);shutil.copy2(p,'tools/purchase-actions-patch/src/interfaces/ShopMenu.as')

from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text().replace('private var repairAction:Sprite;','private var upgradeSummary:Sprite;private var repairAction:Sprite;')
s=s.replace('this._wallIcon.scaleX=this._wallIcon.scaleY=0.25;','this._wallIcon.scaleX=0.25;this._wallIcon.scaleY=90/404;').replace('this._wallIcon.y = 233;','this._wallIcon.y = 228;').replace('this._troopSelection.y = this._wallIcon.y;','this._troopSelection.y = this._wallIcon.y;this._troopSelection.scaleY=90/101;').replace('this._repairBar.y = 340;','this._repairBar.y = 337;')
s=s.replace('shopText(p,"REPAIR",259,346);','')
s=s.replace('var value:String="HP "+String(_wallHealth)+" > "+String(_repairBar.health);','var value:String="REPAIR "+String(_wallHealth)+"/"+String(_wallLevel*50+100)+" HP"+(_wallHealth>=_wallLevel*50+100?" - FULLY REPAIRED":" > "+String(_repairBar.health)+" HP");')
s=s.replace('_repairHealthLabel.x=375;_repairHealthLabel.y=369;','_repairHealthLabel.x=259;_repairHealthLabel.y=323;')
s=s.replace('repairAction.y=340','repairAction.y=337').replace('upgradeAction.y=365','upgradeAction.y=371')
s=s.replace('actionFace(upgradeAction,_wallLevel>=2?"MAXED":"UPGRADE",_wallLevel<2&&_money>=upgradeCost,51,18);','''actionFace(upgradeAction,_wallLevel>=2?"MAXED":"UPGRADE TO TIER "+String(_wallLevel+2),_wallLevel<2&&_money>=upgradeCost,112,14);
       if(upgradeSummary)_background.removeChild(upgradeSummary);
       var description:String=_wallLevel>=2?"TIER 3 - MAXIMUM UPGRADE":"TIER "+String(_wallLevel+1)+" > "+String(_wallLevel+2)+"   MAX HP "+String(_wallLevel*50+100)+" > "+String(_wallLevel*50+150);
       upgradeSummary=_fontManager.getString(description,"SHOP",0,0);upgradeSummary.x=259;upgradeSummary.y=359;_background.addChild(upgradeSummary);''')
s=s.replace('repairPriceText.y=343','repairPriceText.y=340').replace('upgradePriceText.x=320;upgradePriceText.y=371','upgradePriceText.x=384;upgradePriceText.y=375')
p.write_text(s);shutil.copy2(p,'tools/purchase-actions-patch/src/interfaces/ShopMenu.as')

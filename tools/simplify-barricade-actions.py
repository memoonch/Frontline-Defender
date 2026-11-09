from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('this._wallIcon.scaleY=90/404','this._wallIcon.scaleY=101/404').replace('this._wallIcon.y = 228','this._wallIcon.y = 233').replace('this._troopSelection.scaleY=90/101','this._troopSelection.scaleY=1').replace('this._repairBar.y = 337','this._repairBar.y = 340')
a=s.index('var value:String="REPAIR ');b=s.index(';if(value==_repairLabelValue)',a)
s=s[:a]+'var value:String=String(_wallHealth)+"/"+String(_wallLevel*50+100)+" HP"'+s[b:]
s=s.replace('_repairHealthLabel.x=259;_repairHealthLabel.y=323','_repairHealthLabel.x=258;_repairHealthLabel.y=346')
s=s.replace('repairAction.y=337','repairAction.y=340').replace('upgradeAction.y=371','upgradeAction.y=365')
s=s.replace('"UPGRADE TO TIER "+String(_wallLevel+2),_wallLevel<2&&_money>=upgradeCost,112,14','"UPGRADE",_wallLevel<2&&_money>=upgradeCost,76,18')
a=s.index('       if(upgradeSummary)_background.removeChild(upgradeSummary);');b=s.index('       if(repairPriceText)',a)
s=s[:a]+s[b:]
s=s.replace('repairPriceText.y=340','repairPriceText.y=343').replace('upgradePriceText.x=384;upgradePriceText.y=375','upgradePriceText.x=348;upgradePriceText.y=371')
p.write_text(s);shutil.copy2(p,'tools/purchase-actions-patch/src/interfaces/ShopMenu.as')

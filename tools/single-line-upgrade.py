from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text();a=s.index('       var hpText:Sprite=');b=s.index('_background.addChild(_repairHealthLabel);',a);s=s[:a]+'       _background.addChild(_repairHealthLabel);'+s[b+len('_background.addChild(_repairHealthLabel);'):];s=s.replace('_repairHealthLabel.y=365','_repairHealthLabel.y=371');p.write_text(s);shutil.copy2(p,'tools/purchase-actions-patch/src/interfaces/ShopMenu.as')

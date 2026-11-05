from pathlib import Path
import shutil
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=Path('source/game/src/components/gui')/(name+'.as');s=p.read_text().replace('bm.height=height;bm.scaleX=bm.scaleY*0.75;bm.x=cursor;','bm.scaleY=height/35;bm.scaleX=bm.scaleY*0.75;bm.x=cursor;bm.y=(bounds.y-20)*height/35;')
 if name=='WeaponDisplay':s=s.replace('panel(176,42);changeWeapon(0);','panel(176,42);label("/",133,23,0.7,0xcbd1bf,"GUI_DIGITS");changeWeapon(0);')
 p.write_text(s);shutil.copy2(p,Path('tools/hud-patch/src/components/gui')/p.name)
p=Path('source/game/src/components/GUI.as');s=p.read_text().replace('this._scoreDisplay.x = Calc.center(Window.width,this._scoreDisplay.width);','this._scoreDisplay.x = 190;');p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/GUI.as')

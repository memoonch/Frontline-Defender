from pathlib import Path
import shutil
root=Path('source/game/src/components/gui')
for name in ['WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=root/(name+'.as');s=p.read_text();a=s.index(' private function panel(');b=s.index(' private function label(',a)
 s=s[:a]+''' private function panel(w:Number,h:Number):void {
  graphics.lineStyle();graphics.beginFill(0x080d0e,0.94);graphics.drawRect(0,0,w,h);graphics.endFill();
  graphics.lineStyle(1,0x67736d);graphics.drawRect(0.5,0.5,w-1,h-1);
  graphics.lineStyle(1,0x27332e);graphics.drawRect(2.5,2.5,w-5,h-5);
 }
'''+s[b:]
 s=s.replace('(font=="SHOP"?1.4:1.2)','(font=="SHOP"?1:1.2)')
 if name=='ScoreDisplay':
  s=s.replace('28,8,1.2,0xffb321','28,9,1.2,0xf3efdd').replace('174,8,1.2,0x97b969','174,9,1.2,0xf3efdd')
  s=s.replace('graphics.lineStyle(2,0xffaa00);graphics.moveTo(158,6);graphics.lineTo(153,20);','')
 if name=='WeaponDisplay':
  s=s.replace('panel(176,42)','panel(176,36)').replace('57,7,0.85','57,5,1').replace('23/bounds.height','18/bounds.height').replace('icon.y=10','icon.y=9').replace('image.smoothing=true','image.smoothing=false').replace('104,16,1.2','104,13,1.1').replace('143,23,0.7','143,19,0.7').replace('133,23,0.7','133,19,0.7')
  s=s.replace('graphics.lineStyle(1,0xa8ae93);graphics.moveTo(139,23);graphics.lineTo(135,35);','')
 if name=='GrenadeDisplay':
  s=s.replace('panel(58,42)','panel(58,36)').replace('28,24,0.75','28,21,0.75').replace('drawRect(10,25,10,9)','drawRect(10,22,10,9)').replace('moveTo(13,25)','moveTo(13,22)').replace('lineTo(13,34)','lineTo(13,31)').replace('moveTo(17,25)','moveTo(17,22)').replace('lineTo(17,34)','lineTo(17,31)')
 p.write_text(s);shutil.copy2(p,Path('tools/hud-patch/src/components/gui')/p.name)
p=Path('source/game/src/components/GUI.as');s=p.read_text().replace('this._weaponDisplay.y = 430','this._weaponDisplay.y = 434').replace('this._grenadeDisplay.y = 430','this._grenadeDisplay.y = 434');p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/GUI.as')

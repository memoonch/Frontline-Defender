from pathlib import Path
import shutil
for name in ['WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=Path('source/game/src/components/gui')/(name+'.as');s=p.read_text();a=s.index(' private function label(');start=s.index('{',a);depth=1;i=start+1
 while depth:
  if s[i]=='{':depth+=1
  elif s[i]=='}':depth-=1
  i+=1
 replacement=''' private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1);
  var scale:Number=(font=="SHOP"?1.4:1.2)*size;
  s.scaleX=scale;s.scaleY=scale*1.33;s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255;tint.greenMultiplier=((color>>8)&255)/255;tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;
  addChild(s);return s;
 }'''
 s=s[:a]+replacement+s[i:];p.write_text(s);shutil.copy2(p,Path('tools/hud-patch/src/components/gui')/p.name)

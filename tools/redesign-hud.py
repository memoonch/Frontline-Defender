from pathlib import Path
root=Path('source/game/src/components/gui')
common='''
 private function panel(w:Number,h:Number):void {
  var m:Matrix=new Matrix(); m.createGradientBox(w,h,Math.PI/2);
  graphics.lineStyle(1,0x929b70); graphics.beginGradientFill("linear",[0x30382c,0x101615,0x22271e],[0.96,0.96,0.96],[0,140,255],m);
  graphics.moveTo(9,0);graphics.lineTo(w-9,0);graphics.lineTo(w,9);graphics.lineTo(w-7,h);graphics.lineTo(7,h);graphics.lineTo(0,h-9);graphics.lineTo(9,0);graphics.endFill();
  graphics.lineStyle(0.6,0xcbd2a1,0.35);graphics.moveTo(12,3);graphics.lineTo(w-12,3);
  graphics.lineStyle(2,0xffaa00);graphics.moveTo(9,h-2);graphics.lineTo(29,h-2);
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1); s.scaleX=size; s.scaleY=size*1.33; s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.color=color;s.transform.colorTransform=tint;addChild(s);return s;
 }
'''
imports='''import flash.display.Sprite; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;'''
def write(name,body):
 (root/(name+'.as')).write_text('package src.components.gui {\n'+imports+'\npublic class '+name+' extends Sprite {\n'+body+common+'\n}}')
write('HealthDisplay','''
 private var fill:Sprite; private var health:int=100; private var maximum:int=100;
 public function HealthDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(170,34);
  graphics.beginFill(0xffb500);graphics.drawRect(12,9,5,18);graphics.drawRect(7,15,15,6);graphics.endFill();
  fill=new Sprite();fill.x=32;fill.y=12;addChild(fill);draw();}
 private function draw():void {fill.graphics.clear(); var ratio:Number=Math.max(0,Math.min(1,health/Math.max(1,maximum)));
  for(var i:int=0;i<5;i++){var x:Number=i*25;fill.graphics.lineStyle(0.7,0x68764f);fill.graphics.beginFill(0x151c16);fill.graphics.drawRect(x,0,23,12);fill.graphics.endFill();
   var part:Number=Math.max(0,Math.min(1,ratio*5-i));if(part>0){fill.graphics.lineStyle();fill.graphics.beginFill(ratio<0.25?0xff7026:0x85d000);fill.graphics.drawRect(x+1,1,21*part,10);fill.graphics.endFill();}}}
 public function updateHealth(value:int):void {health=value;draw();}
 public function updateTotalHealth(value:int):void {maximum=value;draw();}
''')
write('WeaponDisplay','''
 private var clip:Sprite;private var reserve:Sprite;private var title:Sprite;private var icon:Sprite;
 private const names:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
 public function WeaponDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(164,38);changeWeapon(0);updateClipAmmo(12,true,false);updateTotalAmmo(-1);}
 public function changeWeapon(value:int):void {if(title)removeChild(title);title=label(names[value],9,7,0.95);}
 public function updateClipAmmo(value:int,wide:Boolean,chain:Boolean):void {showClip(String(value));}
 private function showClip(value:String):void {if(clip)removeChild(clip);clip=label(value,90,15,1.15,0xfff6dd,"GUI_DIGITS");if(clip.width>34)clip.width=34;}
 public function updateTotalAmmo(value:int):void {if(reserve)removeChild(reserve);reserve=label(value==-1?"--":String(value),134,20,0.8,0xcbd1bf,"GUI_DIGITS");
  graphics.lineStyle(1,0xa8ae93);graphics.moveTo(128,19);graphics.lineTo(124,31);}
 public function reload(value:int):void {var s:String="";for(var i:int=0;i<value;i++)s+="-";showClip(s);}
''')
write('GrenadeDisplay','''
 private var grenade:Sprite;private var payload:Sprite;
 public function GrenadeDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(58,38);label("G",7,8,1,0xffb321);label("P",7,23,1,0xffb321);updateGrenades(0);updateMissiles(0);}
 public function updateGrenades(value:int):void {if(grenade)removeChild(grenade);grenade=label(String(value),23,5,0.8,0xf3efdd,"GUI_DIGITS");}
 public function updateMissiles(value:int):void {if(payload)removeChild(payload);payload=label(String(value),23,21,0.8,0xf3efdd,"GUI_DIGITS");}
''')
# Keep the score animation, pause/resume, and all update methods intact.
p=root/'ScoreDisplay.as';s=p.read_text();s=s.replace('import flash.events.Event;','import flash.events.Event; import flash.geom.Matrix; import flash.geom.ColorTransform;')
a=s.index('         this._plate = new Sprite();');b=s.index('\n      }',a)
s=s[:a]+'''         mouseEnabled=false;mouseChildren=false;panel(260,26);
         label("SCORE",30,8,1.25,0xffb321);label("WAVE",176,8,1.25,0x97b969);
         graphics.lineStyle(2,0xffaa00);graphics.moveTo(158,6);graphics.lineTo(153,20);'''+s[b:]
s=s.replace('this._scoreText.x = 43;','this._scoreText.x = 85; this._scoreText.scaleX=0.95; this._scoreText.scaleY=1.25;').replace('this._waveText.x = 161;','this._waveText.x = 222; this._waveText.scaleX=0.95; this._waveText.scaleY=1.25;').replace('Text.y = 3;','Text.y = 6;')
s=s.replace('   public class ScoreDisplay extends Sprite','   public class ScoreDisplay extends Sprite');pos=s.rfind('   }');s=s[:pos]+common+s[pos:];p.write_text(s)
p=Path('source/game/src/components/GUI.as');s=p.read_text().replace('this._healthDisplay.x = 3;','this._healthDisplay.x = 12;').replace('this._healthDisplay.y = 3;','this._healthDisplay.y = 434;').replace('this._weaponDisplay.x = Window.width - 142;','this._weaponDisplay.x = 400;').replace('this._weaponDisplay.y = 3;','this._weaponDisplay.y = 430;').replace('this._grenadeDisplay.x = Window.width - this._grenadeDisplay.width - 27;','this._grenadeDisplay.x = 570;').replace('this._grenadeDisplay.y = this._weaponDisplay.y + this._weaponDisplay.height + 3;','this._grenadeDisplay.y = 430;').replace('this._scoreDisplay.y = 3;','this._scoreDisplay.y = 8;').replace('this._minimap.y = this._scoreDisplay.y + this._scoreDisplay.height;','this._minimap.y = 38;')
p.write_text(s)
# Retain minimap data, camera rectangle and object layers, restyle only its frame.
p=root/'Minimap.as';s=p.read_text();s=s.replace('         this.addChild(this._frame);','''         this._frame.visible=false;
         this.addChild(this._frame);
         mouseEnabled=false;mouseChildren=false;
         var border:Sprite=new Sprite();border.graphics.lineStyle(1.2,0xe9a61c);border.graphics.drawRoundRect(8,1,194,50,4,4);
         border.graphics.lineStyle(2,0xffc02d);border.graphics.moveTo(8,11);border.graphics.lineTo(8,2);border.graphics.lineTo(19,2);
         border.graphics.moveTo(191,51);border.graphics.lineTo(202,51);border.graphics.lineTo(202,41);addChild(border);''');p.write_text(s)
import shutil
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay','Minimap']:
 shutil.copy2(root/(name+'.as'),Path('tools/hud-patch/src/components/gui')/(name+'.as'))
shutil.copy2('source/game/src/components/GUI.as','tools/hud-patch/src/components/GUI.as')

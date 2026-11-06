from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/WeaponDisplay.as');s=p.read_text().replace('label("/",133,19,0.7,0xcbd1bf,"GUI_DIGITS");','var divider:Sprite=new Sprite();divider.graphics.beginFill(0xb9c4b8);divider.graphics.drawRect(135,19,1,11);divider.graphics.endFill();addChild(divider);');p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/WeaponDisplay.as')
p=Path('source/game/src/components/gui/GrenadeDisplay.as');s=p.read_text();a=s.index('var icons:Sprite=');b=s.index('updateGrenades(0);',a)
s=s[:a]+'''drawEquipment();'''+s[b:]
pos=s.index(' public function updateGrenades')
s=s[:pos]+''' private function drawEquipment():void {
  var grenadeIcon:Sprite=new Sprite();grenadeIcon.x=10;grenadeIcon.y=4;addChild(grenadeIcon);
  pixelIcon(grenadeIcon,[".....33333..","....344443..","....32..23..","....332.....","...24442....","..2455542...","..2544542...",".245445542..",".244334442..",".255445542..",".244334442..","..2444442...","...22222...."]);
  var payloadIcon:Sprite=new Sprite();payloadIcon.x=9;payloadIcon.y=21;addChild(payloadIcon);
  pixelIcon(payloadIcon,["......22......",".....2442.....","....245542....","...24555542...","...24544542...","...24444442...","...24444442...","....244442....","....244442....","...2244422....","..2442442442..","..2222442222..",".....2222....."]);
 }
 private function pixelIcon(target:Sprite,rows:Array):void {
  var colors:Array=[0,0,0x26302b,0x657465,0xa9b6a4,0xe4e9dc];
  for(var y:int=0;y<rows.length;y++){var row:String=rows[y];for(var x:int=0;x<row.length;x++){var c:String=row.charAt(x);if(c!="."){target.graphics.beginFill(colors[int(c)]);target.graphics.drawRect(x,y,1,1);target.graphics.endFill();}}}
 }
'''+s[pos:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/GrenadeDisplay.as')

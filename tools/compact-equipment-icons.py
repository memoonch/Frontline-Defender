from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/GrenadeDisplay.as');s=p.read_text();a=s.index(' private function drawEquipment()');b=s.index(' public function updateGrenades',a)
s=s[:a]+''' private function drawEquipment():void {
  var grenadeIcon:Sprite=new Sprite();grenadeIcon.x=9;grenadeIcon.y=5;addChild(grenadeIcon);
  pixelIcon(grenadeIcon,["....55555555..","....54444445..","....333....5..","...45554...5..","..4554554.....","..5434345.....","..5434345.....","..4554554.....","..5434345.....","..4554554.....","...44444......","....333......."]);
  var payloadIcon:Sprite=new Sprite();payloadIcon.x=7;payloadIcon.y=23;addChild(payloadIcon);
  pixelIcon(payloadIcon,["...........55....","....444444455....","..4555555445555..",".45544444444555..",".45544444444555..","..4444444445555..","....444444455....","...........55...."]);
 }
 private function pixelIcon(target:Sprite,rows:Array):void {
  var colors:Array=[0,0,0,0x687367,0xb1beaa,0xf3f0df];
  var pixels:BitmapData=new BitmapData(18,12,true,0);
  for(var y:int=0;y<rows.length;y++){var row:String=rows[y];for(var x:int=0;x<row.length;x++){var c:String=row.charAt(x);if(c!=".")pixels.setPixel32(x,y,0xff000000|uint(colors[int(c)]));}}
  var image:Bitmap=new Bitmap(pixels);image.smoothing=false;target.addChild(image);
 }
'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/GrenadeDisplay.as')

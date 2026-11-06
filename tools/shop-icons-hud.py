from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/WeaponDisplay.as');s=p.read_text();a=s.index(' var sheet:BitmapData=');b=s.index(' public function updateClipAmmo',a)
s=s[:a]+''' var sheet:BitmapData=ImageManager.getInstance().getImage("shop_arsenal_icons").bitmapData;
 var raw:BitmapData=new BitmapData(114,71,true,0);raw.copyPixels(sheet,new Rectangle((value%4)*114,int(value/4)*71,114,71),new Point());
 var bounds:Rectangle=raw.getColorBoundsRect(0xff000000,0,false);
 if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(raw,bounds,new Point());var image:Bitmap=new Bitmap(cropped);image.smoothing=false;icon.addChild(image);var factor:Number=Math.min(42/bounds.width,18/bounds.height);icon.scaleX=factor;icon.scaleY=factor*1.33;icon.x=9+(42-bounds.width*factor)/2;icon.y=6+(24-bounds.height*factor*1.33)/2;addChild(icon);}
 raw.dispose();}
'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/WeaponDisplay.as')
p=Path('source/game/src/components/gui/GrenadeDisplay.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import com.hcLibrary.managers.ImageManager;');a=s.index(' private function drawEquipment()');b=s.index(' public function updateGrenades',a)
s=s[:a]+''' private function drawEquipment():void {shopIcon(9,6,4);shopIcon(10,6,21);}
 private function shopIcon(frame:int,px:Number,py:Number):void {
  var sheet:BitmapData=ImageManager.getInstance().getImage("shop_arsenal_icons").bitmapData;
  var raw:BitmapData=new BitmapData(114,71,true,0);raw.copyPixels(sheet,new Rectangle((frame%4)*114,int(frame/4)*71,114,71),new Point());
  var bounds:Rectangle=raw.getColorBoundsRect(0xff000000,0,false);
  if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(raw,bounds,new Point());var image:Bitmap=new Bitmap(cropped);image.smoothing=false;var factor:Number=Math.min(18/bounds.width,10/bounds.height);image.scaleX=factor;image.scaleY=factor*1.33;image.x=px+(18-bounds.width*factor)/2;image.y=py+(14-bounds.height*factor*1.33)/2;addChild(image);}raw.dispose();
 }
'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/GrenadeDisplay.as')

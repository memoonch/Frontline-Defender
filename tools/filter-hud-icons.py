from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/WeaponDisplay.as');s=p.read_text();a=s.index('var image:Bitmap=new Bitmap(cropped);');b=s.index('addChild(icon);}',a)+len('addChild(icon);}')
s=s[:a]+'''var factor:Number=Math.min(63/bounds.width,27/bounds.height);
 var targetWidth:int=Math.max(1,Math.round(bounds.width*factor));var targetHeight:int=Math.max(1,Math.round(bounds.height*factor));
 var reduced:BitmapData=new BitmapData(targetWidth,targetHeight,true,0);var resize:Matrix=new Matrix();resize.scale(targetWidth/bounds.width,targetHeight/bounds.height);reduced.draw(cropped,resize,null,null,null,true);cropped.dispose();
 var image:Bitmap=new Bitmap(reduced);image.smoothing=true;image.width=targetWidth/1.5;image.height=targetHeight/1.125;icon.addChild(image);icon.x=Math.round((9+(42-image.width)/2)*1.5)/1.5;icon.y=Math.round((6+(24-image.height)/2)*1.125)/1.125;addChild(icon);}'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/WeaponDisplay.as')
p=Path('source/game/src/components/gui/GrenadeDisplay.as');s=p.read_text();a=s.index('var image:Bitmap=new Bitmap(cropped);');b=s.index('addChild(image);}',a)+len('addChild(image);}')
s=s[:a]+'''var factor:Number=Math.min(27/bounds.width,15/bounds.height);var targetWidth:int=Math.max(1,Math.round(bounds.width*factor));var targetHeight:int=Math.max(1,Math.round(bounds.height*factor));
  var reduced:BitmapData=new BitmapData(targetWidth,targetHeight,true,0);var resize:Matrix=new Matrix();resize.scale(targetWidth/bounds.width,targetHeight/bounds.height);reduced.draw(cropped,resize,null,null,null,true);cropped.dispose();
  var image:Bitmap=new Bitmap(reduced);image.smoothing=true;image.width=targetWidth/1.5;image.height=targetHeight/1.125;image.x=Math.round((px+(18-image.width)/2)*1.5)/1.5;image.y=Math.round((py+(14-image.height)/2)*1.125)/1.125;addChild(image);}'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/GrenadeDisplay.as')

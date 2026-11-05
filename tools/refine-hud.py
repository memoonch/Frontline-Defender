from pathlib import Path
import shutil
root=Path('source/game/src/components/gui')
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=root/(name+'.as');s=p.read_text().replace('tint.color=color;','tint.redMultiplier=((color>>16)&255)/255; tint.greenMultiplier=((color>>8)&255)/255; tint.blueMultiplier=(color&255)/255;');p.write_text(s)
p=root/'WeaponDisplay.as';s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Rectangle; import flash.geom.Point; import com.hcLibrary.managers.ImageManager;')
s=s.replace('title=label(names[value],9,7,0.95);','''title=label(names[value],9,6,1.1);
+ if(icon)removeChild(icon);icon=new Sprite();
+ var sheet:BitmapData=ImageManager.getInstance().getImage("guns_plate").bitmapData;
+ var raw:BitmapData=new BitmapData(118,21,true,0);raw.copyPixels(sheet,new Rectangle(0,value*21,118,21),new Point());
+ var silhouette:BitmapData=new BitmapData(118,21,true,0);silhouette.threshold(raw,raw.rect,new Point(),">",0x777777,0xffe6e8da,0xffffff,false);
+ var bounds:Rectangle=silhouette.getColorBoundsRect(0xff000000,0,false);
+ if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(silhouette,bounds,new Point());var image:Bitmap=new Bitmap(cropped);image.smoothing=true;icon.addChild(image);var factor:Number=Math.min(64/bounds.width,15/bounds.height);icon.scaleX=factor;icon.scaleY=factor*1.33;icon.x=12;icon.y=17;addChild(icon);}
+ raw.dispose();silhouette.dispose();'''.replace('\n+ ','\n '));p.write_text(s)
p=Path('source/game/src/components/GUI.as');s=p.read_text().replace('this._minimap.y = 38;','this._minimap.y = 35; this._minimap.scaleY=0.8;');p.write_text(s)
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay','Minimap']:shutil.copy2(root/(name+'.as'),Path('tools/hud-patch/src/components/gui')/(name+'.as'))
shutil.copy2('source/game/src/components/GUI.as','tools/hud-patch/src/components/GUI.as')

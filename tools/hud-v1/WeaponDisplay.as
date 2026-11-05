package src.components.gui {
import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Rectangle; import flash.geom.Point; import com.hcLibrary.managers.ImageManager; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class WeaponDisplay extends Sprite {

 private var clip:Sprite;private var reserve:Sprite;private var title:Sprite;private var icon:Sprite;
 private const names:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
 public function WeaponDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(164,38);changeWeapon(0);updateClipAmmo(12,true,false);updateTotalAmmo(-1);}
 public function changeWeapon(value:int):void {if(title)removeChild(title);title=label(names[value],9,6,1.1);
 if(icon)removeChild(icon);icon=new Sprite();
 var sheet:BitmapData=ImageManager.getInstance().getImage("guns_plate").bitmapData;
 var raw:BitmapData=new BitmapData(118,21,true,0);raw.copyPixels(sheet,new Rectangle(0,value*21,118,21),new Point());
 var silhouette:BitmapData=new BitmapData(118,21,true,0);silhouette.threshold(raw,raw.rect,new Point(),">",0x777777,0xffe6e8da,0xffffff,false);
 var bounds:Rectangle=silhouette.getColorBoundsRect(0xff000000,0,false);
 if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(silhouette,bounds,new Point());var image:Bitmap=new Bitmap(cropped);image.smoothing=true;icon.addChild(image);var factor:Number=Math.min(64/bounds.width,15/bounds.height);icon.scaleX=factor;icon.scaleY=factor*1.33;icon.x=12;icon.y=17;addChild(icon);}
 raw.dispose();silhouette.dispose();}
 public function updateClipAmmo(value:int,wide:Boolean,chain:Boolean):void {showClip(String(value));}
 private function showClip(value:String):void {if(clip)removeChild(clip);clip=label(value,90,15,1.15,0xfff6dd,"GUI_DIGITS");if(clip.width>34)clip.width=34;}
 public function updateTotalAmmo(value:int):void {if(reserve)removeChild(reserve);reserve=label(value==-1?"--":String(value),134,20,0.8,0xcbd1bf,"GUI_DIGITS");
  graphics.lineStyle(1,0xa8ae93);graphics.moveTo(128,19);graphics.lineTo(124,31);}
 public function reload(value:int):void {var s:String="";for(var i:int=0;i<value;i++)s+="-";showClip(s);}

 private function panel(w:Number,h:Number):void {
  var m:Matrix=new Matrix(); m.createGradientBox(w,h,Math.PI/2);
  graphics.lineStyle(1,0x929b70); graphics.beginGradientFill("linear",[0x30382c,0x101615,0x22271e],[0.96,0.96,0.96],[0,140,255],m);
  graphics.moveTo(9,0);graphics.lineTo(w-9,0);graphics.lineTo(w,9);graphics.lineTo(w-7,h);graphics.lineTo(7,h);graphics.lineTo(0,h-9);graphics.lineTo(9,0);graphics.endFill();
  graphics.lineStyle(0.6,0xcbd2a1,0.35);graphics.moveTo(12,3);graphics.lineTo(w-12,3);
  graphics.lineStyle(2,0xffaa00);graphics.moveTo(9,h-2);graphics.lineTo(29,h-2);
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1); s.scaleX=size; s.scaleY=size*1.33; s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255; tint.greenMultiplier=((color>>8)&255)/255; tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;addChild(s);return s;
 }

}}
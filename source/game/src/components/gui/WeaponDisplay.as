package src.components.gui {
import flash.display.Sprite; import flash.net.URLRequest; import flash.events.Event; import flash.display.Loader; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Rectangle; import flash.geom.Point; import com.hcLibrary.managers.ImageManager; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class WeaponDisplay extends Sprite {

 private var clip:Sprite;private var reserve:Sprite;private var title:Sprite;private var icon:Sprite;
 private const names:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
 public function WeaponDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(176,36);label("/",133,19,0.7,0xcbd1bf,"GUI_DIGITS");changeWeapon(0);updateClipAmmo(12,true,false);updateTotalAmmo(-1);}
 public function changeWeapon(value:int):void {if(title)removeChild(title);title=label(names[value],57,5,1);
 if(icon)removeChild(icon);icon=new Sprite();
 var sheet:BitmapData=ImageManager.getInstance().getImage("guns_plate").bitmapData;
 var raw:BitmapData=new BitmapData(118,21,true,0);raw.copyPixels(sheet,new Rectangle(0,value*21,118,21),new Point());
 var silhouette:BitmapData=new BitmapData(118,21,true,0);silhouette.threshold(raw,raw.rect,new Point(),">",0x777777,0xffe6e8da,0xffffff,false);
 var bounds:Rectangle=silhouette.getColorBoundsRect(0xff000000,0,false);
 if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(silhouette,bounds,new Point());var image:Bitmap=new Bitmap(cropped);image.smoothing=false;icon.addChild(image);var factor:Number=Math.min(40/bounds.width,18/bounds.height);icon.scaleX=factor;icon.scaleY=factor*1.33;icon.x=12;icon.y=9;addChild(icon);}
 raw.dispose();silhouette.dispose();}
 public function updateClipAmmo(value:int,wide:Boolean,chain:Boolean):void {showClip(String(value));}
 private function showClip(value:String):void {if(clip)removeChild(clip);clip=label(value,104,13,1.1,0xfff6dd,"GUI_DIGITS");if(clip.width>34)clip.width=34;}
 public function updateTotalAmmo(value:int):void {if(reserve)removeChild(reserve);reserve=label(value==-1?"--":String(value),143,19,0.7,0xcbd1bf,"GUI_DIGITS");
  }
 public function reload(value:int):void {var s:String="";for(var i:int=0;i<value;i++)s+="-";showClip(s);}


 private static var fontSheet:BitmapData;
 private static var fontWaiting:Array=[];
 private static var fontLoading:Boolean=false;
 private function panel(w:Number,h:Number):void {
  graphics.lineStyle();graphics.beginFill(0x080d0e,0.94);graphics.drawRect(0,0,w,h);graphics.endFill();
  graphics.lineStyle(1,0x67736d);graphics.drawRect(0.5,0.5,w-1,h-1);
  graphics.lineStyle(1,0x27332e);graphics.drawRect(2.5,2.5,w-5,h-5);
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1);
  var scale:Number=(font=="SHOP"?1:1.2)*size;
  s.scaleX=scale;s.scaleY=scale*1.33;s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255;tint.greenMultiplier=((color>>8)&255)/255;tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;
  addChild(s);return s;
 }

}}


package src.components.gui {
import flash.display.Sprite; import flash.net.URLRequest; import flash.events.Event; import flash.display.Loader; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Rectangle; import flash.geom.Point; import com.hcLibrary.managers.ImageManager; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class WeaponDisplay extends Sprite {

 private var clip:Sprite;private var reserve:Sprite;private var title:Sprite;private var icon:Sprite;
 private const names:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
 public function WeaponDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(176,36);var divider:Sprite=new Sprite();divider.graphics.beginFill(0xb9c4b8);divider.graphics.drawRect(135,19,1,10);divider.graphics.endFill();addChild(divider);changeWeapon(0);updateClipAmmo(12,true,false);updateTotalAmmo(-1);}
 public function changeWeapon(value:int):void {if(title)removeChild(title);title=label(names[value],57,5,1);
 if(icon)removeChild(icon);icon=new Sprite();
 var sheet:BitmapData=ImageManager.getInstance().getImage("shop_arsenal_icons").bitmapData;
 var raw:BitmapData=new BitmapData(114,71,true,0);raw.copyPixels(sheet,new Rectangle((value%4)*114,int(value/4)*71,114,71),new Point());
 var bounds:Rectangle=raw.getColorBoundsRect(0xff000000,0,false);
 if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(raw,bounds,new Point());var factor:Number=Math.min(63/bounds.width,27/bounds.height);
 var targetWidth:int=Math.max(1,Math.round(bounds.width*factor));var targetHeight:int=Math.max(1,Math.round(bounds.height*factor));
 var reduced:BitmapData=new BitmapData(targetWidth,targetHeight,true,0);var resize:Matrix=new Matrix();resize.scale(targetWidth/bounds.width,targetHeight/bounds.height);reduced.draw(cropped,resize,null,null,null,true);cropped.dispose();
 var image:Bitmap=new Bitmap(reduced);image.smoothing=true;image.width=targetWidth/1.5;image.height=targetHeight/1.125;icon.addChild(image);icon.x=Math.round((9+(42-image.width)/2)*1.5)/1.5;icon.y=Math.round((6+(24-image.height)/2)*1.125)/1.125;addChild(icon);}
 raw.dispose();}
 public function updateClipAmmo(value:int,wide:Boolean,chain:Boolean):void {showClip(String(value));}
 private function showClip(value:String):void {if(clip)removeChild(clip);clip=label(value,104,13,0.99,0xfff6dd,"GUI_DIGITS");if(clip.width>34)clip.width=34;}
 public function updateTotalAmmo(value:int):void {if(reserve)removeChild(reserve);reserve=label(value==-1?"--":String(value),143,19,0.63,0xcbd1bf,"GUI_DIGITS");
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




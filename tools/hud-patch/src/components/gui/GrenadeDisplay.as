package src.components.gui {
import flash.display.Sprite; import com.hcLibrary.managers.ImageManager; import flash.geom.Point; import flash.geom.Rectangle; import flash.net.URLRequest; import flash.events.Event; import flash.display.Loader; import flash.display.BitmapData; import flash.display.Bitmap; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class GrenadeDisplay extends Sprite {

 private var grenade:Sprite;private var payload:Sprite;
 public function GrenadeDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(92,36);drawEquipment();updateGrenades(0);updateMissiles(0);}
 private function drawEquipment():void {shopIcon(9,5,4);shopIcon(10,49,4);}
 private function shopIcon(frame:int,px:Number,py:Number):void {
  var sheet:BitmapData=ImageManager.getInstance().getImage("shop_arsenal_icons").bitmapData;
  var raw:BitmapData=new BitmapData(114,71,true,0);raw.copyPixels(sheet,new Rectangle((frame%4)*114,int(frame/4)*71,114,71),new Point());
  var bounds:Rectangle=raw.getColorBoundsRect(0xff000000,0,false);
  if(bounds.width>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(raw,bounds,new Point());var factor:Number=Math.min(36/bounds.width,27/bounds.height);var targetWidth:int=Math.max(1,Math.round(bounds.width*factor));var targetHeight:int=Math.max(1,Math.round(bounds.height*factor));
  var reduced:BitmapData=new BitmapData(targetWidth,targetHeight,true,0);var resize:Matrix=new Matrix();resize.scale(targetWidth/bounds.width,targetHeight/bounds.height);reduced.draw(cropped,resize,null,null,null,true);cropped.dispose();
  var image:Bitmap=new Bitmap(reduced);image.smoothing=true;image.width=targetWidth/1.5;image.height=targetHeight/1.125;image.x=Math.round((px+(24-image.width)/2)*1.5)/1.5;image.y=Math.round((py+(28-image.height)/2)*1.125)/1.125;addChild(image);}raw.dispose();
 }
 public function updateGrenades(value:int):void {if(grenade)removeChild(grenade);grenade=label(String(value),31,12,0.8,0xf3efdd,"GUI_DIGITS");}
 public function updateMissiles(value:int):void {if(payload)removeChild(payload);payload=label(String(value),76,12,0.8,0xf3efdd,"GUI_DIGITS");}


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


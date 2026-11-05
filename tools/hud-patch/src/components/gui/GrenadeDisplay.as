package src.components.gui {
import flash.display.Sprite; import flash.geom.Point; import flash.geom.Rectangle; import flash.net.URLRequest; import flash.events.Event; import flash.display.Loader; import flash.display.BitmapData; import flash.display.Bitmap; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class GrenadeDisplay extends Sprite {

 private var grenade:Sprite;private var payload:Sprite;
 public function GrenadeDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(58,36);var icons:Sprite=new Sprite();icons.graphics.lineStyle(1,0xe3e4ce);icons.graphics.beginFill(0x7b8265);icons.graphics.drawEllipse(11,7,7,10);icons.graphics.endFill();icons.graphics.drawRect(13,4,4,3);icons.graphics.moveTo(11,10);icons.graphics.lineTo(18,10);icons.graphics.moveTo(11,13);icons.graphics.lineTo(18,13);icons.graphics.drawRect(10,22,10,9);icons.graphics.moveTo(13,22);icons.graphics.lineTo(13,31);icons.graphics.moveTo(17,22);icons.graphics.lineTo(17,31);addChild(icons);updateGrenades(0);updateMissiles(0);}
 public function updateGrenades(value:int):void {if(grenade)removeChild(grenade);grenade=label(String(value),28,5,0.75,0xf3efdd,"GUI_DIGITS");}
 public function updateMissiles(value:int):void {if(payload)removeChild(payload);payload=label(String(value),28,21,0.75,0xf3efdd,"GUI_DIGITS");}


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


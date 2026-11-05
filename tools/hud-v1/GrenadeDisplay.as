package src.components.gui {
import flash.display.Sprite; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class GrenadeDisplay extends Sprite {

 private var grenade:Sprite;private var payload:Sprite;
 public function GrenadeDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(58,38);label("G",7,8,1,0xffb321);label("P",7,23,1,0xffb321);updateGrenades(0);updateMissiles(0);}
 public function updateGrenades(value:int):void {if(grenade)removeChild(grenade);grenade=label(String(value),23,5,0.8,0xf3efdd,"GUI_DIGITS");}
 public function updateMissiles(value:int):void {if(payload)removeChild(payload);payload=label(String(value),23,21,0.8,0xf3efdd,"GUI_DIGITS");}

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
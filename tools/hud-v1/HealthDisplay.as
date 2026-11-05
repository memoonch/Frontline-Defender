package src.components.gui {
import flash.display.Sprite; import flash.geom.Matrix; import flash.geom.ColorTransform; import com.hcLibrary.managers.FontManager;
public class HealthDisplay extends Sprite {

 private var fill:Sprite; private var health:int=100; private var maximum:int=100;
 public function HealthDisplay(){super();mouseEnabled=false;mouseChildren=false;panel(170,34);
  graphics.beginFill(0xffb500);graphics.drawRect(12,9,5,18);graphics.drawRect(7,15,15,6);graphics.endFill();
  fill=new Sprite();fill.x=32;fill.y=12;addChild(fill);draw();}
 private function draw():void {fill.graphics.clear(); var ratio:Number=Math.max(0,Math.min(1,health/Math.max(1,maximum)));
  for(var i:int=0;i<5;i++){var x:Number=i*25;fill.graphics.lineStyle(0.7,0x68764f);fill.graphics.beginFill(0x151c16);fill.graphics.drawRect(x,0,23,12);fill.graphics.endFill();
   var part:Number=Math.max(0,Math.min(1,ratio*5-i));if(part>0){fill.graphics.lineStyle();fill.graphics.beginFill(ratio<0.25?0xff7026:0x85d000);fill.graphics.drawRect(x+1,1,21*part,10);fill.graphics.endFill();}}}
 public function updateHealth(value:int):void {health=value;draw();}
 public function updateTotalHealth(value:int):void {maximum=value;draw();}

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
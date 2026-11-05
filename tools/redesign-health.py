from pathlib import Path
p=Path('source/game/src/components/gui/HealthDisplay.as')
p.write_text('''package src.components.gui {
 import flash.display.Sprite;
 import flash.display.Bitmap;
 import com.hcLibrary.managers.ImageManager;
 import com.hcLibrary.managers.FontManager;
 public class HealthDisplay extends Sprite {
  private var fill:Sprite;
  private var health:int=100;
  private var maximum:int=100;
  public function HealthDisplay(){
   super();mouseEnabled=false;mouseChildren=false;
   graphics.beginFill(0x080d0e,0.94);graphics.drawRect(0,0,190,36);graphics.endFill();
   graphics.lineStyle(1,0x67736d);graphics.drawRect(0.5,0.5,189,35);
   graphics.lineStyle(1,0x27332e);graphics.drawRect(2.5,2.5,185,31);
   graphics.lineStyle();graphics.beginFill(0x202c28);graphics.drawRect(4,4,30,28);graphics.endFill();
   graphics.lineStyle(1,0x45534c);graphics.moveTo(37,5);graphics.lineTo(37,31);
   var cross:Bitmap=ImageManager.getInstance().getImage("health_bar_left");
   cross.smoothing=false;cross.x=5;cross.y=5;addChild(cross);
   var title:Sprite=FontManager.getInstance().getString("HEALTH","SHOP",1);title.x=44;title.y=5;addChild(title);
   fill=new Sprite();fill.x=44;fill.y=16;addChild(fill);draw();
  }
  private function draw():void {
   fill.graphics.clear();var ratio:Number=Math.max(0,Math.min(1,health/Math.max(1,maximum)));
   for(var i:int=0;i<10;i++){
    var x:int=i*14;fill.graphics.beginFill(0x48564a);fill.graphics.drawRect(x,0,12,12);fill.graphics.endFill();
    fill.graphics.beginFill(0x101914);fill.graphics.drawRect(x+1,1,10,10);fill.graphics.endFill();
    var part:Number=Math.max(0,Math.min(1,ratio*10-i));var width:int=Math.ceil(part*10);
    if(width>0){var color:uint=ratio<=0.25?0xe64038:0x80c735;
     fill.graphics.beginFill(color);fill.graphics.drawRect(x+1,1,width,10);fill.graphics.endFill();
     fill.graphics.beginFill(ratio<=0.25?0xff8476:0xb8ef74);fill.graphics.drawRect(x+1,1,width,2);fill.graphics.endFill();
    }
   }
  }
  public function updateHealth(value:int):void {health=value;draw();}
  public function updateTotalHealth(value:int):void {maximum=value;draw();}
 }
}
''')

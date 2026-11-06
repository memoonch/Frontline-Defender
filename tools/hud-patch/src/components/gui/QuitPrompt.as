package src.components.gui {
 import flash.display.Sprite;import flash.events.MouseEvent;
 import com.hcLibrary.events.GameEvent;import com.hcLibrary.managers.FontManager;
 public class QuitPrompt extends Sprite {
  private var card:Sprite;private var quit:Sprite;private var cancel:Sprite;
  public function QuitPrompt(){super();graphics.beginFill(0x020706,0.65);graphics.drawRect(0,0,640,480);graphics.endFill();
   card=new Sprite();card.x=160;card.y=154;addChild(card);frame(card,320,172,0x080d0e);
   text(card,"QUIT GAME",22,21,2.4);text(card,"ARE YOU SURE YOU WANT TO QUIT",22,64,1);
   var warning:Sprite=text(card,"ALL PROGRESS WILL BE LOST",22,85,1);warning.alpha=0.7;
   cancel=button("CANCEL",22,false);quit=button("QUIT",166,true);
  }
  private function frame(t:Sprite,w:Number,h:Number,c:uint):void {t.graphics.clear();t.graphics.beginFill(c,0.98);t.graphics.drawRect(0,0,w,h);t.graphics.endFill();t.graphics.lineStyle(1,0x67736d);t.graphics.drawRect(0.5,0.5,w-1,h-1);t.graphics.lineStyle(1,0x27332e);t.graphics.drawRect(2.5,2.5,w-5,h-5);}
  private function text(p:Sprite,v:String,x:Number,y:Number,z:Number):Sprite {var s:Sprite=FontManager.getInstance().getString(v,"SHOP",1,0);s.x=x;s.y=y;s.scaleX=z;s.scaleY=z*1.33;s.mouseEnabled=false;s.mouseChildren=false;p.addChild(s);return s;}
  private function button(v:String,x:Number,danger:Boolean):Sprite {var b:Sprite=new Sprite();b.x=x;b.y=118;b.buttonMode=true;b.mouseChildren=false;frame(b,132,34,danger?0x362321:0x18211c);var label:Sprite=text(b,v,0,12,1.3);label.x=(132-label.width)/2;card.addChild(b);b.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void {frame(b,132,34,danger?0x51312c:0x35452d);});b.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void {frame(b,132,34,danger?0x362321:0x18211c);});return b;}
  public function addEventListeners():void {quit.addEventListener(MouseEvent.CLICK,confirm);cancel.addEventListener(MouseEvent.CLICK,back);}
  public function removeEventListeners():void {quit.removeEventListener(MouseEvent.CLICK,confirm);cancel.removeEventListener(MouseEvent.CLICK,back);}
  private function confirm(e:MouseEvent):void {dispatchEvent(new GameEvent(GameEvent.CONFIRM));}
  private function back(e:MouseEvent):void {dispatchEvent(new GameEvent(GameEvent.CANCEL));}
 }
}


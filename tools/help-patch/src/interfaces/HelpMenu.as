package src.interfaces {
 import flash.display.Sprite;import flash.events.Event;import flash.events.MouseEvent;
 import com.hcLibrary.events.GameEvent;import com.hcLibrary.managers.FontManager;
 public class HelpMenu extends Sprite {
  private var controls:ControlsMenu;private var back:Sprite;
  public function HelpMenu(){super();graphics.beginFill(0x020706,0.72);graphics.drawRect(0,0,640,480);graphics.endFill();controls=new ControlsMenu("HELP");addChild(controls);
   back=new Sprite();back.x=125;back.y=419;back.buttonMode=true;back.mouseChildren=false;paint(false);addChild(back);
   var text:Sprite=FontManager.getInstance().getString("BACK TO MENU","SHOP",1,0);text.scaleX=1.3;text.scaleY=1.73;text.x=(390-text.width)/2;text.y=12;back.addChild(text);
   back.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{paint(true);});back.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void{paint(false);});
  }
  private function paint(hover:Boolean):void {back.graphics.clear();back.graphics.beginFill(hover?0x35452d:0x18211c);back.graphics.drawRect(0,0,390,34);back.graphics.endFill();back.graphics.lineStyle(1,0x67736d);back.graphics.drawRect(0.5,0.5,389,33);}
  public function Activate():void {visible=true;controls.reset();controls.Activate();addEventListeners();}
  public function Deactivate():void {removeEventListeners();controls.reset();visible=false;dispatchEvent(new GameEvent(GameEvent.RESUME));}
  public function addEventListeners():void {back.addEventListener(MouseEvent.CLICK,close);}
  public function removeEventListeners():void {back.removeEventListener(MouseEvent.CLICK,close);}
  private function close(e:MouseEvent):void {dispatchEvent(new Event("ACTIVATE_MAIN"));}
 }
}

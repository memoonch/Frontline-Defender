from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ControlsMenu.as');s=p.read_text().replace('public function ControlsMenu()','public function ControlsMenu(title:String="CONTROLS")').replace('         this.drawControls();','         this.drawControls(title);').replace('private function drawControls():void','private function drawControls(title:String):void').replace('controlText("CONTROLS",18,18,2)','controlText(title,18,18,2)');p.write_text(s)
p=Path('source/game/src/interfaces/HelpMenu.as');p.write_text('''package src.interfaces {
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
''')
Path('tools/help-patch/src/interfaces').mkdir(parents=True,exist_ok=True)
for name in ['ControlsMenu','HelpMenu']:shutil.copy2(Path('source/game/src/interfaces')/(name+'.as'),Path('tools/help-patch/src/interfaces')/(name+'.as'))

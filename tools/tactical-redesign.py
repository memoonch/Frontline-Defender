from pathlib import Path
import shutil
root=Path('source/game/src/components/gui')
panel=''' private function panel(w:Number,h:Number):void {
  graphics.lineStyle(0.7,0x65705c,0.8);graphics.beginFill(0x101918,0.82);
  graphics.moveTo(5,0);graphics.lineTo(w-5,0);graphics.lineTo(w,5);graphics.lineTo(w,h-5);graphics.lineTo(w-5,h);graphics.lineTo(5,h);graphics.lineTo(0,h-5);graphics.lineTo(0,5);graphics.lineTo(5,0);graphics.endFill();
  graphics.lineStyle(1,0xffb42b,0.9);graphics.moveTo(9,h-1);graphics.lineTo(w-9,h-1);
 }
'''
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=root/(name+'.as');s=p.read_text();a=s.index(' private function panel(');b=s.index(' private function label(',a);s=s[:a]+panel+s[b:]
 s=s.replace('0xff7026','0xef3f38')
 if name=='ScoreDisplay':s=s.replace('panel(260,30)','panel(260,28)')
 p.write_text(s)
# Dark glass tactical frame, retaining all original minimap markers and viewport maths.
p=root/'Minimap.as';s=p.read_text();a=s.index('         var border:Sprite=');b=s.index('\n      }',a)
s=s[:a]+'''         var border:Sprite=new Sprite();
         border.graphics.lineStyle(1,0x263530,0.9);border.graphics.drawRect(7,0,196,52);
         border.graphics.lineStyle(1.3,0xffb42b);
         border.graphics.moveTo(8,11);border.graphics.lineTo(8,1);border.graphics.lineTo(19,1);
         border.graphics.moveTo(191,1);border.graphics.lineTo(202,1);border.graphics.lineTo(202,11);
         border.graphics.moveTo(8,41);border.graphics.lineTo(8,51);border.graphics.lineTo(19,51);
         border.graphics.moveTo(191,51);border.graphics.lineTo(202,51);border.graphics.lineTo(202,41);addChild(border);'''+s[b:];p.write_text(s)
# Reuse the crisp raster type renderer, independent of device-font fallback.
base=(root/'HealthDisplay.as').read_text();common=base[base.index(' private static var fontSheet:'):base.rfind('}}')]
options='''package src.components.gui {
 import flash.display.Sprite;import flash.display.Bitmap;import flash.display.BitmapData;import flash.display.Loader;
 import flash.events.Event;import flash.events.MouseEvent;import flash.net.URLRequest;import flash.geom.Rectangle;import flash.geom.Point;import flash.geom.ColorTransform;
 import flash.filters.BlurFilter;import flash.filters.GlowFilter;
 import com.hcLibrary.events.GameEvent;import src.interfaces.ControlsMenu;import src.managers.NewSoundManager;
 public class Options extends Sprite {
  private var overlay:Sprite;private var plate:Sprite;private var backdrop:Sprite;private var frozen:Bitmap;
  private var controls:ControlsMenu;private var prompt:QuitPrompt;private var soundState:Sprite;private var musicState:Sprite;
  private var buttons:Array=[];private var active:Boolean=false;
  public function Options(){super();
   overlay=new Sprite();overlay.visible=false;addChild(overlay);
   backdrop=new Sprite();overlay.addChild(backdrop);
   var dim:Sprite=new Sprite();dim.graphics.beginFill(0x020706,0.53);dim.graphics.drawRect(0,0,640,480);dim.graphics.endFill();overlay.addChild(dim);
   plate=new Sprite();plate.x=432;plate.y=42;overlay.addChild(plate);
   plate.graphics.lineStyle(0.8,0x758065);plate.graphics.beginFill(0x101918,0.95);plate.graphics.drawRect(0,0,196,396);plate.graphics.endFill();
   plate.graphics.lineStyle(2,0xffb42b);plate.graphics.moveTo(0,17);plate.graphics.lineTo(0,0);plate.graphics.lineTo(18,0);plate.graphics.moveTo(178,396);plate.graphics.lineTo(196,396);plate.graphics.lineTo(196,379);
   plate.graphics.lineStyle();plate.graphics.beginFill(0xffb42b);plate.graphics.drawRect(15,21,5,22);plate.graphics.drawRect(25,21,5,22);plate.graphics.endFill();
   placeText(plate,"PAUSED",43,22,1.8);
   makeButton("RESUME",72,0);makeButton("CONTROLS",132,1);makeButton("SOUND",192,2);makeButton("MUSIC",252,3);makeButton("QUIT",312,4);
   controls=new ControlsMenu();addChild(controls);prompt=new QuitPrompt();prompt.visible=false;addChild(prompt);
   var gear:Sprite=new Sprite();gear.x=614;gear.y=5;gear.buttonMode=true;gear.graphics.beginFill(0x101918,0.8);gear.graphics.drawRoundRect(0,0,22,24,4,4);gear.graphics.endFill();gear.graphics.beginFill(0xe5eadd);gear.graphics.drawRect(7,6,3,12);gear.graphics.drawRect(13,6,3,12);gear.graphics.endFill();addChild(gear);
   gear.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{toggleOptionsMenu();});updateAudio();
  }
  private function placeText(parent:Sprite,value:String,x:Number,y:Number,size:Number,color:uint=0xf5f5e8):Sprite {var s:Sprite=label(value,x,y,size,color);parent.addChild(s);return s;}
  private function makeButton(text:String,y:Number,index:int):void {
   var b:Sprite=new Sprite();b.x=12;b.y=y;b.name=String(index);b.mouseChildren=false;b.buttonMode=true;plate.addChild(b);buttons.push(b);drawButton(b,index,false);
   drawIcon(b,index);placeText(b,text,40,17,index==1?1.05:1.2);b.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void {drawButton(b,index,true);});b.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void {drawButton(b,index,false);});b.addEventListener(MouseEvent.CLICK,buttonClick);
  }
  private function drawButton(b:Sprite,index:int,hover:Boolean):void {
   b.graphics.clear();b.graphics.lineStyle(0.8,index==0||hover?0xffb42b:0x606e52);b.graphics.beginFill(index==0?(hover?0xb27417:0x85500d):(hover?0x29362c:0x18221e),0.97);
   b.graphics.moveTo(6,0);b.graphics.lineTo(172,0);b.graphics.lineTo(172,44);b.graphics.lineTo(166,50);b.graphics.lineTo(0,50);b.graphics.lineTo(0,6);b.graphics.lineTo(6,0);b.graphics.endFill();
  }
  private function drawIcon(b:Sprite,index:int):void {
   var s:Sprite=new Sprite();s.x=12;s.y=16;b.addChild(s);s.graphics.lineStyle(1.5,0xe8ebdf);
   if(index==0){s.graphics.beginFill(0xf5f5e8);s.graphics.moveTo(2,0);s.graphics.lineTo(15,9);s.graphics.lineTo(2,18);s.graphics.lineTo(2,0);s.graphics.endFill();}
   if(index==1){s.graphics.drawRoundRect(0,3,20,14,6,6);s.graphics.moveTo(4,10);s.graphics.lineTo(10,10);s.graphics.moveTo(7,7);s.graphics.lineTo(7,13);s.graphics.drawCircle(15,8,1);s.graphics.drawCircle(17,12,1);}
   if(index==2){s.graphics.moveTo(0,6);s.graphics.lineTo(5,6);s.graphics.lineTo(11,1);s.graphics.lineTo(11,18);s.graphics.lineTo(5,13);s.graphics.lineTo(0,13);s.graphics.lineTo(0,6);s.graphics.moveTo(15,4);s.graphics.curveTo(22,9,15,16);}
   if(index==3){s.graphics.moveTo(6,16);s.graphics.lineTo(6,2);s.graphics.lineTo(18,0);s.graphics.lineTo(18,14);s.graphics.beginFill(0xe8ebdf);s.graphics.drawEllipse(0,14,6,5);s.graphics.drawEllipse(12,12,6,5);s.graphics.endFill();}
   if(index==4){s.graphics.moveTo(10,0);s.graphics.lineTo(0,0);s.graphics.lineTo(0,20);s.graphics.lineTo(10,20);s.graphics.moveTo(7,10);s.graphics.lineTo(20,10);s.graphics.moveTo(15,5);s.graphics.lineTo(20,10);s.graphics.lineTo(15,15);}
  }
  private function buttonClick(e:MouseEvent):void {if(!active)return;var id:int=int(Sprite(e.currentTarget).name);
   if(id==0){close();}else if(id==1){if(controls.isActive)controls.Deactivate();else controls.Activate();}
   else if(id==2){NewSoundManager.muteSound=!NewSoundManager.muteSound;updateAudio();}
   else if(id==3){NewSoundManager.muteMusic=!NewSoundManager.muteMusic;updateAudio();}
   else {prompt.visible=true;prompt.addEventListeners();}
  }
  public function updateAudio():void {
   if(soundState)buttons[2].removeChild(soundState);if(musicState)buttons[3].removeChild(musicState);
   soundState=placeText(buttons[2],NewSoundManager.muteSound?"OFF":"ON",133,18,1,NewSoundManager.muteSound?0x87918c:0x94db47);
   musicState=placeText(buttons[3],NewSoundManager.muteMusic?"OFF":"ON",133,18,1,NewSoundManager.muteMusic?0x87918c:0x94db47);
  }
  private function capture():void {release();if(!parent||!parent.parent)return;var image:BitmapData=new BitmapData(640,480,false,0);var wasVisible:Boolean=visible;visible=false;image.draw(parent.parent);visible=wasVisible;frozen=new Bitmap(image);frozen.filters=[new BlurFilter(2,2,1)];backdrop.addChild(frozen);}
  private function release():void {if(frozen){backdrop.removeChild(frozen);frozen.bitmapData.dispose();frozen=null;}}
  public function toggleOptionsMenu():void {if(overlay.visible){close();return;}capture();overlay.visible=true;updateAudio();dispatchEvent(new GameEvent(GameEvent.PAUSE));}
  private function close():void {controls.reset();prompt.visible=false;prompt.removeEventListeners();overlay.visible=false;release();dispatchEvent(new GameEvent(GameEvent.RESUME));}
  public function addEventListeners():void {active=true;prompt.addEventListener(GameEvent.CANCEL,cancelQuit);prompt.addEventListener(GameEvent.CONFIRM,confirmQuit);}
  public function removeEventListeners():void {active=false;prompt.removeEventListener(GameEvent.CANCEL,cancelQuit);prompt.removeEventListener(GameEvent.CONFIRM,confirmQuit);}
  private function cancelQuit(e:GameEvent):void {prompt.visible=false;prompt.removeEventListeners();}
  private function confirmQuit(e:GameEvent):void {release();removeEventListeners();prompt.removeEventListeners();dispatchEvent(e);}
'''
(root/'Options.as').write_text(options+common+'\n}}')
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay','Minimap','Options']:
 shutil.copy2(root/(name+'.as'),Path('tools/hud-patch/src/components/gui')/(name+'.as'))

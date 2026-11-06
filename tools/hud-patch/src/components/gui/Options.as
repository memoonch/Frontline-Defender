package src.components.gui {
 import flash.display.Sprite;import flash.display.Bitmap;import flash.display.BitmapData;import flash.display.Loader;
 import flash.events.Event;import flash.events.MouseEvent;import flash.net.URLRequest;import flash.geom.Rectangle;import flash.geom.Point;import flash.geom.ColorTransform;
 import flash.filters.BlurFilter;import flash.filters.GlowFilter;
 import com.hcLibrary.events.GameEvent;import com.hcLibrary.managers.FontManager;import src.interfaces.ControlsMenu;import src.managers.NewSoundManager;
 public class Options extends Sprite {
  private var overlay:Sprite;private var plate:Sprite;private var backdrop:Sprite;private var frozen:Bitmap;
  private var controls:ControlsMenu;private var prompt:QuitPrompt;private var soundState:Sprite;private var musicState:Sprite;
  private var buttons:Array=[];private var active:Boolean=false;
  public function Options(){super();
   overlay=new Sprite();overlay.visible=false;addChild(overlay);
   backdrop=new Sprite();overlay.addChild(backdrop);
   var dim:Sprite=new Sprite();dim.graphics.beginFill(0x020706,0.53);dim.graphics.drawRect(0,0,640,480);dim.graphics.endFill();overlay.addChild(dim);
   plate=new Sprite();plate.x=432;plate.y=42;overlay.addChild(plate);
   plate.graphics.beginFill(0x080d0e,0.94);plate.graphics.drawRect(0,0,196,396);plate.graphics.endFill();
   plate.graphics.lineStyle(1,0x67736d);plate.graphics.drawRect(0.5,0.5,195,395);plate.graphics.lineStyle(1,0x27332e);plate.graphics.drawRect(2.5,2.5,191,391);
   plate.graphics.lineStyle();plate.graphics.beginFill(0xffb42b);plate.graphics.drawRect(15,21,5,22);plate.graphics.drawRect(25,21,5,22);plate.graphics.endFill();
   placeText(plate,"PAUSED",43,26,2);
   makeButton("RESUME",72,0);makeButton("CONTROLS",132,1);makeButton("SOUND",192,2);makeButton("MUSIC",252,3);makeButton("QUIT",312,4);
   controls=new ControlsMenu();controls.x=-85;addChild(controls);prompt=new QuitPrompt();prompt.visible=false;addChild(prompt);
   var gear:Sprite=new Sprite();gear.x=614;gear.y=5;gear.buttonMode=true;gear.graphics.beginFill(0x101918,0.8);gear.graphics.drawRect(0,0,22,24);gear.graphics.endFill();gear.graphics.lineStyle(1,0x67736d);gear.graphics.drawRect(0.5,0.5,21,23);gear.graphics.lineStyle();gear.graphics.beginFill(0xe5eadd);gear.graphics.drawRect(7,6,3,12);gear.graphics.drawRect(13,6,3,12);gear.graphics.endFill();addChild(gear);
   gear.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{toggleOptionsMenu();});updateAudio();
  }
  private function placeText(parent:Sprite,value:String,x:Number,y:Number,size:Number,color:uint=0xf5f5e8):Sprite {var s:Sprite=label(value,x,y,size,color);parent.addChild(s);return s;}
  private function makeButton(text:String,y:Number,index:int):void {
   var b:Sprite=new Sprite();b.x=12;b.y=y;b.name=String(index);b.mouseChildren=false;b.buttonMode=true;plate.addChild(b);buttons.push(b);drawButton(b,index,false);
   drawIcon(b,index);placeText(b,text,40,20,1.25);b.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void {drawButton(b,index,true);});b.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void {drawButton(b,index,false);});b.addEventListener(MouseEvent.CLICK,buttonClick);
  }
  private function drawButton(b:Sprite,index:int,hover:Boolean):void {
   b.graphics.clear();b.graphics.beginFill(index==0?(hover?0x35452d:0x263623):(hover?0x202c28:0x080d0e),0.97);b.graphics.drawRect(0,0,172,50);b.graphics.endFill();
   b.graphics.lineStyle(1,hover?0xa0b08b:0x67736d);b.graphics.drawRect(0.5,0.5,171,49);
   b.graphics.lineStyle(1,0x27332e);b.graphics.drawRect(2.5,2.5,167,45);
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
   soundState=placeText(buttons[2],NewSoundManager.muteSound?"OFF":"ON",133,21,1,NewSoundManager.muteSound?0x87918c:0x94db47);
   musicState=placeText(buttons[3],NewSoundManager.muteMusic?"OFF":"ON",133,21,1,NewSoundManager.muteMusic?0x87918c:0x94db47);
  }
  private function capture():void {release();if(!parent||!parent.parent)return;var image:BitmapData=new BitmapData(640,480,false,0);var wasVisible:Boolean=visible;visible=false;image.draw(parent.parent);visible=wasVisible;frozen=new Bitmap(image);frozen.filters=[new BlurFilter(2,2,1)];backdrop.addChild(frozen);}
  private function release():void {if(frozen){backdrop.removeChild(frozen);frozen.bitmapData.dispose();frozen=null;}}
  public function toggleOptionsMenu():void {if(overlay.visible){close();return;}capture();overlay.visible=true;updateAudio();dispatchEvent(new GameEvent(GameEvent.PAUSE));}
  private function close():void {controls.reset();prompt.visible=false;prompt.removeEventListeners();overlay.visible=false;release();dispatchEvent(new GameEvent(GameEvent.RESUME));}
  public function addEventListeners():void {active=true;prompt.addEventListener(GameEvent.CANCEL,cancelQuit);prompt.addEventListener(GameEvent.CONFIRM,confirmQuit);}
  public function removeEventListeners():void {active=false;prompt.removeEventListener(GameEvent.CANCEL,cancelQuit);prompt.removeEventListener(GameEvent.CONFIRM,confirmQuit);}
  private function cancelQuit(e:GameEvent):void {prompt.visible=false;prompt.removeEventListeners();}
  private function confirmQuit(e:GameEvent):void {release();removeEventListeners();prompt.removeEventListeners();dispatchEvent(e);}
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1);s.scaleX=size;s.scaleY=size*1.33;s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255;tint.greenMultiplier=((color>>8)&255)/255;tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;addChild(s);return s;
 }
}}

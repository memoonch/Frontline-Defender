package src.interfaces
{
 import flash.display.Sprite;
 import flash.display.Loader;
 import flash.display.Bitmap;
 import flash.display.BitmapData;
 import flash.geom.Point;
 import flash.display.GradientType;
 import flash.events.Event;
 import flash.events.MouseEvent;
 import flash.events.IOErrorEvent;
 import flash.net.URLRequest;
 import flash.geom.Matrix;
 import flash.geom.Rectangle;
 import flash.text.TextField;
 import flash.text.TextFormat;
 import flash.filters.GlowFilter;
 import com.hcLibrary.events.GameEvent;
 import com.hcLibrary.managers.SoundManager;
 public class MainMenu extends Sprite
 {
  private var _playButton:Sprite;
  private var _helpButton:Sprite;
  private var _isActive:Boolean;
  public function MainMenu()
  {
   super();
   graphics.beginFill(0x121813); graphics.drawRect(0,0,640,480); graphics.endFill();
   var art:Sprite=new Sprite(); art.mouseEnabled=false; art.mouseChildren=false; addChild(art);
   loadArt(art,"ui/menu-background.png",0,0,640,480);
   var logo:Sprite=new Sprite(); logo.mouseEnabled=false; logo.mouseChildren=false; addChild(logo);
   loadArt(logo,"ui/menu-logo.png",60,32,520,231.1);
   _playButton=makeButton("PLAY",true,276);
   _helpButton=makeButton("HELP",false,378);
  }
  private function loadArt(parent:Sprite,url:String,px:Number,py:Number,w:Number,h:Number,trim:Boolean=false):void
  {
   var loader:Loader=new Loader(); loader.x=px; loader.y=py; parent.addChild(loader);
   loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void {
    if(loader.content is Bitmap) Bitmap(loader.content).smoothing=true;
    if(trim && loader.content is Bitmap) {
     var bitmap:Bitmap=Bitmap(loader.content);
     var bounds:Rectangle=new Rectangle(426,url.indexOf("button-play")>=0?3:367,1318,348);
     var cropped:BitmapData=new BitmapData(1318,348,true,0);
     cropped.copyPixels(bitmap.bitmapData,bounds,new Point()); bitmap.bitmapData=cropped; bitmap.smoothing=true;
     loader.width=w; loader.height=h;
    } else {loader.width=w; loader.height=h;}
   });
   loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(e:IOErrorEvent):void {trace(e.text);});
   loader.load(new URLRequest(url));
  }
  private function makeButton(label:String,primary:Boolean,py:Number):Sprite
  {
   var b:Sprite=new Sprite(); b.name=label; b.x=190; b.y=py; b.buttonMode=true; b.mouseChildren=false;
   loadArt(b,primary?"ui/button-play.png":"ui/button-help.png",0,0,260,91,true);
   var hit:Sprite=new Sprite(); hit.graphics.beginFill(0); hit.graphics.drawRect(0,0,260,91); hit.graphics.endFill(); hit.visible=false; b.addChild(hit); b.hitArea=hit;
   b.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void {paint(b,primary,true);SoundManager.getInstance().playSound("BUTTON_OVER");});
   b.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void {b.y=py;paint(b,primary,false);});
   b.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void {b.y=py+2;});
   b.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void {b.y=py;});
   addChild(b); return b;
  }
  private function paint(b:Sprite,primary:Boolean,hover:Boolean):void
  {
   b.filters=hover?[new GlowFilter(primary?0xffb521:0xa6b76b,0.55,10,10,1,2)]:[];
  }
  public function Activate():void {addEventListeners();_isActive=true;}
  public function Deactivate():void {removeEventListeners(); if(_isActive){_isActive=false;dispatchEvent(new GameEvent(GameEvent.RESUME));}}
  public function addEventListeners():void {_playButton.addEventListener(MouseEvent.CLICK,play);_helpButton.addEventListener(MouseEvent.CLICK,help);}
  public function removeEventListeners():void {_playButton.removeEventListener(MouseEvent.CLICK,play);_helpButton.removeEventListener(MouseEvent.CLICK,help);}
  private function play(e:MouseEvent):void {SoundManager.getInstance().playSound("BUTTON_CLICK");dispatchEvent(new Event("ACTIVATE_GAME"));}
  private function help(e:MouseEvent):void {SoundManager.getInstance().playSound("BUTTON_CLICK");dispatchEvent(new Event("ACTIVATE_HELP"));}
 }
}





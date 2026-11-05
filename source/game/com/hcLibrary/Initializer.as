package com.hcLibrary
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.debug.DebugPanel;
   import com.hcLibrary.debug.FPSCounter;
   import com.hcLibrary.display.GameWindow;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class Initializer extends Sprite
   {
      
      private static var _instance:Initializer;
      
      private static var _allowInstance:Boolean;
      
      private static var SplashLogo:Class = Initializer_SplashLogo;
      
      private static var ButtonOverSound:Class = Initializer_ButtonOverSound;
      
      private static var ButtonClickSound:Class = Initializer_ButtonClickSound;
      
      private var _stageRef:Stage;
      
      private var _display:Sprite;
      
      private var _function:Function;
      
      private var _splashScreen:Sprite;
      
      private var _splashCounter:int;
      
      private var _delayCounter:int;
      
      private var _gameWindow:GameWindow;
      
      private var _deviceSize:Rectangle;
      
      private var _debugging:Boolean;
      
      private var _debugPanel:DebugPanel;
      
      private var _fpsCounter:FPSCounter;
      
      private var _soundManager:SoundManager;
      
      public function Initializer()
      {
         super();
      }
      
      public static function getInstance() : Initializer
      {
         if(Initializer._instance == null)
         {
            Initializer._allowInstance = true;
            Initializer._instance = new Initializer();
            Initializer._allowInstance = false;
         }
         return Initializer._instance;
      }
      
      public function Initialize(param1:int, param2:int, param3:Sprite, param4:Stage, param5:Function, param6:Boolean) : void
      {
         this._display = param3;
         this._stageRef = param4;
         this._function = param5;
         this._debugging = param6;
         this._splashCounter = 0;
         this._delayCounter = 30;
         Window.width = param1;
         Window.height = param2;
         this._deviceSize = new Rectangle(0,0,800,480);
         if(this._stageRef == null)
         {
            this._display.addEventListener(Event.ADDED_TO_STAGE,this.StartInitialization,false,0,true);
         }
         else
         {
            this.StartInitialization();
         }
      }
      
      private function StartInitialization(param1:Event = null) : void
      {
         if(param1 != null)
         {
            this._display.removeEventListener(Event.ADDED_TO_STAGE,this.StartInitialization);
         }
         this._gameWindow = new GameWindow();
         this._gameWindow.changeSize(this._stageRef.stageWidth,this._stageRef.stageHeight);
         if(this._debugging)
         {
            this._debugPanel = DebugPanel.getInstance();
            this._gameWindow.addChild(this._debugPanel);
            this._debugPanel.position = DebugPanel.BOTTOM_RIGHT;
            this._fpsCounter = new FPSCounter(FPSCounter.BOTTOM_LEFT,16777215,true,0);
            this._gameWindow.addChild(this._fpsCounter);
            DebugPanel.traceLine("Debug mode enabled",16711935,12);
            DebugPanel.lineBreak();
         }
         this._soundManager = SoundManager.getInstance();
         this._soundManager.addSound(ButtonClickSound,"BUTTON_CLICK",false);
         this._soundManager.addSound(ButtonOverSound,"BUTTON_OVER",false);
         this._stageRef.scaleMode = StageScaleMode.NO_SCALE;
         this._stageRef.align = StageAlign.TOP_LEFT;
         this._stageRef.addEventListener(Event.RESIZE,this.ResizeScreen,false,0,true);
         this.finishedWaiting();
      }
      
      private function finishedWaiting() : void
      {
         this._splashScreen = new Sprite();
         this._splashScreen.graphics.beginFill(0);
         this._splashScreen.graphics.drawRect(0,0,this._gameWindow.width,this._gameWindow.height);
         this._splashScreen.graphics.endFill();
         var _loc1_:Bitmap = new SplashLogo();
         _loc1_.x = Calc.center(this._splashScreen.width,_loc1_.width);
         _loc1_.y = Calc.center(this._splashScreen.height,_loc1_.height);
         this._splashScreen.addChild(_loc1_);
         this._gameWindow.addChild(this._splashScreen);
         this._function();
      }
      
      public function finishInitializing() : void
      {
         this._display.addEventListener(Event.ENTER_FRAME,this.splashDelay,false,0,true);
      }
      
      private function ResizeScreen(param1:Event) : void
      {
         if(this._deviceSize.width != this._stageRef.stageWidth || this._deviceSize.height != this._stageRef.stageHeight)
         {
            this._deviceSize = new Rectangle(0,0,this._stageRef.stageWidth,this._stageRef.stageHeight);
            this._gameWindow.changeSize(this._deviceSize.width,this._deviceSize.height);
            if(this._debugging)
            {
               this._debugPanel.position = DebugPanel.BOTTOM_RIGHT;
               DebugPanel.traceLine("Screen resized:",16777215,12);
               DebugPanel.traceLine(String("Screen: width: " + this._deviceSize.width + ", height: " + this._deviceSize.height),16777215,12,true);
               DebugPanel.traceLine(String("Window: width: " + this._gameWindow.width + ", height: " + this._gameWindow.height),16777215,12,true);
               DebugPanel.traceLine(String("Scale: " + GameWindow.scale),16777215,12,true);
            }
         }
      }
      
      private function delay(param1:Event) : void
      {
         ++this._delayCounter;
         if(this._delayCounter >= 30)
         {
            this._display.removeEventListener(Event.ENTER_FRAME,this.delay);
            this.finishedWaiting();
         }
      }
      
      private function splashDelay(param1:Event) : void
      {
         ++this._splashCounter;
         this._gameWindow.setChildIndex(this._splashScreen,this._gameWindow.numChildren - 1);
         if(this._splashCounter >= 0)
         {
            this._splashScreen.alpha -= 0.05;
            if(this._splashCounter >= 0)
            {
               this._display.removeEventListener(Event.ENTER_FRAME,this.splashDelay);
               this._gameWindow.removeChild(this._splashScreen);
               this._splashScreen = null;
               this.dispatchEvent(new GameEvent(GameEvent.FINISHED));
            }
         }
      }
      
      public function get gameWindow() : GameWindow
      {
         return this._gameWindow;
      }
   }
}


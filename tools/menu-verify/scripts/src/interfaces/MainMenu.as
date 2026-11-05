package src.interfaces
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class MainMenu extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _background:Sprite;
      
      private var _plate:Sprite;
      
      private var _leftPlate:Sprite;
      
      private var _rightPlate:Sprite;
      
      private var _copyright:Sprite;
      
      private var _playButton:CustomButton;
      
      private var _helpButton:CustomButton;
      
      private var _isActive:Boolean;
      
      public function MainMenu()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._background = new Sprite();
         this._background.addChild(this._imageManager.getImage("main_background"));
         this.addChild(this._background);
         this._plate = new Sprite();
         this._plate.x = Calc.center(Window.width,this._plate.width);
         this._plate.y = Window.height - this._plate.height - 20;
         this.addChild(this._plate);
         this._leftPlate = new Sprite();
         this._leftPlate.x = 0;
         this._leftPlate.y = Window.height - this._leftPlate.height - 20;
         this.addChild(this._leftPlate);
         this._rightPlate = new Sprite();
         this._rightPlate.x = Window.width - this._rightPlate.width;
         this._rightPlate.y = Window.height - this._rightPlate.height - 20;
         this.addChild(this._rightPlate);
         this._copyright = new Sprite();
         this._copyright.y = Window.height - this._copyright.height;
         this.addChild(this._copyright);
         this.InitializeButtons();
         this._plate.x = Calc.center(Window.width,this._plate.width);
         this._plate.y = Window.height - this._plate.height - 10;
         this._rightPlate.x = Window.width - this._rightPlate.width;
         this._rightPlate.y = Window.height - this._rightPlate.height;
         this._leftPlate.x = 0;
         this._leftPlate.y = Window.height - this._leftPlate.height + 10;
      }
      
      private function InitializeButtons() : void
      {
         this._playButton = new CustomButton(this._imageManager.getImage("play_button"),189,54,2);
         this._playButton.idleState = 1;
         this._playButton.overState = 2;
         this._leftPlate.addChild(this._playButton);
         this._helpButton = new CustomButton(this._imageManager.getImage("main_buttons"),196,42,8);
         this._helpButton.idleState = 1;
         this._helpButton.overState = 2;
         this._helpButton.y = this._playButton.y + this._playButton.height;
         this._leftPlate.addChild(this._helpButton);
      }
      
      public function Activate() : void
      {
         this.addEventListeners();
         this._isActive = true;
      }
      
      public function Deactivate() : void
      {
         this.removeEventListeners();
         this._playButton.enabled = true;
         if(this._isActive)
         {
            this._isActive = false;
            this.dispatchEvent(new GameEvent(GameEvent.RESUME));
         }
      }
      
      public function addEventListeners() : void
      {
         this._playButton.enabled = true;
         this._playButton.addMouseEvents();
         this._playButton.addEventListener(GameEvent.CLICKED,this.playButtonHandler,false,0,true);
         this._helpButton.enabled = true;
         this._helpButton.addMouseEvents();
         this._helpButton.addEventListener(GameEvent.CLICKED,this.helpButtonHandler,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this._playButton.removeMouseEvents();
         this._playButton.removeEventListener(GameEvent.CLICKED,this.playButtonHandler);
         this._helpButton.removeMouseEvents();
         this._helpButton.removeEventListener(GameEvent.CLICKED,this.helpButtonHandler);
      }
      
      private function playButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new Event("ACTIVATE_GAME"));
      }
      
      private function helpButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new Event("ACTIVATE_HELP"));
      }
   }
}


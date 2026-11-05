package src.components.gui
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import src.interfaces.ControlsMenu;
   import src.managers.NewSoundManager;
   
   public class Options extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _soundManager:NewSoundManager;
      
      private var _fontManager:FontManager;
      
      private var _overlay:Sprite;
      
      private var _plate:Sprite;
      
      private var _pausedText:Sprite;
      
      private var _controlsMenu:ControlsMenu;
      
      private var _quitPrompt:QuitPrompt;
      
      private var _optionsButton:CustomButton;
      
      private var _resumeButton:CustomButton;
      
      private var _soundOnButton:CustomButton;
      
      private var _soundOffButton:CustomButton;
      
      private var _musicOnButton:CustomButton;
      
      private var _musicOffButton:CustomButton;
      
      private var _controlsButton:CustomButton;
      
      private var _quitButton:CustomButton;
      
      public function Options()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._soundManager = NewSoundManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this.InitializeParts();
         this.InitializeButtons();
         this._quitPrompt = new QuitPrompt();
         this._quitPrompt.visible = false;
         this.addChild(this._quitPrompt);
         this._optionsButton.enabled = true;
         this._optionsButton.addMouseEvents();
         this._optionsButton.addEventListener(GameEvent.CLICKED,this.optionsButtonHandler,false,0,true);
      }
      
      private function InitializeParts() : void
      {
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.7);
         this._overlay.graphics.drawRect(0,0,Window.width,Window.height);
         this._overlay.graphics.endFill();
         this._overlay.visible = false;
         this.addChild(this._overlay);
         this._pausedText = new Sprite();
         this._pausedText.x = Calc.center(Window.width,this._pausedText.width);
         this._pausedText.y = Calc.center(Window.height,this._pausedText.height);
         this._overlay.addChild(this._pausedText);
         this._plate = new Sprite();
         this._plate.addChild(this._imageManager.getImage("options_plate"));
         this._plate.x = Window.width - this._plate.width - 24;
         this._plate.y = 3;
         this._overlay.addChild(this._plate);
         this._controlsMenu = new ControlsMenu();
         this.addChild(this._controlsMenu);
      }
      
      private function InitializeButtons() : void
      {
         this._optionsButton = new CustomButton(this._imageManager.getImage("options_gear"),18,18,1);
         this._optionsButton.idleState = 1;
         this._optionsButton.overState = 1;
         this._optionsButton.x = Window.width - this._optionsButton.width - 3;
         this._optionsButton.y = 3;
         this.addChild(this._optionsButton);
         this._resumeButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._resumeButton.idleState = 1;
         this._resumeButton.overState = 2;
         this._resumeButton.x = 6;
         this._resumeButton.y = 6;
         this._plate.addChild(this._resumeButton);
         this._controlsButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._controlsButton.idleState = 5;
         this._controlsButton.overState = 6;
         this._controlsButton.x = 6;
         this._controlsButton.y = this._resumeButton.y + this._resumeButton.height + 1;
         this._plate.addChild(this._controlsButton);
         this._soundOnButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._soundOnButton.idleState = 9;
         this._soundOnButton.overState = 10;
         this._soundOnButton.x = 6;
         this._soundOnButton.y = this._controlsButton.y + this._controlsButton.height + 1;
         this._soundOnButton.visible = !NewSoundManager.muteSound;
         this._plate.addChild(this._soundOnButton);
         this._soundOffButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._soundOffButton.idleState = 13;
         this._soundOffButton.overState = 14;
         this._soundOffButton.x = this._soundOnButton.x;
         this._soundOffButton.y = this._soundOnButton.y;
         this._soundOffButton.visible = NewSoundManager.muteSound;
         this._plate.addChild(this._soundOffButton);
         this._musicOnButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._musicOnButton.idleState = 3;
         this._musicOnButton.overState = 4;
         this._musicOnButton.x = 6;
         this._musicOnButton.y = this._soundOnButton.y + this._soundOnButton.height + 1;
         this._musicOnButton.visible = !NewSoundManager.muteMusic;
         this._plate.addChild(this._musicOnButton);
         this._musicOffButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._musicOffButton.idleState = 7;
         this._musicOffButton.overState = 8;
         this._musicOffButton.x = this._musicOnButton.x;
         this._musicOffButton.y = this._musicOnButton.y;
         this._musicOffButton.visible = NewSoundManager.muteMusic;
         this._plate.addChild(this._musicOffButton);
         this._quitButton = new CustomButton(this._imageManager.getImage("options_buttons"),114,26,14);
         this._quitButton.idleState = 11;
         this._quitButton.overState = 12;
         this._quitButton.x = 6;
         this._quitButton.y = this._musicOnButton.y + this._musicOnButton.height + 1;
         this._plate.addChild(this._quitButton);
      }
      
      public function addEventListeners() : void
      {
         this._resumeButton.enabled = true;
         this._resumeButton.addMouseEvents();
         this._resumeButton.addEventListener(GameEvent.CLICKED,this.resumeButtonHandler,false,0,true);
         this._controlsButton.enabled = true;
         this._controlsButton.addMouseEvents();
         this._controlsButton.addEventListener(GameEvent.CLICKED,this.controlsButtonHandler,false,0,true);
         this._soundOnButton.enabled = true;
         this._soundOnButton.addMouseEvents();
         this._soundOnButton.addEventListener(GameEvent.CLICKED,this.soundOnButtonHandler,false,0,true);
         this._soundOffButton.enabled = true;
         this._soundOffButton.addMouseEvents();
         this._soundOffButton.addEventListener(GameEvent.CLICKED,this.soundOffButtonHandler,false,0,true);
         this._musicOnButton.enabled = true;
         this._musicOnButton.addMouseEvents();
         this._musicOnButton.addEventListener(GameEvent.CLICKED,this.musicOnButtonHandler,false,0,true);
         this._musicOffButton.enabled = true;
         this._musicOffButton.addMouseEvents();
         this._musicOffButton.addEventListener(GameEvent.CLICKED,this.musicOffButtonHandler,false,0,true);
         this._quitButton.enabled = true;
         this._quitButton.addMouseEvents();
         this._quitButton.addEventListener(GameEvent.CLICKED,this.quitButtonHandler,false,0,true);
         this._quitPrompt.addEventListener(GameEvent.CANCEL,this.cancelQuit,false,0,true);
         this._quitPrompt.addEventListener(GameEvent.CONFIRM,this.confirmQuit,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this._resumeButton.removeMouseEvents();
         this._resumeButton.removeEventListener(GameEvent.CLICKED,this.resumeButtonHandler);
         this._controlsButton.removeMouseEvents();
         this._controlsButton.removeEventListener(GameEvent.CLICKED,this.controlsButtonHandler);
         this._soundOnButton.removeMouseEvents();
         this._soundOnButton.removeEventListener(GameEvent.CLICKED,this.soundOnButtonHandler);
         this._soundOffButton.removeMouseEvents();
         this._soundOffButton.removeEventListener(GameEvent.CLICKED,this.soundOffButtonHandler);
         this._musicOnButton.removeMouseEvents();
         this._musicOnButton.removeEventListener(GameEvent.CLICKED,this.musicOnButtonHandler);
         this._musicOffButton.removeMouseEvents();
         this._musicOffButton.removeEventListener(GameEvent.CLICKED,this.musicOffButtonHandler);
         this._quitButton.removeMouseEvents();
         this._quitButton.removeEventListener(GameEvent.CLICKED,this.quitButtonHandler);
         this._quitPrompt.removeEventListener(GameEvent.CANCEL,this.cancelQuit);
         this._quitPrompt.removeEventListener(GameEvent.CONFIRM,this.confirmQuit);
      }
      
      private function optionsButtonHandler(param1:GameEvent) : void
      {
         this._overlay.visible = !this._overlay.visible;
         if(this._overlay.visible)
         {
            this.dispatchEvent(new GameEvent(GameEvent.PAUSE));
         }
         else
         {
            this._quitPrompt.visible = false;
            this._quitPrompt.removeEventListeners();
            this._controlsMenu.reset();
            this.dispatchEvent(new GameEvent(GameEvent.RESUME));
         }
      }
      
      private function resumeButtonHandler(param1:GameEvent) : void
      {
         this._controlsMenu.reset();
         this._overlay.visible = false;
         this.dispatchEvent(new GameEvent(GameEvent.RESUME));
      }
      
      private function controlsButtonHandler(param1:GameEvent) : void
      {
         if(this._controlsMenu.isActive)
         {
            this._controlsMenu.Deactivate();
         }
         else
         {
            this._controlsMenu.Activate();
         }
      }
      
      private function soundOnButtonHandler(param1:GameEvent) : void
      {
         NewSoundManager.muteSound = true;
         this._soundOnButton.visible = false;
         this._soundOffButton.visible = true;
      }
      
      private function soundOffButtonHandler(param1:GameEvent) : void
      {
         NewSoundManager.muteSound = false;
         this._soundOffButton.visible = false;
         this._soundOnButton.visible = true;
      }
      
      private function musicOnButtonHandler(param1:GameEvent) : void
      {
         NewSoundManager.muteMusic = true;
         this._musicOnButton.visible = false;
         this._musicOffButton.visible = true;
      }
      
      private function musicOffButtonHandler(param1:GameEvent) : void
      {
         NewSoundManager.muteMusic = false;
         this._musicOffButton.visible = false;
         this._musicOnButton.visible = true;
      }
      
      private function quitButtonHandler(param1:GameEvent) : void
      {
         this._quitPrompt.visible = true;
         this._quitPrompt.addEventListeners();
      }
      
      private function cancelQuit(param1:GameEvent) : void
      {
         this._quitPrompt.visible = false;
         this._quitPrompt.removeEventListeners();
      }
      
      private function confirmQuit(param1:GameEvent) : void
      {
         this.removeEventListeners();
         this._quitPrompt.removeEventListeners();
         this.dispatchEvent(param1);
      }
      
      public function updateAudio() : void
      {
         this._soundOnButton.visible = !NewSoundManager.muteSound;
         this._soundOffButton.visible = NewSoundManager.muteSound;
         this._musicOnButton.visible = !NewSoundManager.muteMusic;
         this._musicOffButton.visible = NewSoundManager.muteMusic;
      }
      
      public function toggleOptionsMenu() : void
      {
         this.optionsButtonHandler(null);
      }
   }
}


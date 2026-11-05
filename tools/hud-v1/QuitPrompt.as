package src.components.gui
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class QuitPrompt extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _overlay:Sprite;
      
      private var _plate:Sprite;
      
      private var _yesButton:CustomButton;
      
      private var _noButton:CustomButton;
      
      public function QuitPrompt()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.7);
         this._overlay.graphics.drawRect(0,0,Window.width,Window.height);
         this._overlay.graphics.endFill();
         this.addChild(this._overlay);
         this._plate = new Sprite();
         this._plate.addChild(this._imageManager.getImage("quit_plate"));
         this._plate.x = Calc.center(this._overlay.width,this._plate.width);
         this._plate.y = Calc.center(this._overlay.height,this._plate.height);
         this._overlay.addChild(this._plate);
         this.InitializeButtons();
      }
      
      private function InitializeButtons() : void
      {
         this._yesButton = new CustomButton(this._imageManager.getImage("quit_buttons"),73,16,4);
         this._yesButton.idleState = 1;
         this._yesButton.overState = 2;
         this._yesButton.enabled = true;
         this._yesButton.x = 23;
         this._yesButton.y = 85;
         this._plate.addChild(this._yesButton);
         this._noButton = new CustomButton(this._imageManager.getImage("quit_buttons"),73,16,4);
         this._noButton.idleState = 3;
         this._noButton.overState = 4;
         this._noButton.enabled = true;
         this._noButton.x = 97;
         this._noButton.y = 85;
         this._plate.addChild(this._noButton);
      }
      
      public function addEventListeners() : void
      {
         this._yesButton.enabled = true;
         this._yesButton.addMouseEvents();
         this._yesButton.addEventListener(GameEvent.CLICKED,this.yesButtonHandler,false,0,true);
         this._noButton.enabled = true;
         this._noButton.addMouseEvents();
         this._noButton.addEventListener(GameEvent.CLICKED,this.noButtonHandler,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this._yesButton.removeMouseEvents();
         this._yesButton.removeEventListener(GameEvent.CLICKED,this.yesButtonHandler);
         this._noButton.removeMouseEvents();
         this._noButton.removeEventListener(GameEvent.CLICKED,this.noButtonHandler);
      }
      
      private function yesButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new GameEvent(GameEvent.CONFIRM));
      }
      
      private function noButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new GameEvent(GameEvent.CANCEL));
      }
   }
}


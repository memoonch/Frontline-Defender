package src.interfaces
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import src.Main;
   
   public class GameoverMenu extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _background:Sprite;
      
      private var _overlay:Sprite;
      
      private var _yesButton:CustomButton;
      
      private var _noButton:CustomButton;
      
      private var _wavesText:Sprite;
      
      private var _scoreText:Sprite;
      
      private var _moneyText:Sprite;
      
      private var _soldierText:Sprite;
      
      private var _vehicleText:Sprite;
      
      private var _score:Number;
      
      public function GameoverMenu()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.7);
         this._overlay.graphics.drawRect(0,0,Window.width,Window.height);
         this._overlay.graphics.endFill();
         this.addChild(this._overlay);
         this._background = new Sprite();
         this._background.addChild(this._imageManager.getImage("gameover_plate"));
         this._background.x = Calc.center(this._overlay.width,this._background.width);
         this._background.y = Calc.center(this._overlay.height,this._background.height,-Window.height);
         this.addChild(this._background);
         this._yesButton = new CustomButton(this._imageManager.getImage("quit_buttons"),73,16,4);
         this._yesButton.idleState = 1;
         this._yesButton.overState = 2;
         this._yesButton.enabled = true;
         this._yesButton.x = 82;
         this._yesButton.y = 204;
         this._background.addChild(this._yesButton);
         this._noButton = new CustomButton(this._imageManager.getImage("quit_buttons"),73,16,4);
         this._noButton.idleState = 3;
         this._noButton.overState = 4;
         this._noButton.enabled = true;
         this._noButton.x = 156;
         this._noButton.y = 204;
         this._background.addChild(this._noButton);
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
         this.dispatchEvent(new GameEvent(GameEvent.CANCEL));
      }
      
      private function noButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new GameEvent(GameEvent.CONFIRM));
      }
      
      public function Activate() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.moveDown,false,0,true);
      }
      
      private function moveDown(param1:Event) : void
      {
         this._background.y += 40;
         if(this._background.y >= Calc.center(this._overlay.height,this._background.height))
         {
            this._background.y = Calc.center(this._overlay.height,this._background.height);
            this.removeEventListener(Event.ENTER_FRAME,this.moveDown);
            if(this._score == 0)
            {
               this.addEventListeners();
            }
            else
            {
               Main.FogAPI.submitScore(this._score,this.addEventListeners);
            }
         }
      }
      
      public function updateStats(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this._score = param2;
         this._wavesText = this._fontManager.getString(String(param1),"SHOP",1,0);
         this._wavesText.x = 226 - this._wavesText.width;
         this._wavesText.y = 91;
         this._background.addChild(this._wavesText);
         this._scoreText = this._fontManager.getString(String(param2),"SHOP",1,0);
         this._scoreText.x = 226 - this._scoreText.width;
         this._scoreText.y = this._wavesText.y + this._wavesText.height + 11;
         this._background.addChild(this._scoreText);
         this._moneyText = this._fontManager.getString(String(param3),"SHOP",1,0);
         this._moneyText.x = 226 - this._moneyText.width;
         this._moneyText.y = this._scoreText.y + this._scoreText.height + 11;
         this._background.addChild(this._moneyText);
         this._soldierText = this._fontManager.getString(String(param4),"SHOP",1,0);
         this._soldierText.x = 226 - this._soldierText.width;
         this._soldierText.y = this._moneyText.y + this._moneyText.height + 11;
         this._background.addChild(this._soldierText);
         this._vehicleText = this._fontManager.getString(String(param5),"SHOP",1,0);
         this._vehicleText.x = 226 - this._vehicleText.width;
         this._vehicleText.y = this._soldierText.y + this._soldierText.height + 11;
         this._background.addChild(this._vehicleText);
      }
   }
}


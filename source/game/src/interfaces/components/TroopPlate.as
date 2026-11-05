package src.interfaces.components
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class TroopPlate extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _background:Sprite;
      
      private var _overlay:Sprite;
      
      private var _nextButton:CustomButton;
      
      private var _previousButton:CustomButton;
      
      private var _troopButtons:Array;
      
      private var _page:int;
      
      private var _clickedTroop:int;
      
      public function TroopPlate()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.7);
         this._overlay.graphics.drawRect(0,0,235,101);
         this._overlay.graphics.endFill();
         this.addChild(this._overlay);
         this._background = new Sprite();
         this._background.addChild(this._imageManager.getImage("shop_troop_selection_plate"));
         this._background.x = Calc.center(this._overlay.width,this._background.width);
         this._background.y = Calc.center(this._overlay.height,this._background.height);
         this.addChild(this._background);
         this.InitializeButtons();
         this._page = 0;
         this._clickedTroop = -1;
      }
      
      private function InitializeButtons() : void
      {
         var _loc2_:TroopButton = null;
         this._nextButton = new CustomButton(this._imageManager.getImage("shop_troop_selection_arrows"),19,44,4);
         this._nextButton.idleState = 3;
         this._nextButton.overState = 4;
         this._nextButton.x = this._background.x + this._background.width;
         this._nextButton.y = this._background.y + 29;
         this._nextButton.enabled = true;
         this.addChild(this._nextButton);
         this._previousButton = new CustomButton(this._imageManager.getImage("shop_troop_selection_arrows"),19,44,4);
         this._previousButton.idleState = 1;
         this._previousButton.overState = 2;
         this._previousButton.x = this._background.x - this._previousButton.width;
         this._previousButton.y = this._nextButton.y;
         this._previousButton.enabled = true;
         this.addChild(this._previousButton);
         this._troopButtons = new Array();
         var _loc1_:int = -1;
         while(_loc1_ < 6)
         {
            _loc2_ = new TroopButton(_loc1_);
            switch(_loc1_)
            {
               case -1:
                  _loc2_.x = 0;
                  break;
               case 0:
                  _loc2_.x = 52;
                  break;
               case 1:
                  _loc2_.x = 104;
                  break;
               default:
                  _loc2_.x = 0;
                  _loc2_.visible = false;
            }
            _loc2_.y = 25;
            _loc2_.unlock();
            if(_loc1_ != -1)
            {
               _loc2_.changeQuantity(0);
            }
            this._troopButtons.push(_loc2_);
            this._background.addChild(_loc2_);
            _loc1_++;
         }
      }
      
      public function addEventListeners() : void
      {
         this._nextButton.addMouseEvents();
         this._nextButton.addEventListener(GameEvent.CLICKED,this.nextButtonHandler,false,0,true);
         this._previousButton.addMouseEvents();
         this._previousButton.addEventListener(GameEvent.CLICKED,this.previousButtonHandler,false,0,true);
         var _loc1_:int = 0;
         while(_loc1_ < this._troopButtons.length)
         {
            this._troopButtons[_loc1_].addEventListeners();
            this._troopButtons[_loc1_].addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
            _loc1_++;
         }
      }
      
      public function removeEventListeners() : void
      {
         this._nextButton.removeMouseEvents();
         this._nextButton.removeEventListener(GameEvent.CLICKED,this.nextButtonHandler);
         this._previousButton.removeMouseEvents();
         this._previousButton.removeEventListener(GameEvent.CLICKED,this.previousButtonHandler);
         var _loc1_:int = 0;
         while(_loc1_ < this._troopButtons.length)
         {
            this._troopButtons[_loc1_].removeEventListeners();
            this._troopButtons[_loc1_].removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
            _loc1_++;
         }
      }
      
      private function nextButtonHandler(param1:GameEvent) : void
      {
         ++this._page;
         if(this._page > 6)
         {
            this._page = 0;
         }
         this.changePage();
      }
      
      private function previousButtonHandler(param1:GameEvent) : void
      {
         --this._page;
         if(this._page < 0)
         {
            this._page = 6;
         }
         this.changePage();
      }
      
      private function changePage() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._troopButtons.length)
         {
            this._troopButtons[_loc1_].visible = false;
            this._troopButtons[_loc1_].x = 0;
            _loc1_++;
         }
         switch(this._page)
         {
            case 0:
               this._troopButtons[0].x = 0;
               this._troopButtons[1].x = 52;
               this._troopButtons[2].x = 104;
               this._troopButtons[0].visible = true;
               this._troopButtons[1].visible = true;
               this._troopButtons[2].visible = true;
               break;
            case 1:
               this._troopButtons[1].x = 0;
               this._troopButtons[2].x = 52;
               this._troopButtons[3].x = 104;
               this._troopButtons[1].visible = true;
               this._troopButtons[2].visible = true;
               this._troopButtons[3].visible = true;
               break;
            case 2:
               this._troopButtons[2].x = 0;
               this._troopButtons[3].x = 52;
               this._troopButtons[4].x = 104;
               this._troopButtons[2].visible = true;
               this._troopButtons[3].visible = true;
               this._troopButtons[4].visible = true;
               break;
            case 3:
               this._troopButtons[3].x = 0;
               this._troopButtons[4].x = 52;
               this._troopButtons[5].x = 104;
               this._troopButtons[3].visible = true;
               this._troopButtons[4].visible = true;
               this._troopButtons[5].visible = true;
               break;
            case 4:
               this._troopButtons[4].x = 0;
               this._troopButtons[5].x = 52;
               this._troopButtons[6].x = 104;
               this._troopButtons[4].visible = true;
               this._troopButtons[5].visible = true;
               this._troopButtons[6].visible = true;
               break;
            case 5:
               this._troopButtons[5].x = 0;
               this._troopButtons[6].x = 52;
               this._troopButtons[0].x = 104;
               this._troopButtons[5].visible = true;
               this._troopButtons[6].visible = true;
               this._troopButtons[0].visible = true;
               break;
            case 6:
               this._troopButtons[6].x = 0;
               this._troopButtons[0].x = 52;
               this._troopButtons[1].x = 104;
               this._troopButtons[6].visible = true;
               this._troopButtons[0].visible = true;
               this._troopButtons[1].visible = true;
         }
      }
      
      private function troopButtonHandler(param1:GameEvent) : void
      {
         this._clickedTroop = this._troopButtons.indexOf(param1.target) - 1;
         this.dispatchEvent(new Event("TROOP_CLICKED"));
      }
      
      public function reset(param1:Array, param2:Array) : void
      {
         this._clickedTroop = -1;
         this._page = 0;
         this.changePage();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_])
            {
               this._troopButtons[_loc3_ + 1].unlock();
               this._troopButtons[_loc3_ + 1].changeQuantity(param2[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public function get troopType() : int
      {
         return this._clickedTroop;
      }
   }
}


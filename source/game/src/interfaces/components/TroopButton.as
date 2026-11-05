package src.interfaces.components
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import com.hcLibrary.managers.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TroopButton extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _soundManager:SoundManager;
      
      private var _image:AnimatedSprite;
      
      private var _text:Sprite;
      
      private var _amount:int;
      
      private var _clearButton:Boolean;
      
      public function TroopButton(param1:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this._soundManager = SoundManager.getInstance();
         this._image = new AnimatedSprite(this._imageManager.getImage("shop_troop_selection_icons"),49,50,20);
         if(param1 == -1)
         {
            this._image.addSequence("IDLE",19,19,0,0);
            this._image.addSequence("OVER",20,20,0,0);
            this._image.gotoAndStop("IDLE");
            this._clearButton = true;
         }
         else
         {
            this._image.addSequence("LOCKED",param1 * 3 + 1,param1 * 3 + 1,0,0);
            this._image.addSequence("IDLE",param1 * 3 + 2,param1 * 3 + 2,0,0);
            this._image.addSequence("OVER",param1 * 3 + 3,param1 * 3 + 3,0,0);
            this._image.gotoAndStop("LOCKED");
            this._clearButton = false;
         }
         this.addChild(this._image);
         this._amount = 0;
         this._text = this._fontManager.getString(String(this._amount),"SHOP",1,0);
         this._text.x = 38 - this._text.width / 2;
         this._text.y = 7;
         this._text.visible = false;
         this.addChild(this._text);
      }
      
      public function addEventListeners() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
         this.addEventListener(MouseEvent.CLICK,this.mouseClick,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         this.removeEventListener(MouseEvent.CLICK,this.mouseClick);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED")
         {
            this._image.gotoAndStop("OVER");
            this._soundManager.playSound("BUTTON_OVER");
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED")
         {
            this._image.gotoAndStop("IDLE");
         }
      }
      
      private function mouseClick(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED" && (this._amount > 0 || this._clearButton))
         {
            this._image.gotoAndStop("IDLE");
            this._soundManager.playSound("BUTTON_CLICK");
            this.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
      }
      
      public function changeQuantity(param1:int) : void
      {
         this.removeChild(this._text);
         this._amount = param1;
         this._text = this._fontManager.getString(String(this._amount),"SHOP",1,0);
         this._text.x = 38 - this._text.width / 2;
         this._text.y = 7;
         this.addChild(this._text);
         if(this._amount == 0)
         {
            this._image.gotoAndStop("LOCKED");
         }
         else
         {
            this._image.gotoAndStop("IDLE");
         }
      }
      
      public function get isLocked() : Boolean
      {
         return this._image.sequence == "LOCKED";
      }
      
      public function unlock() : void
      {
         this._image.gotoAndStop("IDLE");
         this._text.visible = true;
      }
   }
}


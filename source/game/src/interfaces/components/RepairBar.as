package src.interfaces.components
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RepairBar extends Sprite
   {
      
      private static const MAX_SCALE:int = 69;
      
      private var _imageManager:ImageManager;
      
      private var _healthBar:Sprite;
      
      private var _darkHealthBar:Sprite;
      
      private var _button:AnimatedSprite;
      
      private var _minimumScale:int;
      
      private var _updating:Boolean;
      
      private var _health:int;
      
      private var _totalHealth:int;
      
      public function RepairBar()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._darkHealthBar = new Sprite();
         this._darkHealthBar.addChild(this._imageManager.getImage("health_fill_dark"));
         this._darkHealthBar.scaleX = MAX_SCALE;
         this.addChild(this._darkHealthBar);
         this._healthBar = new Sprite();
         this._healthBar.addChild(this._imageManager.getImage("health_fill"));
         this._healthBar.scaleX = MAX_SCALE;
         this.addChild(this._healthBar);
         this._button = new AnimatedSprite(this._imageManager.getImage("shop_repair_slider"),6,20,2);
         this._button.addSequence("IDLE",1,1,0,0);
         this._button.addSequence("OVER",2,2,0,0);
         this._button.gotoAndStop("IDLE");
         this._button.y = -1;
         this.addChild(this._button);
         this._minimumScale = 0;
         this._updating = false;
         this._health = 0;
         this._totalHealth = 0;
      }
      
      public function setHealth(param1:int, param2:int) : void
      {
         var _loc3_:Number = param1 / param2;
         this._health = param1;
         this._totalHealth = param2;
         this._minimumScale = Math.floor(MAX_SCALE * _loc3_);
         this._healthBar.scaleX = this._darkHealthBar.scaleX = this._minimumScale;
         this._button.x = this._minimumScale - 3;
         if(_loc3_ == 1)
         {
            this._button.visible = false;
         }
         else
         {
            this._button.visible = true;
         }
      }
      
      public function addEventListeners() : void
      {
         this._button.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this._button.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
         this._button.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown,false,0,true);
         this._button.buttonMode = true;
         this._button.useHandCursor = true;
      }
      
      public function removeEventListeners() : void
      {
         this._button.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this._button.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         this._button.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         this._button.buttonMode = false;
         this._button.useHandCursor = false;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         this._button.gotoAndStop("OVER");
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         if(!this._updating)
         {
            this._button.gotoAndStop("IDLE");
         }
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         this._updating = true;
         this.addEventListener(Event.ENTER_FRAME,this.update,false,0,true);
         this.parent.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp,false,0,true);
         this.parent.addEventListener(MouseEvent.ROLL_OUT,this.mouseUp,false,0,true);
      }
      
      private function mouseUp(param1:Event) : void
      {
         this._updating = false;
         this.removeEventListener(Event.ENTER_FRAME,this.update);
         this.parent.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.parent.removeEventListener(MouseEvent.ROLL_OUT,this.mouseUp);
         this.mouseOut(null);
         this._button.visible = false;
         this._button.visible = true;
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:int = mouseX;
         if(_loc2_ < this._minimumScale)
         {
            _loc2_ = this._minimumScale;
         }
         else if(_loc2_ > MAX_SCALE)
         {
            _loc2_ = MAX_SCALE;
         }
         this._health = Math.ceil(_loc2_ / MAX_SCALE * this._totalHealth);
         if(this._button.x != _loc2_ - 3)
         {
            this.dispatchEvent(new Event("UPDATE"));
         }
         this._button.x = _loc2_ - 3;
         this._darkHealthBar.scaleX = _loc2_;
      }
      
      public function get health() : int
      {
         return this._health;
      }
   }
}


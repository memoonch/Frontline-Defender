package src.interfaces
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ControlsMenu extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _background:Sprite;
      
      private var _container:Sprite;
      
      private var _isActive:Boolean;
      
      private var _animating:Boolean;
      
      public function ControlsMenu()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._container = new Sprite();
         this._container.x = -Window.width;
         this.addChild(this._container);
         this._background = new Sprite();
         this._background.addChild(this._imageManager.getImage("controls_plate"));
         this._background.x = Calc.center(Window.width,this._background.width);
         this._background.y = Calc.center(Window.height,this._background.height);
         this._container.addChild(this._background);
         this._isActive = false;
         this._animating = false;
         this.visible = false;
      }
      
      public function Activate() : void
      {
         if(!this._animating)
         {
            this.visible = true;
            this._isActive = true;
            this._animating = true;
            this.addEventListener(Event.ENTER_FRAME,this.moveIn,false,0,true);
         }
      }
      
      public function Deactivate() : void
      {
         if(!this._animating)
         {
            this._isActive = false;
            this._animating = true;
            this.addEventListener(Event.ENTER_FRAME,this.moveOut,false,0,true);
         }
      }
      
      private function moveIn(param1:Event) : void
      {
         var _loc2_:int = this._container.x + 80;
         if(_loc2_ >= 0)
         {
            _loc2_ = 0;
            this._animating = false;
            this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         }
         this._container.x = _loc2_;
      }
      
      private function moveOut(param1:Event) : void
      {
         var _loc2_:int = this._container.x - 80;
         if(_loc2_ <= -Window.width)
         {
            _loc2_ = -Window.width;
            this._animating = false;
            this.visible = false;
            this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         }
         this._container.x = _loc2_;
      }
      
      public function reset() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         this.visible = false;
         this._isActive = false;
         this._animating = false;
         this._container.x = -Window.width;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
   }
}


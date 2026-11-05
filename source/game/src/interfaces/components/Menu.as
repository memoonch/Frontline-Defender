package src.interfaces.components
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.events.GameEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Menu extends Sprite
   {
      
      protected var _background:Sprite;
      
      private var _container:Sprite;
      
      private var _overlay:Sprite;
      
      public function Menu(param1:Bitmap)
      {
         super();
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.7);
         this._overlay.graphics.drawRect(0,0,Window.width,Window.height);
         this._overlay.graphics.endFill();
         this.addChild(this._overlay);
         this._container = new Sprite();
         this._container.x = -Window.width;
         this.addChild(this._container);
         this._background = new Sprite();
         this._background.addChild(param1);
         this._background.x = Calc.center(Window.width,this._background.width);
         this._background.y = Calc.center(Window.height,this._background.height);
         this._container.addChild(this._background);
      }
      
      public function addEventListeners() : void
      {
      }
      
      public function removeEventListeners() : void
      {
      }
      
      public function Activate() : void
      {
         this.visible = true;
         this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         this.addEventListener(Event.ENTER_FRAME,this.moveIn,false,0,true);
      }
      
      public function Deactivate() : void
      {
         this.removeEventListeners();
         this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         this.addEventListener(Event.ENTER_FRAME,this.moveOut,false,0,true);
      }
      
      private function moveIn(param1:Event) : void
      {
         var _loc2_:int = this._container.x + 80;
         if(_loc2_ >= 0)
         {
            _loc2_ = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
            this.addEventListeners();
         }
         this._container.x = _loc2_;
      }
      
      private function moveOut(param1:Event) : void
      {
         var _loc2_:int = this._container.x - 80;
         if(_loc2_ <= -Window.width)
         {
            _loc2_ = -Window.width;
            this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
            this.dispatchEvent(new GameEvent(GameEvent.RESUME));
         }
         this._container.x = _loc2_;
      }
   }
}


package src.components.effects
{
   import com.hcLibrary.data.Window;
   import com.hcLibrary.events.GameEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SwipeEffect extends Sprite
   {
      
      private var _counter:int;
      
      public function SwipeEffect()
      {
         super();
      }
      
      public function start() : void
      {
         this._counter = 0;
         this.addEventListener(Event.ENTER_FRAME,this.closeAnimation,false,0,true);
      }
      
      private function closeAnimation(param1:Event) : void
      {
         ++this._counter;
         if(this._counter <= 10)
         {
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.moveTo(0,0);
            this.graphics.lineTo(this._counter * (Window.width / 5),0);
            this.graphics.lineTo(0,this._counter * (Window.height / 5));
            this.graphics.lineTo(0,0);
            this.graphics.endFill();
         }
         else
         {
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.moveTo(0,0);
            this.graphics.lineTo(Window.width,0);
            this.graphics.lineTo(Window.width,(this._counter - 5) * (Window.height / 5));
            this.graphics.lineTo((this._counter - 5) * (Window.width / 5),Window.height);
            this.graphics.lineTo(0,Window.height);
            this.graphics.lineTo(0,0);
            this.graphics.endFill();
            if(this._counter >= 10)
            {
               this.removeEventListener(Event.ENTER_FRAME,this.closeAnimation);
               this.dispatchEvent(new GameEvent(GameEvent.RESUME));
               this._counter = 0;
               this.addEventListener(Event.ENTER_FRAME,this.openAnimation,false,0,true);
            }
         }
      }
      
      private function openAnimation(param1:Event) : void
      {
         ++this._counter;
         if(this._counter <= 5)
         {
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.moveTo(Window.width,Window.height);
            this.graphics.lineTo(0,Window.height);
            this.graphics.lineTo(0,this._counter * (Window.height / 5));
            this.graphics.lineTo(this._counter * (Window.width / 5),0);
            this.graphics.lineTo(Window.width,0);
            this.graphics.lineTo(Window.width,Window.height);
            this.graphics.endFill();
         }
         else
         {
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.moveTo(Window.width,Window.height);
            this.graphics.lineTo((this._counter - 5) * (Window.width / 5),Window.height);
            this.graphics.lineTo(Window.width,(this._counter - 5) * (Window.height / 5));
            this.graphics.lineTo(Window.width,Window.height);
            this.graphics.endFill();
            if(this._counter >= 10)
            {
               this.removeEventListener(Event.ENTER_FRAME,this.openAnimation);
               this.dispatchEvent(new GameEvent(GameEvent.FINISHED));
            }
         }
      }
   }
}


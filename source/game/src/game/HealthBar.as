package src.game
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class HealthBar extends Sprite
   {
      
      private var _fill:Sprite;
      
      private var _counter:int;
      
      private var _mouseOver:Boolean;
      
      public function HealthBar()
      {
         super();
         this.graphics.beginFill(0);
         this.graphics.drawRect(0,0,56,11);
         this.graphics.endFill();
         this.graphics.beginFill(16777215);
         this.graphics.drawRect(1,1,54,9);
         this.graphics.endFill();
         this.graphics.beginFill(0);
         this.graphics.drawRect(2,2,52,7);
         this.graphics.endFill();
         this._fill = new Sprite();
         this._fill.graphics.beginFill(16711680);
         this._fill.graphics.drawRect(0,0,50,5);
         this._fill.graphics.endFill();
         this._fill.x = 3;
         this._fill.y = 3;
         this.addChild(this._fill);
         this._counter = 0;
         this._mouseOver = false;
         this.visible = false;
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = 50 * (param1 / 100);
         if(_loc2_ < 1 && param1 != 0)
         {
            _loc2_ = 1;
         }
         this._fill.graphics.clear();
         this._fill.graphics.beginFill(16711680);
         this._fill.graphics.drawRect(0,0,_loc2_,5);
         this._fill.graphics.endFill();
         this.visible = true;
         this.alpha = 1;
         this._counter = 0;
         this.removeEventListener(Event.ENTER_FRAME,this.FadeOut);
         if(!this._mouseOver)
         {
            this.addEventListener(Event.ENTER_FRAME,this.FadeOut,false,0,true);
         }
      }
      
      public function reset() : void
      {
         this._fill.graphics.clear();
         this._fill.graphics.beginFill(16711680);
         this._fill.graphics.drawRect(0,0,50,5);
         this._fill.graphics.endFill();
      }
      
      private function FadeOut(param1:Event) : void
      {
         ++this._counter;
         if(this._counter >= 30)
         {
            this.alpha -= 0.05;
            if(this.alpha <= 0)
            {
               this.visible = false;
               this.alpha = 1;
               this.removeEventListener(Event.ENTER_FRAME,this.FadeOut);
            }
         }
      }
      
      public function Show() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.FadeOut);
         this.alpha = 1;
         this.visible = true;
         this._mouseOver = true;
      }
      
      public function Hide() : void
      {
         this._mouseOver = false;
         this._counter = 25;
         this.addEventListener(Event.ENTER_FRAME,this.FadeOut,false,0,true);
      }
      
      public function pause() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.FadeOut);
      }
      
      public function unpause() : void
      {
         if(this.visible)
         {
            this.addEventListener(Event.ENTER_FRAME,this.FadeOut,false,0,true);
         }
      }
   }
}


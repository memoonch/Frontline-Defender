package src.components.effects
{
   import com.hcLibrary.data.Window;
   import com.hcLibrary.events.GameEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import com.hcLibrary.managers.FontManager;
   
   public class SwipeEffect extends Sprite
   {
      
      private var _counter:int;
      
      private var _loading:Sprite;
      private var _dots:Array;
      private var _tick:int;

      public function SwipeEffect(showLoading:Boolean = false)
      {
         super();
         mouseChildren = false;
         if(showLoading)
         {
            _loading = new Sprite();
            var title:Sprite = FontManager.getInstance().getString("LOADING","SHOP",2,0);
            title.x = -title.width/2;
            _loading.addChild(title);
            _dots = [];
            for(var i:int=0;i<3;i++)
            {
               var dot:Sprite = new Sprite();
               dot.graphics.beginFill(0x9ec66b);
               dot.graphics.drawRect(0,0,4,4);
               dot.graphics.endFill();
               dot.x = -12+i*10;
               dot.y = 26;
               _dots.push(dot);
               _loading.addChild(dot);
            }
            _loading.x = Window.width/2;
            _loading.y = Window.height/2-12;
            _loading.visible = false;
            addChild(_loading);
         }
      }
      
      public function start() : void
      {
         this._counter = 0;
         this._tick = 0;
         this.addEventListener(Event.ENTER_FRAME,this.animateLoading,false,0,true);
         this.addEventListener(Event.ENTER_FRAME,this.closeAnimation,false,0,true);
      }
      
      private function animateLoading(event:Event):void
      {
         if(_loading == null) return;
         _tick++;
         for(var i:int=0;i<3;i++) _dots[i].alpha = int(_tick/5)%3==i ? 1 : 0.25;
      }

      private function closeAnimation(param1:Event) : void
      {
         ++this._counter;
         if(_loading != null && this._counter >= 8) _loading.visible = true;
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
         if(_loading != null && this._counter >= 2) _loading.visible = false;
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
               this.removeEventListener(Event.ENTER_FRAME,this.animateLoading);
               this.dispatchEvent(new GameEvent(GameEvent.FINISHED));
            }
         }
      }
   }
}


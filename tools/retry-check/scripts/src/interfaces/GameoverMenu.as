package src.interfaces
{
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import src.Main;
   
   public class GameoverMenu extends Sprite
   {
      
      private var card:Sprite;
      
      private var stats:Sprite;
      
      private var retry:Sprite;
      
      private var menu:Sprite;
      
      private var score:Number = 0;
      
      public function GameoverMenu()
      {
         super();
         graphics.beginFill(132870,0.72);
         graphics.drawRect(0,0,640,480);
         graphics.endFill();
         card = new Sprite();
         card.x = 120;
         card.y = -310;
         addChild(card);
         frame(card,400,310,527630);
         text(card,"GAME OVER",24,22,3);
         text(card,"MISSION REPORT",25,59,1.2).alpha = 0.65;
         stats = new Sprite();
         card.addChild(stats);
         retry = button("RETRY",24,true);
         menu = button("MENU",208,false);
      }
      
      private function frame(t:Sprite, w:Number, h:Number, c:uint) : void
      {
         t.graphics.clear();
         t.graphics.beginFill(c,0.97);
         t.graphics.drawRect(0,0,w,h);
         t.graphics.endFill();
         t.graphics.lineStyle(1,6779757);
         t.graphics.drawRect(0.5,0.5,w - 1,h - 1);
         t.graphics.lineStyle(1,2569006);
         t.graphics.drawRect(2.5,2.5,w - 5,h - 5);
      }
      
      private function text(p:Sprite, v:String, x:Number, y:Number, z:Number) : Sprite
      {
         var s:Sprite = FontManager.getInstance().getString(v,"SHOP",1,0);
         s.scaleX = z;
         s.scaleY = z * 1.33;
         s.x = x;
         s.y = y;
         s.mouseEnabled = false;
         s.mouseChildren = false;
         p.addChild(s);
         return s;
      }
      
      private function button(v:String, x:Number, primary:Boolean) : Sprite
      {
         var s:Sprite;
         var b:Sprite = new Sprite();
         b.x = x;
         b.y = 254;
         b.mouseChildren = false;
         b.buttonMode = true;
         frame(b,168,36,primary ? 2504227 : 1054741);
         s = text(b,v,0,13,1.5);
         s.x = (168 - s.width) / 2;
         card.addChild(b);
         b.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            frame(b,168,36,3491117);
         });
         b.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void
         {
            frame(b,168,36,primary ? 2504227 : 1054741);
         });
         return b;
      }
      
      public function addEventListeners() : void
      {
         retry.addEventListener(MouseEvent.CLICK,yes);
         menu.addEventListener(MouseEvent.CLICK,no);
      }
      
      public function removeEventListeners() : void
      {
         retry.removeEventListener(MouseEvent.CLICK,yes);
         menu.removeEventListener(MouseEvent.CLICK,no);
      }
      
      private function yes(e:MouseEvent) : void
      {
         removeEventListeners();
         dispatchEvent(new GameEvent(GameEvent.CANCEL));
      }
      
      private function no(e:MouseEvent) : void
      {
         removeEventListeners();
         dispatchEvent(new GameEvent(GameEvent.CONFIRM));
      }
      
      public function Activate() : void
      {
         addEventListener(Event.ENTER_FRAME,moveDown,false,0,true);
      }
      
      private function moveDown(e:Event) : void
      {
         card.y += 40;
         if(card.y >= 85)
         {
            card.y = 85;
            removeEventListener(Event.ENTER_FRAME,moveDown);
            if(score == 0)
            {
               addEventListeners();
            }
            else
            {
               Main.FogAPI.submitScore(score,addEventListeners);
            }
         }
      }
      
      public function updateStats(w:int, p:Number, m:Number, s:Number, v:Number) : void
      {
         score = p;
         while(stats.numChildren > 0)
         {
            stats.removeChildAt(0);
         }
         var names:Array = ["WAVES COMPLETED","FINAL SCORE","MONEY EARNED","GRUNTS KILLED","VEHICLES DESTROYED"];
         var values:Array = [w,p,m,s,v];
         var i:int = 0;
         while(i < 5)
         {
            var row:Sprite = new Sprite();
            row.x = 24;
            row.y = 94 + i * 28;
            stats.addChild(row);
            row.graphics.beginFill(i % 2 == 0 ? 1581340 : 1054741);
            row.graphics.drawRect(0,0,352,25);
            row.graphics.endFill();
            text(row,names[i],10,9,1);
            var n:Sprite = text(row,String(values[i]),0,6,1.5);
            n.x = 342 - n.width;
            i++;
         }
      }
   }
}


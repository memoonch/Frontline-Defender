package com.hcLibrary.display
{
   import com.hcLibrary.data.Window;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class GameWindow extends Sprite
   {
      
      private static var SCALE:Number = 1;
      
      public function GameWindow()
      {
         super();
      }
      
      public static function get scale() : Number
      {
         return SCALE;
      }
      
      public function changeSize(param1:Number, param2:Number) : void
      {
         // Keep all gameplay, HUD and mouse coordinates in the original space.
         // Scale the complete display together to fill the browser viewport.
         SCALE = 1;
         this.scrollRect = new Rectangle(0,0,Window.width,Window.height);
         this.scaleX = param1 / Window.width;
         this.scaleY = param2 / Window.height;
         this.x = 0;
         this.y = 0;
      }
      
      override public function get width() : Number
      {
         return Window.width * SCALE;
      }
      
      override public function get height() : Number
      {
         return Window.height * SCALE;
      }
   }
}


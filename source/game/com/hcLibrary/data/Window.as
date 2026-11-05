package com.hcLibrary.data
{
   public class Window
   {
      
      private static var _windowWidth:int;
      
      private static var _windowHeight:int;
      
      public function Window()
      {
         super();
      }
      
      public static function get width() : int
      {
         return _windowWidth;
      }
      
      public static function set width(param1:int) : void
      {
         _windowWidth = param1;
      }
      
      public static function get height() : int
      {
         return _windowHeight;
      }
      
      public static function set height(param1:int) : void
      {
         _windowHeight = param1;
      }
   }
}


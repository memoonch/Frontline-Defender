package com.hcLibrary.debug
{
   public class GameError
   {
      
      public function GameError()
      {
         super();
      }
      
      public static function throwError(param1:String, param2:String, param3:String) : void
      {
         DebugPanel.lineBreak();
         DebugPanel.traceLine("Class: " + param1,16711680,12);
         DebugPanel.traceLine("Function: " + param2,16711680,12);
         DebugPanel.traceLine("Error: " + param3,16711680,12,true);
         DebugPanel.lineBreak();
      }
   }
}


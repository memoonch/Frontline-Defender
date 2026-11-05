package com.hcLibrary.events
{
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const CANCEL:String = "cancel";
      
      public static const CLICKED:String = "clicked";
      
      public static const CONFIRM:String = "confirm";
      
      public static const FINISHED:String = "finished";
      
      public static const ON_SCREEN:String = "onScreen";
      
      public static const PAUSE:String = "pause";
      
      public static const RESUME:String = "resume";
      
      public function GameEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new GameEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("GameEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}


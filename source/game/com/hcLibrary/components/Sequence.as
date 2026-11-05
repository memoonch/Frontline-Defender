package com.hcLibrary.components
{
   public class Sequence
   {
      
      private var _name:String;
      
      private var _startFrame:int;
      
      private var _endFrame:int;
      
      private var _loops:int;
      
      private var _delay:int;
      
      private var _direction:int;
      
      private var _nextSequence:String;
      
      public function Sequence(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int, param7:String = null)
      {
         super();
         this._name = param1;
         this._startFrame = param2;
         this._endFrame = param3;
         this._loops = param4;
         this._delay = param5;
         this._direction = param6;
         this._nextSequence = param7;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get startFrame() : int
      {
         return this._startFrame;
      }
      
      public function get endFrame() : int
      {
         return this._endFrame;
      }
      
      public function get loops() : int
      {
         return this._loops;
      }
      
      public function get delay() : int
      {
         return this._delay;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get nextSequence() : String
      {
         return this._nextSequence;
      }
   }
}


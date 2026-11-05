package com.hcLibrary.debug
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class FPSCounter extends Sprite
   {
      
      public static const TOP_LEFT:int = 0;
      
      public static const TOP_RIGHT:int = 1;
      
      public static const BOTTOM_LEFT:int = 2;
      
      public static const BOTTOM_RIGHT:int = 3;
      
      private var _lastUpdate:int;
      
      private var _ticks:int;
      
      private var _position:int;
      
      private var _text:TextField;
      
      private var _format:TextFormat;
      
      public function FPSCounter(param1:int, param2:uint, param3:Boolean, param4:uint)
      {
         super();
         this._format = new TextFormat();
         this._format.color = param2;
         this._format.size = 14;
         this._format.font = "Arial";
         this._text = new TextField();
         this._text.text = "--- FPS";
         this._text.selectable = false;
         this._text.border = false;
         this._text.background = param3;
         this._text.backgroundColor = param4;
         this._text.autoSize = TextFieldAutoSize.LEFT;
         this._text.setTextFormat(this._format);
         this.addChild(this._text);
         this._position = param1;
         this.addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function update(param1:Event) : void
      {
         var _loc4_:Number = NaN;
         ++this._ticks;
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastUpdate;
         if(_loc3_ >= 1000)
         {
            _loc4_ = this._ticks / _loc3_ * 1000;
            this._text.text = _loc4_.toFixed(1) + " FPS";
            this._text.setTextFormat(this._format);
            switch(this._position)
            {
               case FPSCounter.TOP_RIGHT:
                  this.x = this.parent.width - this.width;
                  this.y = 0;
                  break;
               case FPSCounter.BOTTOM_LEFT:
                  this.x = 0;
                  this.y = this.parent.height - this.height;
                  break;
               case FPSCounter.BOTTOM_RIGHT:
                  this.x = this.parent.width - this.width;
                  this.y = this.parent.height - this.height;
                  break;
               default:
                  this.x = 0;
                  this.y = 0;
            }
            this._ticks = 0;
            this._lastUpdate = _loc2_;
         }
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
      }
   }
}


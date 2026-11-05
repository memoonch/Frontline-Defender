package com.hcLibrary.display
{
   import com.hcLibrary.data.Calc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SpecialEffect extends Sprite
   {
      
      private var _image:AnimatedSprite;
      
      private var _name:String;
      
      public function SpecialEffect(param1:Bitmap, param2:Number, param3:Number, param4:int, param5:String, param6:int = 2, param7:int = 1, param8:int = 0)
      {
         super();
         if(param8 < 0)
         {
            param8 = 0;
         }
         this._image = new AnimatedSprite(param1,param2,param3,param4);
         this._image.addSequence("PLAY",1,param4,param6,param8,param7,"FINISHED");
         this._image.addSequence("FINISHED",param4,param4,0,0);
         this._image.gotoAndPlay("PLAY");
         this._image.x = Calc.center(0,this._image.width);
         this._image.y = Calc.center(0,this._image.height);
         this.addChild(this._image);
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._name = param5;
      }
      
      public function reset() : void
      {
         this._image.gotoAndPlay("PLAY");
      }
      
      public function pause() : void
      {
         this._image.pause();
      }
      
      public function unpause() : void
      {
         this._image.resume();
      }
      
      public function get isFinished() : Boolean
      {
         return this._image.sequence == "FINISHED";
      }
      
      override public function get name() : String
      {
         return this._name;
      }
   }
}


package com.hcLibrary.data
{
   import flash.geom.Point;
   
   public class Calc
   {
      
      public function Calc()
      {
         super();
      }
      
      public static function absoluteValue(param1:Number) : Number
      {
         if(param1 < 0)
         {
            param1 = 0 - param1;
         }
         return param1;
      }
      
      public static function angle(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = (param2.y - param1.y) * -1;
         var _loc5_:Number = Calc.toDegrees(Math.atan(_loc3_ / _loc4_));
         if(_loc4_ < 0)
         {
            _loc5_ += 180;
         }
         return _loc5_;
      }
      
      public static function center(param1:int, param2:int, param3:int = 0) : Number
      {
         return param1 / 2 - param2 / 2 + param3;
      }
      
      public static function distance(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public static function movementVector(param1:Point, param2:Point, param3:Number) : Point
      {
         var _loc4_:Point = new Point(param1.x - param2.x,param1.y - param2.y);
         _loc4_.normalize(param3);
         return _loc4_;
      }
      
      public static function random(param1:int, param2:int) : int
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public static function rotateAroundPoint(param1:Point, param2:Point, param3:Number) : Point
      {
         param1.x -= param2.x;
         param1.y -= param2.y;
         var _loc4_:Number = Calc.toRadians(param3);
         var _loc5_:Number = Math.sin(_loc4_);
         var _loc6_:Number = Math.cos(_loc4_);
         var _loc7_:Point = new Point();
         _loc7_.x = param1.x * _loc6_ - param1.y * _loc5_ + param2.x;
         _loc7_.y = param1.x * _loc5_ + param1.y * _loc6_ + param2.y;
         return _loc7_;
      }
      
      public static function rotateTo(param1:Point, param2:Point) : Number
      {
         var _loc3_:Point = new Point(param1.x - param2.x,param1.y - param2.y);
         return Calc.toDegrees(Math.atan2(_loc3_.y,_loc3_.x));
      }
      
      public static function shuffle(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = param1.concat();
         var _loc3_:Array = new Array();
         while(_loc2_.length > 0)
         {
            _loc4_ = Math.floor(Math.random() * _loc2_.length);
            _loc3_.push(_loc2_[_loc4_]);
            _loc2_.splice(_loc4_,1);
         }
         return _loc3_;
      }
      
      public static function toDegrees(param1:Number) : Number
      {
         return param1 * 180 / Math.PI;
      }
      
      public static function toRadians(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
   }
}


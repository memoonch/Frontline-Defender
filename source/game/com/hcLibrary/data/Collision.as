package com.hcLibrary.data
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Collision
   {
      
      public function Collision()
      {
         super();
      }
      
      private static function getCollisionRect(param1:DisplayObject, param2:DisplayObject, param3:DisplayObjectContainer) : Rectangle
      {
         var _loc7_:BitmapData = null;
         var _loc8_:BitmapData = null;
         var _loc9_:Rectangle = null;
         var _loc4_:Rectangle = param1.getBounds(param3);
         var _loc5_:Rectangle = param2.getBounds(param3);
         var _loc6_:Rectangle = _loc4_.intersection(_loc5_);
         if(_loc6_.size.length > 0)
         {
            _loc6_.width = Math.ceil(_loc6_.width);
            _loc6_.height = Math.ceil(_loc6_.height);
            _loc7_ = getAlphaMap(param1,_loc6_,BitmapDataChannel.RED,param3);
            _loc8_ = getAlphaMap(param2,_loc6_,BitmapDataChannel.GREEN,param3);
            _loc7_.draw(_loc8_,null,null,BlendMode.LIGHTEN);
            _loc9_ = _loc7_.getColorBoundsRect(65792,65792);
            _loc9_.x += _loc6_.x;
            _loc9_.y += _loc6_.y;
            return _loc9_;
         }
         return null;
      }
      
      private static function getAlphaMap(param1:DisplayObject, param2:Rectangle, param3:uint, param4:DisplayObjectContainer) : BitmapData
      {
         var _loc5_:Matrix = param4.transform.concatenatedMatrix.clone();
         _loc5_.invert();
         var _loc6_:Matrix = param1.transform.concatenatedMatrix.clone();
         _loc6_.concat(_loc5_);
         _loc6_.translate(-param2.x,-param2.y);
         var _loc7_:BitmapData = new BitmapData(param2.width,param2.height,true,0);
         _loc7_.draw(param1,_loc6_);
         var _loc8_:BitmapData = new BitmapData(param2.width,param2.height,false,0);
         _loc8_.copyChannel(_loc7_,_loc7_.rect,new Point(0,0),BitmapDataChannel.ALPHA,param3);
         return _loc8_;
      }
      
      public static function isColliding(param1:DisplayObject, param2:Rectangle, param3:DisplayObject, param4:Rectangle, param5:DisplayObjectContainer) : Boolean
      {
         var _loc6_:Rectangle = null;
         if(param2.intersects(param4))
         {
            _loc6_ = getCollisionRect(param1,param3,param5);
            if(_loc6_ != null && _loc6_.size.length > 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}


package com.hcLibrary.managers
{
   import com.hcLibrary.debug.GameError;
   import com.hcLibrary.display.GameWindow;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class ImageManager
   {
      
      private static var _instance:ImageManager;
      
      private static var _allowInstance:Boolean;
      
      private static var _imageDict:Dictionary;
      
      private static var _images:Array;
      
      public function ImageManager()
      {
         super();
         if(ImageManager._allowInstance)
         {
            _imageDict = new Dictionary(true);
            _images = new Array();
         }
         else
         {
            GameError.throwError("ImageManager","constructor","Only 1 instance of ImageManager is necessary. Use the \'getInstance\' method instead of the \'new\' keyword.");
         }
      }
      
      public static function getInstance() : ImageManager
      {
         if(ImageManager._instance == null)
         {
            ImageManager._allowInstance = true;
            ImageManager._instance = new ImageManager();
            ImageManager._allowInstance = false;
         }
         return ImageManager._instance;
      }
      
      public function addImage(param1:*, param2:String) : void
      {
         var _loc3_:Object = _imageDict[param2];
         if(_loc3_ != null)
         {
            GameError.throwError("ImageManager","addImage","An image with the name \'" + param2 + "\' already exists.");
            return;
         }
         var _loc4_:Bitmap = new param1();
         _loc3_ = {
            "name":param2,
            "image":_loc4_,
            "width":_loc4_.width,
            "height":_loc4_.height
         };
         _imageDict[param2] = _loc3_;
         _images.push(_loc3_);
      }
      
      public function getImage(param1:String) : Bitmap
      {
         var _loc2_:Object = _imageDict[param1];
         if(_loc2_ == null)
         {
            GameError.throwError("ImageManager","getImage","An image with the name \'" + param1 + "\' does not exist.");
            return new Bitmap();
         }
         var _loc3_:Matrix = new Matrix();
         _loc3_.scale(GameWindow.scale,GameWindow.scale);
         var _loc4_:BitmapData = new BitmapData(_loc2_.width * GameWindow.scale,_loc2_.height * GameWindow.scale,true,0);
         _loc4_.draw(_loc2_.image,_loc3_,null,null,null,false);
         return new Bitmap(_loc4_,PixelSnapping.NEVER,false);
      }
   }
}


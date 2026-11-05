package com.hcLibrary.managers
{
   import com.hcLibrary.debug.GameError;
   import com.hcLibrary.display.GameWindow;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class FontManager
   {
      
      private static var _instance:FontManager;
      
      private static var _allowInstance:Boolean;
      
      private var _fontDict:Dictionary;
      
      private var _fonts:Array;
      
      public function FontManager()
      {
         super();
         if(FontManager._allowInstance)
         {
            this._fontDict = new Dictionary(true);
            this._fonts = new Array();
         }
         else
         {
            GameError.throwError("FontManager","constructor","Only 1 instance of FontManager is necessary. Use the \'getInstance\' method instead of the \'new\' keyword.");
         }
      }
      
      public static function getInstance() : FontManager
      {
         if(FontManager._instance == null)
         {
            FontManager._allowInstance = true;
            FontManager._instance = new FontManager();
            FontManager._allowInstance = false;
         }
         return FontManager._instance;
      }
      
      public function addFontSheet(param1:String, param2:Bitmap, param3:ByteArray, param4:int, param5:int = 5) : void
      {
         var _loc6_:Object = this._fontDict[param1];
         if(_loc6_ != null)
         {
            GameError.throwError("FontManager","addFontSheet","A font sheet with the name \'" + param1 + "\' already exists.");
            return;
         }
         var _loc7_:XML = new XML(param3.readUTFBytes(param3.length));
         _loc6_ = {
            "name":param1,
            "sheet":param2,
            "style":_loc7_,
            "height":param4,
            "space":param5
         };
         this._fontDict[param1] = _loc6_;
         this._fonts.push(_loc6_);
      }
      
      public function getString(param1:String, param2:String, param3:Number = 1, param4:int = 0) : Sprite
      {
         var _loc8_:Bitmap = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:Object = this._fontDict[param2];
         var _loc6_:String = param1;
         var _loc7_:Sprite = new Sprite();
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc6_.length)
         {
            if(_loc6_.charCodeAt(_loc11_) == 32)
            {
               _loc9_++;
            }
            else
            {
               _loc12_ = 0;
               while(_loc12_ < _loc5_.style.Character.length())
               {
                  if(_loc6_.charAt(_loc11_) == _loc5_.style.Character[_loc12_].@char)
                  {
                     _loc8_ = new Bitmap(new BitmapData(_loc5_.style.Character[_loc12_].width * GameWindow.scale,_loc5_.height * GameWindow.scale,true,0));
                     _loc8_.bitmapData.copyPixels(_loc5_.sheet.bitmapData,new Rectangle(_loc5_.style.Character[_loc12_].x * GameWindow.scale,param4 * _loc5_.height * GameWindow.scale,_loc5_.style.Character[_loc12_].width * GameWindow.scale,_loc5_.height * GameWindow.scale),new Point());
                     break;
                  }
                  _loc12_++;
               }
               if(_loc8_ == null)
               {
                  GameError.throwError("FontManager","getString","The font sheet does not contain the character \"" + _loc6_.charAt(_loc11_) + "\" in its data.");
               }
               else
               {
                  _loc8_.x = _loc10_ + _loc9_ * _loc5_.space * GameWindow.scale + _loc11_ * param3 * GameWindow.scale;
                  _loc10_ += int(_loc5_.style.Character[_loc12_].width);
                  _loc7_.addChild(_loc8_);
               }
            }
            _loc11_++;
         }
         _loc7_.mouseEnabled = false;
         _loc7_.mouseChildren = false;
         return _loc7_;
      }
   }
}


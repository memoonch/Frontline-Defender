package com.hcLibrary.data
{
   import com.hcLibrary.debug.GameError;
   
   public class Controls
   {
      
      private static var _keys:Array = new Array();
      
      public function Controls()
      {
         super();
      }
      
      public static function addKey(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < _keys.length)
         {
            if(_keys[_loc3_][0] == param1)
            {
               GameError.throwError("Controls","addKey","A key with that name already exists.");
               return;
            }
            _loc3_++;
         }
         _keys.push(new Array(param1,param2,false));
      }
      
      public static function changeKey(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < _keys.length)
         {
            if(_keys[_loc3_][0] == param1)
            {
               _keys[_loc3_][1] = param2;
               return;
            }
            _loc3_++;
         }
      }
      
      public static function keyStateChange(param1:String = null, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < _keys.length)
         {
            if(param1 != null && _keys[_loc3_][0] == param1 || _keys[_loc3_][1] == param2)
            {
               _keys[_loc3_][2] = !_keys[_loc3_][2];
               return;
            }
            _loc3_++;
         }
      }
      
      public static function getKeyState(param1:String = null, param2:int = 0) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < _keys.length)
         {
            if(param1 != null && _keys[_loc3_][0] == param1 || _keys[_loc3_][1] == param2)
            {
               return _keys[_loc3_][2];
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function getKeyValue(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < _keys.length)
         {
            if(_keys[_loc2_][0] == param1)
            {
               return _keys[_loc2_][1];
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function getKeyInUse(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 >= 37 && param1 <= 40 || param1 >= 65 && param1 <= 93 || param1 == 32)
         {
            _loc2_ = 0;
            while(_loc2_ < _keys.length)
            {
               if(_keys[_loc2_][1] == param1)
               {
                  return true;
               }
               _loc2_++;
            }
            return false;
         }
         return true;
      }
   }
}


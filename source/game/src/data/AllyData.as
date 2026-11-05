package src.data
{
   import flash.geom.Point;
   
   public class AllyData
   {
      
      private var _name:String;
      
      private var _damage:int;
      
      private var _range:int;
      
      private var _bulletType:int;
      
      private var _bulletSpawn:Point;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _frames:int;
      
      private var _image:String;
      
      private var _animations:Array;
      
      public function AllyData(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:String, param11:Array)
      {
         super();
         this._name = param1;
         this._damage = param2;
         this._range = param3;
         this._bulletType = param4;
         this._bulletSpawn = new Point(param5,param6);
         this._width = param7;
         this._height = param8;
         this._frames = param9;
         this._image = param10;
         this._animations = param11;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get damage() : int
      {
         return this._damage;
      }
      
      public function get range() : int
      {
         return this._range;
      }
      
      public function get bulletType() : int
      {
         return this._bulletType;
      }
      
      public function get bulletSpawn() : Point
      {
         return this._bulletSpawn;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function get frames() : int
      {
         return this._frames;
      }
      
      public function get image() : String
      {
         return this._image;
      }
      
      public function get animations() : Array
      {
         return this._animations;
      }
   }
}


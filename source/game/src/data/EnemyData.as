package src.data
{
   import flash.geom.Point;
   
   public class EnemyData
   {
      
      private var _name:String;
      
      private var _health:int;
      
      private var _damage:int;
      
      private var _speed:int;
      
      private var _range:int;
      
      private var _loot:int;
      
      private var _points:int;
      
      private var _isAir:Boolean;
      
      private var _bulletType:int;
      
      private var _deathSound:int;
      
      private var _bulletSpawn:Point;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _frames:int;
      
      private var _xPosition:int;
      
      private var _yPosition:int;
      
      private var _boundsWidth:int;
      
      private var _boundsHeight:int;
      
      private var _image:String;
      
      private var _animations:Array;
      
      public function EnemyData(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:int, param10:int, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int, param17:int, param18:int, param19:int, param20:String, param21:Array)
      {
         super();
         this._name = param1;
         this._health = param2;
         this._damage = param3;
         this._speed = param4;
         this._range = param5;
         this._loot = param6;
         this._points = param7;
         this._isAir = param8;
         this._bulletType = param9;
         this._deathSound = param10;
         this._bulletSpawn = new Point(param11,param12);
         this._width = param13;
         this._height = param14;
         this._frames = param15;
         this._xPosition = param16;
         this._yPosition = param17;
         this._boundsWidth = param18;
         this._boundsHeight = param19;
         this._image = param20;
         this._animations = param21;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get health() : int
      {
         return this._health;
      }
      
      public function get damage() : int
      {
         return this._damage;
      }
      
      public function get speed() : int
      {
         return this._speed;
      }
      
      public function get range() : int
      {
         return this._range;
      }
      
      public function get loot() : int
      {
         return this._loot;
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      public function get isAir() : Boolean
      {
         return this._isAir;
      }
      
      public function get bulletType() : int
      {
         return this._bulletType;
      }
      
      public function get deathSound() : int
      {
         return this._deathSound;
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
      
      public function get xPosition() : int
      {
         return this._xPosition;
      }
      
      public function get yPosition() : int
      {
         return this._yPosition;
      }
      
      public function get boundsWidth() : int
      {
         return this._boundsWidth;
      }
      
      public function get boundsHeight() : int
      {
         return this._boundsHeight;
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


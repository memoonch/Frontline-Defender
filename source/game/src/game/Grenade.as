package src.game
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class Grenade extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _image:Sprite;
      
      private var _a:Number;
      
      private var _b:Number;
      
      private var _c:Number;
      
      private var _direction:int;
      
      private var _midpoint:int;
      
      private var _endpoint:int;
      
      private var _scaleFactor01:Number;
      
      private var _scaleFactor02:Number;
      
      public var scale:Number;
      
      private var _damage:int;
      
      public var isEnemy:Boolean;
      
      public var isAerial:Boolean;
      
      public function Grenade(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:int, param7:Number, param8:Number)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._image = new Sprite();
         this._image.addChild(this._imageManager.getImage("grenade"));
         this._image.x = -(this._image.width / 2);
         this._image.y = -(this._image.height / 2);
         this.addChild(this._image);
         this.rotation = Calc.random(0,360);
         this._a = param1;
         this._b = param2;
         this._c = param3;
         this._direction = param4;
         this._midpoint = param5;
         this._endpoint = param6;
         this._scaleFactor01 = param7;
         this._scaleFactor02 = param8;
         this.scale = 1;
         this.isEnemy = false;
         this.isAerial = false;
      }
      
      public function reset(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:int, param7:Number, param8:Number) : void
      {
         this._a = param1;
         this._b = param2;
         this._c = param3;
         this._direction = param4;
         this._midpoint = param5;
         this._endpoint = param6;
         this._scaleFactor01 = param7;
         this._scaleFactor02 = param8;
         this.scale = 1;
         this.isEnemy = false;
         this.isAerial = false;
         this.scaleX = 1;
         this.scaleY = 1;
         this.rotation = Calc.random(0,360);
      }
      
      public function pause() : void
      {
      }
      
      public function unpause() : void
      {
      }
      
      public function get a() : Number
      {
         return this._a;
      }
      
      public function get b() : Number
      {
         return this._b;
      }
      
      public function get c() : Number
      {
         return this._c;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get midpoint() : int
      {
         return this._midpoint;
      }
      
      public function get endpoint() : int
      {
         return this._endpoint;
      }
      
      public function get scaleFactor01() : Number
      {
         return this._scaleFactor01;
      }
      
      public function get scaleFactor02() : Number
      {
         return this._scaleFactor02;
      }
      
      public function get damage() : int
      {
         return 200;
      }
   }
}


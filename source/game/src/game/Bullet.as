package src.game
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Bullet extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _image:AnimatedSprite;
      
      private var _direction:int;
      
      private var _damage:int;
      
      public var isEnemy:Boolean;
      
      public var isAerial:Boolean;
      
      public var moveVector:Point;
      
      public function Bullet(param1:int, param2:int, param3:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._image = new AnimatedSprite(this._imageManager.getImage("bullets"),35,18,4);
         var _loc4_:int = 1;
         while(_loc4_ < 5)
         {
            this._image.addSequence(String(_loc4_),_loc4_,_loc4_,0,0);
            _loc4_++;
         }
         if(param2 == -1)
         {
            this._image.flippedX = true;
         }
         this._image.gotoAndStop(String(param1));
         this._image.x = -(this._image.width / 2);
         this._image.y = -(this._image.height / 2);
         this.addChild(this._image);
         this._direction = param2;
         this._damage = param3;
         this.isEnemy = false;
         this.isAerial = false;
      }
      
      public function reset(param1:int, param2:int, param3:int) : void
      {
         this._direction = param2;
         this._damage = param3;
         this.isEnemy = false;
         this.isAerial = false;
         this.rotation = 0;
         this._image.gotoAndStop(String(param1));
         if(this._direction == 1)
         {
            this._image.flippedX = false;
         }
         else if(this._direction == -1)
         {
            this._image.flippedX = true;
         }
      }
      
      public function pause() : void
      {
      }
      
      public function unpause() : void
      {
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get damage() : int
      {
         return this._damage;
      }
   }
}


package src.game
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class Flame extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _image:AnimatedSprite;
      
      private var _direction:int;
      
      private var _damage:int;
      
      public var isEnemy:Boolean;
      
      public var isAerial:Boolean;
      
      public function Flame(param1:int, param2:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._image = new AnimatedSprite(this._imageManager.getImage("flamethrower"),164,152,15);
         this._image.addSequence("IDLE",1,15,3,0,1,"FINISHED");
         this._image.addSequence("FINISHED",15,15,0,0);
         this._image.gotoAndPlay("IDLE");
         this._image.y = -(this._image.height / 2);
         this.addChild(this._image);
         this._direction = param1;
         this._damage = param2;
         this.isEnemy = false;
         this.isAerial = false;
         if(this._direction == 1)
         {
            this._image.flippedX = false;
         }
         else if(this._direction == -1)
         {
            this._image.flippedX = true;
         }
      }
      
      public function reset(param1:int, param2:int) : void
      {
         this._direction = param1;
         this._damage = param2;
         this.isEnemy = false;
         this.isAerial = false;
         this._image.gotoAndPlay("IDLE");
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
         this._image.pause();
      }
      
      public function unpause() : void
      {
         this._image.resume();
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get damage() : int
      {
         return this._damage;
      }
      
      public function get isFinished() : Boolean
      {
         return this._image.sequence == "FINISHED";
      }
   }
}


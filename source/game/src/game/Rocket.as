package src.game
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Rocket extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _rocket01:AnimatedSprite;
      
      private var _rocket02:AnimatedSprite;
      
      private var _direction:int;
      
      private var _damage:int;
      
      public var isEnemy:Boolean;
      
      public var isAerial:Boolean;
      
      public var moveVector:Point;
      
      public function Rocket(param1:int, param2:int, param3:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._rocket01 = new AnimatedSprite(this._imageManager.getImage("rocket_01"),50,14,2);
         this._rocket01.addSequence("IDLE",1,2,3);
         this._rocket01.gotoAndPlay("IDLE");
         this._rocket01.x = -(this._rocket01.width / 2);
         this._rocket01.y = -(this._rocket01.height / 2);
         this.addChild(this._rocket01);
         this._rocket02 = new AnimatedSprite(this._imageManager.getImage("rocket_02"),45,12,2);
         this._rocket02.addSequence("IDLE",1,2,3);
         this._rocket02.gotoAndPlay("IDLE");
         this._rocket02.x = -(this._rocket02.width / 2);
         this._rocket02.y = -(this._rocket02.height / 2);
         this.addChild(this._rocket02);
         if(param1 == 5)
         {
            this._rocket01.visible = true;
            this._rocket02.visible = false;
         }
         else if(param1 == 6)
         {
            this._rocket01.visible = false;
            this._rocket02.visible = true;
         }
         this._direction = param2;
         this._damage = param3;
         this.isEnemy = false;
         this.isAerial = false;
         if(this._direction == 1)
         {
            this._rocket01.flippedX = false;
            this._rocket02.flippedX = false;
         }
         else if(this._direction == -1)
         {
            this._rocket01.flippedX = true;
            this._rocket02.flippedX = true;
         }
      }
      
      public function reset(param1:int, param2:int, param3:int) : void
      {
         this._direction = param2;
         this._damage = param3;
         this.isEnemy = false;
         this.isAerial = false;
         this.rotation = 0;
         if(param1 == 5)
         {
            this._rocket01.visible = true;
            this._rocket02.visible = false;
         }
         else if(param1 == 6)
         {
            this._rocket01.visible = false;
            this._rocket02.visible = true;
         }
         if(this._direction == 1)
         {
            this._rocket01.flippedX = false;
            this._rocket02.flippedX = false;
         }
         else if(this._direction == -1)
         {
            this._rocket01.flippedX = true;
            this._rocket02.flippedX = true;
         }
      }
      
      public function pause() : void
      {
         this._rocket01.pause();
         this._rocket02.pause();
      }
      
      public function unpause() : void
      {
         this._rocket01.resume();
         this._rocket02.resume();
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


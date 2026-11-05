package src.game
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import src.data.EnemyData;
   
   public class Enemy extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      public var isAttacking:Boolean;
      
      public var shotFired:Boolean;
      
      public var direction:int;
      
      private var _health:int;
      
      private var _totalHealth:int;
      
      private var _isDead:Boolean;
      
      private var _offset:int;
      
      private var _x:int;
      
      private var _healthBar:HealthBar;
      
      private var _image:AnimatedSprite;
      
      private var _data:EnemyData;
      
      public var gravity:int;
      
      public var hoverCounter:int;
      
      public var hoverDirection:int;
      
      public function Enemy(param1:EnemyData, param2:int, param3:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._data = param1;
         this.isAttacking = false;
         this.shotFired = false;
         this.direction = param2;
         this._health = this._totalHealth = this._data.health;
         this._isDead = false;
         this._offset = (Calc.random(0,4) - 2) * 5;
         this.gravity = 0;
         this.hoverCounter = 0;
         this.hoverDirection = Calc.random(0,1);
         switch(param3)
         {
            case 0:
               this._health = this._totalHealth = this._data.health;
               break;
            case 1:
               this._health = this._totalHealth = Math.ceil(this._data.health * 1.5);
               break;
            case 2:
               this._health = this._totalHealth = this._data.health * 2;
         }
         if(this.hoverDirection == 0)
         {
            this.hoverDirection = -1;
         }
         this.InitializeImage();
      }
      
      private function InitializeImage() : void
      {
         this._image = new AnimatedSprite(this._imageManager.getImage(this._data.image),this._data.width,this._data.height,this._data.frames);
         if(this.direction == 1)
         {
            this._image.x = -this._data.xPosition - this._data.boundsWidth / 2;
            this._x = this._data.xPosition + this._image.x;
         }
         else
         {
            this._image.x = -(this._image.width - this._data.xPosition - this._data.boundsWidth) - this._data.boundsWidth / 2;
            this._x = this._image.width - this._data.xPosition - this._data.boundsWidth + this._image.x;
         }
         this._image.y = -this._image.height;
         var _loc1_:int = 0;
         while(_loc1_ < this._data.animations.length)
         {
            this._image.addSequence(this._data.animations[_loc1_].name,this._data.animations[_loc1_].startFrame,this._data.animations[_loc1_].endFrame,this._data.animations[_loc1_].delay,this._data.animations[_loc1_].loops,this._data.animations[_loc1_].direction,this._data.animations[_loc1_].nextSequence);
            _loc1_++;
         }
         if(this.direction == -1)
         {
            this._image.flippedX = true;
         }
         this._image.gotoAndPlay("RUN");
         this.addChild(this._image);
         this.graphics.beginFill(65535);
         this.graphics.endFill();
         this._healthBar = new HealthBar();
         this._healthBar.x = -(this._healthBar.width / 2);
         if(this._data.isAir)
         {
            this._healthBar.y = this._image.y + this._data.boundsHeight + 14;
         }
         else
         {
            this._healthBar.y = this._image.y - this._healthBar.height - 16;
         }
         this.addChild(this._healthBar);
         this.allowMouseOver = true;
      }
      
      public function takeDamage(param1:int) : void
      {
         this._health -= param1;
         if(this._health <= 0)
         {
            this._health = 0;
            this._isDead = true;
            this.allowMouseOver = false;
            this.hideHealthBar(null);
         }
         else if(this._health > this._totalHealth)
         {
            this._health = this._totalHealth;
         }
         this._healthBar.update(Math.ceil(this._health / this._totalHealth * 100));
      }
      
      public function destroy() : void
      {
         this._health = this._totalHealth = this._data.health;
         this._healthBar.update(100);
         this.allowMouseOver = true;
         this._image.gotoAndPlay("RUN");
      }
      
      public function reset(param1:int, param2:int) : void
      {
         this.isAttacking = false;
         this.shotFired = false;
         this.direction = param1;
         this._isDead = false;
         this._offset = (Calc.random(0,4) - 2) * 5;
         this.gravity = 0;
         this.hoverCounter = 0;
         this.hoverDirection = Calc.random(0,1);
         if(this.hoverDirection == 0)
         {
            this.hoverDirection = -1;
         }
         this._image.flippedX = false;
         this.alpha = 1;
         if(this.direction == 1)
         {
            this._image.x = -this._data.xPosition - this._data.boundsWidth / 2;
            this._x = this._data.xPosition + this._image.x;
         }
         else
         {
            this._image.x = -(this._image.width - this._data.xPosition - this._data.boundsWidth) - this._data.boundsWidth / 2;
            this._x = this._image.width - this._data.xPosition - this._data.boundsWidth + this._image.x;
            this._image.flippedX = true;
         }
         switch(param2)
         {
            case 1:
               this._health = this._totalHealth = Math.ceil(this._data.health * 1.5);
               break;
            case 2:
               this._health = this._totalHealth = this._data.health * 2;
         }
         this.graphics.clear();
         this.graphics.beginFill(65535);
         this.graphics.endFill();
      }
      
      private function set allowMouseOver(param1:Boolean) : void
      {
         if(param1)
         {
            this._image.addEventListener(MouseEvent.ROLL_OVER,this.showHealthBar,false,0,true);
            this._image.addEventListener(MouseEvent.ROLL_OUT,this.hideHealthBar,false,0,true);
         }
         else
         {
            this._image.removeEventListener(MouseEvent.ROLL_OVER,this.showHealthBar);
            this._image.removeEventListener(MouseEvent.ROLL_OUT,this.hideHealthBar);
         }
      }
      
      private function showHealthBar(param1:MouseEvent) : void
      {
         this._healthBar.Show();
      }
      
      private function hideHealthBar(param1:MouseEvent) : void
      {
         this._healthBar.Hide();
      }
      
      public function pause() : void
      {
         this._image.pause();
         this.allowMouseOver = false;
      }
      
      public function unpause() : void
      {
         this._image.resume();
         if(!this._isDead)
         {
            this.allowMouseOver = true;
            this.hideHealthBar(null);
         }
      }
      
      public function get animation() : String
      {
         return this._image.sequence;
      }
      
      public function set animation(param1:String) : void
      {
         if(this._image.sequence != param1)
         {
            this._image.gotoAndPlay(param1);
         }
      }
      
      public function get data() : EnemyData
      {
         return this._data;
      }
      
      public function get range() : int
      {
         return this._data.range + this._offset;
      }
      
      public function get isDead() : Boolean
      {
         return this._isDead;
      }
      
      public function get X() : int
      {
         return this._x;
      }
      
      public function get Y() : int
      {
         return this._data.yPosition + this._image.y;
      }
      
      public function get Width() : int
      {
         return this._data.boundsWidth;
      }
      
      public function get Height() : int
      {
         return this._data.boundsHeight;
      }
   }
}


package src.game
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import src.data.AllyData;
   
   public class Ally extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      public var isAttacking:Boolean;
      
      public var shotFired:Boolean;
      
      public var direction:int;
      
      private var _image:AnimatedSprite;
      
      private var _data:AllyData;
      
      public function Ally(param1:AllyData, param2:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._data = param1;
         this.isAttacking = false;
         this.shotFired = false;
         this.direction = param2;
         this.InitializeImage();
      }
      
      private function InitializeImage() : void
      {
         this._image = new AnimatedSprite(this._imageManager.getImage(this._data.image),this._data.width,this._data.height,this._data.frames);
         this._image.addSequence("START",this._data.animations[0].startFrame,this._data.animations[0].startFrame,1,Calc.random(0,20),1,"IDLE");
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
         this._image.gotoAndPlay("START");
         this.addChild(this._image);
      }
      
      public function reset(param1:int) : void
      {
         this.isAttacking = false;
         this.shotFired = false;
         this.direction = param1;
         this._image.gotoAndPlay("START");
         if(this.direction == 1)
         {
            this._image.flippedX = false;
         }
         else
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
      
      public function get data() : AllyData
      {
         return this._data;
      }
   }
}


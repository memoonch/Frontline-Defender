package src.components.gui
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class AttackIcon extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _image:AnimatedSprite;
      
      private var _moveCounter:int;
      
      private var _direction:int;
      
      private var _counter:int;
      
      public function AttackIcon()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._image = new AnimatedSprite(this._imageManager.getImage("under_attack"),130,58,32);
         this._image.addSequence("RIGHT",1,16,1);
         this._image.addSequence("LEFT",17,32,1);
         this._image.gotoAndPlay("LEFT");
         this.addChild(this._image);
         this._moveCounter = 0;
         this._direction = 1;
         this._counter = 0;
      }
      
      public function update() : void
      {
         if(this.visible)
         {
            this._image.x += this._direction * 2;
            this._moveCounter += this._direction;
            if(this._moveCounter >= 4 || this._moveCounter <= -4)
            {
               this._direction *= -1;
            }
            ++this._counter;
            if(this._counter >= 30)
            {
               this.alpha -= 0.05;
               if(this.alpha <= 0)
               {
                  this._counter = 0;
                  this.visible = false;
                  this.alpha = 1;
               }
            }
         }
      }
      
      public function switchDirections(param1:int) : void
      {
         if(param1 == 1 && this._image.sequence != "RIGHT")
         {
            this._image.gotoAndPlay("RIGHT");
         }
         else if(param1 == -1 && this._image.sequence != "LEFT")
         {
            this._image.gotoAndPlay("LEFT");
         }
         this._counter = 0;
         this.alpha = 1;
         this.visible = true;
      }
      
      public function pause() : void
      {
         this._image.pause();
      }
      
      public function unpause() : void
      {
         this._image.resume();
      }
      
      public function get direction() : String
      {
         return this._image.sequence;
      }
   }
}


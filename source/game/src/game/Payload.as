package src.game
{
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class Payload extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _image:Sprite;
      
      private var _target:int;
      
      private var _counter:int;
      
      public var destroyed:Boolean;
      
      public var shadow:Shadow;
      
      public function Payload(param1:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._image = new Sprite();
         this._image.addChild(this._imageManager.getImage("payload"));
         this._image.x = -(this._image.width / 2);
         this._image.y = -this._image.height;
         this.addChild(this._image);
         this._target = param1;
         this.destroyed = false;
         this._counter = 0;
         this.rotation = -30;
         this.shadow = new Shadow();
      }
      
      public function reset(param1:int) : void
      {
         this._target = param1;
         this.destroyed = false;
         this._counter = 0;
         this.rotation = -30;
         this.shadow.reset();
      }
      
      public function get isFinished() : Boolean
      {
         ++this._counter;
         if(this._counter >= 3)
         {
            return true;
         }
         return false;
      }
      
      public function get target() : int
      {
         return this._target;
      }
   }
}


package src.components.gui
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class MinimapIcon extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _icon:AnimatedSprite;
      
      public function MinimapIcon()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._icon = new AnimatedSprite(this._imageManager.getImage("minimap_icons"),17,12,4);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._icon.addSequence(String(_loc1_),_loc1_ + 1,_loc1_ + 1,0,0);
            _loc1_++;
         }
         this._icon.gotoAndStop("0");
         this._icon.x = -(this._icon.width / 2);
         this._icon.y = -this._icon.height;
         this.addChild(this._icon);
      }
      
      public function setIcon(param1:int) : void
      {
         this._icon.gotoAndStop(String(param1));
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 == 1)
         {
            this._icon.flippedX = false;
         }
         else if(param1 == -1)
         {
            this._icon.flippedX = true;
         }
      }
      
      public function get type() : int
      {
         return int(this._icon.sequence);
      }
   }
}


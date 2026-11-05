package src.components.gui
{
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class HealthDisplay extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _barLeft:Sprite;
      
      private var _barMiddle:Sprite;
      
      private var _barRight:Sprite;
      
      private var _fill:Sprite;
      
      public function HealthDisplay()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this.InitializeBar();
      }
      
      private function InitializeBar() : void
      {
         this._barLeft = new Sprite();
         this._barLeft.addChild(this._imageManager.getImage("health_bar_left"));
         this.addChild(this._barLeft);
         this._barMiddle = new Sprite();
         this._barMiddle.addChild(this._imageManager.getImage("health_bar_middle"));
         this._barMiddle.x = this._barLeft.x + this._barLeft.width;
         this._barMiddle.scaleX = 50;
         this.addChild(this._barMiddle);
         this._barRight = new Sprite();
         this._barRight.addChild(this._imageManager.getImage("health_bar_right"));
         this._barRight.x = this._barMiddle.x + this._barMiddle.width;
         this.addChild(this._barRight);
         this._fill = new Sprite();
         this._fill.addChild(this._imageManager.getImage("health_fill"));
         this._fill.x = this._barMiddle.x;
         this._fill.y = 5;
         this._fill.scaleX = 50;
         this.addChild(this._fill);
      }
      
      public function updateHealth(param1:int) : void
      {
         this._fill.scaleX = Math.ceil(param1 / 2);
      }
      
      public function updateTotalHealth(param1:int) : void
      {
         this._barMiddle.scaleX = Math.ceil(param1 / 2);
         this._barRight.x = this._barMiddle.x + this._barMiddle.width;
      }
   }
}


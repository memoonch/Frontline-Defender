package src.components.gui
{
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class GrenadeDisplay extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _plate:Sprite;
      
      private var _grenadeText:Sprite;
      
      private var _missileText:Sprite;
      
      public function GrenadeDisplay()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this.InitializePlate();
         this.InitializeText();
      }
      
      private function InitializePlate() : void
      {
         this._plate = new Sprite();
         this._plate.addChild(this._imageManager.getImage("grenade_plate"));
         this.addChild(this._plate);
      }
      
      private function InitializeText() : void
      {
         this._grenadeText = this._fontManager.getString("0","GUI_DIGITS",0);
         this._grenadeText.x = 4;
         this._grenadeText.y = 3;
         this.addChild(this._grenadeText);
         this._missileText = this._fontManager.getString("0","GUI_DIGITS",0);
         this._missileText.x = 28;
         this._missileText.y = 3;
         this.addChild(this._missileText);
      }
      
      public function updateGrenades(param1:int) : void
      {
         if(this._grenadeText != null && this.contains(this._grenadeText))
         {
            this.removeChild(this._grenadeText);
         }
         this._grenadeText = this._fontManager.getString(String(param1),"GUI_DIGITS",0);
         this._grenadeText.x = 4;
         this._grenadeText.y = 3;
         this.addChild(this._grenadeText);
      }
      
      public function updateMissiles(param1:int) : void
      {
         if(this._missileText != null && this.contains(this._missileText))
         {
            this.removeChild(this._missileText);
         }
         this._missileText = this._fontManager.getString(String(param1),"GUI_DIGITS",0);
         this._missileText.x = 28;
         this._missileText.y = 3;
         this.addChild(this._missileText);
      }
   }
}


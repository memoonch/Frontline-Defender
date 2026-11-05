package src.components.gui
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class WeaponDisplay extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _plate:AnimatedSprite;
      
      private var _clipAmmo:Sprite;
      
      private var _totalAmmo:Sprite;
      
      private var _slash:Sprite;
      
      private var _container:Sprite;
      
      private const OFFSET:Array = new Array(43,20,15,6,20,24,29,0,21);
      
      public function WeaponDisplay()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this.InitializePlate();
         this.InitializeText();
      }
      
      private function InitializePlate() : void
      {
         this._container = new Sprite();
         this._container.x = this.OFFSET[0];
         this.addChild(this._container);
         this._plate = new AnimatedSprite(this._imageManager.getImage("guns_plate"),118,21,9);
         this._plate.addSequence("PISTOL",1,1,0,0);
         this._plate.addSequence("SMG",2,2,0,0);
         this._plate.addSequence("SHOTGUN",3,3,0,0);
         this._plate.addSequence("ASSAULT_RIFLE",4,4,0,0);
         this._plate.addSequence("SNIPER",5,5,0,0);
         this._plate.addSequence("RPG",6,6,0,0);
         this._plate.addSequence("RAILGUN",7,7,0,0);
         this._plate.addSequence("CHAINGUN",8,8,0,0);
         this._plate.addSequence("PHOTON_CANNON",9,9,0,0);
         this._plate.gotoAndStop("PISTOL");
         this._container.addChild(this._plate);
      }
      
      private function InitializeText() : void
      {
         this._clipAmmo = this._fontManager.getString("12","GUI_DIGITS",0);
         this._clipAmmo.x = 5;
         this._clipAmmo.y = 5;
         this._container.addChild(this._clipAmmo);
         this._slash = new Sprite();
         this._slash.addChild(this._imageManager.getImage("font_gui_slash"));
         this._slash.x = this._clipAmmo.x + this._clipAmmo.width + 2;
         this._slash.y = 3;
         this._container.addChild(this._slash);
         this._totalAmmo = this._fontManager.getString("--","GUI_DIGITS",0);
         this._totalAmmo.x = this._slash.x + this._slash.width + 2;
         this._totalAmmo.y = 5;
         this._container.addChild(this._totalAmmo);
      }
      
      public function updateClipAmmo(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(this._clipAmmo != null && this._container.contains(this._clipAmmo))
         {
            this._container.removeChild(this._clipAmmo);
         }
         this._clipAmmo = this._fontManager.getString(String(param1),"GUI_DIGITS",0);
         this._clipAmmo.x = 5;
         this._clipAmmo.y = 5;
         this._container.addChild(this._clipAmmo);
         if(param3 && param1 < 100)
         {
            this._clipAmmo.x += 8;
         }
         if(param1 < 10 && param2)
         {
            this._clipAmmo.x += 8;
         }
         this._slash.x = this._clipAmmo.x + this._clipAmmo.width + 2;
         this._totalAmmo.x = this._slash.x + this._slash.width + 2;
      }
      
      public function updateTotalAmmo(param1:int) : void
      {
         if(this._totalAmmo != null && this._container.contains(this._totalAmmo))
         {
            this._container.removeChild(this._totalAmmo);
         }
         if(param1 == -1)
         {
            this._totalAmmo = this._fontManager.getString("--","GUI_DIGITS",0);
         }
         else
         {
            this._totalAmmo = this._fontManager.getString(String(param1),"GUI_DIGITS",0);
         }
         this._totalAmmo.x = this._slash.x + this._slash.width + 2;
         this._totalAmmo.y = 5;
         this._container.addChild(this._totalAmmo);
      }
      
      public function changeWeapon(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this._plate.gotoAndStop("PISTOL");
               break;
            case 1:
               this._plate.gotoAndStop("SMG");
               break;
            case 2:
               this._plate.gotoAndStop("SHOTGUN");
               break;
            case 3:
               this._plate.gotoAndStop("ASSAULT_RIFLE");
               break;
            case 4:
               this._plate.gotoAndStop("SNIPER");
               break;
            case 5:
               this._plate.gotoAndStop("RPG");
               break;
            case 6:
               this._plate.gotoAndStop("RAILGUN");
               break;
            case 7:
               this._plate.gotoAndStop("CHAINGUN");
               break;
            case 8:
               this._plate.gotoAndStop("PHOTON_CANNON");
         }
         this._container.x = this.OFFSET[param1];
      }
      
      public function reload(param1:int) : void
      {
         if(this._clipAmmo != null && this._container.contains(this._clipAmmo))
         {
            this._container.removeChild(this._clipAmmo);
         }
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = String(_loc2_ + "-");
            _loc3_++;
         }
         this._clipAmmo = this._fontManager.getString(_loc2_,"GUI_DIGITS",0);
         this._clipAmmo.x = this._slash.x - this._clipAmmo.width - 2;
         this._clipAmmo.y = 5;
         this._container.addChild(this._clipAmmo);
      }
   }
}


package src.game
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   
   public class Crosshair extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _topSegment:AnimatedSprite;
      
      private var _rightSegment:AnimatedSprite;
      
      private var _bottomSegment:AnimatedSprite;
      
      private var _leftSegment:AnimatedSprite;
      
      private var _topContainer:Sprite;
      
      private var _rightContainer:Sprite;
      
      private var _bottomContainer:Sprite;
      
      private var _leftContainer:Sprite;
      
      private var _reloadingText:AnimatedSprite;
      
      private var _noAmmoText:AnimatedSprite;
      
      private var _minimumAccuracy:int;
      
      private var _maximumAccuracy:int;
      
      private var _recoil:int;
      
      private var _recoilCounter:int;
      
      public function Crosshair()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._minimumAccuracy = 10;
         this._maximumAccuracy = 60;
         this._recoil = 10;
         this._recoilCounter = 10;
         this.InitializeCrosshair();
         this.InitializeText();
      }
      
      private function InitializeCrosshair() : void
      {
         this._topContainer = new Sprite();
         this.addChild(this._topContainer);
         this._topSegment = new AnimatedSprite(this._imageManager.getImage("crosshair"),7,13,4);
         this._topSegment.addSequence("IDLE",1,1,0,0);
         this._topSegment.addSequence("SHOOT",3,4,3);
         this._topSegment.gotoAndStop("IDLE");
         this._topSegment.x = -(this._topSegment.width / 2);
         this._topSegment.y = -this._topSegment.height - 1;
         this._topContainer.addChild(this._topSegment);
         this._rightContainer = new Sprite();
         this._rightContainer.rotation = 90;
         this.addChild(this._rightContainer);
         this._rightSegment = new AnimatedSprite(this._imageManager.getImage("crosshair"),7,13,4);
         this._rightSegment.addSequence("IDLE",1,1,0,0);
         this._rightSegment.addSequence("SHOOT",3,4,3);
         this._rightSegment.gotoAndStop("IDLE");
         this._rightSegment.x = -(this._rightSegment.width / 2);
         this._rightSegment.y = -this._rightSegment.height - 1;
         this._rightContainer.addChild(this._rightSegment);
         this._bottomContainer = new Sprite();
         this._bottomContainer.rotation = 180;
         this.addChild(this._bottomContainer);
         this._bottomSegment = new AnimatedSprite(this._imageManager.getImage("crosshair"),7,13,4);
         this._bottomSegment.addSequence("IDLE",1,1,0,0);
         this._bottomSegment.addSequence("SHOOT",3,4,3);
         this._bottomSegment.gotoAndStop("IDLE");
         this._bottomSegment.x = -(this._bottomSegment.width / 2);
         this._bottomSegment.y = -this._bottomSegment.height - 1;
         this._bottomContainer.addChild(this._bottomSegment);
         this._leftContainer = new Sprite();
         this._leftContainer.rotation = 270;
         this.addChild(this._leftContainer);
         this._leftSegment = new AnimatedSprite(this._imageManager.getImage("crosshair"),7,13,4);
         this._leftSegment.addSequence("IDLE",1,1,0,0);
         this._leftSegment.addSequence("SHOOT",3,4,3);
         this._leftSegment.gotoAndStop("IDLE");
         this._leftSegment.x = -(this._leftSegment.width / 2);
         this._leftSegment.y = -this._leftSegment.height - 1;
         this._leftContainer.addChild(this._leftSegment);
         this._topContainer.y = -this._recoilCounter;
         this._rightContainer.x = this._recoilCounter;
         this._bottomContainer.y = this._recoilCounter;
         this._leftContainer.x = -this._recoilCounter;
      }
      
      private function InitializeText() : void
      {
         this._reloadingText = new AnimatedSprite(this._imageManager.getImage("reloading_text"),103,12,4);
         this._reloadingText.addSequence("IDLE",1,4,4);
         this._reloadingText.gotoAndStop("IDLE");
         this._reloadingText.x = -(this._reloadingText.width / 2);
         this._reloadingText.visible = false;
         this.addChild(this._reloadingText);
         this._noAmmoText = new AnimatedSprite(this._imageManager.getImage("no_ammo_text"),86,12,4);
         this._noAmmoText.addSequence("IDLE",1,4,4);
         this._noAmmoText.gotoAndStop("IDLE");
         this._noAmmoText.x = -(this._noAmmoText.width / 2);
         this._noAmmoText.visible = false;
         this.addChild(this._noAmmoText);
      }
      
      public function update() : void
      {
         --this._recoilCounter;
         if(this._recoilCounter <= this._minimumAccuracy)
         {
            this._recoilCounter = this._minimumAccuracy;
         }
         this._topContainer.y = -this._recoilCounter;
         this._rightContainer.x = this._recoilCounter;
         this._bottomContainer.y = this._recoilCounter;
         this._leftContainer.x = -this._recoilCounter;
      }
      
      public function startShooting() : void
      {
         if(this._topSegment.sequence != "SHOOT")
         {
            this._topSegment.gotoAndPlay("SHOOT");
            this._rightSegment.gotoAndPlay("SHOOT");
            this._bottomSegment.gotoAndPlay("SHOOT");
            this._leftSegment.gotoAndPlay("SHOOT");
         }
      }
      
      public function stopShooting() : void
      {
         if(this._topSegment.sequence != "IDLE")
         {
            this._topSegment.gotoAndStop("IDLE");
            this._rightSegment.gotoAndStop("IDLE");
            this._bottomSegment.gotoAndStop("IDLE");
            this._leftSegment.gotoAndStop("IDLE");
         }
      }
      
      public function showReload() : void
      {
         if(!this._reloadingText.visible)
         {
            this._reloadingText.gotoAndPlay("IDLE");
            this._reloadingText.visible = true;
         }
      }
      
      public function hideReload() : void
      {
         if(this._reloadingText.visible)
         {
            this._reloadingText.stop();
            this._reloadingText.visible = false;
         }
      }
      
      public function recoil() : void
      {
         this._recoilCounter += this._recoil;
         if(this._recoilCounter >= this._maximumAccuracy)
         {
            this._recoilCounter = this._maximumAccuracy;
         }
         this._topContainer.y = -this._recoilCounter;
         this._rightContainer.x = this._recoilCounter;
         this._bottomContainer.y = this._recoilCounter;
         this._leftContainer.x = -this._recoilCounter;
         this._reloadingText.y = -50;
         this._noAmmoText.y = -50;
      }
      
      public function changeWeapon(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         this._minimumAccuracy = param1;
         this._maximumAccuracy = param2;
         this._recoil = param3;
         this._recoilCounter = this._minimumAccuracy;
         this._topContainer.y = -this._recoilCounter;
         this._rightContainer.x = this._recoilCounter;
         this._bottomContainer.y = this._recoilCounter;
         this._leftContainer.x = -this._recoilCounter;
         if(param4)
         {
            this._noAmmoText.gotoAndPlay("IDLE");
            this._noAmmoText.visible = true;
         }
         else
         {
            this._noAmmoText.gotoAndStop("IDLE");
            this._noAmmoText.visible = false;
         }
      }
      
      public function get radius() : int
      {
         return this._recoilCounter;
      }
   }
}


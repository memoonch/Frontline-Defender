package src.components
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import src.components.gui.GrenadeDisplay;
   import src.components.gui.HealthDisplay;
   import src.components.gui.Minimap;
   import src.components.gui.Options;
   import src.components.gui.ScoreDisplay;
   import src.components.gui.WeaponDisplay;
   
   public class GUI extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _healthDisplay:HealthDisplay;
      
      private var _weaponDisplay:WeaponDisplay;
      
      private var _grenadeDisplay:GrenadeDisplay;
      
      private var _scoreDisplay:ScoreDisplay;
      
      private var _minimap:Minimap;
      
      private var _optionsMenu:Options;
      
      public function GUI()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this.InitializeDisplay();
      }
      
      private function InitializeDisplay() : void
      {
         this._healthDisplay = new HealthDisplay();
         this._healthDisplay.x = 12;
         this._healthDisplay.y = 434;
         this.addChild(this._healthDisplay);
         this._weaponDisplay = new WeaponDisplay();
         this._weaponDisplay.x = 354;
         this._weaponDisplay.y = 434;
         this.addChild(this._weaponDisplay);
         this._grenadeDisplay = new GrenadeDisplay();
         this._grenadeDisplay.x = 536;
         this._grenadeDisplay.y = 434;
         this.addChild(this._grenadeDisplay);
         this._scoreDisplay = new ScoreDisplay();
         this._scoreDisplay.x = 190;
         this._scoreDisplay.y = 8;
         this.addChild(this._scoreDisplay);
         this._minimap = new Minimap();
         this._minimap.x = Calc.center(Window.width,this._minimap.width);
         this._minimap.y = 39; this._minimap.scaleY=0.72;
         this.addChild(this._minimap);
         this._optionsMenu = new Options();
         this._optionsMenu.addEventListener(GameEvent.CONFIRM,this.optionsMenuEvents,false,0,true);
         this._optionsMenu.addEventListener(GameEvent.PAUSE,this.optionsMenuEvents,false,0,true);
         this._optionsMenu.addEventListener(GameEvent.RESUME,this.optionsMenuEvents,false,0,true);
         this.addChild(this._optionsMenu);
      }
      
      public function updateHealth(param1:int) : void
      {
         this._healthDisplay.updateHealth(param1);
      }
      
      public function updateTotalHealth(param1:int) : void
      {
         this._healthDisplay.updateTotalHealth(param1);
      }
      
      public function updateScore(param1:Number) : void
      {
         this._scoreDisplay.updateScore(param1);
      }
      
      public function updateWave(param1:int) : void
      {
         this._scoreDisplay.updateWave(param1);
      }
      
      public function updateClipAmmo(param1:int, param2:Boolean, param3:Boolean) : void
      {
         this._weaponDisplay.updateClipAmmo(param1,param2,param3);
      }
      
      public function updateTotalAmmo(param1:int) : void
      {
         this._weaponDisplay.updateTotalAmmo(param1);
      }
      
      public function reload(param1:*) : void
      {
         this._weaponDisplay.reload(param1);
      }
      
      public function changeWeapon(param1:int) : void
      {
         this._weaponDisplay.changeWeapon(param1);
      }
      
      public function updateGrenades(param1:int) : void
      {
         this._grenadeDisplay.updateGrenades(param1);
      }
      
      public function updateMissiles(param1:int) : void
      {
         this._grenadeDisplay.updateMissiles(param1);
      }
      
      public function updateFrame(param1:int) : void
      {
         this._minimap.updateFrame(param1);
      }
      
      public function updateAudio() : void
      {
         this._optionsMenu.updateAudio();
      }
      
      public function drawMinimapObject(param1:int, param2:int, param3:int, param4:int) : void
      {
         this._minimap.drawObject(param1,param2,param3,param4);
      }
      
      public function clearMinimap() : void
      {
         this._minimap.clear();
      }
      
      public function sortMinimap() : void
      {
         this._minimap.sort();
      }
      
      private function optionsMenuEvents(param1:GameEvent) : void
      {
         if(param1.type == GameEvent.PAUSE)
         {
            this._optionsMenu.addEventListeners();
         }
         else
         {
            if(param1.type == GameEvent.CONFIRM)
            {
               this._optionsMenu.removeEventListener(GameEvent.CONFIRM,this.optionsMenuEvents);
               this._optionsMenu.removeEventListener(GameEvent.PAUSE,this.optionsMenuEvents);
               this._optionsMenu.removeEventListener(GameEvent.RESUME,this.optionsMenuEvents);
            }
            this._optionsMenu.removeEventListeners();
         }
         this.dispatchEvent(param1);
      }
      
      public function toggleOptionsMenu() : void
      {
         this._optionsMenu.toggleOptionsMenu();
      }
      
      public function pause() : void
      {
         this._scoreDisplay.pause();
      }
      
      public function unpause() : void
      {
         this._scoreDisplay.unpause();
      }
   }
}


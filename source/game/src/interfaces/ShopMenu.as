package src.interfaces
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Matrix;import flash.geom.Point;
   import flash.events.Event;import flash.events.MouseEvent; import flash.text.TextField; import flash.text.TextFormat; import flash.text.TextFieldAutoSize;
   import src.Main;
   import src.components.gui.Options;
   import src.data.ShopTroopData;
   import src.data.WeaponData;
   import src.interfaces.components.Menu;
   import src.interfaces.components.RepairBar;
   import src.interfaces.components.TroopSelection;
   import src.managers.*;
   
   public class ShopMenu extends Menu
   {
      
      private var _imageManager:ImageManager = ImageManager.getInstance();
      
      private var _fontManager:FontManager = FontManager.getInstance();
      
      private var _propManager:PropManager = PropManager.getInstance();
      
      private var _soundManager:NewSoundManager = NewSoundManager.getInstance();
      
      private var _playButton:CustomButton;
      
      
      private var _options:Options;
      
      private var _pmoney:Number;
      
      private var _activeWeapon:int;
      
      private var _activeTroop:int;
      
      private var _activeUpgrade:int;
      
      private var _grenades:int;
      
      private var _payloads:int;
      
      private var _weaponIcon:AnimatedSprite;
      
      private var _classified:Sprite;
      
      public var weaponData:WeaponData;
      
      private var _weaponStats:Object;
      
      private var _shopStats:Array;
      
      private var _pistolButton:CustomButton;
      
      private var _smgButton:CustomButton;
      
      private var _shotgunButton:CustomButton;
      
      private var _assaultRifleButton:CustomButton;
      
      private var _sniperButton:CustomButton;
      
      private var _rpgButton:CustomButton;
      
      private var _railgunButton:CustomButton;
      
      private var _chaingunButton:CustomButton;
      
      private var _photonCannonButton:CustomButton;
      
      private var _grenadeButton:CustomButton;
      
      private var _payloadButton:CustomButton;
      
      private var _arsenalBuyButton:CustomButton;
      
      private var _arsenalUpgradeButton:CustomButton;
      
      private var _pistolText:Sprite;
      
      private var _smgText:Sprite;
      
      private var _shotgunText:Sprite;
      
      private var _assaultRifleText:Sprite;
      
      private var _sniperText:Sprite;
      
      private var _rpgText:Sprite;
      
      private var _railgunText:Sprite;
      
      private var _chaingunText:Sprite;
      
      private var _photonCannonText:Sprite;
      
      private var _grenadeText:Sprite;
      
      private var _payloadText:Sprite;
      
      private var _powerText:Sprite;
      
      private var _accuracyText:Sprite;
      
      private var _clipText:Sprite;
      
      private var _ammoText:Sprite;
      
      private var _stockText:Sprite;
      
      private var _arsenalCostText:Sprite;
      
      private var _weaponNameText:Sprite;
      
      private var _levelText:Sprite;
      
      private var _troopIcons:Array;
      
      private var _topSecret:Sprite;
      
      public var troopData:ShopTroopData;
      
      private var _shopTroops:Array;
      
      private var _troopStocks:Array;
      
      private var _quickDrawButton:CustomButton;
      
      private var _gungHoButton:CustomButton;
      
      private var _buckshotButton:CustomButton;
      
      private var _eagleEyeButton:CustomButton;
      
      private var _heavyArmsButton:CustomButton;
      
      private var _bbqueButton:CustomButton;
      
      private var _troopBuyButton:CustomButton;
      
      private var _quickDrawText:Sprite;
      
      private var _gungHoText:Sprite;
      
      private var _buckshotText:Sprite;
      
      private var _eagleEyeText:Sprite;
      
      private var _heavyArmsText:Sprite;
      
      private var _bbqueText:Sprite;
      
      private var _damageText:Sprite;
      
      private var _rateOfFireText:Sprite;
      
      private var _troopStockText:Sprite;
      
      private var _troopCostText:Sprite;
      
      private var _wallIcon:AnimatedSprite;
      
      private var _troopSelection:TroopSelection;
      
      private var _repairBar:RepairBar;
      private var upgradeSummary:Sprite;private var repairAction:Sprite;private var upgradeAction:Sprite;private var weaponActionText:Sprite;private var repairPriceText:Sprite;private var upgradePriceText:Sprite;
      private var _arsenalMax:Sprite;private var _wallMax:Sprite;private var _repairFull:Sprite;
      private var _repairHealthLabel:Sprite; private var _repairLabelValue:String="";
      
      private var _wallLevel:int;
      
      private var _wallHealth:int;
      
      private var _wallPrice:int;
      
      private var _wallUpgradeButton:CustomButton;
      
      private var _wallBuyButton:CustomButton;
      
      private var _wallCostText:Sprite;
      
      private var _upgradeText:Sprite;
      
      private var _wallLevelText:Sprite;
      
      private var _waveText:Sprite;
      
      private var _victoryText:Sprite;
      
      private var _scoreText:Sprite;
      
      private var _moneyText:Sprite;
      
      private var _soldierText:Sprite;
      
      private var _vehicleText:Sprite;
      
      private var _healthText:Sprite;
      
      private var _totalScoreText:Sprite;
      
      private var _totalMoneyText:Sprite;
      
      public function ShopMenu()
      {
         super(shopBackground());
         this.InitializeButtons();
         this.InitializeArsenal();
         this.InitializeTroops();
         this.InitializeWall();
         this.InitializeStats();
         _background.x=8; _background.y=8; _background.scaleX=624/509; _background.scaleY=464/441;
         this._options = new Options();
         this._options.visible = false;
         this.addChild(this._options);
         this._money = 0;
         this._activeWeapon = -1;
         this._activeTroop = -1;
         this._activeUpgrade = -1;
         this._wallLevel = 0;
         this._grenades = 0;
         this._payloads = 0;
         this.weaponData = new WeaponData();
         this._shopStats = new Array();
         this._shopTroops = new Array();
         this._troopStocks = new Array();
         var _loc1_:int = 0;
         while(_loc1_ <= 10)
         {
            this._shopStats.push(this._propManager.getShopWeapon(_loc1_));
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this._shopTroops.push(this._propManager.getShopTroop(_loc1_));
            this._troopStocks.push(0);
            if(_loc1_ == 0)
            {
               this._shopTroops[_loc1_].unlocked = true;
            }
            _loc1_++;
         }
         this._troopSelection.stocks = this._troopStocks;
         this._troopSelection.unlocks = new Array(true,false,false,false,false,false);
      }
      
      private function InitializeButtons() : void
      {
         this._playButton = new CustomButton(shopButton(147,46,2,"NEXT WAVE"),147,46,2);
         this._playButton.idleState = 1;
         this._playButton.overState = 2;
         this._playButton.x = _background.width - this._playButton.width - 10;
         this._playButton.y = _background.height - this._playButton.height - 5;
         _background.addChild(this._playButton);
      }
      
      private function InitializeArsenal() : void
      {
         this._pistolButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._pistolButton.idleState = 1;
         this._pistolButton.overState = 2;
         this._pistolButton.disabledState = 3;
         this._pistolButton.enabled = true;
         this._pistolButton.x = 18;
         this._pistolButton.y = 92;
         _background.addChild(this._pistolButton);
         this._smgButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._smgButton.idleState = 1;
         this._smgButton.overState = 2;
         this._smgButton.disabledState = 3;
         this._smgButton.enabled = true;
         this._smgButton.x = this._pistolButton.x;
         this._smgButton.y = this._pistolButton.y + this._pistolButton.height + 1;
         _background.addChild(this._smgButton);
         this._shotgunButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._shotgunButton.idleState = 1;
         this._shotgunButton.overState = 2;
         this._shotgunButton.disabledState = 3;
         this._shotgunButton.enabled = true;
         this._shotgunButton.x = this._smgButton.x;
         this._shotgunButton.y = this._smgButton.y + this._smgButton.height + 1;
         _background.addChild(this._shotgunButton);
         this._assaultRifleButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._assaultRifleButton.idleState = 1;
         this._assaultRifleButton.overState = 2;
         this._assaultRifleButton.disabledState = 3;
         this._assaultRifleButton.enabled = true;
         this._assaultRifleButton.x = this._shotgunButton.x;
         this._assaultRifleButton.y = this._shotgunButton.y + this._shotgunButton.height + 1;
         _background.addChild(this._assaultRifleButton);
         this._sniperButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._sniperButton.idleState = 1;
         this._sniperButton.overState = 2;
         this._sniperButton.disabledState = 3;
         this._sniperButton.enabled = true;
         this._sniperButton.x = this._assaultRifleButton.x;
         this._sniperButton.y = this._assaultRifleButton.y + this._assaultRifleButton.height + 1;
         _background.addChild(this._sniperButton);
         this._rpgButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._rpgButton.idleState = 1;
         this._rpgButton.overState = 2;
         this._rpgButton.disabledState = 3;
         this._rpgButton.enabled = true;
         this._rpgButton.x = this._sniperButton.x;
         this._rpgButton.y = this._sniperButton.y + this._sniperButton.height + 1;
         _background.addChild(this._rpgButton);
         this._railgunButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._railgunButton.idleState = 1;
         this._railgunButton.overState = 2;
         this._railgunButton.disabledState = 3;
         this._railgunButton.enabled = true;
         this._railgunButton.x = this._rpgButton.x;
         this._railgunButton.y = this._rpgButton.y + this._rpgButton.height + 1;
         _background.addChild(this._railgunButton);
         this._chaingunButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._chaingunButton.idleState = 1;
         this._chaingunButton.overState = 2;
         this._chaingunButton.disabledState = 3;
         this._chaingunButton.enabled = true;
         this._chaingunButton.x = this._railgunButton.x;
         this._chaingunButton.y = this._railgunButton.y + this._railgunButton.height + 1;
         _background.addChild(this._chaingunButton);
         this._photonCannonButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._photonCannonButton.idleState = 1;
         this._photonCannonButton.overState = 2;
         this._photonCannonButton.disabledState = 3;
         this._photonCannonButton.enabled = true;
         this._photonCannonButton.x = this._chaingunButton.x;
         this._photonCannonButton.y = this._chaingunButton.y + this._chaingunButton.height + 1;
         _background.addChild(this._photonCannonButton);
         this._grenadeButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._grenadeButton.idleState = 1;
         this._grenadeButton.overState = 2;
         this._grenadeButton.disabledState = 3;
         this._grenadeButton.enabled = true;
         this._grenadeButton.x = this._photonCannonButton.x;
         this._grenadeButton.y = this._photonCannonButton.y + this._photonCannonButton.height + 1;
         _background.addChild(this._grenadeButton);
         this._payloadButton = new CustomButton(shopButton(102,16,3,""),102,16,3);
         this._payloadButton.idleState = 1;
         this._payloadButton.overState = 2;
         this._payloadButton.disabledState = 3;
         this._payloadButton.enabled = true;
         this._payloadButton.x = this._grenadeButton.x;
         this._payloadButton.y = this._grenadeButton.y + this._grenadeButton.height + 1;
         _background.addChild(this._payloadButton);
         this._arsenalUpgradeButton = new CustomButton(shopButton(114,23,3,"UPGRADE"),114,23,3);
         this._arsenalUpgradeButton.idleState = 2;
         this._arsenalUpgradeButton.overState = 3;
         this._arsenalUpgradeButton.disabledState = 1;
         this._arsenalUpgradeButton.x = 127;
         this._arsenalUpgradeButton.y = 230;
         this._arsenalUpgradeButton.visible = false;
         _background.addChild(this._arsenalUpgradeButton);
         this._arsenalBuyButton = new CustomButton(shopButton(114,23,3,"BUY"),114,23,3);
         this._arsenalBuyButton.idleState = 2;
         this._arsenalBuyButton.overState = 3;
         this._arsenalBuyButton.disabledState = 1;
         this._arsenalBuyButton.x = 127;
         this._arsenalBuyButton.y = 258;
         _background.addChild(this._arsenalBuyButton);
         this._weaponIcon = new AnimatedSprite(this._imageManager.getImage("shop_arsenal_icons"),114,71,11);
         this._weaponIcon.addSequence("PISTOL",1,1,0,0);
         this._weaponIcon.addSequence("SMG",2,2,0,0);
         this._weaponIcon.addSequence("SHOTGUN",3,3,0,0);
         this._weaponIcon.addSequence("ASSAULT_RIFLE",4,4,0,0);
         this._weaponIcon.addSequence("SNIPER",5,5,0,0);
         this._weaponIcon.addSequence("RPG",6,6,0,0);
         this._weaponIcon.addSequence("RAILGUN",7,7,0,0);
         this._weaponIcon.addSequence("CHAINGUN",8,8,0,0);
         this._weaponIcon.addSequence("PHOTON_CANNON",9,9,0,0);
         this._weaponIcon.addSequence("GRENADE",10,10,0,0);
         this._weaponIcon.addSequence("PAYLOAD",11,11,0,0);
         this._weaponIcon.gotoAndStop("PISTOL");
         this._weaponIcon.x = 127;
         this._weaponIcon.y = 62;
         this._weaponIcon.visible = false;
         _background.addChild(this._weaponIcon);
         this._classified = new Sprite();
         this._classified.addChild(this._imageManager.getImage("shop_classified"));
         this._classified.scaleX=this._classified.scaleY=0.4;
         this._classified.x = 153;
         this._classified.y = 62;
         _background.addChild(this._classified);
      }
      
      private function InitializeTroops() : void
      {
         var _loc2_:AnimatedSprite = null;
         this._quickDrawButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._quickDrawButton.idleState = 1;
         this._quickDrawButton.overState = 2;
         this._quickDrawButton.disabledState = 3;
         this._quickDrawButton.enabled = true;
         this._quickDrawButton.x = 258;
         this._quickDrawButton.y = 89;
         _background.addChild(this._quickDrawButton);
         this._buckshotButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._buckshotButton.idleState = 1;
         this._buckshotButton.overState = 2;
         this._buckshotButton.disabledState = 3;
         this._buckshotButton.enabled = true;
         this._buckshotButton.x = this._quickDrawButton.x;
         this._buckshotButton.y = this._quickDrawButton.y + this._quickDrawButton.height + 1;
         _background.addChild(this._buckshotButton);
         this._gungHoButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._gungHoButton.idleState = 1;
         this._gungHoButton.overState = 2;
         this._gungHoButton.disabledState = 3;
         this._gungHoButton.enabled = true;
         this._gungHoButton.x = this._buckshotButton.x;
         this._gungHoButton.y = this._buckshotButton.y + this._buckshotButton.height + 1;
         _background.addChild(this._gungHoButton);
         this._bbqueButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._bbqueButton.idleState = 1;
         this._bbqueButton.overState = 2;
         this._bbqueButton.disabledState = 3;
         this._bbqueButton.enabled = true;
         this._bbqueButton.x = this._gungHoButton.x;
         this._bbqueButton.y = this._gungHoButton.y + this._gungHoButton.height + 1;
         _background.addChild(this._bbqueButton);
         this._eagleEyeButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._eagleEyeButton.idleState = 1;
         this._eagleEyeButton.overState = 2;
         this._eagleEyeButton.disabledState = 3;
         this._eagleEyeButton.enabled = true;
         this._eagleEyeButton.x = this._bbqueButton.x;
         this._eagleEyeButton.y = this._bbqueButton.y + this._bbqueButton.height + 1;
         _background.addChild(this._eagleEyeButton);
         this._heavyArmsButton = new CustomButton(shopButton(83,16,3,""),83,16,3);
         this._heavyArmsButton.idleState = 1;
         this._heavyArmsButton.overState = 2;
         this._heavyArmsButton.disabledState = 3;
         this._heavyArmsButton.enabled = true;
         this._heavyArmsButton.x = this._eagleEyeButton.x;
         this._heavyArmsButton.y = this._eagleEyeButton.y + this._eagleEyeButton.height + 1;
         _background.addChild(this._heavyArmsButton);
         this._troopBuyButton = new CustomButton(shopButton(42,18,3,"BUY"),42,18,3);
         this._troopBuyButton.idleState = 2;
         this._troopBuyButton.overState = 3;
         this._troopBuyButton.disabledState = 1;
         this._troopBuyButton.x = 449;
         this._troopBuyButton.y = 172;
         _background.addChild(this._troopBuyButton);
         this._troopIcons = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            switch(_loc1_)
            {
               case 0:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_pistol")),206,150,7);
                  break;
               case 1:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_assault_rifle")),256,150,8);
                  break;
               case 2:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_shotgun")),236,148,7);
                  break;
               case 3:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_sniper")),206,102,7);
                  break;
               case 4:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_rocket_launcher")),316,180,12);
                  break;
               case 5:
                  _loc2_ = new AnimatedSprite(refineTroop(this._imageManager.getImage("ally_flamethrower")),156,158,8);
            }
            _loc2_.scaleX = _loc2_.scaleY = 0.5;
            var troopBitmap:Bitmap = _loc2_.getChildAt(0) as Bitmap;
            if(troopBitmap != null) troopBitmap.smoothing = false;
            _loc2_.addSequence("IDLE",1,1,5,5,1,"IDLE2");
            _loc2_.addSequence("IDLE2",1,4,5,0,1,"IDLE");
            _loc2_.gotoAndPlay("IDLE");
            _loc2_.flippedX = true;
            _loc2_.x = 458 - _loc2_.width;
            _loc2_.y = 147 - _loc2_.height;
            _loc2_.visible = false;
            _loc2_.mouseEnabled = false;
            _loc2_.mouseChildren = false;
            this._troopIcons.push(_loc2_);
            _background.addChild(_loc2_);
            _loc1_++;
         }
         this._topSecret = new Sprite();
         var stamp:TextField = new TextField();
         stamp.defaultTextFormat = new TextFormat("Arial Black",21,0xd91c18,true);
         stamp.autoSize = TextFieldAutoSize.LEFT;
         stamp.text = "TOP SECRET";
         stamp.selectable = false;
         stamp.mouseEnabled = false;
         stamp.rotation = -15;
         stamp.y = 24;
         this._topSecret.addChild(stamp);
         this._topSecret.x = 348;
         this._topSecret.y = 77;
         _background.addChild(this._topSecret);
      }
      
      private static function refineTroop(image:Bitmap):Bitmap
      {
         var source:BitmapData = image.bitmapData;
         var result:BitmapData = new BitmapData(source.width*2,source.height*2,true,0);
         for(var y:int=0;y<source.height;y++) for(var x:int=0;x<source.width;x++)
         {
            var e:uint=source.getPixel32(x,y);
            var b:uint=source.getPixel32(x,Math.max(0,y-1));
            var d:uint=source.getPixel32(Math.max(0,x-1),y);
            var f:uint=source.getPixel32(Math.min(source.width-1,x+1),y);
            var h:uint=source.getPixel32(x,Math.min(source.height-1,y+1));
            result.setPixel32(x*2,y*2,d==b && b!=f && d!=h?d:e);
            result.setPixel32(x*2+1,y*2,b==f && b!=d && f!=h?f:e);
            result.setPixel32(x*2,y*2+1,d==h && d!=b && h!=f?d:e);
            result.setPixel32(x*2+1,y*2+1,h==f && d!=h && b!=f?f:e);
         }
         return new Bitmap(result);
      }

      private function InitializeWall() : void
      {
         this._wallUpgradeButton = new CustomButton(shopButton(51,18,3,""),51,18,3);
         this._wallUpgradeButton.idleState = 2;
         this._wallUpgradeButton.overState = 3;
         this._wallUpgradeButton.disabledState = 1;
         this._wallUpgradeButton.enabled = true;
         this._wallUpgradeButton.x = 258;
         this._wallUpgradeButton.y = 365;
         _background.addChild(this._wallUpgradeButton);
         this._wallBuyButton = new CustomButton(shopButton(42,18,3,"BUY"),42,18,3);
         this._wallBuyButton.idleState = 2;
         this._wallBuyButton.overState = 3;
         this._wallBuyButton.disabledState = 1;
         this._wallBuyButton.x = 449;
         this._wallBuyButton.y = 340;
         _background.addChild(this._wallBuyButton);
         this._upgradeText = this._fontManager.getString("UPGRADE","SHOP",1,0);
         this._upgradeText.x = Calc.center(this._wallUpgradeButton.width,this._upgradeText.width,this._wallUpgradeButton.x);
         this._upgradeText.y = Calc.center(this._wallUpgradeButton.height,this._upgradeText.height,this._wallUpgradeButton.y);
         _background.addChild(this._upgradeText);
         this._wallIcon = new AnimatedSprite(highResolutionBarricade(),940,404,3);
         this._wallIcon.addSequence("LEVEL_01",1,1,0,0);
         this._wallIcon.addSequence("LEVEL_02",2,2,0,0);
         this._wallIcon.addSequence("LEVEL_03",3,3,0,0);
         this._wallIcon.gotoAndStop("LEVEL_01");
         this._wallIcon.scaleX=0.25;this._wallIcon.scaleY=101/404;
         this._wallIcon.x = 257;
         this._wallIcon.y = 233;
         _background.addChild(this._wallIcon);
         this._troopSelection = new TroopSelection();
         this._troopSelection.x = this._wallIcon.x;
         this._troopSelection.y = this._wallIcon.y;this._troopSelection.scaleY=1;
         _background.addChild(this._troopSelection);
         this._repairBar = new RepairBar();
         this._repairBar.x = 298;
         this._repairBar.y = 340;
         _background.addChild(this._repairBar);
         this.addEventListener(Event.ENTER_FRAME,refreshRepairLabel,false,0,true);
      }
      
      private function InitializeStats() : void
      {
         this._waveText = this._fontManager.getString("0:","SHOP",1,0);
         this._waveText.x = 54;
         this._waveText.y = 326;
         _background.addChild(this._waveText);
         this._victoryText = this._fontManager.getString("COMPLETE","SHOP",1,1);
         this._victoryText.x = 235 - this._victoryText.width;
         this._victoryText.y = this._waveText.y;
         _background.addChild(this._victoryText);
         this._scoreText = this._fontManager.getString("0","SHOP",1,0);
         this._scoreText.x = 235 - this._scoreText.width;
         this._scoreText.y = this._waveText.y + this._waveText.height + 11;
         _background.addChild(this._scoreText);
         this._moneyText = this._fontManager.getString("0","SHOP",1,0);
         this._moneyText.x = 235 - this._moneyText.width;
         this._moneyText.y = this._scoreText.y + this._scoreText.height + 11;
         _background.addChild(this._moneyText);
         this._soldierText = this._fontManager.getString("0","SHOP",1,0);
         this._soldierText.x = 235 - this._soldierText.width;
         this._soldierText.y = this._moneyText.y + this._moneyText.height + 11;
         _background.addChild(this._soldierText);
         this._vehicleText = this._fontManager.getString("0","SHOP",1,0);
         this._vehicleText.x = 235 - this._vehicleText.width;
         this._vehicleText.y = this._soldierText.y + this._soldierText.height + 11;
         _background.addChild(this._vehicleText);
         this._healthText = this._fontManager.getString("0","SHOP",1,0);
         this._healthText.x = 235 - this._healthText.width;
         this._healthText.y = this._vehicleText.y + this._vehicleText.height + 11;
         _background.addChild(this._healthText);
         this._totalScoreText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
         this._totalScoreText.x = 262;
         this._totalScoreText.y = 12;
         _background.addChild(this._totalScoreText);
         this._totalMoneyText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
      }
      
      override public function addEventListeners() : void
      {
         this._playButton.enabled = true;
         this._playButton.addMouseEvents();
         this._playButton.addEventListener(GameEvent.CLICKED,this.playButtonHandler,false,0,true);
         this._pistolButton.addMouseEvents();
         this._pistolButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._smgButton.addMouseEvents();
         this._smgButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._shotgunButton.addMouseEvents();
         this._shotgunButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._assaultRifleButton.addMouseEvents();
         this._assaultRifleButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._sniperButton.addMouseEvents();
         this._sniperButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._rpgButton.addMouseEvents();
         this._rpgButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._railgunButton.addMouseEvents();
         this._railgunButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._chaingunButton.addMouseEvents();
         this._chaingunButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._photonCannonButton.addMouseEvents();
         this._photonCannonButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._grenadeButton.addMouseEvents();
         this._grenadeButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._payloadButton.addMouseEvents();
         this._payloadButton.addEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler,false,0,true);
         this._arsenalUpgradeButton.addEventListener(GameEvent.CLICKED,this.updateArsenalUpgrade,false,0,true);
         this._arsenalBuyButton.addEventListener(GameEvent.CLICKED,this.buyWeaponUpgrade,false,0,true);
         this._quickDrawButton.addMouseEvents();
         this._quickDrawButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._gungHoButton.addMouseEvents();
         this._gungHoButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._buckshotButton.addMouseEvents();
         this._buckshotButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._eagleEyeButton.addMouseEvents();
         this._eagleEyeButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._heavyArmsButton.addMouseEvents();
         this._heavyArmsButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._bbqueButton.addMouseEvents();
         this._bbqueButton.addEventListener(GameEvent.CLICKED,this.troopButtonHandler,false,0,true);
         this._troopBuyButton.addEventListener(GameEvent.CLICKED,this.buyTroop,false,0,true);
         this._wallUpgradeButton.enabled = true;
         this._wallUpgradeButton.addMouseEvents();
         this._wallUpgradeButton.addEventListener(GameEvent.CLICKED,this.wallButtonHandler,false,0,true);
         this._wallBuyButton.addEventListener(GameEvent.CLICKED,this.buyWallUpgrade,false,0,true);
         this._troopSelection.addEventListeners();
         this._repairBar.addEventListeners();
         this._repairBar.addEventListener("UPDATE",this.updateRepairCost,false,0,true);
         this._options.addEventListeners();
         this._options.addEventListener(GameEvent.CONFIRM,this.optionsMenuEvents,false,0,true);
         this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         this._quickDrawButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         this.dispatchEvent(new GameEvent(GameEvent.FINISHED));
      }
      
      override public function removeEventListeners() : void
      {
         this._playButton.removeMouseEvents();
         this._playButton.removeEventListener(GameEvent.CLICKED,this.playButtonHandler);
         this._pistolButton.removeMouseEvents();
         this._pistolButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._smgButton.removeMouseEvents();
         this._smgButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._shotgunButton.removeMouseEvents();
         this._shotgunButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._assaultRifleButton.removeMouseEvents();
         this._assaultRifleButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._sniperButton.removeMouseEvents();
         this._sniperButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._rpgButton.removeMouseEvents();
         this._rpgButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._railgunButton.removeMouseEvents();
         this._railgunButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._chaingunButton.removeMouseEvents();
         this._chaingunButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._photonCannonButton.removeMouseEvents();
         this._photonCannonButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._grenadeButton.removeMouseEvents();
         this._grenadeButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._payloadButton.removeMouseEvents();
         this._payloadButton.removeEventListener(GameEvent.CLICKED,this.arsenalWeaponButtonHandler);
         this._arsenalUpgradeButton.removeEventListener(GameEvent.CLICKED,this.updateArsenalUpgrade);
         this._arsenalBuyButton.removeEventListener(GameEvent.CLICKED,this.buyWeaponUpgrade);
         this._quickDrawButton.removeMouseEvents();
         this._quickDrawButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._gungHoButton.removeMouseEvents();
         this._gungHoButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._buckshotButton.removeMouseEvents();
         this._buckshotButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._eagleEyeButton.removeMouseEvents();
         this._eagleEyeButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._heavyArmsButton.removeMouseEvents();
         this._heavyArmsButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._bbqueButton.removeMouseEvents();
         this._bbqueButton.removeEventListener(GameEvent.CLICKED,this.troopButtonHandler);
         this._troopBuyButton.removeEventListener(GameEvent.CLICKED,this.buyTroop);
         this._wallUpgradeButton.enabled = true;
         this._wallUpgradeButton.removeMouseEvents();
         this._wallUpgradeButton.removeEventListener(GameEvent.CLICKED,this.wallButtonHandler);
         this._wallBuyButton.removeEventListener(GameEvent.CLICKED,this.buyWallUpgrade);
         this._troopSelection.removeEventListeners();
         this._repairBar.removeEventListeners();
         this._repairBar.removeEventListener("UPDATE",this.updateRepairCost);
         this._options.removeEventListeners();
         this._options.removeEventListener(GameEvent.CONFIRM,this.optionsMenuEvents);
      }
      
      private function playButtonHandler(param1:GameEvent) : void
      {
         Deactivate();
      }
      
      
      private function arsenalWeaponButtonHandler(param1:GameEvent) : void
      {
         var _loc2_:Boolean = false;
         switch(this._activeWeapon)
         {
            case 0:
               _background.removeChild(this._pistolText);
               this._pistolText = this._fontManager.getString("PISTOL","SHOP",1,0);
               this._pistolText.x = 38;
               this._pistolText.y = 97;
               _background.addChild(this._pistolText);
               break;
            case 1:
               _background.removeChild(this._smgText);
               this._smgText = this._fontManager.getString("SMG","SHOP",1,0);
               this._smgText.x = this._pistolText.x;
               this._smgText.y = this._pistolText.y + this._pistolText.height + 11;
               _background.addChild(this._smgText);
               break;
            case 2:
               _background.removeChild(this._shotgunText);
               this._shotgunText = this._fontManager.getString("SHOTGUN","SHOP",1,0);
               this._shotgunText.x = this._smgText.x;
               this._shotgunText.y = this._smgText.y + this._smgText.height + 11;
               _background.addChild(this._shotgunText);
               break;
            case 3:
               _background.removeChild(this._assaultRifleText);
               this._assaultRifleText = this._fontManager.getString("ASSAULT RIFLE","SHOP",1,0);
               this._assaultRifleText.x = this._shotgunText.x;
               this._assaultRifleText.y = this._shotgunText.y + this._shotgunText.height + 11;
               _background.addChild(this._assaultRifleText);
               break;
            case 4:
               _background.removeChild(this._sniperText);
               this._sniperText = this._fontManager.getString("SNIPER RIFLE","SHOP",1,0);
               this._sniperText.x = this._assaultRifleText.x;
               this._sniperText.y = this._assaultRifleText.y + this._assaultRifleText.height + 11;
               _background.addChild(this._sniperText);
               break;
            case 5:
               _background.removeChild(this._rpgText);
               this._rpgText = this._fontManager.getString("RPG LAUNCHER","SHOP",1,0);
               this._rpgText.x = this._sniperText.x;
               this._rpgText.y = this._sniperText.y + this._sniperText.height + 11;
               _background.addChild(this._rpgText);
               break;
            case 6:
               _background.removeChild(this._railgunText);
               this._railgunText = this._fontManager.getString("RAILGUN","SHOP",1,0);
               this._railgunText.x = this._rpgText.x;
               this._railgunText.y = this._rpgText.y + this._rpgText.height + 11;
               _background.addChild(this._railgunText);
               break;
            case 7:
               _background.removeChild(this._chaingunText);
               this._chaingunText = this._fontManager.getString("CHAINGUN","SHOP",1,0);
               this._chaingunText.x = this._railgunText.x;
               this._chaingunText.y = this._railgunText.y + this._railgunText.height + 11;
               _background.addChild(this._chaingunText);
               break;
            case 8:
               _background.removeChild(this._photonCannonText);
               this._photonCannonText = this._fontManager.getString("PHOTON CANNON","SHOP",1,0);
               this._photonCannonText.x = this._chaingunText.x;
               this._photonCannonText.y = this._chaingunText.y + this._chaingunText.height + 11;
               _background.addChild(this._photonCannonText);
               break;
            case 9:
               _background.removeChild(this._grenadeText);
               this._grenadeText = this._fontManager.getString("GRENADE","SHOP",1,0);
               this._grenadeText.x = this._photonCannonText.x;
               this._grenadeText.y = this._photonCannonText.y + this._photonCannonText.height + 11;
               _background.addChild(this._grenadeText);
               break;
            case 10:
               _background.removeChild(this._payloadText);
               this._payloadText = this._fontManager.getString("PAYLOAD","SHOP",1,0);
               this._payloadText.x = this._grenadeText.x;
               this._payloadText.y = this._grenadeText.y + this._grenadeText.height + 11;
               _background.addChild(this._payloadText);
         }
         this._pistolButton.enabled = true;
         this._smgButton.enabled = true;
         this._shotgunButton.enabled = true;
         this._assaultRifleButton.enabled = true;
         this._sniperButton.enabled = true;
         this._rpgButton.enabled = true;
         this._railgunButton.enabled = true;
         this._chaingunButton.enabled = true;
         this._photonCannonButton.enabled = true;
         this._grenadeButton.enabled = true;
         this._payloadButton.enabled = true;
         CustomButton(param1.target).enabled = false;
         switch(param1.target)
         {
            case this._pistolButton:
               this._activeWeapon = 0;
               this._weaponIcon.gotoAndStop("PISTOL");
               _background.removeChild(this._pistolText);
               this._pistolText = this._fontManager.getString("PISTOL","SHOP",1,0);
               this._pistolText.x = 38;
               this._pistolText.y = 97;
               _background.addChild(this._pistolText);
               break;
            case this._smgButton:
               this._activeWeapon = 1;
               this._weaponIcon.gotoAndStop("SMG");
               _background.removeChild(this._smgText);
               this._smgText = this._fontManager.getString("SMG","SHOP",1,0);
               this._smgText.x = this._pistolText.x;
               this._smgText.y = this._pistolText.y + this._pistolText.height + 11;
               _background.addChild(this._smgText);
               break;
            case this._shotgunButton:
               this._activeWeapon = 2;
               this._weaponIcon.gotoAndStop("SHOTGUN");
               _background.removeChild(this._shotgunText);
               this._shotgunText = this._fontManager.getString("SHOTGUN","SHOP",1,0);
               this._shotgunText.x = this._smgText.x;
               this._shotgunText.y = this._smgText.y + this._smgText.height + 11;
               _background.addChild(this._shotgunText);
               break;
            case this._assaultRifleButton:
               this._activeWeapon = 3;
               this._weaponIcon.gotoAndStop("ASSAULT_RIFLE");
               _background.removeChild(this._assaultRifleText);
               this._assaultRifleText = this._fontManager.getString("ASSAULT RIFLE","SHOP",1,0);
               this._assaultRifleText.x = this._shotgunText.x;
               this._assaultRifleText.y = this._shotgunText.y + this._shotgunText.height + 11;
               _background.addChild(this._assaultRifleText);
               break;
            case this._sniperButton:
               this._activeWeapon = 4;
               this._weaponIcon.gotoAndStop("SNIPER");
               _background.removeChild(this._sniperText);
               this._sniperText = this._fontManager.getString("SNIPER RIFLE","SHOP",1,0);
               this._sniperText.x = this._assaultRifleText.x;
               this._sniperText.y = this._assaultRifleText.y + this._assaultRifleText.height + 11;
               _background.addChild(this._sniperText);
               break;
            case this._rpgButton:
               this._activeWeapon = 5;
               this._weaponIcon.gotoAndStop("RPG");
               _background.removeChild(this._rpgText);
               this._rpgText = this._fontManager.getString("RPG LAUNCHER","SHOP",1,0);
               this._rpgText.x = this._sniperText.x;
               this._rpgText.y = this._sniperText.y + this._sniperText.height + 11;
               _background.addChild(this._rpgText);
               break;
            case this._railgunButton:
               this._activeWeapon = 6;
               this._weaponIcon.gotoAndStop("RAILGUN");
               _background.removeChild(this._railgunText);
               this._railgunText = this._fontManager.getString("RAILGUN","SHOP",1,0);
               this._railgunText.x = this._rpgText.x;
               this._railgunText.y = this._rpgText.y + this._rpgText.height + 11;
               _background.addChild(this._railgunText);
               break;
            case this._chaingunButton:
               this._activeWeapon = 7;
               this._weaponIcon.gotoAndStop("CHAINGUN");
               _background.removeChild(this._chaingunText);
               this._chaingunText = this._fontManager.getString("CHAINGUN","SHOP",1,0);
               this._chaingunText.x = this._railgunText.x;
               this._chaingunText.y = this._railgunText.y + this._railgunText.height + 11;
               _background.addChild(this._chaingunText);
               break;
            case this._photonCannonButton:
               this._activeWeapon = 8;
               this._weaponIcon.gotoAndStop("PHOTON_CANNON");
               _background.removeChild(this._photonCannonText);
               this._photonCannonText = this._fontManager.getString("PHOTON CANNON","SHOP",1,0);
               this._photonCannonText.x = this._chaingunText.x;
               this._photonCannonText.y = this._chaingunText.y + this._chaingunText.height + 11;
               _background.addChild(this._photonCannonText);
               break;
            case this._grenadeButton:
               this._activeWeapon = 9;
               this._weaponIcon.gotoAndStop("GRENADE");
               _background.removeChild(this._grenadeText);
               this._grenadeText = this._fontManager.getString("GRENADE","SHOP",1,0);
               this._grenadeText.x = this._photonCannonText.x;
               this._grenadeText.y = this._photonCannonText.y + this._photonCannonText.height + 11;
               _background.addChild(this._grenadeText);
               break;
            case this._payloadButton:
               this._activeWeapon = 10;
               this._weaponIcon.gotoAndStop("PAYLOAD");
               _background.removeChild(this._payloadText);
               this._payloadText = this._fontManager.getString("PAYLOAD","SHOP",1,0);
               this._payloadText.x = this._grenadeText.x;
               this._payloadText.y = this._grenadeText.y + this._grenadeText.height + 11;
               _background.addChild(this._payloadText);
         }
         this._weaponIcon.visible = true;
         this._arsenalUpgradeButton.enabled = false;
         this._arsenalUpgradeButton.removeMouseEvents();
         this._arsenalBuyButton.enabled = false;
         this._arsenalBuyButton.removeMouseEvents();
         if(this._activeWeapon < 9)
         {
            this._weaponStats = this.weaponData.getProperties(this._activeWeapon);
            if(this._weaponStats.purchased)
            {
               this._classified.visible = false;
               _background.removeChild(this._powerText);
               if(this._activeWeapon == 2)
               {
                  this._powerText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level)) + "0x6","SHOP",2,0);
               }
               else
               {
                  this._powerText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level)) + "0","SHOP",1,0);
               }
               if(this._powerText.width>53)this._powerText.width=53; this._powerText.x = 237 - this._powerText.width;
               this._powerText.y = 150;
               _background.addChild(this._powerText);
               _background.removeChild(this._accuracyText);
               this._accuracyText = this._fontManager.getString(String(100 - this._shopStats[this._activeWeapon].getAccuracy(this._shopStats[this._activeWeapon].level)),"SHOP",1,0);
               if(this._accuracyText.width>53)this._accuracyText.width=53; this._accuracyText.x = 237 - this._accuracyText.width;
               this._accuracyText.y = this._powerText.y + this._powerText.height + 11;
               _background.addChild(this._accuracyText);
               _background.removeChild(this._clipText);
               this._clipText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getClip(this._shopStats[this._activeWeapon].level)),"SHOP",1,0);
               if(this._clipText.width>53)this._clipText.width=53; this._clipText.x = 237 - this._clipText.width;
               this._clipText.y = this._accuracyText.y + this._accuracyText.height + 11;
               _background.addChild(this._clipText);
               _background.removeChild(this._ammoText);
               if(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level) == -1)
               {
                  this._ammoText = this._fontManager.getString("N/A","SHOP",1,0);
               }
               else
               {
                  this._ammoText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level)),"SHOP",1,0);
               }
               if(this._ammoText.width>53)this._ammoText.width=53; this._ammoText.x = 237 - this._ammoText.width;
               this._ammoText.y = this._clipText.y + this._clipText.height + 11;
               _background.addChild(this._ammoText);
               _background.removeChild(this._stockText);
               this._stockText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._stockText.width>53)this._stockText.width=53; this._stockText.x = 237 - this._stockText.width;
               this._stockText.y = this._ammoText.y + this._ammoText.height + 11;
               _background.addChild(this._stockText);
               _background.removeChild(this._arsenalCostText);
               this._arsenalCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
               this._arsenalCostText.x = 138;
               this._arsenalCostText.y = 263;
               priceMark(this._arsenalCostText); _background.addChild(this._arsenalCostText);
               _background.removeChild(this._levelText);
               this._levelText = this._fontManager.getString("T:" + String(this._shopStats[this._activeWeapon].level + 1),"SHOP",1,0);
               this._levelText.x = 237 - this._levelText.width;
               this._levelText.y = 136;
               _background.addChild(this._levelText);
               if(this._shopStats[this._activeWeapon].level < 2)
               {
                  this._arsenalUpgradeButton.enabled = true;
                  this._arsenalUpgradeButton.addMouseEvents();
                  this._arsenalUpgradeButton.visible = true;
               }
               else
               {
                  this._arsenalUpgradeButton.visible = false;
               }
            }
            else
            {
               this._classified.visible = true;
               _background.removeChild(this._powerText);
               this._powerText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._powerText.width>53)this._powerText.width=53; this._powerText.x = 237 - this._powerText.width;
               this._powerText.y = 150;
               _background.addChild(this._powerText);
               _background.removeChild(this._accuracyText);
               this._accuracyText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._accuracyText.width>53)this._accuracyText.width=53; this._accuracyText.x = 237 - this._accuracyText.width;
               this._accuracyText.y = this._powerText.y + this._powerText.height + 11;
               _background.addChild(this._accuracyText);
               _background.removeChild(this._clipText);
               this._clipText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._clipText.width>53)this._clipText.width=53; this._clipText.x = 237 - this._clipText.width;
               this._clipText.y = this._accuracyText.y + this._accuracyText.height + 11;
               _background.addChild(this._clipText);
               _background.removeChild(this._ammoText);
               this._ammoText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._ammoText.width>53)this._ammoText.width=53; this._ammoText.x = 237 - this._ammoText.width;
               this._ammoText.y = this._clipText.y + this._clipText.height + 11;
               _background.addChild(this._ammoText);
               _background.removeChild(this._stockText);
               this._stockText = this._fontManager.getString("N/A","SHOP",1,0);
               if(this._stockText.width>53)this._stockText.width=53; this._stockText.x = 237 - this._stockText.width;
               this._stockText.y = this._ammoText.y + this._ammoText.height + 11;
               _background.addChild(this._stockText);
               _background.removeChild(this._arsenalCostText);
               if(this._money >= this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level))
               {
                  this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level)),"SHOP_DIGITS",1,0);
                  this._arsenalBuyButton.enabled = true;
                  this._arsenalBuyButton.addMouseEvents();
               }
               else
               {
                  this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level)),"SHOP_DIGITS",1,1);
               }
               this._arsenalCostText.x = 138;
               this._arsenalCostText.y = 263;
               priceMark(this._arsenalCostText); _background.addChild(this._arsenalCostText);
               _background.removeChild(this._levelText);
               this._levelText = this._fontManager.getString("T:-","SHOP",1,0);
               this._levelText.x = 237 - this._levelText.width;
               this._levelText.y = 136;
               _background.addChild(this._levelText);
               this._arsenalUpgradeButton.visible = false;
            }
         }
         else
         {
            this._classified.visible = false;
            _loc2_ = false;
            _background.removeChild(this._powerText);
            this._powerText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level)) + "0","SHOP",1,0);
            if(this._powerText.width>53)this._powerText.width=53; this._powerText.x = 237 - this._powerText.width;
            this._powerText.y = 150;
            _background.addChild(this._powerText);
            _background.removeChild(this._accuracyText);
            this._accuracyText = this._fontManager.getString("N/A","SHOP",1,0);
            if(this._accuracyText.width>53)this._accuracyText.width=53; this._accuracyText.x = 237 - this._accuracyText.width;
            this._accuracyText.y = this._powerText.y + this._powerText.height + 11;
            _background.addChild(this._accuracyText);
            _background.removeChild(this._clipText);
            this._clipText = this._fontManager.getString("N/A","SHOP",1,0);
            if(this._clipText.width>53)this._clipText.width=53; this._clipText.x = 237 - this._clipText.width;
            this._clipText.y = this._accuracyText.y + this._accuracyText.height + 11;
            _background.addChild(this._clipText);
            _background.removeChild(this._ammoText);
            this._ammoText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level)),"SHOP",1,0);
            if(this._ammoText.width>53)this._ammoText.width=53; this._ammoText.x = 237 - this._ammoText.width;
            this._ammoText.y = this._clipText.y + this._clipText.height + 11;
            _background.addChild(this._ammoText);
            _background.removeChild(this._stockText);
            if(this._activeWeapon == 9)
            {
               this._stockText = this._fontManager.getString(String(this._grenades),"SHOP",1,0);
               if(this._grenades < this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level))
               {
                  _loc2_ = true;
               }
            }
            else
            {
               this._stockText = this._fontManager.getString(String(this._payloads),"SHOP",1,0);
               if(this._payloads < this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level))
               {
                  _loc2_ = true;
               }
            }
            if(this._stockText.width>53)this._stockText.width=53; this._stockText.x = 237 - this._stockText.width;
            this._stockText.y = this._ammoText.y + this._ammoText.height + 11;
            _background.addChild(this._stockText);
            _background.removeChild(this._arsenalCostText);
            if(_loc2_)
            {
               if(this._money >= this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level))
               {
                  this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level)),"SHOP_DIGITS",1,0);
                  this._arsenalBuyButton.enabled = true;
                  this._arsenalBuyButton.addMouseEvents();
               }
               else
               {
                  this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level)),"SHOP_DIGITS",1,1);
               }
            }
            else
            {
               this._arsenalCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
            }
            this._arsenalCostText.x = 138;
            this._arsenalCostText.y = 263;
            priceMark(this._arsenalCostText); _background.addChild(this._arsenalCostText);
            _background.removeChild(this._levelText);
            this._levelText = this._fontManager.getString("T:-","SHOP",1,0);
            this._levelText.x = 237 - this._levelText.width;
            this._levelText.y = 136;
            _background.addChild(this._levelText);
            this._arsenalUpgradeButton.visible = false;
         }
         if(this._weaponNameText != null && _background.contains(this._weaponNameText))
         {
            _background.removeChild(this._weaponNameText);
         }
         this._weaponNameText = this._fontManager.getString(this._shopStats[this._activeWeapon].name,"SHOP",1,0);
         this._weaponNameText.x = 130;
         this._weaponNameText.y = 136;
         _background.addChild(this._weaponNameText);
         _background.setChildIndex(this._classified,_background.numChildren - 1);
         if(_activeWeapon<9 && _weaponStats.purchased && _shopStats[_activeWeapon].level<2)updateArsenalUpgrade(null);
      }
      
      private function troopButtonHandler(param1:GameEvent) : void
      {
         var _loc3_:Boolean = false;
         switch(this._activeTroop)
         {
            case 0:
               _background.removeChild(this._quickDrawText);
               this._quickDrawText = this._fontManager.getString("QUICK DRAW","SHOP",1,0);
               this._quickDrawText.x = 278;
               this._quickDrawText.y = 94;
               _background.addChild(this._quickDrawText);
               break;
            case 2:
               _background.removeChild(this._buckshotText);
               this._buckshotText = this._fontManager.getString("BUCKSHOT","SHOP",1,0);
               this._buckshotText.x = this._quickDrawText.x;
               this._buckshotText.y = this._quickDrawText.y + this._quickDrawText.height + 11;
               _background.addChild(this._buckshotText);
               break;
            case 1:
               _background.removeChild(this._gungHoText);
               this._gungHoText = this._fontManager.getString("GUNG-HO","SHOP",1,0);
               this._gungHoText.x = this._buckshotText.x;
               this._gungHoText.y = this._buckshotText.y + this._buckshotText.height + 11;
               _background.addChild(this._gungHoText);
               break;
            case 5:
               _background.removeChild(this._bbqueText);
               this._bbqueText = this._fontManager.getString("B. B. QUE","SHOP",1,0);
               this._bbqueText.x = this._gungHoText.x;
               this._bbqueText.y = this._gungHoText.y + this._gungHoText.height + 11;
               _background.addChild(this._bbqueText);
               break;
            case 3:
               _background.removeChild(this._eagleEyeText);
               this._eagleEyeText = this._fontManager.getString("EAGLE EYE","SHOP",1,0);
               this._eagleEyeText.x = this._bbqueText.x;
               this._eagleEyeText.y = this._bbqueText.y + this._bbqueText.height + 11;
               _background.addChild(this._eagleEyeText);
               break;
            case 4:
               _background.removeChild(this._heavyArmsText);
               this._heavyArmsText = this._fontManager.getString("HEAVY ARMS","SHOP",1,0);
               this._heavyArmsText.x = this._eagleEyeText.x;
               this._heavyArmsText.y = this._eagleEyeText.y + this._eagleEyeText.height + 11;
               _background.addChild(this._heavyArmsText);
         }
         switch(this._activeWeapon)
         {
            case 0:
               this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._smgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._shotgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._assaultRifleButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._sniperButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._rpgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 6:
               this._railgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 7:
               this._chaingunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 8:
               this._photonCannonButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 9:
               this._grenadeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 10:
               this._payloadButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
         this._quickDrawButton.enabled = true;
         this._gungHoButton.enabled = true;
         this._buckshotButton.enabled = true;
         this._eagleEyeButton.enabled = true;
         this._heavyArmsButton.enabled = true;
         this._bbqueButton.enabled = true;
         CustomButton(param1.target).enabled = false;
         var _loc2_:int = 0;
         while(_loc2_ < this._troopIcons.length)
         {
            this._troopIcons[_loc2_].visible = false;
            _loc2_++;
         }
         switch(param1.target)
         {
            case this._quickDrawButton:
               this._activeTroop = 0;
               _background.removeChild(this._quickDrawText);
               this._quickDrawText = this._fontManager.getString("QUICK DRAW","SHOP",1,0);
               this._quickDrawText.x = 278;
               this._quickDrawText.y = 94;
               _background.addChild(this._quickDrawText);
               break;
            case this._buckshotButton:
               this._activeTroop = 2;
               _background.removeChild(this._buckshotText);
               this._buckshotText = this._fontManager.getString("BUCKSHOT","SHOP",1,0);
               this._buckshotText.x = this._quickDrawText.x;
               this._buckshotText.y = this._quickDrawText.y + this._quickDrawText.height + 11;
               _background.addChild(this._buckshotText);
               break;
            case this._gungHoButton:
               this._activeTroop = 1;
               _background.removeChild(this._gungHoText);
               this._gungHoText = this._fontManager.getString("GUNG-HO","SHOP",1,0);
               this._gungHoText.x = this._buckshotText.x;
               this._gungHoText.y = this._buckshotText.y + this._buckshotText.height + 11;
               _background.addChild(this._gungHoText);
               break;
            case this._bbqueButton:
               this._activeTroop = 5;
               _background.removeChild(this._bbqueText);
               this._bbqueText = this._fontManager.getString("B. B. QUE","SHOP",1,0);
               this._bbqueText.x = this._gungHoText.x;
               this._bbqueText.y = this._gungHoText.y + this._gungHoText.height + 11;
               _background.addChild(this._bbqueText);
               break;
            case this._eagleEyeButton:
               this._activeTroop = 3;
               _background.removeChild(this._eagleEyeText);
               this._eagleEyeText = this._fontManager.getString("EAGLE EYE","SHOP",1,0);
               this._eagleEyeText.x = this._bbqueText.x;
               this._eagleEyeText.y = this._bbqueText.y + this._bbqueText.height + 11;
               _background.addChild(this._eagleEyeText);
               break;
            case this._heavyArmsButton:
               this._activeTroop = 4;
               _background.removeChild(this._heavyArmsText);
               this._heavyArmsText = this._fontManager.getString("HEAVY ARMS","SHOP",1,0);
               this._heavyArmsText.x = this._eagleEyeText.x;
               this._heavyArmsText.y = this._eagleEyeText.y + this._eagleEyeText.height + 11;
               _background.addChild(this._heavyArmsText);
         }
         this._troopIcons[this._activeTroop].visible = true;
         _background.setChildIndex(this._topSecret,_background.numChildren - 1);
         this._troopBuyButton.enabled = false;
         this._troopBuyButton.removeMouseEvents();
         this.troopData = this._shopTroops[this._activeTroop];
         if(this.troopData.unlocked)
         {
            _loc3_ = false;
            if(this._damageText != null && _background.contains(this._damageText))
            {
               _background.removeChild(this._damageText);
            }
            this._damageText = this._fontManager.getString(this.troopData.damage,"SHOP",1,0);
            this._damageText.x = 366 - this._damageText.width/2;
            this._damageText.y = 160;
            _background.addChild(this._damageText);
            if(this._rateOfFireText != null && _background.contains(this._rateOfFireText))
            {
               _background.removeChild(this._rateOfFireText);
            }
            this._rateOfFireText = this._fontManager.getString(this.troopData.rateOfFire,"SHOP",1,0);
            this._rateOfFireText.x = 416 - this._rateOfFireText.width/2;
            this._rateOfFireText.y = this._damageText.y;
            _background.addChild(this._rateOfFireText);
            if(this._troopStockText != null && _background.contains(this._troopStockText))
            {
               _background.removeChild(this._troopStockText);
            }
            this._troopStockText = this._fontManager.getString(String(this._troopStocks[this._activeTroop]),"SHOP",1,0);
            this._troopStockText.x = 470 - this._troopStockText.width/2;
            this._troopStockText.y = this._rateOfFireText.y;
            _background.addChild(this._troopStockText);
            if(this._troopStocks[this._activeTroop] < 6)
            {
               _loc3_ = true;
            }
            if(this._troopCostText != null && _background.contains(this._troopCostText))
            {
               _background.removeChild(this._troopCostText);
            }
            if(_loc3_)
            {
               if(this._money >= this.troopData.cost)
               {
                  this._troopCostText = this._fontManager.getString(String(this.troopData.cost),"SHOP_DIGITS",1,0);
                  this._troopBuyButton.enabled = true;
                  this._troopBuyButton.addMouseEvents();
                  this._topSecret.visible = false;
               }
               else
               {
                  this._troopCostText = this._fontManager.getString(String(this.troopData.cost),"SHOP_DIGITS",1,1);
                  this._topSecret.visible = true;
               }
            }
            else
            {
               this._troopCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
            }
            this._troopCostText.x = 359;
            this._troopCostText.y = 175;
            priceMark(this._troopCostText); _background.addChild(this._troopCostText);
         }
         else
         {
            this._topSecret.visible = true;
            if(this._damageText != null && _background.contains(this._damageText))
            {
               _background.removeChild(this._damageText);
            }
            this._damageText = this._fontManager.getString("N/A","SHOP",1,0);
            this._damageText.x = 366 - this._damageText.width/2;
            this._damageText.y = 160;
            _background.addChild(this._damageText);
            if(this._rateOfFireText != null && _background.contains(this._rateOfFireText))
            {
               _background.removeChild(this._rateOfFireText);
            }
            this._rateOfFireText = this._fontManager.getString("N/A","SHOP",1,0);
            this._rateOfFireText.x = 416 - this._rateOfFireText.width/2;
            this._rateOfFireText.y = this._damageText.y;
            _background.addChild(this._rateOfFireText);
            if(this._troopStockText != null && _background.contains(this._troopStockText))
            {
               _background.removeChild(this._troopStockText);
            }
            this._troopStockText = this._fontManager.getString("0","SHOP",1,0);
            this._troopStockText.x = 470 - this._troopStockText.width/2;
            this._troopStockText.y = this._rateOfFireText.y;
            _background.addChild(this._troopStockText);
            if(this._troopCostText != null && _background.contains(this._troopCostText))
            {
               _background.removeChild(this._troopCostText);
            }
            this._troopCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
            this._troopCostText.x = 359;
            this._troopCostText.y = 175;
            priceMark(this._troopCostText); _background.addChild(this._troopCostText);
         }
      }
      
      public function Update(param1:Boolean, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Number, param12:Number) : void
      {
         _background.removeChild(this._waveText);
         this._waveText = this._fontManager.getString(String(param2) + ":","SHOP",1,0);
         this._waveText.x = 54;
         this._waveText.y = 326;
         _background.addChild(this._waveText);
         _background.removeChild(this._victoryText);
         if(param1)
         {
            this._victoryText = this._fontManager.getString("COMPLETE","SHOP",1,1);
         }
         else
         {
            this._victoryText = this._fontManager.getString("FAILED","SHOP",1,2);
         }
         this._victoryText.x = 235 - this._victoryText.width;
         this._victoryText.y = this._waveText.y;
         _background.addChild(this._victoryText);
         _background.removeChild(this._scoreText);
         this._scoreText = this._fontManager.getString(String(param3),"SHOP",1,0);
         this._scoreText.x = 235 - this._scoreText.width;
         this._scoreText.y = this._waveText.y + this._waveText.height + 11;
         _background.addChild(this._scoreText);
         _background.removeChild(this._moneyText);
         this._moneyText = this._fontManager.getString(String(param4),"SHOP",1,0);
         this._moneyText.x = 235 - this._moneyText.width;
         this._moneyText.y = this._scoreText.y + this._scoreText.height + 11;
         _background.addChild(this._moneyText);
         _background.removeChild(this._soldierText);
         this._soldierText = this._fontManager.getString(String(param5),"SHOP",1,0);
         this._soldierText.x = 235 - this._soldierText.width;
         this._soldierText.y = this._moneyText.y + this._moneyText.height + 11;
         _background.addChild(this._soldierText);
         _background.removeChild(this._vehicleText);
         this._vehicleText = this._fontManager.getString(String(param6),"SHOP",1,0);
         this._vehicleText.x = 235 - this._vehicleText.width;
         this._vehicleText.y = this._soldierText.y + this._soldierText.height + 11;
         _background.addChild(this._vehicleText);
         _background.removeChild(this._healthText);
         if(param9 == 0)
         {
            this._healthText = this._fontManager.getString(String(param9) + "/" + String(param10),"SHOP",1,2);
         }
         else
         {
            this._healthText = this._fontManager.getString(String(param9) + "/" + String(param10),"SHOP",1,0);
         }
         this._healthText.x = 235 - this._healthText.width;
         this._healthText.y = this._vehicleText.y + this._vehicleText.height + 11;
         _background.addChild(this._healthText);
         _background.removeChild(this._totalScoreText);
         this._totalScoreText = this._fontManager.getString(String(param11),"SHOP_DIGITS",1,0);
         this._totalScoreText.x = 262;
         this._totalScoreText.y = 12;
         _background.addChild(this._totalScoreText);
         this._money = param12;
         this._grenades = param7;
         this._payloads = param8;
         this._wallHealth = param9;
         this._repairBar.setHealth(this._wallHealth,param10);
         if(this._wallHealth == 0)
         {
            switch(this._wallLevel)
            {
               case 0:
                  this._money -= 750;
                  this._wallHealth = 100;
                  break;
               case 1:
                  this._money -= 1500;
                  this._wallHealth = 150;
                  break;
               case 2:
                  this._money -= 3000;
                  this._wallHealth = 200;
            }
            if(this._money <= 0)
            {
               this._money = 0;
            }
         }
         _background.removeChild(this._totalMoneyText);
         this._totalMoneyText = this._fontManager.getString(String(this._money),"SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
      }
      
      private function updateArsenalUpgrade(param1:GameEvent) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         _background.removeChild(this._arsenalCostText);
         if(this._money >= this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level + 1))
         {
            this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level + 1)),"SHOP_DIGITS",1,0);
            this._arsenalBuyButton.enabled = true;
            this._arsenalBuyButton.addMouseEvents();
         }
         else
         {
            this._arsenalCostText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level + 1)),"SHOP_DIGITS",1,1);
         }
         this._arsenalCostText.x = 138;
         this._arsenalCostText.y = 263;
         priceMark(this._arsenalCostText); _background.addChild(this._arsenalCostText);
         _background.removeChild(this._powerText);
         if(this._activeWeapon == 2)
         {
            this._powerText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level)) + "0x6","SHOP",2,2);
            _loc3_ = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level + 1)) + "0x6","SHOP",2,1);
         }
         else
         {
            this._powerText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level)) + "0","SHOP",1,2);
            _loc3_ = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level + 1)) + "0","SHOP",1,1);
         }
         _loc2_ = this._fontManager.getString(">","SHOP",1,0);
         _loc2_.x = this._powerText.width + 4;
         this._powerText.addChild(_loc2_);
         _loc3_.x = this._powerText.width + 4;
         this._powerText.addChild(_loc3_);
         if(this._powerText.width>53)this._powerText.width=53; this._powerText.x = 237 - this._powerText.width;
         this._powerText.y = 150;
         _background.addChild(this._powerText);
         _background.removeChild(this._accuracyText);
         this._accuracyText = this._fontManager.getString(String(100 - this._shopStats[this._activeWeapon].getAccuracy(this._shopStats[this._activeWeapon].level)),"SHOP",1,2);
         _loc3_ = this._fontManager.getString(String(100 - this._shopStats[this._activeWeapon].getAccuracy(this._shopStats[this._activeWeapon].level + 1)),"SHOP",1,1);
         _loc2_ = this._fontManager.getString(">","SHOP",1,0);
         _loc2_.x = this._accuracyText.width + 4;
         this._accuracyText.addChild(_loc2_);
         _loc3_.x = this._accuracyText.width + 4;
         this._accuracyText.addChild(_loc3_);
         if(this._accuracyText.width>53)this._accuracyText.width=53; this._accuracyText.x = 237 - this._accuracyText.width;
         this._accuracyText.y = this._powerText.y + this._powerText.height + 11;
         _background.addChild(this._accuracyText);
         _background.removeChild(this._clipText);
         this._clipText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getClip(this._shopStats[this._activeWeapon].level)),"SHOP",1,2);
         _loc3_ = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getClip(this._shopStats[this._activeWeapon].level + 1)),"SHOP",1,1);
         _loc2_ = this._fontManager.getString(">","SHOP",1,0);
         _loc2_.x = this._clipText.width + 4;
         this._clipText.addChild(_loc2_);
         _loc3_.x = this._clipText.width + 4;
         this._clipText.addChild(_loc3_);
         if(this._clipText.width>53)this._clipText.width=53; this._clipText.x = 237 - this._clipText.width;
         this._clipText.y = this._accuracyText.y + this._accuracyText.height + 11;
         _background.addChild(this._clipText);
         if(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level) != -1)
         {
            _background.removeChild(this._ammoText);
            this._ammoText = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level)),"SHOP",1,2);
            _loc3_ = this._fontManager.getString(String(this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level + 1)),"SHOP",1,1);
            _loc2_ = this._fontManager.getString(">","SHOP",1,0);
            _loc2_.x = this._ammoText.width + 4;
            this._ammoText.addChild(_loc2_);
            _loc3_.x = this._ammoText.width + 4;
            this._ammoText.addChild(_loc3_);
            if(this._ammoText.width>53)this._ammoText.width=53; this._ammoText.x = 237 - this._ammoText.width;
            this._ammoText.y = this._clipText.y + this._clipText.height + 11;
            _background.addChild(this._ammoText);
         }
      }
      
      private function buyWeaponUpgrade(param1:GameEvent) : void
      {
         if(this._activeWeapon == 9)
         {
            ++this._grenades;
         }
         else if(this._activeWeapon == 10)
         {
            ++this._payloads;
         }
         else
         {
            if(this._weaponStats.purchased)
            {
               ++this._shopStats[this._activeWeapon].level;
            }
            this._weaponStats.purchased = true;
            this._weaponStats.damage = this._shopStats[this._activeWeapon].getDamage(this._shopStats[this._activeWeapon].level);
            this._weaponStats.minimumAccuracy = this._shopStats[this._activeWeapon].getAccuracy(this._shopStats[this._activeWeapon].level);
            this._weaponStats.rateOfFire = this._shopStats[this._activeWeapon].getRateOfFire(this._shopStats[this._activeWeapon].level);
            this._weaponStats.clipSize = this._shopStats[this._activeWeapon].getClip(this._shopStats[this._activeWeapon].level);
            this._weaponStats.ammo = this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level);
            this._weaponStats.maxAmmo = this._shopStats[this._activeWeapon].getAmmo(this._shopStats[this._activeWeapon].level);
            this.weaponData.setProperties(this._activeWeapon,this._weaponStats);
         }
         this._money -= this._shopStats[this._activeWeapon].getCost(this._shopStats[this._activeWeapon].level);
         _background.removeChild(this._totalMoneyText);
         this._totalMoneyText = this._fontManager.getString(String(this._money),"SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
         this._soundManager.playSound("purchase");
         switch(this._activeUpgrade)
         {
            case 0:
               this.wallButtonHandler(null);
               break;
            case 1:
               this.updateRepairCost(null);
         }
         switch(this._activeTroop)
         {
            case 0:
               this._quickDrawButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._gungHoButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._buckshotButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._eagleEyeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._heavyArmsButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._bbqueButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
         switch(this._activeWeapon)
         {
            case 0:
               this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._smgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._shotgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._assaultRifleButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._sniperButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._rpgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 6:
               this._railgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 7:
               this._chaingunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 8:
               this._photonCannonButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 9:
               this._grenadeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 10:
               this._payloadButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
      }
      
      public function set _money(param1:Number) : void
      {
         this._pmoney = param1;
         this.RefreshUI();
      }
      
      public function get _money() : Number
      {
         return this._pmoney;
      }
      
      private function RefreshUI(param1:Event = null) : void
      {
         _background.removeChild(this._totalMoneyText);
         this._totalMoneyText = this._fontManager.getString(String(this._money),"SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
      }
      
      private function buyTroop(param1:GameEvent) : void
      {
         ++this._troopStocks[this._activeTroop];
         this._troopSelection.stocks = this._troopStocks;
         this._troopSelection.unlocks = new Array(true,true,true,true,true,true);
         this._money -= this.troopData.cost;
         _background.removeChild(this._totalMoneyText);
         this._totalMoneyText = this._fontManager.getString(String(this._money),"SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
         this._soundManager.playSound("purchase");
         switch(this._activeUpgrade)
         {
            case 0:
               this.wallButtonHandler(null);
               break;
            case 1:
               this.updateRepairCost(null);
         }
         switch(this._activeTroop)
         {
            case 0:
               this._quickDrawButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._gungHoButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._buckshotButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._eagleEyeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._heavyArmsButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._bbqueButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
      }
      
      private function buyWallUpgrade(param1:GameEvent) : void
      {
         this._money -= this._wallPrice;
         _background.removeChild(this._totalMoneyText);
         this._totalMoneyText = this._fontManager.getString(String(this._money),"SHOP_DIGITS",1,0);
         this._totalMoneyText.x = 401;
         this._totalMoneyText.y = 12;
         _background.addChild(this._totalMoneyText);
         this._soundManager.playSound("purchase");
         switch(this._activeTroop)
         {
            case 0:
               this._quickDrawButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._gungHoButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._buckshotButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._eagleEyeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._heavyArmsButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._bbqueButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
         switch(this._activeUpgrade)
         {
            case 0:
               ++this._wallLevel;
               this._wallHealth += 50;
               this._repairBar.setHealth(this._wallHealth,this._wallLevel * 50 + 100);
               if(this._wallLevel >= 2)
               {
                  this._wallUpgradeButton.visible = false;
                  if(this._upgradeText != null && _background.contains(this._upgradeText))
                  {
                     _background.removeChild(this._upgradeText);
                  }
                  this._upgradeText = this._fontManager.getString("UPGRADE","SHOP",1,0);
                  this._upgradeText.x = Calc.center(this._wallUpgradeButton.width,this._upgradeText.width,this._wallUpgradeButton.x);
                  this._upgradeText.y = Calc.center(this._wallUpgradeButton.height,this._upgradeText.height,this._wallUpgradeButton.y);
                  _background.addChild(this._upgradeText);
                  if(this._wallCostText != null && _background.contains(this._wallCostText))
                  {
                     _background.removeChild(this._wallCostText);
                  }
                  this._wallCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
                  this._wallCostText.x = 384;
                  this._wallCostText.y = 343;
                  priceMark(this._wallCostText); _background.addChild(this._wallCostText);
                  this._activeUpgrade = -1;
                  switch(this._activeWeapon)
                  {
                     case 0:
                        this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 1:
                        this._smgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 2:
                        this._shotgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 3:
                        this._assaultRifleButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 4:
                        this._sniperButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 5:
                        this._rpgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 6:
                        this._railgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 7:
                        this._chaingunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                        break;
                     case 8:
                        this._photonCannonButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                  }
               }
               else
               {
                  this._wallUpgradeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               }
               if(this._wallLevel == 1)
               {
                  this._wallIcon.gotoAndStop("LEVEL_02");
               }
               else if(this._wallLevel == 2)
               {
                  this._wallIcon.gotoAndStop("LEVEL_03");
               }
               _background.removeChild(this._wallLevelText);
               this._wallLevelText = this._fontManager.getString("T:" + String(this._wallLevel + 1),"SHOP",1,0);
               this._wallLevelText.x = 488 - this._wallLevelText.width;
               this._wallLevelText.y = 218;
               _background.addChild(this._wallLevelText);
               break;
            case 1:
               this._wallHealth = this._repairBar.health;
               this._repairBar.setHealth(this._wallHealth,this._wallLevel * 50 + 100);
               if(this._wallCostText != null && _background.contains(this._wallCostText))
               {
                  _background.removeChild(this._wallCostText);
               }
               this._wallCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
               this._wallCostText.x = 384;
               this._wallCostText.y = 343;
               priceMark(this._wallCostText); _background.addChild(this._wallCostText);
               switch(this._activeWeapon)
               {
                  case 0:
                     this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 1:
                     this._smgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 2:
                     this._shotgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 3:
                     this._assaultRifleButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 4:
                     this._sniperButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 5:
                     this._rpgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 6:
                     this._railgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 7:
                     this._chaingunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
                     break;
                  case 8:
                     this._photonCannonButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               }
         }
      }
      
      private function wallButtonHandler(param1:GameEvent) : void
      {
         switch(this._activeWeapon)
         {
            case 0:
               this._pistolButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 1:
               this._smgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 2:
               this._shotgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 3:
               this._assaultRifleButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 4:
               this._sniperButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 5:
               this._rpgButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 6:
               this._railgunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 7:
               this._chaingunButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 8:
               this._photonCannonButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 9:
               this._grenadeButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
               break;
            case 10:
               this._payloadButton.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
         this._wallBuyButton.enabled = false;
         this._wallBuyButton.removeMouseEvents();
         if(this._wallCostText != null && _background.contains(this._wallCostText))
         {
            _background.removeChild(this._wallCostText);
         }
         this._activeUpgrade = 0;
         switch(this._wallLevel)
         {
            case 0:
               this._wallPrice = 1000;
               break;
            case 1:
               this._wallPrice = 2000;
         }
         if(this._money >= this._wallPrice)
         {
            this._wallCostText = this._fontManager.getString(String(this._wallPrice),"SHOP_DIGITS",1,0);
            this._wallBuyButton.enabled = true;
            this._wallBuyButton.addMouseEvents();
         }
         else
         {
            this._wallCostText = this._fontManager.getString(String(this._wallPrice),"SHOP_DIGITS",1,1);
         }
         this._wallCostText.x = 384;
         this._wallCostText.y = 343;
         priceMark(this._wallCostText); _background.addChild(this._wallCostText);
      }
      
      private function updateRepairCost(param1:Event) : void
      {
         this._wallUpgradeButton.enabled = true;
         this._wallUpgradeButton.addMouseEvents();
         this._wallBuyButton.enabled = false;
         this._wallBuyButton.removeMouseEvents();
         if(this._wallCostText != null && _background.contains(this._wallCostText))
         {
            _background.removeChild(this._wallCostText);
         }
         this._activeUpgrade = 1;
         switch(this._wallLevel)
         {
            case 0:
               this._wallPrice = this._repairBar.health - this._wallHealth;
               break;
            case 1:
               this._wallPrice = (this._repairBar.health - this._wallHealth) * 3;
               break;
            case 2:
               this._wallPrice = (this._repairBar.health - this._wallHealth) * 6;
         }
         if(this._wallPrice < 0)
         {
            this._wallPrice = 0;
         }
         if(this._money >= this._wallPrice)
         {
            this._wallCostText = this._fontManager.getString(String(this._wallPrice),"SHOP_DIGITS",1,0);
            if(this._wallPrice != 0)
            {
               this._wallBuyButton.enabled = true;
               this._wallBuyButton.addMouseEvents();
            }
         }
         else
         {
            this._wallCostText = this._fontManager.getString(String(this._wallPrice),"SHOP_DIGITS",1,1);
         }
         this._wallCostText.x = 384;
         this._wallCostText.y = 343;
         priceMark(this._wallCostText); _background.addChild(this._wallCostText);
         this._wallCostText.visible=false;
         this.refreshPurchaseActions();
      }
      
      public function reset() : void
      {
         if(this._pistolText != null && _background.contains(this._pistolText))
         {
            _background.removeChild(this._pistolText);
         }
         this._pistolText = this._fontManager.getString("PISTOL","SHOP",1,0);
         this._pistolText.x = 38;
         this._pistolText.y = 97;
         _background.addChild(this._pistolText);
         if(this._smgText != null && _background.contains(this._smgText))
         {
            _background.removeChild(this._smgText);
         }
         this._smgText = this._fontManager.getString("SMG","SHOP",1,0);
         this._smgText.x = this._pistolText.x;
         this._smgText.y = this._pistolText.y + this._pistolText.height + 11;
         _background.addChild(this._smgText);
         if(this._shotgunText != null && _background.contains(this._shotgunText))
         {
            _background.removeChild(this._shotgunText);
         }
         this._shotgunText = this._fontManager.getString("SHOTGUN","SHOP",1,0);
         this._shotgunText.x = this._smgText.x;
         this._shotgunText.y = this._smgText.y + this._smgText.height + 11;
         _background.addChild(this._shotgunText);
         if(this._assaultRifleText != null && _background.contains(this._assaultRifleText))
         {
            _background.removeChild(this._assaultRifleText);
         }
         this._assaultRifleText = this._fontManager.getString("ASSAULT RIFLE","SHOP",1,0);
         this._assaultRifleText.x = this._shotgunText.x;
         this._assaultRifleText.y = this._shotgunText.y + this._shotgunText.height + 11;
         _background.addChild(this._assaultRifleText);
         if(this._sniperText != null && _background.contains(this._sniperText))
         {
            _background.removeChild(this._sniperText);
         }
         this._sniperText = this._fontManager.getString("SNIPER RIFLE","SHOP",1,0);
         this._sniperText.x = this._assaultRifleText.x;
         this._sniperText.y = this._assaultRifleText.y + this._assaultRifleText.height + 11;
         _background.addChild(this._sniperText);
         if(this._rpgText != null && _background.contains(this._rpgText))
         {
            _background.removeChild(this._rpgText);
         }
         this._rpgText = this._fontManager.getString("RPG LAUNCHER","SHOP",1,0);
         this._rpgText.x = this._sniperText.x;
         this._rpgText.y = this._sniperText.y + this._sniperText.height + 11;
         _background.addChild(this._rpgText);
         if(this._railgunText != null && _background.contains(this._railgunText))
         {
            _background.removeChild(this._railgunText);
         }
         this._railgunText = this._fontManager.getString("RAILGUN","SHOP",1,0);
         this._railgunText.x = this._rpgText.x;
         this._railgunText.y = this._rpgText.y + this._rpgText.height + 11;
         _background.addChild(this._railgunText);
         if(this._chaingunText != null && _background.contains(this._chaingunText))
         {
            _background.removeChild(this._chaingunText);
         }
         this._chaingunText = this._fontManager.getString("CHAINGUN","SHOP",1,0);
         this._chaingunText.x = this._railgunText.x;
         this._chaingunText.y = this._railgunText.y + this._railgunText.height + 11;
         _background.addChild(this._chaingunText);
         if(this._photonCannonText != null && _background.contains(this._photonCannonText))
         {
            _background.removeChild(this._photonCannonText);
         }
         this._photonCannonText = this._fontManager.getString("PHOTON CANNON","SHOP",1,0);
         this._photonCannonText.x = this._chaingunText.x;
         this._photonCannonText.y = this._chaingunText.y + this._chaingunText.height + 11;
         _background.addChild(this._photonCannonText);
         if(this._grenadeText != null && _background.contains(this._grenadeText))
         {
            _background.removeChild(this._grenadeText);
         }
         this._grenadeText = this._fontManager.getString("GRENADE","SHOP",1,0);
         this._grenadeText.x = this._photonCannonText.x;
         this._grenadeText.y = this._photonCannonText.y + this._photonCannonText.height + 11;
         _background.addChild(this._grenadeText);
         if(this._payloadText != null && _background.contains(this._payloadText))
         {
            _background.removeChild(this._payloadText);
         }
         this._payloadText = this._fontManager.getString("PAYLOAD","SHOP",1,0);
         this._payloadText.x = this._grenadeText.x;
         this._payloadText.y = this._grenadeText.y + this._grenadeText.height + 11;
         _background.addChild(this._payloadText);
         if(this._powerText != null && _background.contains(this._powerText))
         {
            _background.removeChild(this._powerText);
         }
         this._powerText = this._fontManager.getString("N/A","SHOP",1,0);
         if(this._powerText.width>53)this._powerText.width=53; this._powerText.x = 237 - this._powerText.width;
         this._powerText.y = 150;
         _background.addChild(this._powerText);
         if(this._accuracyText != null && _background.contains(this._accuracyText))
         {
            _background.removeChild(this._accuracyText);
         }
         this._accuracyText = this._fontManager.getString("N/A","SHOP",1,0);
         if(this._accuracyText.width>53)this._accuracyText.width=53; this._accuracyText.x = 237 - this._accuracyText.width;
         this._accuracyText.y = this._powerText.y + this._powerText.height + 11;
         _background.addChild(this._accuracyText);
         if(this._clipText != null && _background.contains(this._clipText))
         {
            _background.removeChild(this._clipText);
         }
         this._clipText = this._fontManager.getString("N/A","SHOP",1,0);
         if(this._clipText.width>53)this._clipText.width=53; this._clipText.x = 237 - this._clipText.width;
         this._clipText.y = this._accuracyText.y + this._accuracyText.height + 11;
         _background.addChild(this._clipText);
         if(this._ammoText != null && _background.contains(this._ammoText))
         {
            _background.removeChild(this._ammoText);
         }
         this._ammoText = this._fontManager.getString("N/A","SHOP",1,0);
         if(this._ammoText.width>53)this._ammoText.width=53; this._ammoText.x = 237 - this._ammoText.width;
         this._ammoText.y = this._clipText.y + this._clipText.height + 11;
         _background.addChild(this._ammoText);
         if(this._stockText != null && _background.contains(this._stockText))
         {
            _background.removeChild(this._stockText);
         }
         this._stockText = this._fontManager.getString("N/A","SHOP",1,0);
         if(this._stockText.width>53)this._stockText.width=53; this._stockText.x = 237 - this._stockText.width;
         this._stockText.y = this._ammoText.y + this._ammoText.height + 11;
         _background.addChild(this._stockText);
         if(this._arsenalCostText != null && _background.contains(this._arsenalCostText))
         {
            _background.removeChild(this._arsenalCostText);
         }
         this._arsenalCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
         this._arsenalCostText.x = 138;
         this._arsenalCostText.y = 263;
         priceMark(this._arsenalCostText); _background.addChild(this._arsenalCostText);
         if(this._weaponNameText != null && _background.contains(this._weaponNameText))
         {
            _background.removeChild(this._weaponNameText);
         }
         this._weaponNameText = this._fontManager.getString("N/A","SHOP",1,0);
         this._weaponNameText.x = 130;
         this._weaponNameText.y = 136;
         _background.addChild(this._weaponNameText);
         if(this._levelText != null && _background.contains(this._levelText))
         {
            _background.removeChild(this._levelText);
         }
         this._levelText = this._fontManager.getString("T:-","SHOP",1,0);
         this._levelText.x = 237 - this._levelText.width;
         this._levelText.y = 136;
         _background.addChild(this._levelText);
         this._activeWeapon = -1;
         this._weaponIcon.visible = false;
         this._classified.visible = true;
         this._arsenalUpgradeButton.visible = false;
         this._pistolButton.enabled = true;
         this._smgButton.enabled = true;
         this._shotgunButton.enabled = true;
         this._assaultRifleButton.enabled = true;
         this._sniperButton.enabled = true;
         this._rpgButton.enabled = true;
         this._railgunButton.enabled = true;
         this._chaingunButton.enabled = true;
         this._photonCannonButton.enabled = true;
         this._grenadeButton.enabled = true;
         this._payloadButton.enabled = true;
         this._arsenalBuyButton.enabled = false;
         if(this._quickDrawText != null && _background.contains(this._quickDrawText))
         {
            _background.removeChild(this._quickDrawText);
         }
         this._quickDrawText = this._fontManager.getString("QUICK DRAW","SHOP",1,0);
         this._quickDrawText.x = 278;
         this._quickDrawText.y = 94;
         _background.addChild(this._quickDrawText);
         if(this._buckshotText != null && _background.contains(this._buckshotText))
         {
            _background.removeChild(this._buckshotText);
         }
         this._buckshotText = this._fontManager.getString("BUCKSHOT","SHOP",1,0);
         this._buckshotText.x = this._quickDrawText.x;
         this._buckshotText.y = this._quickDrawText.y + this._quickDrawText.height + 11;
         _background.addChild(this._buckshotText);
         if(this._gungHoText != null && _background.contains(this._gungHoText))
         {
            _background.removeChild(this._gungHoText);
         }
         this._gungHoText = this._fontManager.getString("GUNG-HO","SHOP",1,0);
         this._gungHoText.x = this._buckshotText.x;
         this._gungHoText.y = this._buckshotText.y + this._buckshotText.height + 11;
         _background.addChild(this._gungHoText);
         if(this._bbqueText != null && _background.contains(this._bbqueText))
         {
            _background.removeChild(this._bbqueText);
         }
         this._bbqueText = this._fontManager.getString("B. B. QUE","SHOP",1,0);
         this._bbqueText.x = this._gungHoText.x;
         this._bbqueText.y = this._gungHoText.y + this._gungHoText.height + 11;
         _background.addChild(this._bbqueText);
         if(this._eagleEyeText != null && _background.contains(this._eagleEyeText))
         {
            _background.removeChild(this._eagleEyeText);
         }
         this._eagleEyeText = this._fontManager.getString("EAGLE EYE","SHOP",1,0);
         this._eagleEyeText.x = this._bbqueText.x;
         this._eagleEyeText.y = this._bbqueText.y + this._bbqueText.height + 11;
         _background.addChild(this._eagleEyeText);
         if(this._heavyArmsText != null && _background.contains(this._heavyArmsText))
         {
            _background.removeChild(this._heavyArmsText);
         }
         this._heavyArmsText = this._fontManager.getString("HEAVY ARMS","SHOP",1,0);
         this._heavyArmsText.x = this._eagleEyeText.x;
         this._heavyArmsText.y = this._eagleEyeText.y + this._eagleEyeText.height + 11;
         _background.addChild(this._heavyArmsText);
         if(this._damageText != null && _background.contains(this._damageText))
         {
            _background.removeChild(this._damageText);
         }
         this._damageText = this._fontManager.getString("N/A","SHOP",1,0);
         this._damageText.x = 366 - this._damageText.width/2;
         this._damageText.y = 160;
         _background.addChild(this._damageText);
         if(this._rateOfFireText != null && _background.contains(this._rateOfFireText))
         {
            _background.removeChild(this._rateOfFireText);
         }
         this._rateOfFireText = this._fontManager.getString("N/A","SHOP",1,0);
         this._rateOfFireText.x = 416 - this._rateOfFireText.width/2;
         this._rateOfFireText.y = this._damageText.y;
         _background.addChild(this._rateOfFireText);
         if(this._troopStockText != null && _background.contains(this._troopStockText))
         {
            _background.removeChild(this._troopStockText);
         }
         this._troopStockText = this._fontManager.getString("0","SHOP",1,0);
         this._troopStockText.x = 470 - this._troopStockText.width/2;
         this._troopStockText.y = this._rateOfFireText.y;
         _background.addChild(this._troopStockText);
         if(this._troopCostText != null && _background.contains(this._troopCostText))
         {
            _background.removeChild(this._troopCostText);
         }
         this._troopCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
         this._troopCostText.x = 359;
         this._troopCostText.y = 175;
         priceMark(this._troopCostText); _background.addChild(this._troopCostText);
         this._activeTroop = -1;
         this._topSecret.visible = true;
         this._quickDrawButton.enabled = true;
         this._gungHoButton.enabled = true;
         this._buckshotButton.enabled = true;
         this._eagleEyeButton.enabled = true;
         this._heavyArmsButton.enabled = true;
         this._bbqueButton.enabled = true;
         if(this._wallCostText != null && _background.contains(this._wallCostText))
         {
            _background.removeChild(this._wallCostText);
         }
         this._wallCostText = this._fontManager.getString("0","SHOP_DIGITS",1,0);
         this._wallCostText.x = 384;
         this._wallCostText.y = 343;
         priceMark(this._wallCostText); _background.addChild(this._wallCostText);
         if(this._wallLevelText != null && _background.contains(this._wallLevelText))
         {
            _background.removeChild(this._wallLevelText);
         }
         this._wallLevelText = this._fontManager.getString("T:" + String(this._wallLevel + 1),"SHOP",1,0);
         this._wallLevelText.x = 488 - this._wallLevelText.width;
         this._wallLevelText.y = 218;
         _background.addChild(this._wallLevelText);
         this._wallBuyButton.enabled = false;
         this._wallBuyButton.removeMouseEvents();
      }
      
      public function updateAudio() : void
      {
         this._options.updateAudio();
      }
      
      private function optionsMenuEvents(param1:GameEvent) : void
      {
         if(param1.type == GameEvent.CONFIRM)
         {
            this._options.removeEventListener(GameEvent.CONFIRM,this.optionsMenuEvents);
         }
         this._options.removeEventListeners();
         this.dispatchEvent(param1);
      }
      
      public function get money() : Number
      {
         return this._money;
      }
      
      public function get grenades() : int
      {
         return this._grenades;
      }
      
      public function get payloads() : int
      {
         return this._payloads;
      }
      
      public function get wallHealth() : int
      {
         return this._wallHealth;
      }
      
      public function get wallLevel() : int
      {
         return this._wallLevel;
      }
      
      public function get loadout() : Array
      {
         return this._troopSelection.loadout;
      }

      private static function shopFrame(p:Sprite,x:Number,y:Number,w:Number,h:Number,color:uint=0x080d0e):void {
       p.graphics.lineStyle();p.graphics.beginFill(color,0.98);p.graphics.drawRect(x,y,w,h);p.graphics.endFill();
       p.graphics.lineStyle(1,(w==509?0x67736d:0x35433b));p.graphics.drawRect(x+0.5,y+0.5,w-1,h-1);
       if(w==509){p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(x+2.5,y+2.5,w-5,h-5);}
      }
      private static function shopText(p:Sprite,value:String,x:Number,y:Number,scale:Number=1):void {
       var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.x=x;t.y=y;t.scaleX=t.scaleY=scale;p.addChild(t);
      }
      private static function shopBackground():Bitmap {
       var p:Sprite=new Sprite();shopFrame(p,0,0,509,441);
       shopText(p,"SHOP",17,14,2.5);shopText(p,"SCORE",228,15);shopText(p,"MONEY",355,15);
       shopFrame(p,12,56,111,226);shopText(p,"ARSENAL",36,70,1.3);
       shopFrame(p,125,56,121,226);
       var labels:Array=["POWER","ACC","CLIP SIZE","AMMO","STOCK"];
       for(var i:int=0;i<5;i++){p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(129,145+i*17);p.graphics.lineTo(241,145+i*17);shopText(p,labels[i],130,150+i*17);}
       shopFrame(p,253,56,244,139);shopText(p,"TROOPS",280,70,1.3);
       shopText(p,"DMG",354,148);shopText(p,"R/S",404,148);shopText(p,"STOCK",454,148);
       shopFrame(p,253,201,244,184);shopText(p,"BARRICADE",335,213,1.3);shopText(p,"REPAIR",259,346);
       shopFrame(p,12,289,234,140);shopText(p,"MISSION REPORT",57,302,1.3);
       var report:Array=["WAVE","SCORE","MONEY EARNED","GRUNTS KILLED","VEHICLES DESTROYED","BARRICADE HEALTH"];
       for(i=0;i<6;i++){p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(21,338+i*17);p.graphics.lineTo(236,338+i*17);shopText(p,report[i],23,326+i*17);}
       var data:BitmapData=new BitmapData(509,441,true,0);data.draw(p);return new Bitmap(data);
      }
      private static function shopButton(w:int,h:int,frames:int,value:String):Bitmap {
       var data:BitmapData=new BitmapData(w,h*frames,true,0);
       for(var i:int=0;i<frames;i++){
        var p:Sprite=new Sprite();
        if(value.length==0 && w>70){
         p.graphics.beginFill(i==0?0x080d0e:(i==1?0x1e2c23:0x30442b));p.graphics.drawRect(0,0,w,h);p.graphics.endFill();
         if(i==2){p.graphics.beginFill(0x9ac76a);p.graphics.drawRect(0,2,2,h-4);p.graphics.endFill();}
        }else {shopFrame(p,0,0,w,h,value=="NEXT WAVE"?(i==0?0x4c6b33:0x648b43):(i==0?0x111715:(i==1?0x3c592e:0x597b3c)));}
        if(!(value.length==0 && w>70)) {p.graphics.lineStyle(1,i==0 && value!="NEXT WAVE"?0x29332c:(i==2?0xb7d796:0x86a66b));p.graphics.drawRect(0.5,0.5,w-1,h-1);}
        if(value.length>0){var size:Number=value=="NEXT WAVE"?2:1;var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.scaleX=t.scaleY=size;t.x=(w-t.width)/2;t.y=(h-t.height)/2;if(i==0 && value!="NEXT WAVE")t.alpha=0.4;p.addChild(t);}
        else if(w>70){p.graphics.lineStyle();p.graphics.beginFill(i==2?0xa0ce6b:0xc7d0bf);p.graphics.drawRect(5,5,5,6);p.graphics.drawRect(10,6,3,4);p.graphics.endFill();}
        var m:Matrix=new Matrix();m.translate(0,i*h);data.draw(p,m);
       }return new Bitmap(data);
      }

      public function grantTestingMoney():void {
       this._money+=2000;
       var weapons:Array=[_pistolButton,_smgButton,_shotgunButton,_assaultRifleButton,_sniperButton,_rpgButton,_railgunButton,_chaingunButton,_photonCannonButton,_grenadeButton,_payloadButton];
       if(_activeWeapon>=0)weapons[_activeWeapon].dispatchEvent(new GameEvent(GameEvent.CLICKED));
       var troops:Array=[_quickDrawButton,_gungHoButton,_buckshotButton,_eagleEyeButton,_heavyArmsButton,_bbqueButton];
       if(_activeTroop>=0)troops[_activeTroop].dispatchEvent(new GameEvent(GameEvent.CLICKED));
       if(_activeUpgrade==1)updateRepairCost(null);else wallButtonHandler(null);
      }
      private function refreshRepairLabel(e:Event):void {
       if(!visible||!_repairBar)return;
       refreshActionStates();
       refreshPurchaseActions();
       var value:String=_wallLevel>=2?"MAXIMUM TIER":"UPGRADE TO TIER "+String(_wallLevel+2);if(value==_repairLabelValue)return;_repairLabelValue=value;
       if(_repairHealthLabel)_background.removeChild(_repairHealthLabel);
       _repairHealthLabel=_fontManager.getString(value,"SHOP",1,0);
       _repairHealthLabel.x=258;_repairHealthLabel.y=371;
       _background.addChild(_repairHealthLabel);
      }
      private function priceMark(p:Sprite):void {
       var mark:Sprite=new Sprite();var rows:Array=["01110","11000","11000","01110","00011","00011","11110"];
       mark.graphics.beginFill(0xcbd5c4);for(var y:int=0;y<7;y++)for(var x:int=0;x<5;x++)if(String(rows[y]).charAt(x)=="1")mark.graphics.drawRect(x,y,1,1);
       mark.graphics.drawRect(2,-1,1,9);mark.graphics.endFill();mark.x=-8;mark.y=2;p.addChild(mark);
      }

      private static function highResolutionBarricade():Bitmap {
       var images:ImageManager=ImageManager.getInstance();var sheet:BitmapData=new BitmapData(940,1212,true,0);
       for(var tier:int=0;tier<3;tier++){
        var scene:Sprite=new Sprite();var background:Bitmap=images.getImage("background");background.scaleX=background.scaleY=1.016;background.x=-656;background.y=-88;scene.addChild(background);
        var right:AnimatedSprite=new AnimatedSprite(images.getImage("walls_right"),489,310,3);right.addSequence("STILL",tier+1,tier+1,0,0);right.gotoAndStop("STILL");right.scaleX=right.scaleY=1.02;right.x=540;right.y=76;scene.addChild(right);
        var left:AnimatedSprite=new AnimatedSprite(images.getImage("walls_left"),499,302,3);left.addSequence("STILL",tier+1,tier+1,0,0);left.gotoAndStop("STILL");left.scaleX=left.scaleY=1.04;left.x=-128;left.y=76;scene.addChild(left);
        var frame:BitmapData=new BitmapData(940,404,true,0);var crop:Matrix=new Matrix();frame.draw(scene,crop,null,null,null,false);sheet.copyPixels(frame,frame.rect,new Point(0,tier*404));frame.dispose();
       }return new Bitmap(sheet);
      }

      private function statusCard(value:String,x:Number,y:Number,w:Number,h:Number):Sprite {
       var p:Sprite=new Sprite();p.x=x;p.y=y;p.mouseEnabled=false;p.mouseChildren=false;shopFrame(p,0,0,w,h,0x111715);
       var t:Sprite=_fontManager.getString(value,"SHOP",1,0);t.x=(w-t.width)/2;t.y=(h-t.height)/2;t.alpha=0.5;p.addChild(t);_background.addChild(p);return p;
      }
      private function refreshActionStates():void {
       if(!_arsenalMax){_arsenalMax=statusCard("MAXED",127,230,114,23);_wallMax=statusCard("MAXED",258,365,51,18);_repairFull=statusCard("FULL",449,340,42,18);}
       _arsenalMax.visible=_activeWeapon>=0 && _activeWeapon<9 && _shopStats[_activeWeapon].level>=2;
       _wallMax.visible=_wallLevel>=2;
       _repairFull.visible=_activeUpgrade==1 && _wallHealth>=_wallLevel*50+100;
       _upgradeText.alpha=_wallUpgradeButton.enabled?1:0.4;
      }

      private function actionFace(b:Sprite,value:String,available:Boolean,w:Number,h:Number):void {
       b.graphics.clear();b.graphics.beginFill(available?0x3c592e:0x111715);b.graphics.drawRect(0,0,w,h);b.graphics.endFill();b.graphics.lineStyle(1,available?0x86a66b:0x29332c);b.graphics.drawRect(0.5,0.5,w-1,h-1);
       while(b.numChildren>0)b.removeChildAt(0);
       var t:Sprite=_fontManager.getString(value,"SHOP",1,0);t.x=(w-t.width)/2;t.y=(h-t.height)/2;t.alpha=available?1:0.4;t.mouseEnabled=false;t.mouseChildren=false;b.addChild(t);b.buttonMode=available;b.mouseChildren=false;
      }
      private function refreshPurchaseActions():void {
       _arsenalUpgradeButton.visible=false;if(_arsenalMax)_arsenalMax.visible=false;
       if(_activeWeapon>=0){
        var owned:Boolean=_activeWeapon<9 && _weaponStats.purchased;
        var maxed:Boolean=owned && _shopStats[_activeWeapon].level>=2;
        var name:String=maxed?"MAXED":(_activeWeapon==9?"BUY GRENADE":(_activeWeapon==10?"BUY PAYLOAD":(owned?"UPGRADE TO TIER "+String(_shopStats[_activeWeapon].level+2):"BUY WEAPON")));
        _arsenalBuyButton.visible=true;
        _arsenalBuyButton.getChildAt(0).visible=false;
        if(weaponActionText)_arsenalBuyButton.removeChild(weaponActionText);
        _arsenalBuyButton.graphics.clear();_arsenalBuyButton.graphics.beginFill(!maxed&&_arsenalBuyButton.enabled?0x3c592e:0x111715);_arsenalBuyButton.graphics.drawRect(0,0,114,23);_arsenalBuyButton.graphics.endFill();_arsenalBuyButton.graphics.lineStyle(1,!maxed&&_arsenalBuyButton.enabled?0x86a66b:0x29332c);_arsenalBuyButton.graphics.drawRect(0.5,0.5,113,22);
        weaponActionText=_fontManager.getString(name,"SHOP",1,0);weaponActionText.x=(114-weaponActionText.width)/2;weaponActionText.y=8;weaponActionText.alpha=!maxed&&_arsenalBuyButton.enabled?1:0.4;weaponActionText.mouseEnabled=false;weaponActionText.mouseChildren=false;_arsenalBuyButton.addChild(weaponActionText);
        if(maxed)_arsenalBuyButton.enabled=false;
        _arsenalCostText.y=239;
       }
       _wallUpgradeButton.visible=false;_wallBuyButton.visible=false;_upgradeText.visible=false;if(_wallMax)_wallMax.visible=false;if(_repairFull)_repairFull.visible=false;if(_wallCostText)_wallCostText.visible=false;
       if(!repairAction){repairAction=new Sprite();repairAction.x=443;repairAction.y=340;_background.addChild(repairAction);repairAction.addEventListener(MouseEvent.CLICK,repairPurchase);upgradeAction=new Sprite();upgradeAction.x=443;upgradeAction.y=365;_background.addChild(upgradeAction);upgradeAction.addEventListener(MouseEvent.CLICK,wallPurchase);}
       var repairCost:Number=Math.max(0,_repairBar.health-_wallHealth)*(_wallLevel==0?1:(_wallLevel==1?3:6));
       actionFace(repairAction,"REPAIR",repairCost>0&&_money>=repairCost,48,18);
       var upgradeCost:Number=_wallLevel==0?1000:2000;
       actionFace(upgradeAction,_wallLevel>=2?"MAXED":"UPGRADE",_wallLevel<2&&_money>=upgradeCost,48,18);
       if(repairPriceText)_background.removeChild(repairPriceText);repairPriceText=_fontManager.getString(String(repairCost),"SHOP_DIGITS",1,_money>=repairCost?0:1);repairPriceText.x=384;repairPriceText.y=343;priceMark(repairPriceText);_background.addChild(repairPriceText);
       if(upgradePriceText)_background.removeChild(upgradePriceText);upgradePriceText=_fontManager.getString(_wallLevel>=2?"0":String(upgradeCost),"SHOP_DIGITS",1,_money>=upgradeCost?0:1);upgradePriceText.x=384;upgradePriceText.y=368;priceMark(upgradePriceText);upgradePriceText.visible=_wallLevel<2;_background.addChild(upgradePriceText);
      }
      private function repairPurchase(e:MouseEvent):void {var cost:Number=Math.max(0,_repairBar.health-_wallHealth)*(_wallLevel==0?1:(_wallLevel==1?3:6));if(cost<=0||_money<cost)return;updateRepairCost(null);buyWallUpgrade(null);}
      private function wallPurchase(e:MouseEvent):void {var cost:Number=_wallLevel==0?1000:2000;if(_wallLevel>=2||_money<cost)return;wallButtonHandler(null);buyWallUpgrade(null);}
   }
}












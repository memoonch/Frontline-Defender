package src.components
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Collision;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.display.SpecialEffect;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import src.Main;
   import src.components.gui.AttackIcon;
   import src.data.WaveData;
   import src.data.WeaponData;
   import src.game.*;
   import src.game.pools.*;
   import src.interfaces.GameoverMenu;
   import src.interfaces.ShopMenu;
   import src.managers.NewSoundManager;
   
   public class Game extends Sprite
   {
      
      private static const ALLY_POSITIONS:Array = new Array(new Point(722,294),new Point(872,369),new Point(1022,444),new Point(930,294),new Point(1080,369),new Point(1230,444));
      
      private static const SPAWN_BOUND_TOP:int = 264;
      
      private static const EASING:Number = 0.5;
      
      private var _imageManager:ImageManager;
      
      private var _soundManager:NewSoundManager;
      
      private var _background:Background;
      
      public var mouseOnScreen:Boolean;
      
      private var _offsetX:Number;
      
      private var _mousePosition:Point;
      
      private var _gui:GUI;
      
      private var _crosshair:Crosshair;
      
      private var _attackIcon:AttackIcon;
      
      private var _paused:Boolean;
      
      private var _shopMenu:ShopMenu;
      
      private var _gameoverMenu:GameoverMenu;
      
      private var _enemyPool:EnemyPool;
      
      private var _allyPool:AllyPool;
      
      private var _effectsPool:EffectsPool;
      
      private var _enemies:Array;
      
      private var _allies:Array;
      
      private var _effects:Array;
      
      private var _projectiles:Array;
      
      private var _payloads:Array;
      
      public var leftKeyPressed:Boolean;
      
      public var rightKeyPressed:Boolean;
      
      private var _activeWeapon:int;
      
      private var _weaponData:WeaponData;
      
      private var _weaponStats:Object;
      
      public var isShooting:Boolean;
      
      private var _isReloading:Boolean;
      
      private var _health:int;
      
      private var _score:Number;
      
      private var _money:Number;
      
      private var _grenades:int;
      
      private var _bombs:int;
      
      private var _isShopping:Boolean;
      
      private var _isVictory:Boolean;
      
      private var _level:int;
      
      private var _droppingBombs:Boolean;
      
      private var _bombCounter:int;
      
      private var _bombPosition:int;
      
      private var _shotCounter:int;
      
      private var _reloadCounter:int;
      
      private var _spawnCounter:int;
      
      private var _enemyAsync:int;
      
      private var _allyAsync:int;
      
      private var _effectAsync:int;
      
      private var _projectileAsync:int;
      
      private var _payloadCounter:int;
      
      private var _wave:int;
      
      private var _waveData:WaveData;
      
      private var _waveSpawns:Array;
      
      private var _lanes:Array;
      
      private var _aerialLanes:Array;
      
      private var _shakeCounter:int;
      
      private var _isShaking:Boolean;
      
      private var _scoreEarned:int;
      
      private var _moneyEarned:int;
      
      private var _soldiersKilled:int;
      
      private var _vehiclesKilled:int;
      
      private var _totalMoney:int;
      
      private var _totalSoldiers:int;
      
      private var _totalVehicles:int;
      
      private var _screenFade:Sprite;
      
      private var _tutorials:Array;
      
      private var _prompt:AnimatedSprite;
      
      public function Game()
      {
         super();
         this._soundManager = NewSoundManager.getInstance();
         this.InitializeDisplay();
         this.leftKeyPressed = false;
         this.rightKeyPressed = false;
         this.isShooting = false;
         this._isReloading = false;
         this._isShopping = false;
         this._isVictory = false;
         this._offsetX = 0;
         this._health = 100;
         this._score = 0;
         this._money = 0;
         this._grenades = 0;
         this._bombs = 0;
         this._level = 0;
         this._paused = false;
         this._droppingBombs = false;
         this._bombCounter = 0;
         this._bombPosition = 100;
         this._tutorials = new Array(false,false,false,false,false,false,false);
         this._shotCounter = 0;
         this._reloadCounter = 0;
         this._spawnCounter = 60;
         this._enemyAsync = -1;
         this._allyAsync = -1;
         this._effectAsync = -1;
         this._projectileAsync = -1;
         this._payloadCounter = -1;
         this._weaponData = new WeaponData();
         this._activeWeapon = 0;
         this._weaponStats = this._weaponData.getProperties(this._activeWeapon);
         this._enemyPool = EnemyPool.getInstance();
         this._allyPool = AllyPool.getInstance();
         this._effectsPool = EffectsPool.getInstance();
         this._enemies = new Array();
         this._allies = new Array();
         this._effects = new Array();
         this._projectiles = new Array();
         this._payloads = new Array();
         this._wave = 0;
         this._waveData = WaveData.getInstance();
         this.getWaveData();
         this._lanes = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 40)
         {
            this._lanes.push(_loc1_);
            _loc1_++;
         }
         this._lanes = Calc.shuffle(this._lanes);
         this._aerialLanes = new Array();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            this._aerialLanes.push(_loc1_);
            _loc1_++;
         }
         this._aerialLanes = Calc.shuffle(this._aerialLanes);
         this._shakeCounter = 0;
         this._isShaking = false;
         this._scoreEarned = 0;
         this._moneyEarned = 0;
         this._soldiersKilled = 0;
         this._vehiclesKilled = 0;
         this._totalMoney = 0;
         this._totalSoldiers = 0;
         this._totalVehicles = 0;
         this.mouseOnScreen = true;
         this.stopScroll();
         this._screenFade = new Sprite();
         this._screenFade.graphics.beginFill(0);
         this._screenFade.graphics.drawRect(0,0,Window.width,Window.height);
         this._screenFade.graphics.endFill();
         this._screenFade.alpha = 0;
         this._screenFade.visible = false;
         this.addChild(this._screenFade);
      }
      
      private function InitializeDisplay() : void
      {
         this._background = new Background();
         this.addChild(this._background);
         this._attackIcon = new AttackIcon();
         this._attackIcon.x = 10;
         this._attackIcon.y = 150;
         this._attackIcon.visible = false;
         this.addChild(this._attackIcon);
         this._crosshair = new Crosshair();
         this._crosshair.x = -100;
         this._crosshair.y = -100;
         this.addChild(this._crosshair);
         this._imageManager = ImageManager.getInstance();
         this._prompt = new AnimatedSprite(this._imageManager.getImage("prompts"),235,10,7);
         this._prompt.addSequence("TUTORIAL_01",1,1,0,0);
         this._prompt.addSequence("TUTORIAL_02",2,2,0,0);
         this._prompt.addSequence("TUTORIAL_03",3,3,0,0);
         this._prompt.addSequence("TUTORIAL_04",4,4,0,0);
         this._prompt.addSequence("TUTORIAL_05",5,5,0,0);
         this._prompt.addSequence("TUTORIAL_06",6,6,0,0);
         this._prompt.addSequence("TUTORIAL_07",7,7,0,0);
         this._prompt.gotoAndStop("TUTORIAL_01");
         this._prompt.x = Calc.center(Window.width,this._prompt.width);
         this._prompt.y = 85;
         this._prompt.visible = false;
         this.addChild(this._prompt);
         this._gui = new GUI();
         this._gui.addEventListener(GameEvent.PAUSE,this.togglePause,false,0,true);
         this._gui.addEventListener(GameEvent.RESUME,this.togglePause,false,0,true);
         this._gui.addEventListener(GameEvent.CONFIRM,this.quitGame,false,0,true);
         this.addChild(this._gui);
         this._shopMenu = new ShopMenu();
         this._shopMenu.visible = false;
         this._shopMenu.addEventListener(GameEvent.RESUME,this.CloseShop,false,0,true);
         this._shopMenu.addEventListener(GameEvent.FINISHED,this.WaveFailed,false,0,true);
         this._shopMenu.addEventListener(GameEvent.CONFIRM,this.quitGame,false,0,true);
         this.addChild(this._shopMenu);
         this._gameoverMenu = new GameoverMenu();
         this._gameoverMenu.visible = false;
         this._gameoverMenu.addEventListener(GameEvent.CANCEL,this.quitGame,false,0,true);
         this._gameoverMenu.addEventListener(GameEvent.CONFIRM,this.quitGame,false,0,true);
         this.addChild(this._gameoverMenu);
      }
      
      public function addEventListeners() : void
      {
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.setMousePosition,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.startShooting,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,this.stopShooting,false,0,true);
         this.addEventListener(Event.ENTER_FRAME,this.update,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.setMousePosition);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.startShooting);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.stopShooting);
         this.removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function update(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:Payload = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Enemy = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc2_:Boolean = false;
         if(!this._tutorials[4] || !this._tutorials[5])
         {
            _loc8_ = 1;
            while(_loc8_ < 9)
            {
               _loc9_ = this._weaponData.getProperties(_loc8_);
               if(_loc9_.purchased)
               {
                  _loc2_ = true;
                  break;
               }
               _loc8_++;
            }
         }
         if(!this._tutorials[0] && !this._prompt.visible)
         {
            this._prompt.gotoAndStop("TUTORIAL_01");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[1] && !this._prompt.visible)
         {
            this._prompt.gotoAndStop("TUTORIAL_02");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[2] && !this._prompt.visible && this._weaponStats.magazine <= this._weaponStats.clipSize / 2)
         {
            this._prompt.gotoAndStop("TUTORIAL_03");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[3] && !this._prompt.visible && this._grenades > 0)
         {
            this._prompt.gotoAndStop("TUTORIAL_04");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[4] && !this._prompt.visible && this._bombs > 0)
         {
            this._prompt.gotoAndStop("TUTORIAL_05");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[5] && !this._prompt.visible && _loc2_)
         {
            this._prompt.gotoAndStop("TUTORIAL_06");
            this._prompt.visible = true;
         }
         else if(!this._tutorials[6] && !this._prompt.visible && _loc2_)
         {
            this._prompt.gotoAndStop("TUTORIAL_07");
            this._prompt.visible = true;
         }
         if(!this._tutorials[0] && this._prompt.sequence == "TUTORIAL_01" && (this.leftKeyPressed || this.rightKeyPressed))
         {
            this._tutorials[0] = true;
            this._prompt.visible = false;
         }
         this._attackIcon.update();
         if(this._attackIcon.visible)
         {
            if(this._soundManager.isSoundStopped("alarm"))
            {
               this._soundManager.playSound("alarm",-1);
            }
         }
         else
         {
            this._soundManager.stopSound("alarm");
         }
         this._crosshair.update();
         this.Scroll();
         if(this._isShaking)
         {
            if(this._shakeCounter % 2 == 0)
            {
               this._background.shakeScreen();
            }
            ++this._shakeCounter;
            if(this._shakeCounter >= 30)
            {
               this._shakeCounter = 0;
               this._isShaking = false;
               this._background.finishedShaking();
            }
         }
         if(this.isShooting && !this._isReloading && this._mousePosition.y >= 80 || this._shotCounter != 0)
         {
            if(this._shotCounter == 0)
            {
               this.shoot();
            }
            ++this._shotCounter;
            if(this._shotCounter >= this._weaponStats.rateOfFire)
            {
               this._shotCounter = 0;
            }
         }
         if(this._isReloading)
         {
            this.reload();
         }
         if(this._weaponStats.updated)
         {
            this._weaponStats.updated = false;
            this._weaponData.setProperties(this._activeWeapon,this._weaponStats);
         }
         if(this._droppingBombs)
         {
            ++this._bombCounter;
            if(this._bombCounter >= 10)
            {
               _loc10_ = this._effectsPool.getPayload(Calc.random(264,454));
               _loc10_.x = this._bombPosition;
               _loc10_.y = _loc10_.target - Window.height * 2;
               _loc10_.shadow.x = _loc10_.x;
               _loc10_.shadow.y = _loc10_.target;
               this._background.addToLayer(_loc10_.shadow,3);
               this._payloads.push(_loc10_);
               this._background.addToLayer(_loc10_,3);
               this._bombCounter = 0;
               this._bombPosition += 200;
               this._soundManager.playSound("bomb");
               if(this._bombPosition >= this._background.width)
               {
                  this._droppingBombs = false;
               }
            }
         }
         if(this._waveSpawns.length > 0 && !this._isShopping)
         {
            ++this._spawnCounter;
            if(this._spawnCounter >= 120 && this._enemies.length < 20)
            {
               _loc11_ = Calc.random(0,99);
               if(_loc11_ <= 84)
               {
                  _loc12_ = 1;
               }
               else if(_loc11_ <= 97)
               {
                  _loc12_ = 2;
               }
               else
               {
                  _loc12_ = 3;
               }
               if(this._waveSpawns.length < _loc12_)
               {
                  _loc12_ = int(this._waveSpawns.length);
               }
               _loc13_ = 0;
               while(_loc13_ < _loc12_)
               {
                  _loc14_ = false;
                  if(this._waveSpawns[0] == 2 || this._waveSpawns[0] == 5)
                  {
                     if(this._aerialLanes.length == 0)
                     {
                        this._waveSpawns.push(this._waveSpawns[0]);
                        this._waveSpawns.splice(0,1);
                        _loc14_ = true;
                     }
                     else
                     {
                        if(this._aerialLanes[0] == 0)
                        {
                           _loc16_ = 1;
                        }
                        else if(this._aerialLanes[0] == 1)
                        {
                           _loc16_ = -1;
                        }
                        this._aerialLanes.splice(0,1);
                     }
                  }
                  else if(this._lanes.length == 0)
                  {
                     this._waveSpawns.push(this._waveSpawns[0]);
                     this._waveSpawns.splice(0,1);
                     _loc14_ = true;
                  }
                  else
                  {
                     _loc15_ = Calc.random(0,this._lanes.length - 1);
                     if(this._lanes[_loc15_] < 20)
                     {
                        _loc16_ = 1;
                     }
                     else
                     {
                        _loc16_ = -1;
                     }
                  }
                  if(!_loc14_)
                  {
                     _loc17_ = this._enemyPool.getEnemy(_loc16_,this._waveSpawns[0],this._level);
                     if(_loc17_.data.isAir)
                     {
                        if(_loc17_.data.name == "Plane")
                        {
                           _loc17_.y = 160;
                        }
                        else
                        {
                           _loc17_.y = 200;
                        }
                     }
                     else
                     {
                        _loc17_.y = this._lanes[_loc15_] % 20 * 10 + SPAWN_BOUND_TOP;
                        this._lanes.splice(_loc15_,1);
                     }
                     if(_loc16_ == 1)
                     {
                        _loc17_.x = -150;
                        this._background.addToLayer(_loc17_,0);
                     }
                     else
                     {
                        _loc17_.x = this._background.width + 150;
                        if(_loc17_.data.isAir)
                        {
                           this._background.addToLayer(_loc17_,0);
                        }
                        else
                        {
                           this._background.addToLayer(_loc17_,1);
                        }
                     }
                     _loc18_ = 0;
                     _loc19_ = 0;
                     while(_loc19_ < this._enemies.length)
                     {
                        if(this._enemies[_loc19_].y > _loc17_.y)
                        {
                           _loc18_ = _loc19_;
                        }
                        _loc19_++;
                     }
                     this._enemies.splice(_loc18_,0,_loc17_);
                     this._waveSpawns.splice(0,1);
                  }
                  _loc13_++;
               }
               this._spawnCounter = Calc.random(0,60);
            }
         }
         this.UpdateEnemies();
         this.UpdateAllies();
         this.UpdateEffects();
         this.UpdateProjectiles();
         this.UpdatePayloads();
         if(this._health <= 0)
         {
            this._health = 0;
            this._isShopping = true;
            this._isVictory = false;
            this._screenFade.visible = true;
         }
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         this._gui.updateHealth(this._health);
         this._gui.clearMinimap();
         _loc19_ = 0;
         while(_loc19_ < this._allies.length)
         {
            this._gui.drawMinimapObject(Math.ceil(this._allies[_loc19_].x / 10),Math.ceil(this._allies[_loc19_].y / 10),0,this._allies[_loc19_].direction);
            _loc19_++;
         }
         _loc19_ = 0;
         while(_loc19_ < this._enemies.length)
         {
            if(!this._enemies[_loc19_].isDead)
            {
               if(this._enemies[_loc19_].data.isAir)
               {
                  _loc6_ = 3;
                  if(this._enemies[_loc19_].data.name == "Helicopter")
                  {
                     _loc4_ = true;
                  }
               }
               else if(this._enemies[_loc19_].data.name == "Humvee" || this._enemies[_loc19_].data.name == "Tank")
               {
                  _loc6_ = 2;
                  _loc5_ = true;
               }
               else
               {
                  _loc6_ = 1;
               }
               this._gui.drawMinimapObject(Math.ceil(this._enemies[_loc19_].x / 10),Math.ceil(this._enemies[_loc19_].y / 10),_loc6_,this._enemies[_loc19_].direction);
               _loc3_ = true;
            }
            _loc19_++;
         }
         if(_loc4_)
         {
            if(this._soundManager.isSoundStopped("helicopter"))
            {
               this._soundManager.playSound("helicopter",-1);
            }
         }
         else
         {
            this._soundManager.stopSound("helicopter");
         }
         if(_loc5_)
         {
            if(this._soundManager.isSoundStopped("truck"))
            {
               this._soundManager.playSound("truck",-1);
            }
         }
         else
         {
            this._soundManager.stopSound("truck");
         }
         var _loc7_:Boolean = false;
         _loc19_ = 0;
         while(_loc19_ < this._projectiles.length)
         {
            if(this._projectiles[_loc19_] is Flame)
            {
               _loc7_ = true;
               break;
            }
            _loc19_++;
         }
         if(_loc7_)
         {
            if(this._soundManager.isSoundStopped("flamethrower"))
            {
               this._soundManager.playSound("flamethrower",-1);
            }
         }
         else
         {
            this._soundManager.stopSound("flamethrower");
         }
         this._gui.sortMinimap();
         if(this._waveSpawns.length <= 0 && !_loc3_ && !this._isShopping)
         {
            this._isShopping = true;
            this._isVictory = true;
            this._screenFade.visible = true;
         }
         if(this._screenFade.visible)
         {
            if(this._isShopping)
            {
               this._screenFade.alpha += 0.02;
               if(this._screenFade.alpha >= 0.7)
               {
                  this._screenFade.visible = false;
                  if(this._isVictory)
                  {
                     this.OpenShop();
                     this._spawnCounter = 60;
                     ++this._wave;
                     if(this._wave >= 27)
                     {
                        this._level = 2;
                     }
                     else if(this._wave > 17)
                     {
                        this._level = 1;
                     }
                     this._gui.updateWave(this._wave + 1);
                     this.getWaveData();
                  }
                  else
                  {
                     this.Pause();
                     this._gameoverMenu.updateStats(this._wave,this._score,this._totalMoney,this._totalSoldiers,this._totalVehicles);
                     this._gameoverMenu.visible = true;
                     this._gameoverMenu.Activate();
                     this._soundManager.playSound("menu_music",-1);
                  }
               }
            }
            else
            {
               this._screenFade.alpha -= 0.02;
               if(this._screenFade.alpha <= 0)
               {
                  this._screenFade.alpha = 0;
                  this._screenFade.visible = false;
               }
            }
         }
      }
      
      private function UpdateEnemies() : void
      {
         var _loc2_:Enemy = null;
         var _loc3_:Number = NaN;
         var _loc4_:Explosion = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = getTimer();
         this._enemyAsync;
         while(this._enemyAsync > -1)
         {
            if(getTimer() - _loc1_ > 5)
            {
               return;
            }
            _loc2_ = this._enemies[this._enemyAsync];
            if(_loc2_.isAttacking)
            {
               if(_loc2_.animation == "IDLE")
               {
                  _loc2_.animation = "SHOOT";
               }
               else if(_loc2_.animation.indexOf("FIRE") != -1 && !_loc2_.shotFired)
               {
                  _loc2_.shotFired = true;
                  this.enemyShot(_loc2_);
               }
               if(_loc2_.animation.indexOf("FIRE") == -1)
               {
                  _loc2_.shotFired = false;
               }
               if(_loc2_.data.name == "Plane" && !_loc2_.isDead)
               {
                  _loc2_.x += _loc2_.data.speed * _loc2_.direction;
                  if(_loc2_.direction == 1 && (_loc2_.x < 600 || _loc2_.x > 980) || _loc2_.direction == -1 && (_loc2_.x < 1000 || _loc2_.x > 1380))
                  {
                     _loc2_.isAttacking = false;
                     _loc2_.animation = "RUN";
                  }
               }
            }
            else if(!_loc2_.isDead)
            {
               _loc2_.x += _loc2_.data.speed * _loc2_.direction;
               if(_loc2_.data.name == "Sniper" || _loc2_.data.name == "Humvee" || _loc2_.data.name == "Tank")
               {
                  if(_loc2_.direction == 1)
                  {
                     _loc3_ = _loc2_.x;
                  }
                  else if(_loc2_.direction == -1)
                  {
                     _loc3_ = this._background.width - _loc2_.x;
                  }
                  if(_loc3_ >= _loc2_.range)
                  {
                     _loc2_.isAttacking = true;
                     _loc2_.animation = "SHOOT";
                  }
               }
               else if(_loc2_.data.name == "Helicopter")
               {
                  if(_loc2_.direction == 1 && _loc2_.x >= 700 || _loc2_.direction == -1 && _loc2_.x <= 1350)
                  {
                     _loc2_.isAttacking = true;
                     _loc2_.animation = "SHOOT";
                  }
               }
               else if(_loc2_.data.name == "Plane")
               {
                  if(_loc2_.direction == 1 && _loc2_.x >= this._background.width + 500 || _loc2_.direction == -1 && _loc2_.x <= -500)
                  {
                     if(_loc2_.direction == 1)
                     {
                        _loc2_.x = -150;
                     }
                     else if(_loc2_.direction == -1)
                     {
                        _loc2_.x = this._background.width + 150;
                     }
                  }
                  if(_loc2_.direction == 1 && _loc2_.x >= 600 && _loc2_.x <= 980 || _loc2_.direction == -1 && _loc2_.x >= 1000 && _loc2_.x <= 1380)
                  {
                     _loc2_.isAttacking = true;
                     _loc2_.animation = "SHOOT";
                  }
               }
               else
               {
                  _loc3_ = this._background.checkDistance(_loc2_.x,_loc2_.y,_loc2_.direction);
                  if(_loc3_ <= _loc2_.range)
                  {
                     _loc2_.isAttacking = true;
                     _loc2_.animation = "SHOOT";
                  }
                  else if(_loc2_.data.name == "Bomber" && _loc3_ <= _loc2_.range + 35)
                  {
                     _loc2_.animation = "SHOOT";
                  }
               }
            }
            if(_loc2_.isDead)
            {
               if(_loc2_.animation == "DEATH" || _loc2_.animation == "DEATH2")
               {
                  _loc2_.x -= _loc2_.direction * 5;
               }
               else if(_loc2_.animation == "FINISHED")
               {
                  this.cleanUpEnemy(_loc2_);
               }
               else if(_loc2_.animation == "FADE")
               {
                  _loc2_.alpha -= 0.05;
               }
               else if(_loc2_.animation != "DEAD")
               {
                  if(_loc2_.data.name == "Humvee" || _loc2_.data.name == "Tank" || _loc2_.data.name == "Helicopter" || _loc2_.data.name == "Plane")
                  {
                     _loc2_.animation = "DEAD";
                     _loc4_ = new Explosion(_loc2_.Width,_loc2_.Height);
                     _loc4_.x = _loc2_.x + _loc2_.X;
                     _loc4_.y = _loc2_.y + _loc2_.Y;
                     this._background.addToLayer(_loc4_,3);
                     this._effects.push(_loc4_);
                  }
                  else
                  {
                     _loc2_.animation = "DEATH";
                  }
               }
               if(_loc2_.animation == "DEAD" && _loc2_.data.isAir)
               {
                  _loc2_.x += _loc2_.direction * _loc2_.data.speed;
                  _loc2_.y += _loc2_.gravity;
                  ++_loc2_.gravity;
                  if(_loc2_.gravity >= 16)
                  {
                     _loc2_.gravity = 16;
                  }
                  if(_loc2_.y >= 400)
                  {
                     _loc2_.animation = "FADE";
                     _loc4_ = new Explosion(_loc2_.Width,_loc2_.Height);
                     _loc4_.x = _loc2_.x + _loc2_.X;
                     _loc4_.y = _loc2_.y + _loc2_.Y;
                     this._background.addToLayer(_loc4_,3);
                     this._effects.push(_loc4_);
                  }
               }
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < this._allies.length)
               {
                  _loc3_ = Math.abs(_loc2_.x - (this._allies[_loc5_].x + this._allies[_loc5_].data.bulletSpawn.x * this._allies[_loc5_].direction));
                  _loc6_ = this._allies[_loc5_].y - this._allies[_loc5_].data.bulletSpawn.y;
                  if(this._allies[_loc5_].data.name == "Sniper")
                  {
                     if(_loc2_.direction == 1 && this._allies[_loc5_].direction == -1 && _loc2_.x >= this._allies[_loc5_].data.range || _loc2_.direction == -1 && this._allies[_loc5_].direction == 1 && _loc2_.x <= this._background.width - this._allies[_loc5_].data.range)
                     {
                        if(_loc6_ >= _loc2_.y + _loc2_.Y && _loc6_ <= _loc2_.y + _loc2_.Y + _loc2_.Height)
                        {
                           this._allies[_loc5_].isAttacking = true;
                        }
                     }
                  }
                  else if(_loc2_.direction != this._allies[_loc5_].direction && !this._allies[_loc5_].isAttacking && _loc3_ <= this._allies[_loc5_].data.range)
                  {
                     if(_loc6_ >= _loc2_.y + _loc2_.Y && _loc6_ <= _loc2_.y + _loc2_.Y + _loc2_.Height)
                     {
                        this._allies[_loc5_].isAttacking = true;
                     }
                  }
                  _loc5_++;
               }
               if(_loc2_.data.name == "Helicopter")
               {
                  if(_loc2_.hoverCounter % 2 == 0)
                  {
                     _loc2_.y += _loc2_.hoverDirection;
                  }
                  _loc2_.hoverCounter += _loc2_.hoverDirection;
                  if(_loc2_.hoverCounter >= 6 || _loc2_.hoverCounter <= -6)
                  {
                     _loc2_.hoverDirection *= -1;
                  }
               }
            }
            --this._enemyAsync;
         }
         this._enemyAsync = this._enemies.length - 1;
      }
      
      private function UpdateAllies() : void
      {
         var _loc2_:Ally = null;
         var _loc1_:int = getTimer();
         this._allyAsync;
         while(this._allyAsync > -1)
         {
            if(getTimer() - _loc1_ > 5)
            {
               return;
            }
            _loc2_ = this._allies[this._allyAsync];
            if(_loc2_.isAttacking)
            {
               if(_loc2_.animation == "IDLE" || _loc2_.animation == "IDLE2")
               {
                  _loc2_.animation = "SHOOT";
               }
               else if(_loc2_.animation.indexOf("FIRE") != -1 && !_loc2_.shotFired)
               {
                  _loc2_.shotFired = true;
                  this.allyShot(_loc2_);
               }
               if(_loc2_.animation.indexOf("FIRE") == -1)
               {
                  _loc2_.shotFired = false;
                  if(_loc2_.animation.indexOf("SHOOT") == -1)
                  {
                     _loc2_.isAttacking = false;
                  }
               }
            }
            --this._allyAsync;
         }
         this._allyAsync = this._allies.length - 1;
      }
      
      private function UpdateEffects() : void
      {
         var _loc1_:int = getTimer();
         this._effectAsync;
         while(this._effectAsync > -1)
         {
            if(getTimer() - _loc1_ > 5)
            {
               return;
            }
            if(this._effects[this._effectAsync].isFinished)
            {
               this._background.removeFromLayer(this._effects[this._effectAsync],3);
               if(!(this._effects[this._effectAsync] is Explosion))
               {
                  this._effectsPool.returnEffect(this._effects[this._effectAsync]);
               }
               this._effects.splice(this._effectAsync,1);
            }
            --this._effectAsync;
         }
         this._effectAsync = this._effects.length - 1;
      }
      
      private function UpdateProjectiles() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:SpecialEffect = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Rectangle = null;
         var _loc9_:Rectangle = null;
         var _loc10_:SpecialEffect = null;
         var _loc11_:SpecialEffect = null;
         var _loc12_:Explosion = null;
         var _loc1_:int = getTimer();
         this._projectileAsync;
         while(this._projectileAsync > -1)
         {
            if(getTimer() - _loc1_ > 5)
            {
               return;
            }
            _loc2_ = Number(this._projectiles[this._projectileAsync].x);
            _loc3_ = Number(this._projectiles[this._projectileAsync].y);
            _loc4_ = false;
            if(this._projectiles[this._projectileAsync] is Grenade)
            {
               if(this._projectiles[this._projectileAsync].x == this._projectiles[this._projectileAsync].endpoint)
               {
                  _loc4_ = true;
                  _loc5_ = this._effectsPool.getEffect("GROUND_EXPLOSION");
                  this._soundManager.playSound("explosion");
               }
               else
               {
                  _loc2_ = this._projectiles[this._projectileAsync].x + this._projectiles[this._projectileAsync].direction * 15;
                  if(this._projectiles[this._projectileAsync].direction == 1 && _loc2_ > this._projectiles[this._projectileAsync].endpoint || this._projectiles[this._projectileAsync].direction == -1 && _loc2_ < this._projectiles[this._projectileAsync].endpoint)
                  {
                     _loc2_ = Number(this._projectiles[this._projectileAsync].endpoint);
                  }
                  _loc3_ = Math.round(this._projectiles[this._projectileAsync].a * _loc2_ * _loc2_ + this._projectiles[this._projectileAsync].b * _loc2_ + this._projectiles[this._projectileAsync].c);
                  this._projectiles[this._projectileAsync].rotation += this._projectiles[this._projectileAsync].direction * 35;
                  if(this._projectiles[this._projectileAsync].direction == 1 && _loc2_ <= this._projectiles[this._projectileAsync].midpoint || this._projectiles[this._projectileAsync].direction == -1 && _loc2_ > this._projectiles[this._projectileAsync].midpoint)
                  {
                     this._projectiles[this._projectileAsync].scale -= this._projectiles[this._projectileAsync].scaleFactor02;
                  }
                  else
                  {
                     this._projectiles[this._projectileAsync].scale -= this._projectiles[this._projectileAsync].scaleFactor01;
                  }
                  this._projectiles[this._projectileAsync].scaleX = this._projectiles[this._projectileAsync].scaleY = this._projectiles[this._projectileAsync].scale;
               }
            }
            else
            {
               if(!(this._projectiles[this._projectileAsync] is Flame))
               {
                  if(this._projectiles[this._projectileAsync].isAerial)
                  {
                     _loc2_ = this._projectiles[this._projectileAsync].x - this._projectiles[this._projectileAsync].moveVector.x;
                     _loc3_ = this._projectiles[this._projectileAsync].y - this._projectiles[this._projectileAsync].moveVector.y;
                  }
                  else
                  {
                     _loc2_ = this._projectiles[this._projectileAsync].x + this._projectiles[this._projectileAsync].direction * 20;
                     _loc3_ = Number(this._projectiles[this._projectileAsync].y);
                  }
               }
               if(this._projectiles[this._projectileAsync].isEnemy)
               {
                  if(this._projectiles[this._projectileAsync].isAerial)
                  {
                     if(this._projectiles[this._projectileAsync].y >= 320)
                     {
                        if(this._projectiles[this._projectileAsync] is Rocket)
                        {
                           _loc5_ = this._effectsPool.getEffect("EXPLOSION");
                           this._soundManager.playSound("explosion");
                        }
                        else
                        {
                           _loc5_ = this._effectsPool.getEffect("WALL_HIT");
                           this._soundManager.playSound("wall_hit");
                        }
                        _loc4_ = true;
                        switch(this._level)
                        {
                           case 0:
                              this._health -= this._projectiles[this._projectileAsync].damage;
                              break;
                           case 1:
                              this._health -= Math.ceil(this._projectiles[this._projectileAsync].damage * 1.5);
                              break;
                           case 2:
                              this._health -= this._projectiles[this._projectileAsync].damage * 2;
                        }
                        if(this._background.x <= 420 && this._projectiles[this._projectileAsync].direction == -1)
                        {
                           this._attackIcon.x = Window.width - this._attackIcon.width - 10;
                           this._attackIcon.switchDirections(1);
                        }
                        else if(this._background.x >= 900 && this._projectiles[this._projectileAsync].direction == 1)
                        {
                           this._attackIcon.x = 10;
                           this._attackIcon.switchDirections(-1);
                        }
                     }
                  }
                  else
                  {
                     if(this._projectiles[this._projectileAsync].direction == 1)
                     {
                        _loc6_ = this._background.checkDistance(_loc2_,_loc3_,this._projectiles[this._projectileAsync].direction,true);
                     }
                     else
                     {
                        _loc6_ = this._background.checkDistance(_loc2_ - 60,_loc3_,this._projectiles[this._projectileAsync].direction,true);
                     }
                     if(this._projectiles[this._projectileAsync].direction == 1 && _loc6_ > 0 || this._projectiles[this._projectileAsync].direction == -1 && (_loc6_ < 0 || _loc2_ <= 1010))
                     {
                        _loc5_ = this._effectsPool.getEffect("WALL_HIT");
                        this._soundManager.playSound("wall_hit");
                        _loc2_ = this._projectiles[this._projectileAsync].x - this._background.checkDistance(this._projectiles[this._projectileAsync].x,this._projectiles[this._projectileAsync].y,this._projectiles[this._projectileAsync].direction,true);
                        if(this._projectiles[this._projectileAsync].direction == -1)
                        {
                           _loc2_ += 60;
                           if(_loc2_ <= 1010)
                           {
                              _loc2_ = 1010;
                           }
                        }
                        _loc4_ = true;
                        switch(this._level)
                        {
                           case 0:
                              this._health -= this._projectiles[this._projectileAsync].damage;
                              break;
                           case 1:
                              this._health -= Math.ceil(this._projectiles[this._projectileAsync].damage * 1.5);
                              break;
                           case 2:
                              this._health -= this._projectiles[this._projectileAsync].damage * 2;
                        }
                        if(this._background.x <= 420 && this._projectiles[this._projectileAsync].direction == -1)
                        {
                           this._attackIcon.x = Window.width - this._attackIcon.width - 10;
                           this._attackIcon.switchDirections(1);
                        }
                        else if(this._background.x >= 900 && this._projectiles[this._projectileAsync].direction == 1)
                        {
                           this._attackIcon.x = 10;
                           this._attackIcon.switchDirections(-1);
                        }
                     }
                  }
               }
               else
               {
                  _loc7_ = 0;
                  while(_loc7_ < this._enemies.length)
                  {
                     _loc8_ = new Rectangle(this._projectiles[this._projectileAsync].x - this._projectiles[this._projectileAsync].width / 2,this._projectiles[this._projectileAsync].y - this._projectiles[this._projectileAsync].height / 2,this._projectiles[this._projectileAsync].width,this._projectiles[this._projectileAsync].height);
                     _loc9_ = new Rectangle(this._enemies[_loc7_].x + this._enemies[_loc7_].X,this._enemies[_loc7_].y + this._enemies[_loc7_].Y,this._enemies[_loc7_].Width,this._enemies[_loc7_].Height);
                     if(this._projectiles[this._projectileAsync] is Flame)
                     {
                        _loc8_ = new Rectangle(this._projectiles[this._projectileAsync].x,this._projectiles[this._projectileAsync].y - this._projectiles[this._projectileAsync].height / 2,this._projectiles[this._projectileAsync].width,this._projectiles[this._projectileAsync].height);
                     }
                     if(!this._enemies[_loc7_].isDead && Collision.isColliding(this._projectiles[this._projectileAsync],_loc8_,this._enemies[_loc7_],_loc9_,this))
                     {
                        if(!(this._projectiles[this._projectileAsync] is Flame))
                        {
                           _loc5_ = this._effectsPool.getEffect("ENEMY_HIT");
                           _loc4_ = true;
                        }
                        this._enemies[_loc7_].takeDamage(this._projectiles[this._projectileAsync].damage);
                        if(this._enemies[_loc7_].isDead)
                        {
                           this._score += this._enemies[_loc7_].data.points;
                           this._money += this._enemies[_loc7_].data.loot;
                           this._totalMoney += this._enemies[_loc7_].data.loot;
                           if(this._score >= 9999999999)
                           {
                              this._score = 9999999999;
                           }
                           if(this._money >= 9999999999)
                           {
                              this._money = 9999999999;
                              this._totalMoney = 9999999999;
                           }
                           this._gui.updateScore(this._score);
                           this._scoreEarned += this._enemies[_loc7_].data.points;
                           this._moneyEarned += this._enemies[_loc7_].data.loot;
                           if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                           {
                              ++this._vehiclesKilled;
                              ++this._totalVehicles;
                           }
                           else
                           {
                              ++this._soldiersKilled;
                              ++this._totalSoldiers;
                           }
                        }
                        if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                        {
                           this._soundManager.playSound("vehicle_hit");
                        }
                        else
                        {
                           this._soundManager.playSound("soldier_hit");
                        }
                        if(this._projectiles[this._projectileAsync] is Rocket)
                        {
                           _loc10_ = this._effectsPool.getEffect("EXPLOSION");
                           _loc10_.x = _loc2_;
                           _loc10_.y = _loc3_;
                           _loc10_.rotation = Calc.random(0,360);
                           this._background.addToLayer(_loc10_,3);
                           this._effects.push(_loc10_);
                           this._soundManager.playSound("explosion");
                        }
                     }
                     if(Boolean(this._enemies[_loc7_].data.name == "Bomber") && Boolean(this._enemies[_loc7_].isDead) && (this._enemies[_loc7_].animation == "SHOOT3" || this._enemies[_loc7_].animation == "SHOOT4" || this._enemies[_loc7_].animation == "SHOOT5" || this._enemies[_loc7_].animation == "SHOOT6" || this._enemies[_loc7_].animation == "FIRE"))
                     {
                        switch(this._level)
                        {
                           case 0:
                              this._health -= this._enemies[_loc7_].data.damage;
                              break;
                           case 1:
                              this._health -= Math.ceil(this._enemies[_loc7_].data.damage * 1.5);
                              break;
                           case 2:
                              this._health -= this._enemies[_loc7_].data.damage * 2;
                        }
                        if(this._background.x <= 420 && this._enemies[_loc7_].direction == -1)
                        {
                           this._attackIcon.x = Window.width - this._attackIcon.width - 10;
                           this._attackIcon.switchDirections(1);
                        }
                        else if(this._background.x >= 900 && this._enemies[_loc7_].direction == 1)
                        {
                           this._attackIcon.x = 10;
                           this._attackIcon.switchDirections(-1);
                        }
                        _loc11_ = this._effectsPool.getEffect("GROUND_EXPLOSION");
                        _loc11_.x = this._enemies[_loc7_].x + this._enemies[_loc7_].data.bulletSpawn.x * this._enemies[_loc7_].direction;
                        _loc11_.y = this._enemies[_loc7_].y - this._enemies[_loc7_].data.bulletSpawn.y;
                        this._effects.push(_loc11_);
                        this._soundManager.playSound("explosion");
                        _loc12_ = new Explosion(100,100);
                        _loc12_.x = _loc11_.x - 50;
                        _loc12_.y = _loc11_.y - 50;
                        this._effects.push(_loc12_);
                        this._background.addToLayer(_loc12_,0);
                        if(this._enemies[_loc7_].direction == 1)
                        {
                           this._background.addToLayer(_loc11_,0);
                        }
                        else if(this._enemies[_loc7_].direction == -1)
                        {
                           this._background.addToLayer(_loc11_,1);
                        }
                     }
                     if(_loc4_)
                     {
                        break;
                     }
                     _loc7_++;
                  }
                  if(this._projectiles[this._projectileAsync] is Flame && Boolean(this._projectiles[this._projectileAsync].isFinished))
                  {
                     _loc4_ = true;
                  }
               }
            }
            this._projectiles[this._projectileAsync].x = _loc2_;
            this._projectiles[this._projectileAsync].y = _loc3_;
            if(!(this._projectiles[this._projectileAsync] is Grenade) && (this._projectiles[this._projectileAsync].x <= -20 || this._projectiles[this._projectileAsync].x >= this._background.width + 20))
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               if(_loc5_ != null)
               {
                  _loc5_.x = this._projectiles[this._projectileAsync].x;
                  _loc5_.y = this._projectiles[this._projectileAsync].y;
                  if(!(this._projectiles[this._projectileAsync] is Grenade))
                  {
                     _loc5_.rotation = Calc.random(0,360);
                  }
                  else
                  {
                     _loc7_ = 0;
                     while(_loc7_ < this._enemies.length)
                     {
                        _loc8_ = new Rectangle(_loc5_.x - _loc5_.width / 2,_loc5_.y - _loc5_.height / 2,_loc5_.width,_loc5_.height / 2);
                        _loc9_ = new Rectangle(this._enemies[_loc7_].x + this._enemies[_loc7_].X,this._enemies[_loc7_].y + this._enemies[_loc7_].Y,this._enemies[_loc7_].Width,this._enemies[_loc7_].Height);
                        if(!this._enemies[_loc7_].isDead && _loc8_.intersects(_loc9_))
                        {
                           this._enemies[_loc7_].takeDamage(this._projectiles[this._projectileAsync].damage);
                           if(this._enemies[_loc7_].isDead)
                           {
                              this._score += this._enemies[_loc7_].data.points;
                              this._money += this._enemies[_loc7_].data.loot;
                              this._totalMoney += this._enemies[_loc7_].data.loot;
                              if(this._score >= 9999999999)
                              {
                                 this._score = 9999999999;
                              }
                              if(this._money >= 9999999999)
                              {
                                 this._money = 9999999999;
                                 this._totalMoney = 9999999999;
                              }
                              this._gui.updateScore(this._score);
                              this._scoreEarned += this._enemies[_loc7_].data.points;
                              this._moneyEarned += this._enemies[_loc7_].data.loot;
                              if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                              {
                                 ++this._vehiclesKilled;
                                 ++this._totalVehicles;
                              }
                              else
                              {
                                 ++this._soldiersKilled;
                                 ++this._totalSoldiers;
                              }
                           }
                        }
                        _loc7_++;
                     }
                  }
                  this._background.addToLayer(_loc5_,3);
                  this._effects.push(_loc5_);
               }
               this._background.removeFromLayer(this._projectiles[this._projectileAsync],3);
               if(this._projectiles[this._projectileAsync] is Bullet)
               {
                  this._effectsPool.returnBullet(this._projectiles[this._projectileAsync]);
               }
               else if(this._projectiles[this._projectileAsync] is Rocket)
               {
                  this._effectsPool.returnRocket(this._projectiles[this._projectileAsync]);
               }
               else if(this._projectiles[this._projectileAsync] is Flame)
               {
                  this._effectsPool.returnFlame(this._projectiles[this._projectileAsync]);
               }
               else if(this._projectiles[this._projectileAsync] is Grenade)
               {
                  this._effectsPool.returnGrenade(this._projectiles[this._projectileAsync]);
               }
               this._projectiles.splice(this._projectileAsync,1);
            }
            --this._projectileAsync;
         }
         this._projectileAsync = this._projectiles.length - 1;
      }
      
      private function UpdatePayloads() : void
      {
         var _loc2_:Explosion = null;
         var _loc3_:int = 0;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc1_:int = getTimer();
         this._payloadCounter;
         while(this._payloadCounter > -1)
         {
            if(getTimer() - _loc1_ > 5)
            {
               return;
            }
            if(this._payloads[this._payloadCounter].destroyed)
            {
               if(this._payloads[this._payloadCounter].isFinished)
               {
                  this._background.removeFromLayer(this._payloads[this._payloadCounter],3);
                  this._effectsPool.returnPayload(this._payloads[this._payloadCounter]);
                  this._payloads.splice(this._payloadCounter,1);
               }
            }
            else
            {
               this._payloads[this._payloadCounter].y += 20;
               if(this._payloads[this._payloadCounter].y >= this._payloads[this._payloadCounter].target)
               {
                  _loc2_ = new Explosion(this._payloads[this._payloadCounter].width,this._payloads[this._payloadCounter].height);
                  _loc2_.x = this._payloads[this._payloadCounter].x - this._payloads[this._payloadCounter].width / 2;
                  _loc2_.y = this._payloads[this._payloadCounter].y - this._payloads[this._payloadCounter].height / 2;
                  this._background.addToLayer(_loc2_,3);
                  this._effects.push(_loc2_);
                  _loc3_ = 0;
                  while(_loc3_ < this._enemies.length)
                  {
                     _loc4_ = new Rectangle(this._payloads[this._payloadCounter].x - this._payloads[this._payloadCounter].width / 2,this._payloads[this._payloadCounter].y - this._payloads[this._payloadCounter].height / 2,this._payloads[this._payloadCounter].width,this._payloads[this._payloadCounter].height);
                     _loc5_ = new Rectangle(this._enemies[_loc3_].x + this._enemies[_loc3_].X,this._enemies[_loc3_].y + this._enemies[_loc3_].Y,this._enemies[_loc3_].Width,this._enemies[_loc3_].Height);
                     if(!this._enemies[_loc3_].isDead && _loc4_.intersects(_loc5_))
                     {
                        this._enemies[_loc3_].takeDamage(400);
                        if(this._enemies[_loc3_].isDead)
                        {
                           this._score += this._enemies[_loc3_].data.points;
                           this._money += this._enemies[_loc3_].data.loot;
                           this._totalMoney += this._enemies[_loc3_].data.loot;
                           if(this._score >= 9999999999)
                           {
                              this._score = 9999999999;
                           }
                           if(this._money >= 9999999999)
                           {
                              this._money = 9999999999;
                              this._totalMoney = 9999999999;
                           }
                           this._gui.updateScore(this._score);
                           this._scoreEarned += this._enemies[_loc3_].data.points;
                           this._moneyEarned += this._enemies[_loc3_].data.loot;
                           if(this._enemies[_loc3_].data.name == "Humvee" || this._enemies[_loc3_].data.name == "Tank" || this._enemies[_loc3_].data.name == "Helicopter" || this._enemies[_loc3_].data.name == "Plane")
                           {
                              ++this._vehiclesKilled;
                              ++this._totalVehicles;
                           }
                           else
                           {
                              ++this._soldiersKilled;
                              ++this._totalSoldiers;
                           }
                        }
                     }
                     _loc3_++;
                  }
                  this._payloads[this._payloadCounter].destroyed = true;
                  this._background.removeFromLayer(this._payloads[this._payloadCounter].shadow,3);
               }
               if(this._payloads[this._payloadCounter].y >= 0)
               {
                  if(this._payloads[this._payloadCounter].rotation < 0)
                  {
                     this._payloads[this._payloadCounter].rotation += 3;
                  }
                  this._payloads[this._payloadCounter].shadow.update();
               }
            }
            --this._payloadCounter;
         }
         this._payloadCounter = this._payloads.length - 1;
      }
      
      public function switchWeapons(param1:int) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         if(!this._isShopping)
         {
            _loc2_ = this._weaponData.getProperties(param1);
            if(!_loc2_.purchased)
            {
               return;
            }
            if(this._activeWeapon != param1)
            {
               this._soundManager.playSound("weapon_swap");
               this._shotCounter = 1;
               this._reloadCounter = 0;
               this._isReloading = false;
               this._weaponData.setProperties(this._activeWeapon,this._weaponStats);
               this._activeWeapon = param1;
               this._weaponStats = this._weaponData.getProperties(param1);
               this._gui.updateClipAmmo(this._weaponStats.magazine,this._weaponStats.clipSize >= 10,this._activeWeapon == 7);
               this._gui.updateTotalAmmo(this._weaponStats.ammo);
               this._gui.changeWeapon(this._activeWeapon);
               _loc3_ = false;
               if(this._weaponStats.magazine + this._weaponStats.ammo == 0)
               {
                  _loc3_ = true;
               }
               this._crosshair.hideReload();
               this._crosshair.changeWeapon(this._weaponStats.minimumAccuracy,this._weaponStats.maximumAccuracy,this._weaponStats.recoil,_loc3_);
            }
         }
      }
      
      private function shoot() : void
      {
         var _loc1_:int = 0;
         if(!this._tutorials[1] && this._prompt.sequence == "TUTORIAL_02")
         {
            this._tutorials[1] = true;
            this._prompt.visible = false;
         }
         if(this._weaponStats.magazine > 0)
         {
            --this._weaponStats.magazine;
            this._weaponStats.updated = true;
            this.playerShot();
            if(this._activeWeapon == 2)
            {
               _loc1_ = 0;
               while(_loc1_ < 5)
               {
                  this.playerShot();
                  _loc1_++;
               }
            }
            this._gui.updateClipAmmo(this._weaponStats.magazine,this._weaponStats.clipSize >= 10,this._activeWeapon == 7);
            this._crosshair.startShooting();
            this._crosshair.recoil();
            this._isShaking = true;
            this._shakeCounter = 26;
         }
         if(this._weaponStats.magazine == 0)
         {
            if(this._weaponStats.ammo > 0 || this._weaponStats.ammo == -1)
            {
               this.activateReload();
            }
            else
            {
               this.cycleWeapons(1);
            }
         }
      }
      
      private function reload() : void
      {
         if(!this._isShopping)
         {
            this._crosshair.stopShooting();
            this._crosshair.showReload();
            if((this._weaponStats.ammo > 0 || this._weaponStats.ammo == -1) && this._weaponStats.magazine != this._weaponStats.clipSize)
            {
               ++this._reloadCounter;
               if(this._reloadCounter >= this._weaponStats.reload)
               {
                  if(this._weaponStats.ammo != -1)
                  {
                     this._weaponStats.ammo += this._weaponStats.magazine;
                     if(this._weaponStats.ammo < this._weaponStats.clipSize)
                     {
                        this._weaponStats.magazine = this._weaponStats.ammo;
                     }
                     else
                     {
                        this._weaponStats.magazine = this._weaponStats.clipSize;
                     }
                     this._weaponStats.ammo -= this._weaponStats.magazine;
                  }
                  else
                  {
                     this._weaponStats.magazine = this._weaponStats.clipSize;
                  }
                  this._reloadCounter = 0;
                  this._isReloading = false;
                  this._crosshair.hideReload();
                  this._gui.updateClipAmmo(this._weaponStats.magazine,this._weaponStats.clipSize >= 10,this._activeWeapon == 7);
                  this._gui.updateTotalAmmo(this._weaponStats.ammo);
               }
            }
            else
            {
               this._reloadCounter = 0;
               this._isReloading = false;
               this._crosshair.hideReload();
            }
         }
      }
      
      private function enemyShot(param1:Enemy) : void
      {
         var _loc2_:Bullet = null;
         var _loc3_:Rocket = null;
         var _loc4_:SpecialEffect = null;
         var _loc5_:Explosion = null;
         switch(param1.data.bulletType)
         {
            case 0:
               switch(this._level)
               {
                  case 0:
                     this._health -= param1.data.damage;
                     break;
                  case 1:
                     this._health -= Math.ceil(param1.data.damage * 1.5);
                     break;
                  case 2:
                     this._health -= param1.data.damage * 2;
               }
               if(this._background.x <= 420 && param1.direction == -1)
               {
                  this._attackIcon.x = Window.width - this._attackIcon.width - 10;
                  this._attackIcon.switchDirections(1);
               }
               else if(this._background.x >= 900 && param1.direction == 1)
               {
                  this._attackIcon.x = 10;
                  this._attackIcon.switchDirections(-1);
               }
               if(param1.data.name == "Bomber")
               {
                  param1.takeDamage(1000);
                  _loc4_ = this._effectsPool.getEffect("GROUND_EXPLOSION");
                  _loc4_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
                  _loc4_.y = param1.y - param1.data.bulletSpawn.y;
                  this._effects.push(_loc4_);
                  this._soundManager.playSound("explosion");
                  _loc5_ = new Explosion(100,100);
                  _loc5_.x = _loc4_.x - 50;
                  _loc5_.y = _loc4_.y - 50;
                  this._effects.push(_loc5_);
                  this._background.addToLayer(_loc5_,0);
                  if(param1.direction == 1)
                  {
                     this._background.addToLayer(_loc4_,0);
                  }
                  else if(param1.direction == -1)
                  {
                     this._background.addToLayer(_loc4_,1);
                  }
               }
               _loc4_ = this._effectsPool.getEffect("WALL_HIT");
               _loc4_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc4_.y = param1.y - param1.data.bulletSpawn.y;
               _loc4_.rotation = Calc.random(0,360);
               this._background.addToLayer(_loc4_,3);
               this._effects.push(_loc4_);
               this._soundManager.playSound("wall_hit");
               if(param1.data.name == "Ram")
               {
                  this._soundManager.playSound("thud");
               }
               else
               {
                  this._soundManager.playSound("slash");
               }
               break;
            case 1:
            case 2:
            case 3:
            case 4:
               _loc2_ = this._effectsPool.getBullet(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc2_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc2_.y = param1.y - param1.data.bulletSpawn.y;
               _loc2_.isEnemy = true;
               _loc2_.isAerial = param1.data.isAir;
               if(_loc2_.isAerial)
               {
                  _loc2_.rotation = param1.direction * 45;
                  _loc2_.moveVector = Calc.movementVector(new Point(_loc2_.x,_loc2_.y),new Point(_loc2_.x + param1.direction * 100,_loc2_.y + 100),20);
               }
               this._background.addToLayer(_loc2_,3);
               this._projectiles.push(_loc2_);
               if(param1.data.name == "Tank")
               {
                  this._soundManager.playSound("rocket");
               }
               else
               {
                  this._soundManager.playSound("shoot");
               }
               break;
            case 6:
               _loc3_ = this._effectsPool.getRocket(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc3_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc3_.y = param1.y - param1.data.bulletSpawn.y;
               if(param1.animation == "FIRE2" || param1.animation == "FIRE4" || param1.animation == "FIRE6")
               {
                  _loc3_.x += param1.direction * 70;
               }
               _loc3_.rotation = param1.direction * 45;
               _loc3_.isEnemy = true;
               _loc3_.isAerial = true;
               _loc3_.moveVector = Calc.movementVector(new Point(_loc3_.x,_loc3_.y),new Point(_loc3_.x + param1.direction * 100,_loc3_.y + 100),25);
               this._background.addToLayer(_loc3_,3);
               this._projectiles.push(_loc3_);
               this._soundManager.playSound("rocket");
         }
      }
      
      private function allyShot(param1:Ally) : void
      {
         var _loc2_:Bullet = null;
         var _loc3_:Rocket = null;
         var _loc4_:Flame = null;
         switch(param1.data.bulletType)
         {
            case 1:
            case 2:
               _loc2_ = this._effectsPool.getBullet(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc2_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc2_.y = param1.y - param1.data.bulletSpawn.y;
               _loc2_.isEnemy = false;
               _loc2_.isAerial = false;
               this._background.addToLayer(_loc2_,3);
               this._projectiles.push(_loc2_);
               if(param1.direction == -1)
               {
                  _loc2_.x += param1.width;
               }
               this._soundManager.playSound("shoot");
               break;
            case 3:
               _loc2_ = this._effectsPool.getBullet(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc2_.x = param1.x + param1.data.bulletSpawn.x * param1.direction + (Calc.random(0,4) - 2) * 3;
               _loc2_.y = param1.y - param1.data.bulletSpawn.y;
               _loc2_.isEnemy = false;
               _loc2_.isAerial = false;
               this._background.addToLayer(_loc2_,3);
               this._projectiles.push(_loc2_);
               if(param1.direction == -1)
               {
                  _loc2_.x += param1.width;
               }
               _loc2_ = this._effectsPool.getBullet(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc2_.x = param1.x + param1.data.bulletSpawn.x * param1.direction + (Calc.random(0,4) - 2) * 3;
               _loc2_.y = param1.y - param1.data.bulletSpawn.y - 7;
               _loc2_.isEnemy = false;
               _loc2_.isAerial = false;
               this._background.addToLayer(_loc2_,3);
               this._projectiles.push(_loc2_);
               if(param1.direction == -1)
               {
                  _loc2_.x += param1.width;
               }
               _loc2_ = this._effectsPool.getBullet(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc2_.x = param1.x + param1.data.bulletSpawn.x * param1.direction + (Calc.random(0,4) - 2) * 3;
               _loc2_.y = param1.y - param1.data.bulletSpawn.y + 7;
               _loc2_.isEnemy = false;
               _loc2_.isAerial = false;
               this._background.addToLayer(_loc2_,3);
               this._projectiles.push(_loc2_);
               if(param1.direction == -1)
               {
                  _loc2_.x += param1.width;
               }
               this._soundManager.playSound("shoot");
               break;
            case 5:
               _loc3_ = this._effectsPool.getRocket(param1.data.bulletType,param1.direction,param1.data.damage);
               _loc3_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc3_.y = param1.y - param1.data.bulletSpawn.y;
               _loc3_.isEnemy = false;
               _loc3_.isAerial = false;
               this._background.addToLayer(_loc3_,3);
               this._projectiles.push(_loc3_);
               if(param1.direction == -1)
               {
                  _loc3_.x += param1.width;
               }
               this._soundManager.playSound("rocket");
               break;
            case 7:
               _loc4_ = this._effectsPool.getFlame(param1.direction,param1.data.damage);
               _loc4_.x = param1.x + param1.data.bulletSpawn.x * param1.direction;
               _loc4_.y = param1.y - param1.data.bulletSpawn.y;
               this._background.addToLayer(_loc4_,3);
               this._projectiles.push(_loc4_);
               if(param1.direction == -1)
               {
                  _loc4_.x += param1.width;
                  _loc4_.x -= _loc4_.width;
               }
         }
      }
      
      private function playerShot() : void
      {
         var _loc8_:SpecialEffect = null;
         var _loc9_:Explosion = null;
         var _loc10_:Rectangle = null;
         var _loc11_:Rectangle = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc1_:Number = Math.random() * (Math.PI * 2);
         var _loc2_:Number = Math.sqrt(Math.random()) * this._crosshair.radius;
         var _loc3_:int = this._crosshair.x + this._background.x + _loc2_ * Math.cos(_loc1_);
         var _loc4_:int = this._crosshair.y + _loc2_ * Math.sin(_loc1_);
         var _loc5_:Boolean = false;
         var _loc6_:int = this._enemies.length - 1;
         if(this._activeWeapon == 5)
         {
            _loc8_ = this._effectsPool.getEffect("GROUND_EXPLOSION");
            _loc8_.x = _loc3_;
            _loc8_.y = _loc4_;
            this._background.addToLayer(_loc8_,3);
            this._effects.push(_loc8_);
            this._soundManager.playSound("rocket");
            this._soundManager.playSound("explosion");
         }
         else if(this._activeWeapon == 8)
         {
            _loc9_ = new Explosion(60,60);
            _loc9_.x = _loc3_ - 30;
            _loc9_.y = _loc4_ - 30;
            this._background.addToLayer(_loc9_,3);
            this._effects.push(_loc9_);
            this._soundManager.playSound("laser");
            this._soundManager.playSound("explosion");
         }
         else
         {
            this._soundManager.playSound("shoot");
         }
         var _loc7_:* = _loc6_;
         while(_loc7_ > -1)
         {
            if(!this._enemies[_loc7_].isDead)
            {
               if(this._activeWeapon == 5 || this._activeWeapon == 8)
               {
                  if(this._activeWeapon == 5)
                  {
                     _loc10_ = new Rectangle(_loc8_.x - _loc8_.width / 2,_loc8_.y - _loc8_.height / 2,_loc8_.width,_loc8_.height);
                  }
                  else
                  {
                     _loc10_ = new Rectangle(_loc9_.x,_loc9_.y,60,60);
                  }
                  _loc11_ = new Rectangle(this._enemies[_loc7_].x + this._enemies[_loc7_].X,this._enemies[_loc7_].y + this._enemies[_loc7_].Y,this._enemies[_loc7_].Width,this._enemies[_loc7_].Height);
                  if(_loc10_.intersects(_loc11_))
                  {
                     this._enemies[_loc7_].takeDamage(this._weaponStats.damage);
                     if(this._enemies[_loc7_].isDead)
                     {
                        this._score += this._enemies[_loc7_].data.points;
                        this._money += this._enemies[_loc7_].data.loot;
                        this._totalMoney += this._enemies[_loc7_].data.loot;
                        if(this._score >= 9999999999)
                        {
                           this._score = 9999999999;
                        }
                        if(this._money >= 9999999999)
                        {
                           this._money = 9999999999;
                           this._totalMoney = 9999999999;
                        }
                        this._gui.updateScore(this._score);
                        this._scoreEarned += this._enemies[_loc7_].data.points;
                        this._moneyEarned += this._enemies[_loc7_].data.loot;
                        if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                        {
                           ++this._vehiclesKilled;
                           ++this._totalVehicles;
                        }
                        else
                        {
                           ++this._soldiersKilled;
                           ++this._totalSoldiers;
                        }
                     }
                  }
               }
               else if(_loc3_ >= this._enemies[_loc7_].x + this._enemies[_loc7_].X && _loc3_ <= this._enemies[_loc7_].x + this._enemies[_loc7_].X + this._enemies[_loc7_].Width && _loc4_ >= this._enemies[_loc7_].y + this._enemies[_loc7_].Y && _loc4_ <= this._enemies[_loc7_].y + this._enemies[_loc7_].Y + this._enemies[_loc7_].Height)
               {
                  _loc5_ = true;
                  this._enemies[_loc7_].takeDamage(this._weaponStats.damage);
                  if(this._enemies[_loc7_].isDead)
                  {
                     this._score += this._enemies[_loc7_].data.points;
                     this._money += this._enemies[_loc7_].data.loot;
                     this._totalMoney += this._enemies[_loc7_].data.loot;
                     if(this._score >= 9999999999)
                     {
                        this._score = 9999999999;
                     }
                     if(this._money >= 9999999999)
                     {
                        this._money = 9999999999;
                        this._totalMoney = 9999999999;
                     }
                     this._gui.updateScore(this._score);
                     this._scoreEarned += this._enemies[_loc7_].data.points;
                     this._moneyEarned += this._enemies[_loc7_].data.loot;
                     if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                     {
                        ++this._vehiclesKilled;
                        ++this._totalVehicles;
                     }
                     else
                     {
                        ++this._soldiersKilled;
                        ++this._totalSoldiers;
                     }
                  }
                  _loc8_ = this._effectsPool.getEffect("ENEMY_HIT");
                  _loc8_.x = _loc3_;
                  _loc8_.y = _loc4_;
                  _loc8_.rotation = Calc.random(0,360);
                  this._background.addToLayer(_loc8_,3);
                  this._effects.push(_loc8_);
                  if(this._enemies[_loc7_].data.name == "Humvee" || this._enemies[_loc7_].data.name == "Tank" || this._enemies[_loc7_].data.name == "Helicopter" || this._enemies[_loc7_].data.name == "Plane")
                  {
                     this._soundManager.playSound("vehicle_hit");
                  }
                  else
                  {
                     this._soundManager.playSound("soldier_hit");
                  }
               }
               if(Boolean(this._enemies[_loc7_].data.name == "Bomber") && Boolean(this._enemies[_loc7_].isDead) && (this._enemies[_loc7_].animation == "SHOOT3" || this._enemies[_loc7_].animation == "SHOOT4" || this._enemies[_loc7_].animation == "SHOOT5" || this._enemies[_loc7_].animation == "SHOOT6" || this._enemies[_loc7_].animation == "FIRE"))
               {
                  switch(this._level)
                  {
                     case 0:
                        this._health -= this._enemies[_loc7_].data.damage;
                        break;
                     case 1:
                        this._health -= Math.ceil(this._enemies[_loc7_].data.damage * 1.5);
                        break;
                     case 2:
                        this._health -= this._enemies[_loc7_].data.damage * 2;
                  }
                  _loc8_ = this._effectsPool.getEffect("GROUND_EXPLOSION");
                  _loc8_.x = this._enemies[_loc7_].x + this._enemies[_loc7_].data.bulletSpawn.x * this._enemies[_loc7_].direction;
                  _loc8_.y = this._enemies[_loc7_].y - this._enemies[_loc7_].data.bulletSpawn.y;
                  this._effects.push(_loc8_);
                  this._soundManager.playSound("explosion");
                  _loc9_ = new Explosion(100,100);
                  _loc9_.x = _loc8_.x - 50;
                  _loc9_.y = _loc8_.y - 50;
                  this._effects.push(_loc9_);
                  this._background.addToLayer(_loc9_,0);
                  if(this._enemies[_loc7_].direction == 1)
                  {
                     this._background.addToLayer(_loc8_,0);
                  }
                  else if(this._enemies[_loc7_].direction == -1)
                  {
                     this._background.addToLayer(_loc8_,1);
                  }
               }
               if(_loc5_)
               {
                  break;
               }
            }
            _loc7_--;
         }
         if(!_loc5_ && this._activeWeapon != 5 && this._activeWeapon != 8)
         {
            _loc12_ = this._background.checkDistance(_loc3_,_loc4_,1,true);
            _loc13_ = this._background.checkDistance(_loc3_,_loc4_,-1,true);
            if(_loc13_ > 0)
            {
               _loc14_ = 1;
            }
            else if(_loc12_ < 0)
            {
               _loc14_ = 0;
            }
            else
            {
               _loc14_ = 2;
            }
            _loc8_ = this._effectsPool.getEffect("GROUND_HIT");
            _loc8_.x = _loc3_;
            _loc8_.y = _loc4_;
            this._background.addToLayer(_loc8_,_loc14_);
            this._effects.push(_loc8_);
         }
      }
      
      private function cleanUpEnemy(param1:Enemy) : void
      {
         var _loc2_:int = 0;
         if(param1.direction == 1 || param1.data.isAir)
         {
            this._background.removeFromLayer(param1,0);
         }
         else if(param1.direction == -1)
         {
            this._background.removeFromLayer(param1,1);
         }
         if(param1.data.isAir)
         {
            if(param1.direction == 1)
            {
               this._aerialLanes.push(0);
            }
            else
            {
               this._aerialLanes.push(1);
            }
         }
         else
         {
            _loc2_ = (param1.y - SPAWN_BOUND_TOP) / 10;
            if(param1.direction == -1)
            {
               _loc2_ += 20;
            }
            this._lanes.push(_loc2_);
         }
         param1.destroy();
         this._enemies.splice(this._enemies.indexOf(param1),1);
         this._enemyPool.returnEnemy(param1);
      }
      
      private function Scroll() : void
      {
         if((this._mousePosition.x > 50 && this._mousePosition.x < Window.width - 50 || this._mousePosition.y < 80 || this._mousePosition.y > 480) && (!this.leftKeyPressed && !this.rightKeyPressed || this.leftKeyPressed && this.rightKeyPressed))
         {
            if(this._offsetX < 0)
            {
               this._offsetX += EASING * 3;
               if(this._offsetX > 0)
               {
                  this._offsetX = 0;
               }
            }
            else if(this._offsetX > 0)
            {
               this._offsetX -= EASING * 3;
               if(this._offsetX < 0)
               {
                  this._offsetX = 0;
               }
            }
         }
         else if((this._mousePosition.x <= 50 || this.leftKeyPressed) && !this.rightKeyPressed)
         {
            if(this._offsetX > 0)
            {
               this._offsetX = 0;
            }
            this._offsetX -= EASING;
            if(this._offsetX <= -18)
            {
               this._offsetX = -18;
            }
         }
         else if((this._mousePosition.x >= Window.width - 50 || this.rightKeyPressed) && !this.leftKeyPressed)
         {
            if(this._offsetX < 0)
            {
               this._offsetX = 0;
            }
            this._offsetX += EASING;
            if(this._offsetX >= 18)
            {
               this._offsetX = 18;
            }
         }
         if(this._offsetX < 0)
         {
            this._background.scroll(Math.floor(this._offsetX));
         }
         else
         {
            this._background.scroll(Math.ceil(this._offsetX));
         }
         if(this._background.atEdge)
         {
            this._offsetX = 0;
         }
         this._gui.updateFrame(this._background.position);
         this._crosshair.x = mouseX;
         this._crosshair.y = mouseY;
         if(this._crosshair.y <= 80 || this._crosshair.y >= 480 || !this.mouseOnScreen)
         {
            this._crosshair.visible = false;
            Mouse.show();
         }
         else
         {
            this._crosshair.visible = true;
            Mouse.hide();
         }
      }
      
      private function getWaveData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this._waveSpawns = new Array();
         var _loc1_:Object = this._waveData.getData(this._wave);
         _loc2_ = int(_loc1_.dagger);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(1);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.shovel);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(7);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.ram);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(6);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.bomber);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(0);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.pistol);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(4);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.sniper);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(8);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.humvee);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(3);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.plane);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(5);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.helicopter);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(2);
            _loc3_++;
         }
         _loc2_ = int(_loc1_.tank);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._waveSpawns.push(9);
            _loc3_++;
         }
         this._waveSpawns = Calc.shuffle(this._waveSpawns);
      }
      
      private function setMousePosition(param1:MouseEvent) : void
      {
         this._mousePosition = new Point(mouseX,mouseY);
      }
      
      public function stopScroll() : void
      {
         this._mousePosition = new Point(Window.width / 2,Window.height / 2);
      }
      
      public function throwGrenade() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Grenade = null;
         if(this._grenades > 0)
         {
            if(!this._tutorials[3] && this._prompt.sequence == "TUTORIAL_04")
            {
               this._tutorials[3] = true;
               this._prompt.visible = false;
            }
            this._soundManager.playSound("throw");
            --this._grenades;
            this._gui.updateGrenades(this._grenades);
            _loc1_ = new Point(this._background.x + mouseX,mouseY);
            if(_loc1_.x <= 50)
            {
               _loc1_.x = 50;
            }
            else if(_loc1_.x >= this._background.width - 50)
            {
               _loc1_.x = this._background.width - 50;
            }
            if(_loc1_.y <= 264)
            {
               _loc1_.y = 264;
            }
            else if(_loc1_.y >= 454)
            {
               _loc1_.y = 454;
            }
            if(mouseX < Window.width / 2)
            {
               _loc4_ = -1;
               _loc2_ = new Point(this._background.x + Window.width - 50,Window.height);
               _loc3_ = new Point(Calc.center(_loc2_.x,_loc1_.x,_loc1_.x),150);
            }
            else
            {
               _loc4_ = 1;
               _loc2_ = new Point(this._background.x + 50,Window.height);
               _loc3_ = new Point(Calc.center(_loc1_.x,_loc2_.x,_loc2_.x),150);
            }
            _loc5_ = (_loc2_.x - _loc1_.x) / (_loc3_.x - _loc1_.x);
            _loc6_ = (_loc2_.y - _loc1_.y + _loc1_.y * _loc5_ - _loc3_.y * _loc5_) / (_loc2_.x * _loc2_.x - _loc1_.x * _loc1_.x - (_loc3_.x * _loc3_.x - _loc1_.x * _loc1_.x) * _loc5_);
            _loc7_ = (_loc3_.y - _loc1_.y - (_loc3_.x * _loc3_.x - _loc1_.x * _loc1_.x) * _loc6_) / (_loc3_.x - _loc1_.x);
            _loc8_ = _loc1_.y - _loc1_.x * _loc1_.x * _loc6_ - _loc1_.x * _loc7_;
            _loc9_ = 0.15 / Calc.absoluteValue((_loc2_.x - _loc3_.x) / 15);
            _loc10_ = 0.45 / Calc.absoluteValue((_loc3_.x - _loc1_.x) / 15);
            _loc11_ = this._effectsPool.getGrenade(_loc6_,_loc7_,_loc8_,_loc4_,_loc3_.x,_loc1_.x,_loc9_,_loc10_);
            _loc11_.x = _loc2_.x;
            _loc11_.y = _loc2_.y;
            this._projectiles.push(_loc11_);
            this._background.addToLayer(_loc11_,3);
         }
      }
      
      public function dropPayload() : void
      {
         if(!this._droppingBombs && this._bombs > 0)
         {
            if(!this._tutorials[4] && this._prompt.sequence == "TUTORIAL_05")
            {
               this._tutorials[4] = true;
               this._prompt.visible = false;
            }
            --this._bombs;
            this._gui.updateMissiles(this._bombs);
            this._droppingBombs = true;
            this._bombCounter = 10;
            this._bombPosition = 100;
         }
      }
      
      public function updateAudio() : void
      {
         this._gui.updateAudio();
         this._shopMenu.updateAudio();
      }
      
      public function activateReload() : void
      {
         var _loc1_:String = null;
         if(this._weaponStats.magazine != this._weaponStats.clipSize && (this._weaponStats.ammo > 0 || this._weaponStats.ammo == -1) && !this._isReloading)
         {
            if(!this._tutorials[2] && this._prompt.sequence == "TUTORIAL_03")
            {
               this._tutorials[2] = true;
               this._prompt.visible = false;
            }
            this._isReloading = true;
            this._soundManager.playSound("reload");
            _loc1_ = String(this._weaponStats.clipSize);
            this._gui.reload(_loc1_.length);
         }
      }
      
      public function toggleOptionsMenu() : void
      {
         if(!this._isShopping)
         {
            this._gui.toggleOptionsMenu();
         }
      }
      
      private function togglePause(param1:GameEvent) : void
      {
         if(param1.type == GameEvent.PAUSE)
         {
            this.Pause();
         }
         else if(param1.type == GameEvent.RESUME)
         {
            this.Unpause();
         }
      }
      
      public function Pause() : void
      {
         var _loc1_:int = 0;
         if(!this._paused)
         {
            this._paused = true;
            this._crosshair.visible = false;
            this._attackIcon.pause();
            this._gui.pause();
            Mouse.show();
            this.stopShooting(null);
            this._soundManager.pauseAllSounds();
            this.removeEventListeners();
            _loc1_ = 0;
            while(_loc1_ < this._enemies.length)
            {
               this._enemies[_loc1_].pause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._allies.length)
            {
               this._allies[_loc1_].pause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._effects.length)
            {
               this._effects[_loc1_].pause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._projectiles.length)
            {
               this._projectiles[_loc1_].pause();
               _loc1_++;
            }
         }
      }
      
      public function Unpause() : void
      {
         var _loc1_:int = 0;
         if(this._paused)
         {
            this._paused = false;
            this._crosshair.visible = true;
            this._attackIcon.unpause();
            this._gui.unpause();
            Mouse.hide();
            this._soundManager.unpauseAllSounds();
            this.addEventListeners();
            _loc1_ = 0;
            while(_loc1_ < this._enemies.length)
            {
               this._enemies[_loc1_].unpause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._allies.length)
            {
               this._allies[_loc1_].unpause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._effects.length)
            {
               this._effects[_loc1_].unpause();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._projectiles.length)
            {
               this._projectiles[_loc1_].unpause();
               _loc1_++;
            }
         }
      }
      
      public function cycleWeapons(param1:int) : void
      {
         var _loc2_:int = this._activeWeapon;
         _loc2_ += param1;
         if(_loc2_ < 0)
         {
            _loc2_ = 8;
         }
         else if(_loc2_ > 8)
         {
            _loc2_ = 0;
         }
         var _loc3_:Object = this._weaponData.getProperties(_loc2_);
         var _loc4_:Boolean = false;
         if(_loc3_.purchased)
         {
            _loc4_ = true;
         }
         while(_loc4_ == false)
         {
            _loc2_ += param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 8;
            }
            else if(_loc2_ > 8)
            {
               _loc2_ = 0;
            }
            _loc3_ = this._weaponData.getProperties(_loc2_);
            if(_loc3_.purchased)
            {
               _loc4_ = true;
            }
         }
         if(!this._tutorials[6] && this._prompt.sequence == "TUTORIAL_07")
         {
            this._tutorials[6] = true;
            this._prompt.visible = false;
         }
         this.switchWeapons(_loc2_);
      }
      
      private function startShooting(param1:MouseEvent) : void
      {
         this.isShooting = true;
      }
      
      private function stopShooting(param1:MouseEvent) : void
      {
         this.isShooting = false;
         this._crosshair.stopShooting();
      }
      
      private function OpenShop() : void
      {
         this._shopMenu.Update(this._isVictory,this._wave + 1,this._scoreEarned,this._moneyEarned,this._soldiersKilled,this._vehiclesKilled,this._grenades,this._bombs,this._health,this._shopMenu.wallLevel * 50 + 100,this._score,this._money);
         this._shopMenu.reset();
         this.Pause();
         this._shopMenu.visible = true;
         this._shopMenu.Activate();
         Main.main.LockCoinMenu = false;
         Main.main.openConvertMenu();
         Main.main.grabCurrency(this._shopMenu,"_money");
         this._soundManager.playSound("shop_music",-1);
      }
      
      private function CloseShop(param1:GameEvent) : void
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Ally = null;
         Main.main.LockCoinMenu = true;
         this._scoreEarned = 0;
         this._moneyEarned = 0;
         this._soldiersKilled = 0;
         this._vehiclesKilled = 0;
         this._money = this._shopMenu.money;
         this._grenades = this._shopMenu.grenades;
         this._bombs = this._shopMenu.payloads;
         this._weaponData = this._shopMenu.weaponData;
         this._health = this._shopMenu.wallHealth;
         this._background.changeWalls(this._shopMenu.wallLevel);
         var _loc2_:* = 0;
         while(_loc2_ < 9)
         {
            _loc4_ = this._weaponData.getProperties(_loc2_);
            _loc4_.magazine = _loc4_.clipSize;
            _loc4_.ammo = _loc4_.maxAmmo;
            this._weaponData.setProperties(_loc2_,_loc4_);
            _loc2_++;
         }
         this._weaponStats = this._weaponData.getProperties(this._activeWeapon);
         this._gui.updateGrenades(this._grenades);
         this._gui.updateMissiles(this._bombs);
         this._gui.updateClipAmmo(this._weaponStats.magazine,this._weaponStats.clipSize >= 10,this._activeWeapon == 7);
         this._gui.updateTotalAmmo(this._weaponStats.ammo);
         this._gui.updateTotalHealth(this._shopMenu.wallLevel * 50 + 100);
         this._gui.updateHealth(this._health);
         var _loc3_:int = this._allies.length - 1;
         _loc2_ = _loc3_;
         while(_loc2_ > -1)
         {
            this._background.removeFromLayer(this._allies[_loc2_],2);
            this._allyPool.returnAlly(this._allies[_loc2_]);
            this._allies.splice(_loc2_,1);
            _loc2_--;
         }
         this._allyAsync = -1;
         _loc2_ = 0;
         while(_loc2_ < this._shopMenu.loadout.length)
         {
            _loc5_ = 1;
            _loc6_ = -1;
            if(_loc2_ < 3)
            {
               _loc5_ = -1;
            }
            switch(this._shopMenu.loadout[_loc2_])
            {
               case 0:
                  _loc6_ = 2;
                  break;
               case 1:
                  _loc6_ = 0;
                  break;
               case 2:
                  _loc6_ = 4;
                  break;
               case 3:
                  _loc6_ = 5;
                  break;
               case 4:
                  _loc6_ = 3;
                  break;
               case 5:
                  _loc6_ = 1;
            }
            if(_loc6_ != -1)
            {
               _loc7_ = this._allyPool.getAlly(_loc5_,_loc6_);
               _loc7_.x = ALLY_POSITIONS[_loc2_].x;
               _loc7_.y = ALLY_POSITIONS[_loc2_].y;
               this._background.addToLayer(_loc7_,2);
               this._allies.push(_loc7_);
            }
            _loc2_++;
         }
         this.Unpause();
         this._isShopping = false;
         this._shopMenu.visible = false;
         this._screenFade.visible = true;
         this._soundManager.stopSound("shop_music");
      }
      
      private function WaveFailed(param1:GameEvent) : void
      {
         if(!this._isVictory)
         {
            this.cleanUpGame();
         }
      }
      
      private function quitGame(param1:Event) : void
      {
         this._gui.removeEventListener(GameEvent.PAUSE,this.togglePause);
         this._gui.removeEventListener(GameEvent.RESUME,this.togglePause);
         this._gui.removeEventListener(GameEvent.CONFIRM,this.quitGame);
         this._shopMenu.removeEventListener(GameEvent.RESUME,this.CloseShop);
         this._shopMenu.removeEventListener(GameEvent.FINISHED,this.WaveFailed);
         this._shopMenu.removeEventListener(GameEvent.CONFIRM,this.quitGame);
         this._gameoverMenu.removeEventListener(GameEvent.CANCEL,this.quitGame);
         this._gameoverMenu.removeEventListener(GameEvent.CONFIRM,this.quitGame);
         this._gameoverMenu.removeEventListeners();
         if(param1.type == GameEvent.CONFIRM)
         {
            this.dispatchEvent(new Event("QUIT_GAME"));
         }
         else
         {
            this.dispatchEvent(new Event("RESET_GAME"));
         }
      }
      
      public function cleanUpGame() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._enemies.length - 1;
         var _loc2_:* = _loc1_;
         while(_loc2_ > -1)
         {
            if(this._enemies[_loc2_].direction == 1 || Boolean(this._enemies[_loc2_].data.isAir))
            {
               this._background.removeFromLayer(this._enemies[_loc2_],0);
            }
            else if(this._enemies[_loc2_].direction == -1)
            {
               this._background.removeFromLayer(this._enemies[_loc2_],1);
            }
            this._enemies[_loc2_].destroy();
            this._enemyPool.returnEnemy(this._enemies[_loc2_]);
            this._enemies.splice(_loc2_,1);
            _loc2_--;
         }
         _loc1_ = this._effects.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ > -1)
         {
            this._background.removeFromLayer(this._effects[_loc2_],3);
            if(!(this._effects[_loc2_] is Explosion))
            {
               this._effectsPool.returnEffect(this._effects[_loc2_]);
            }
            this._effects.splice(_loc2_,1);
            _loc2_--;
         }
         _loc1_ = this._allies.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ > -1)
         {
            this._background.removeFromLayer(this._allies[_loc2_],2);
            this._allyPool.returnAlly(this._allies[_loc2_]);
            this._allies.splice(_loc2_,1);
            _loc2_--;
         }
         _loc1_ = this._projectiles.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ > -1)
         {
            this._background.removeFromLayer(this._projectiles[_loc2_],3);
            if(this._projectiles[_loc2_] is Bullet)
            {
               this._effectsPool.returnBullet(this._projectiles[_loc2_]);
            }
            else if(this._projectiles[_loc2_] is Rocket)
            {
               this._effectsPool.returnRocket(this._projectiles[_loc2_]);
            }
            else if(this._projectiles[_loc2_] is Flame)
            {
               this._effectsPool.returnFlame(this._projectiles[_loc2_]);
            }
            else if(this._projectiles[_loc2_] is Grenade)
            {
               this._effectsPool.returnGrenade(this._projectiles[_loc2_]);
            }
            this._projectiles.splice(_loc2_,1);
            _loc2_--;
         }
         _loc1_ = this._payloads.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ > -1)
         {
            this._background.removeFromLayer(this._payloads[_loc2_],3);
            this._effectsPool.returnPayload(this._payloads[_loc2_]);
            this._payloads.splice(_loc2_,1);
            _loc2_--;
         }
         this._enemyAsync = -1;
         this._effectAsync = -1;
         this._allyAsync = -1;
         this._projectileAsync = -1;
         this._payloadCounter = -1;
      }
      
      public function hideTutorial() : void
      {
         if(!this._tutorials[5] && this._prompt.sequence == "TUTORIAL_06")
         {
            this._tutorials[5] = true;
            this._prompt.visible = false;
         }
      }
      
      public function get isPaused() : Boolean
      {
         return this._paused;
      }
   }
}


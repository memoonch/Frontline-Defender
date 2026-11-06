package src
{
   import com.hcLibrary.Initializer;
   import com.hcLibrary.data.Controls;
   import com.hcLibrary.data.KeyValues;
   import com.hcLibrary.debug.DebugPanel;
   import com.hcLibrary.display.GameWindow;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import com.jac.mouse.MouseWheelEnabler;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import src.components.Game;
   import src.components.Interfaces;
   import src.components.effects.SwipeEffect;
   import src.data.ImageData;
   import src.data.SoundData;
   import src.data.XMLData;
   import src.managers.NewSoundManager;
   import src.managers.PropManager;
   
   [SWF(width="960", height="540", backgroundColor="#000000", frameRate="30")]
   public class Main extends MovieClip
   {
      
      public static var FogAPI:fog;
      
      public static var main:Object;
      
      public static const DEBUGGING:Boolean = false;
      
      private var _initializer:Initializer;
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _soundManager:NewSoundManager;
      
      private var _propManager:PropManager;
      
      private var _gameWindow:GameWindow;
      
      private var _swipeEffect:SwipeEffect;
      
      private var _interfaces:Interfaces;
      
      private var _game:Game;
      
      public function Main()
      {
         super();
         this.addEventListener(Event.ENTER_FRAME,this.startStandalone);
      }
      
      private function startStandalone(param1:Event) : void
      {
         var event:Event = param1;
         this.removeEventListener(Event.ENTER_FRAME,this.startStandalone);
         if(this._initializer == null)
         {
            this.LoadAPI(new fog(),{
               "LockCoinMenu":true,
               "openConvertMenu":function():void
               {
               },
               "grabCurrency":function(param1:*, param2:String):void
               {
               }
            });
         }
      }
      
      private function InitializeProps() : void
      {
         this._propManager = PropManager.getInstance();
         this._propManager.addEventListener(GameEvent.FINISHED,this.Initializations,false,0,true);
         this.addEventListener(Event.ENTER_FRAME,this.PrepareProps,false,0,true);
      }
      
      private function PrepareProps(param1:Event) : void
      {
         this._propManager.Load();
      }
      
      private function Initializations(param1:GameEvent) : void
      {
         this._propManager.removeEventListener(GameEvent.FINISHED,this.Initializations);
         this.removeEventListener(Event.ENTER_FRAME,this.PrepareProps);
         this._gameWindow = this._initializer.gameWindow;
         this.InitializeImages();
         this.InitializeFonts();
         this.InitializeSounds();
         this.InitializeControls();
         this.InitializeInterfaces();
         this._initializer.finishInitializing();
      }
      
      public function LoadAPI(param1:fog, param2:Object) : void
      {
         if(this._initializer != null)
         {
            return;
         }
         FogAPI = param1;
         main = param2;
         this.CreateInitializer();
      }
      
      private function CreateInitializer() : void
      {
         this._initializer = Initializer.getInstance();
         this._initializer.addEventListener(GameEvent.FINISHED,this.FinishInitializing);
         this._initializer.Initialize(640,480,this,stage,this.InitializeProps,DEBUGGING);
      }
      
      private function InitializeImages() : void
      {
         this._imageManager = ImageManager.getInstance();
         this._imageManager.addImage(ImageData.background,"background");
         this._imageManager.addImage(ImageData.walls_left,"walls_left");
         this._imageManager.addImage(ImageData.walls_right,"walls_right");
         this._imageManager.addImage(ImageData.enemy_Bomber,"enemy_bomber");
         this._imageManager.addImage(ImageData.enemy_Dagger,"enemy_dagger");
         this._imageManager.addImage(ImageData.enemy_Helicopter,"enemy_helicopter");
         this._imageManager.addImage(ImageData.enemy_Humvee,"enemy_humvee");
         this._imageManager.addImage(ImageData.enemy_Pistol,"enemy_pistol");
         this._imageManager.addImage(ImageData.enemy_Plane,"enemy_plane");
         this._imageManager.addImage(ImageData.enemy_Ram,"enemy_ram");
         this._imageManager.addImage(ImageData.enemy_Shovel,"enemy_shovel");
         this._imageManager.addImage(ImageData.enemy_Sniper,"enemy_sniper");
         this._imageManager.addImage(ImageData.enemy_Tank,"enemy_tank");
         this._imageManager.addImage(ImageData.ally_AssaultRifle,"ally_assault_rifle");
         this._imageManager.addImage(ImageData.ally_Flamethrower,"ally_flamethrower");
         this._imageManager.addImage(ImageData.ally_Pistol,"ally_pistol");
         this._imageManager.addImage(ImageData.ally_RocketLauncher,"ally_rocket_launcher");
         this._imageManager.addImage(ImageData.ally_Shotgun,"ally_shotgun");
         this._imageManager.addImage(ImageData.ally_Sniper,"ally_sniper");
         this._imageManager.addImage(ImageData.font_GUIDigits,"font_gui_digits");
         this._imageManager.addImage(ImageData.font_ShopDigits,"font_shop_digits");
         this._imageManager.addImage(ImageData.font_Shop,"font_shop");
         this._imageManager.addImage(ImageData.font_GUISlash,"font_gui_slash");
         this._imageManager.addImage(ImageData.options_Buttons,"options_buttons");
         this._imageManager.addImage(ImageData.options_Gear,"options_gear");
         this._imageManager.addImage(ImageData.options_Plate,"options_plate");
         this._imageManager.addImage(ImageData.gui_GrenadePlate,"grenade_plate");
         this._imageManager.addImage(ImageData.gui_GunsPlate,"guns_plate");
         this._imageManager.addImage(ImageData.gui_HealthFill,"health_fill");
         this._imageManager.addImage(ImageData.gui_HealthFillDark,"health_fill_dark");
         this._imageManager.addImage(ImageData.gui_HealthBarLeft,"health_bar_left");
         this._imageManager.addImage(ImageData.gui_HealthBarMiddle,"health_bar_middle");
         this._imageManager.addImage(ImageData.gui_HealthBarRight,"health_bar_right");
         this._imageManager.addImage(ImageData.gui_Prompts,"prompts");
         this._imageManager.addImage(ImageData.gui_Minimap,"minimap");
         this._imageManager.addImage(ImageData.gui_MinimapIcons,"minimap_icons");
         this._imageManager.addImage(ImageData.gui_ScorePlate,"score_plate");
         this._imageManager.addImage(ImageData.menu_SocialButtons,"social_buttons");
         this._imageManager.addImage(ImageData.menu_CreditsBackground,"credits_background");
         this._imageManager.addImage(ImageData.menu_CreditsExitButton,"exit_button_credits");
         this._imageManager.addImage(ImageData.menu_CreditsLogo,"credits_logo");
         this._imageManager.addImage(ImageData.menu_GameoverPlate,"gameover_plate");
         this._imageManager.addImage(ImageData.menu_HelpBackground,"help_background");
         this._imageManager.addImage(ImageData.menu_MainButtons,"main_buttons");
         this._imageManager.addImage(ImageData.menu_MainBackground,"main_background");
         this._imageManager.addImage(ImageData.menu_Copyright,"copyright");
         this._imageManager.addImage(ImageData.menu_MainPlate,"main_plate");
         this._imageManager.addImage(ImageData.menu_PlayButton,"play_button");
         this._imageManager.addImage(ImageData.menu_GoButton,"go_button");
         this._imageManager.addImage(ImageData.pause_QuitButtons,"quit_buttons");
         this._imageManager.addImage(ImageData.pause_ControlsPlate,"controls_plate");
         this._imageManager.addImage(ImageData.pause_QuitPlate,"quit_plate");
         this._imageManager.addImage(ImageData.shop_ArsenalIcons,"shop_arsenal_icons");
         this._imageManager.addImage(ImageData.shop_ArsenalArrowButton,"shop_arsenal_arrow_button");
         this._imageManager.addImage(ImageData.shop_TroopsArrowButton,"shop_troops_arrow_button");
         this._imageManager.addImage(ImageData.shop_BarricadeButton,"shop_barricade_button");
         this._imageManager.addImage(ImageData.shop_BuyButton,"shop_buy_button");
         this._imageManager.addImage(ImageData.shop_RepairSlider,"shop_repair_slider");
         this._imageManager.addImage(ImageData.shop_UpgradeButton,"shop_upgrade_button");
         this._imageManager.addImage(ImageData.shop_Classified,"shop_classified");
         this._imageManager.addImage(ImageData.shop_TroopPlacement,"shop_troop_placement");
         this._imageManager.addImage(ImageData.shop_Troops,"shop_troops");
         this._imageManager.addImage(ImageData.shop_PlayButton,"shop_play_button");
         this._imageManager.addImage(ImageData.shop_GoButton,"shop_go_button");
         this._imageManager.addImage(ImageData.shop_TroopSelectionIcons,"shop_troop_selection_icons");
         this._imageManager.addImage(ImageData.shop_TroopSelectionPlate,"shop_troop_selection_plate");
         this._imageManager.addImage(ImageData.shop_TroopSelectionArrows,"shop_troop_selection_arrows");
         this._imageManager.addImage(ImageData.shop_HoverPrompt,"shop_hover_prompt");
         this._imageManager.addImage(ImageData.shop_Minimap,"shop_minimap");
         this._imageManager.addImage(ImageData.shop_Background,"shop_background");
         this._imageManager.addImage(ImageData.shop_TopSecret,"shop_top_secret");
         this._imageManager.addImage(ImageData.vfx_Bullets,"bullets");
         this._imageManager.addImage(ImageData.vfx_Crosshair,"crosshair");
         this._imageManager.addImage(ImageData.vfx_Explosion,"explosion");
         this._imageManager.addImage(ImageData.vfx_GroundExplosion,"ground_explosion");
         this._imageManager.addImage(ImageData.vfx_Flamethrower,"flamethrower");
         this._imageManager.addImage(ImageData.vfx_Grenade,"grenade");
         this._imageManager.addImage(ImageData.vfx_NoAmmoText,"no_ammo_text");
         this._imageManager.addImage(ImageData.vfx_EnemyHitEffect,"enemy_hit");
         this._imageManager.addImage(ImageData.vfx_GroundHitEffect,"ground_hit");
         this._imageManager.addImage(ImageData.vfx_WallHitEffect,"wall_hit");
         this._imageManager.addImage(ImageData.vfx_Payload,"payload");
         this._imageManager.addImage(ImageData.vfx_ReloadingText,"reloading_text");
         this._imageManager.addImage(ImageData.vfx_Rocket01,"rocket_01");
         this._imageManager.addImage(ImageData.vfx_Rocket02,"rocket_02");
         this._imageManager.addImage(ImageData.vfx_UnderAttack,"under_attack");
         if(DEBUGGING)
         {
            DebugPanel.traceLine("InitializeImages() - completed",65280,12,true);
         }
      }
      
      private function InitializeFonts() : void
      {
         this._fontManager = FontManager.getInstance();
         this._fontManager.addFontSheet("GUI_DIGITS",this._imageManager.getImage("font_gui_digits"),new XMLData.font_GUIDigits(),12);
         this._fontManager.addFontSheet("SHOP_DIGITS",this._imageManager.getImage("font_shop_digits"),new XMLData.font_ShopDigits(),12);
         this._fontManager.addFontSheet("SHOP",this._imageManager.getImage("font_shop"),new XMLData.font_Shop(),6);
         if(DEBUGGING)
         {
            DebugPanel.traceLine("InitializeFonts() - completed",65280,12,true);
         }
      }
      
      private function InitializeSounds() : void
      {
         this._soundManager = NewSoundManager.getInstance();
         this._soundManager.addSound(SoundData.bgm_Game,"game_music",true);
         this._soundManager.addSound(SoundData.bgm_Menu,"menu_music",true);
         this._soundManager.addSound(SoundData.bgm_Shop,"shop_music",true);
         this._soundManager.addSound(SoundData.sfx_Alarm,"alarm",false);
         this._soundManager.addSound(SoundData.sfx_Bomb,"bomb",false);
         this._soundManager.addSound(SoundData.sfx_Explosion,"explosion",false);
         this._soundManager.addSound(SoundData.sfx_Flamethrower,"flamethrower",false);
         this._soundManager.addSound(SoundData.sfx_Helicopter,"helicopter",false);
         this._soundManager.addSound(SoundData.sfx_Laser,"laser",false);
         this._soundManager.addSound(SoundData.sfx_Purchase,"purchase",false);
         this._soundManager.addSound(SoundData.sfx_Rocket,"rocket",false);
         this._soundManager.addSound(SoundData.sfx_Shoot,"shoot",false);
         this._soundManager.addSound(SoundData.sfx_Slash,"slash",false);
         this._soundManager.addSound(SoundData.sfx_SoldierHit,"soldier_hit",false);
         this._soundManager.addSound(SoundData.sfx_Throw,"throw",false);
         this._soundManager.addSound(SoundData.sfx_Thud,"thud",false);
         this._soundManager.addSound(SoundData.sfx_Truck,"truck",false);
         this._soundManager.addSound(SoundData.sfx_VehicleHit,"vehicle_hit",false);
         this._soundManager.addSound(SoundData.sfx_WallHit,"wall_hit",false);
         this._soundManager.addSound(SoundData.sfx_WeaponSwap,"weapon_swap",false);
         this._soundManager.addSound(sfx_reload,"reload",false);
         if(DEBUGGING)
         {
            DebugPanel.traceLine("InitializeSounds() - completed",65280,12,true);
         }
      }
      
      private function InitializeControls() : void
      {
         Controls.addKey("LEFT_01",KeyValues.A);
         Controls.addKey("LEFT_02",KeyValues.LEFT_ARROW);
         Controls.addKey("RIGHT_01",KeyValues.D);
         Controls.addKey("RIGHT_02",KeyValues.RIGHT_ARROW);
         Controls.addKey("GRENADE",KeyValues.Q);
         Controls.addKey("MISSILE",KeyValues.W);
         Controls.addKey("MUTE",KeyValues.M);
         Controls.addKey("RELOAD",KeyValues.R);
         Controls.addKey("PAUSE",KeyValues.P);
         Controls.addKey("OPTIONS",KeyValues.ESCAPE);
         Controls.addKey("WEAPON_01",KeyValues.NUM_1);
         Controls.addKey("WEAPON_02",KeyValues.NUM_2);
         Controls.addKey("WEAPON_03",KeyValues.NUM_3);
         Controls.addKey("WEAPON_04",KeyValues.NUM_4);
         Controls.addKey("WEAPON_05",KeyValues.NUM_5);
         Controls.addKey("WEAPON_06",KeyValues.NUM_6);
         Controls.addKey("WEAPON_07",KeyValues.NUM_7);
         Controls.addKey("WEAPON_08",KeyValues.NUM_8);
         Controls.addKey("WEAPON_09",KeyValues.NUM_9);
         if(DEBUGGING)
         {
            DebugPanel.traceLine("InitializeControls() - completed",65280,12,true);
         }
      }
      
      private function InitializeInterfaces() : void
      {
         this._interfaces = new Interfaces();
         this._interfaces.addEventListeners();
         this._interfaces.addEventListener("START_GAME",this.StartGame,false,0,true);
         this._gameWindow.addChild(this._interfaces);
         this._gameWindow.setChildIndex(this._interfaces,0);
      }
      
      private function FinishInitializing(param1:GameEvent) : void
      {
         this.addChild(this._gameWindow);
         if(DEBUGGING)
         {
            DebugPanel.lineBreak();
            DebugPanel.traceLine("Initialization Complete",16711935,12);
            DebugPanel.lineBreak();
         }
         MouseWheelEnabler.init(stage);
         stage.addEventListener(Event.DEACTIVATE,this.focusLost,false,0,true);
         stage.addEventListener(Event.MOUSE_LEAVE,this.StopScrolling,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyPressed,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyReleased,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseOnScreenStatus,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelScroll,false,0,true);
         this._soundManager.playSound("menu_music",-1);
      }
      
      private function StartGame(param1:Event) : void
      {
         this._swipeEffect = new SwipeEffect();
         this._swipeEffect.addEventListener(GameEvent.RESUME,this.CreateGame,false,0,true);
         this._swipeEffect.addEventListener(GameEvent.FINISHED,this.ActivateGame,false,0,true);
         this._gameWindow.addChild(this._swipeEffect);
         this._swipeEffect.start();
      }
      
      private function CreateGame(param1:GameEvent) : void
      {
         this._game = new Game();
         this._gameWindow.addChild(this._game);
         this._gameWindow.setChildIndex(this._game,this._gameWindow.getChildIndex(this._swipeEffect));
         this._soundManager.stopSound("menu_music");
         this._soundManager.playSound("game_music",-1);
      }
      
      private function ActivateGame(param1:GameEvent) : void
      {
         this._gameWindow.setChildIndex(this._game,this._gameWindow.numChildren - 1);
         this._game.addEventListeners();
         this._game.addEventListener("QUIT_GAME",this.QuitGame,false,0,true);
         this._game.addEventListener("RESET_GAME",this.ResetGame,false,0,true);
         this._swipeEffect.removeEventListener(GameEvent.RESUME,this.CreateGame);
         this._swipeEffect.removeEventListener(GameEvent.FINISHED,this.ActivateGame);
         this._gameWindow.removeChild(this._swipeEffect);
         this._swipeEffect = null;
      }
      
      private function ResetGame(param1:Event) : void
      {
         this._swipeEffect = new SwipeEffect();
         this._swipeEffect.addEventListener(GameEvent.RESUME,this.RestartGame,false,0,true);
         this._swipeEffect.addEventListener(GameEvent.FINISHED,this.ActivateGame,false,0,true);
         this._gameWindow.addChild(this._swipeEffect);
         this._swipeEffect.start();
      }
      
      private function RestartGame(param1:GameEvent) : void
      {
         this.CleanUpGame(null);
         this.CreateGame(null);
      }
      
      private function QuitGame(param1:Event) : void
      {
         this._swipeEffect = new SwipeEffect();
         this._swipeEffect.addEventListener(GameEvent.RESUME,this.CleanUpGame,false,0,true);
         this._swipeEffect.addEventListener(GameEvent.FINISHED,this.ActivateInterfaces,false,0,true);
         this._gameWindow.addChild(this._swipeEffect);
         this._swipeEffect.start();
      }
      
      private function CleanUpGame(param1:GameEvent) : void
      {
         this._game.cleanUpGame();
         this._game.removeEventListener("QUIT_GAME",this.QuitGame);
         this._game.removeEventListener("RESET_GAME",this.ResetGame);
         this._gameWindow.removeChild(this._game);
         this._game = null;
         this._soundManager.stopSound("game_music");
         this._soundManager.stopSound("shop_music");
      }
      
      private function ActivateInterfaces(param1:GameEvent) : void
      {
         if(this._soundManager.isSoundStopped("menu_music"))
         {
            this._soundManager.playSound("menu_music",-1);
         }
         this._swipeEffect.removeEventListener(GameEvent.RESUME,this.CleanUpGame);
         this._swipeEffect.removeEventListener(GameEvent.FINISHED,this.ActivateInterfaces);
         this._gameWindow.removeChild(this._swipeEffect);
         this._swipeEffect = null;
         this._interfaces.ReactivateMenus();
      }
      
      private function StopScrolling(param1:Event) : void
      {
         if(this._game != null)
         {
            this._game.stopScroll();
            this._game.mouseOnScreen = false;
         }
      }
      
      private function mouseOnScreenStatus(param1:MouseEvent) : void
      {
         if(this._game != null)
         {
            this._game.mouseOnScreen = true;
         }
      }
      
      private function keyPressed(param1:KeyboardEvent) : void
      {
         if(Controls.getKeyInUse(param1.keyCode) && !Controls.getKeyState(null,param1.keyCode))
         {
            Controls.keyStateChange(null,param1.keyCode);
            if(param1.keyCode == Controls.getKeyValue("MUTE"))
            {
               if(NewSoundManager.muteMusic && NewSoundManager.muteSound)
               {
                  NewSoundManager.muteMusic = false;
                  NewSoundManager.muteSound = false;
               }
               else
               {
                  NewSoundManager.muteMusic = true;
                  NewSoundManager.muteSound = true;
               }
            }
            if(this._game != null)
            {
               switch(param1.keyCode)
               {
                  case Controls.getKeyValue("LEFT_01"):
                  case Controls.getKeyValue("LEFT_02"):
                     this._game.leftKeyPressed = true;
                     break;
                  case Controls.getKeyValue("RIGHT_01"):
                  case Controls.getKeyValue("RIGHT_02"):
                     this._game.rightKeyPressed = true;
                     break;
                  case Controls.getKeyValue("GRENADE"):
                     this._game.throwGrenade();
                     break;
                  case Controls.getKeyValue("MISSILE"):
                     this._game.dropPayload();
                     break;
                  case Controls.getKeyValue("MUTE"):
                     this._game.updateAudio();
                     break;
                  case Controls.getKeyValue("RELOAD"):
                     this._game.activateReload();
                     break;
                  case Controls.getKeyValue("PAUSE"):
                  case Controls.getKeyValue("OPTIONS"):
                     this._game.toggleOptionsMenu();
                     break;
                  case Controls.getKeyValue("WEAPON_01"):
                     this._game.switchWeapons(0);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_02"):
                     this._game.switchWeapons(1);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_03"):
                     this._game.switchWeapons(2);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_04"):
                     this._game.switchWeapons(3);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_05"):
                     this._game.switchWeapons(4);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_06"):
                     this._game.switchWeapons(5);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_07"):
                     this._game.switchWeapons(6);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_08"):
                     this._game.switchWeapons(7);
                     this._game.hideTutorial();
                     break;
                  case Controls.getKeyValue("WEAPON_09"):
                     this._game.switchWeapons(8);
                     this._game.hideTutorial();
               }
            }
         }
      }
      
      private function keyReleased(param1:KeyboardEvent) : void
      {
         if(Controls.getKeyInUse(param1.keyCode) && Controls.getKeyState(null,param1.keyCode))
         {
            Controls.keyStateChange(null,param1.keyCode);
         }
         if(this._game != null)
         {
            switch(param1.keyCode)
            {
               case Controls.getKeyValue("LEFT_01"):
               case Controls.getKeyValue("LEFT_02"):
                  this._game.leftKeyPressed = false;
                  break;
               case Controls.getKeyValue("RIGHT_01"):
               case Controls.getKeyValue("RIGHT_02"):
                  this._game.rightKeyPressed = false;
            }
         }
      }
      
      private function mouseWheelScroll(param1:MouseEvent) : void
      {
         if(this._game != null && !this._game.isPaused)
         {
            if(param1.delta < 0)
            {
               this._game.cycleWeapons(-1);
            }
            else if(param1.delta > 0)
            {
               this._game.cycleWeapons(1);
            }
         }
      }
      
      private function focusLost(param1:Event) : void
      {
         if(this._game != null && !this._game.isPaused)
         {
            this._game.toggleOptionsMenu();
         }
      }
   }
}


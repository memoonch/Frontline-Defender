package src.game.pools
{
   import com.hcLibrary.debug.GameError;
   import src.game.Ally;
   import src.managers.PropManager;
   
   public class AllyPool
   {
      
      private static var _instance:AllyPool;
      
      private static var _allowInstance:Boolean;
      
      private var _assaultRiflePool:Array;
      
      private var _flamethrowerPool:Array;
      
      private var _pistolPool:Array;
      
      private var _rocketLauncherPool:Array;
      
      private var _shotgunPool:Array;
      
      private var _sniperPool:Array;
      
      private var _assaultRifleCounter:int;
      
      private var _flamethrowerCounter:int;
      
      private var _pistolCounter:int;
      
      private var _rocketLauncherCounter:int;
      
      private var _shotgunCounter:int;
      
      private var _sniperCounter:int;
      
      private var _propManager:PropManager;
      
      public function AllyPool()
      {
         super();
         if(AllyPool._allowInstance)
         {
            this._propManager = PropManager.getInstance();
            this._assaultRiflePool = new Array();
            this._flamethrowerPool = new Array();
            this._pistolPool = new Array();
            this._rocketLauncherPool = new Array();
            this._shotgunPool = new Array();
            this._sniperPool = new Array();
            this._assaultRifleCounter = 0;
            this._flamethrowerCounter = 0;
            this._pistolCounter = 0;
            this._rocketLauncherCounter = 0;
            this._shotgunCounter = 0;
            this._sniperCounter = 0;
         }
         else
         {
            GameError.throwError("EnemyPool","constructor","Only one instance of AllyPool is necessary. Use the \"getInstance()\" method instead of the \"new\" keyword.");
         }
      }
      
      public static function getInstance() : AllyPool
      {
         if(AllyPool._instance == null)
         {
            AllyPool._allowInstance = true;
            AllyPool._instance = new AllyPool();
            AllyPool._allowInstance = false;
         }
         return AllyPool._instance;
      }
      
      public function getAlly(param1:int, param2:int) : Ally
      {
         var _loc3_:Ally = null;
         switch(param2)
         {
            case 0:
               if(this._assaultRifleCounter > 0)
               {
                  --this._assaultRifleCounter;
                  this._assaultRiflePool[this._assaultRifleCounter].reset(param1);
               }
               else
               {
                  this._assaultRiflePool.unshift(new Ally(this._propManager.getAlly("Assault Rifle"),param1));
               }
               _loc3_ = this._assaultRiflePool[this._assaultRifleCounter];
               break;
            case 1:
               if(this._flamethrowerCounter > 0)
               {
                  --this._flamethrowerCounter;
                  this._flamethrowerPool[this._flamethrowerCounter].reset(param1);
               }
               else
               {
                  this._flamethrowerPool.unshift(new Ally(this._propManager.getAlly("Flamethrower"),param1));
               }
               _loc3_ = this._flamethrowerPool[this._flamethrowerCounter];
               break;
            case 2:
               if(this._pistolCounter > 0)
               {
                  --this._pistolCounter;
                  this._pistolPool[this._pistolCounter].reset(param1);
               }
               else
               {
                  this._pistolPool.unshift(new Ally(this._propManager.getAlly("Pistol"),param1));
               }
               _loc3_ = this._pistolPool[this._pistolCounter];
               break;
            case 3:
               if(this._rocketLauncherCounter > 0)
               {
                  --this._rocketLauncherCounter;
                  this._rocketLauncherPool[this._rocketLauncherCounter].reset(param1);
               }
               else
               {
                  this._rocketLauncherPool.unshift(new Ally(this._propManager.getAlly("Rocket Launcher"),param1));
               }
               _loc3_ = this._rocketLauncherPool[this._rocketLauncherCounter];
               break;
            case 4:
               if(this._shotgunCounter > 0)
               {
                  --this._shotgunCounter;
                  this._shotgunPool[this._shotgunCounter].reset(param1);
               }
               else
               {
                  this._shotgunPool.unshift(new Ally(this._propManager.getAlly("Shotgun"),param1));
               }
               _loc3_ = this._shotgunPool[this._shotgunCounter];
               break;
            case 5:
               if(this._sniperCounter > 0)
               {
                  --this._sniperCounter;
                  this._sniperPool[this._sniperCounter].reset(param1);
               }
               else
               {
                  this._sniperPool.unshift(new Ally(this._propManager.getAlly("Sniper"),param1));
               }
               _loc3_ = this._sniperPool[this._sniperCounter];
         }
         return _loc3_;
      }
      
      public function returnAlly(param1:Ally) : void
      {
         switch(param1.data.name)
         {
            case "Assault Rifle":
               this._assaultRiflePool[this._assaultRifleCounter] = param1;
               ++this._assaultRifleCounter;
               break;
            case "Flamethrower":
               this._flamethrowerPool[this._flamethrowerCounter] = param1;
               ++this._flamethrowerCounter;
               break;
            case "Pistol":
               this._pistolPool[this._pistolCounter] = param1;
               ++this._pistolCounter;
               break;
            case "Rocket Launcher":
               this._rocketLauncherPool[this._rocketLauncherCounter] = param1;
               ++this._rocketLauncherCounter;
               break;
            case "Shotgun":
               this._shotgunPool[this._shotgunCounter] = param1;
               ++this._shotgunCounter;
               break;
            case "Sniper":
               this._sniperPool[this._sniperCounter] = param1;
               ++this._sniperCounter;
         }
      }
   }
}


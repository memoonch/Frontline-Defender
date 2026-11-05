package src.game.pools
{
   import com.hcLibrary.debug.GameError;
   import src.game.Enemy;
   import src.managers.PropManager;
   
   public class EnemyPool
   {
      
      private static var _instance:EnemyPool;
      
      private static var _allowInstance:Boolean;
      
      private var _bomberPool:Array;
      
      private var _daggerPool:Array;
      
      private var _helicopterPool:Array;
      
      private var _humveePool:Array;
      
      private var _pistolPool:Array;
      
      private var _planePool:Array;
      
      private var _ramPool:Array;
      
      private var _shovelPool:Array;
      
      private var _sniperPool:Array;
      
      private var _tankPool:Array;
      
      private var _bomberCounter:int;
      
      private var _daggerCounter:int;
      
      private var _helicopterCounter:int;
      
      private var _humveeCounter:int;
      
      private var _pistolCounter:int;
      
      private var _planeCounter:int;
      
      private var _ramCounter:int;
      
      private var _shovelCounter:int;
      
      private var _sniperCounter:int;
      
      private var _tankCounter:int;
      
      private var _propManager:PropManager;
      
      public function EnemyPool()
      {
         super();
         if(EnemyPool._allowInstance)
         {
            this._propManager = PropManager.getInstance();
            this._bomberPool = new Array();
            this._daggerPool = new Array();
            this._helicopterPool = new Array();
            this._humveePool = new Array();
            this._pistolPool = new Array();
            this._planePool = new Array();
            this._ramPool = new Array();
            this._shovelPool = new Array();
            this._sniperPool = new Array();
            this._tankPool = new Array();
            this._bomberCounter = 0;
            this._daggerCounter = 0;
            this._helicopterCounter = 0;
            this._humveeCounter = 0;
            this._pistolCounter = 0;
            this._planeCounter = 0;
            this._ramCounter = 0;
            this._shovelCounter = 0;
            this._sniperCounter = 0;
            this._tankCounter = 0;
         }
         else
         {
            GameError.throwError("EnemyPool","constructor","Only one instance of EnemyPool is necessary. Use the \"getInstance()\" method instead of the \"new\" keyword.");
         }
      }
      
      public static function getInstance() : EnemyPool
      {
         if(EnemyPool._instance == null)
         {
            EnemyPool._allowInstance = true;
            EnemyPool._instance = new EnemyPool();
            EnemyPool._allowInstance = false;
         }
         return EnemyPool._instance;
      }
      
      public function getEnemy(param1:int, param2:int, param3:int) : Enemy
      {
         var _loc4_:Enemy = null;
         switch(param2)
         {
            case 0:
               if(this._bomberCounter > 0)
               {
                  --this._bomberCounter;
                  this._bomberPool[this._bomberCounter].reset(param1,param3);
               }
               else
               {
                  this._bomberPool.unshift(new Enemy(this._propManager.getEnemy("Bomber"),param1,param3));
               }
               _loc4_ = this._bomberPool[this._bomberCounter];
               break;
            case 1:
               if(this._daggerCounter > 0)
               {
                  --this._daggerCounter;
                  this._daggerPool[this._daggerCounter].reset(param1,param3);
               }
               else
               {
                  this._daggerPool.unshift(new Enemy(this._propManager.getEnemy("Dagger"),param1,param3));
               }
               _loc4_ = this._daggerPool[this._daggerCounter];
               break;
            case 2:
               if(this._helicopterCounter > 0)
               {
                  --this._helicopterCounter;
                  this._helicopterPool[this._helicopterCounter].reset(param1,param3);
               }
               else
               {
                  this._helicopterPool.unshift(new Enemy(this._propManager.getEnemy("Helicopter"),param1,param3));
               }
               _loc4_ = this._helicopterPool[this._helicopterCounter];
               break;
            case 3:
               if(this._humveeCounter > 0)
               {
                  --this._humveeCounter;
                  this._humveePool[this._humveeCounter].reset(param1,param3);
               }
               else
               {
                  this._humveePool.unshift(new Enemy(this._propManager.getEnemy("Humvee"),param1,param3));
               }
               _loc4_ = this._humveePool[this._humveeCounter];
               break;
            case 4:
               if(this._pistolCounter > 0)
               {
                  --this._pistolCounter;
                  this._pistolPool[this._pistolCounter].reset(param1,param3);
               }
               else
               {
                  this._pistolPool.unshift(new Enemy(this._propManager.getEnemy("Pistol"),param1,param3));
               }
               _loc4_ = this._pistolPool[this._pistolCounter];
               break;
            case 5:
               if(this._planeCounter > 0)
               {
                  --this._planeCounter;
                  this._planePool[this._planeCounter].reset(param1,param3);
               }
               else
               {
                  this._planePool.unshift(new Enemy(this._propManager.getEnemy("Plane"),param1,param3));
               }
               _loc4_ = this._planePool[this._planeCounter];
               break;
            case 6:
               if(this._ramCounter > 0)
               {
                  --this._ramCounter;
                  this._ramPool[this._ramCounter].reset(param1,param3);
               }
               else
               {
                  this._ramPool.unshift(new Enemy(this._propManager.getEnemy("Ram"),param1,param3));
               }
               _loc4_ = this._ramPool[this._ramCounter];
               break;
            case 7:
               if(this._shovelCounter > 0)
               {
                  --this._shovelCounter;
                  this._shovelPool[this._shovelCounter].reset(param1,param3);
               }
               else
               {
                  this._shovelPool.unshift(new Enemy(this._propManager.getEnemy("Shovel"),param1,param3));
               }
               _loc4_ = this._shovelPool[this._shovelCounter];
               break;
            case 8:
               if(this._sniperCounter > 0)
               {
                  --this._sniperCounter;
                  this._sniperPool[this._sniperCounter].reset(param1,param3);
               }
               else
               {
                  this._sniperPool.unshift(new Enemy(this._propManager.getEnemy("Sniper"),param1,param3));
               }
               _loc4_ = this._sniperPool[this._sniperCounter];
               break;
            case 9:
               if(this._tankCounter > 0)
               {
                  --this._tankCounter;
                  this._tankPool[this._tankCounter].reset(param1,param3);
               }
               else
               {
                  this._tankPool.unshift(new Enemy(this._propManager.getEnemy("Tank"),param1,param3));
               }
               _loc4_ = this._tankPool[this._tankCounter];
         }
         return _loc4_;
      }
      
      public function returnEnemy(param1:Enemy) : void
      {
         switch(param1.data.name)
         {
            case "Bomber":
               this._bomberPool[this._bomberCounter] = param1;
               ++this._bomberCounter;
               break;
            case "Dagger":
               this._daggerPool[this._daggerCounter] = param1;
               ++this._daggerCounter;
               break;
            case "Helicopter":
               this._helicopterPool[this._helicopterCounter] = param1;
               ++this._helicopterCounter;
               break;
            case "Humvee":
               this._humveePool[this._humveeCounter] = param1;
               ++this._humveeCounter;
               break;
            case "Pistol":
               this._pistolPool[this._pistolCounter] = param1;
               ++this._pistolCounter;
               break;
            case "Plane":
               this._planePool[this._planeCounter] = param1;
               ++this._planeCounter;
               break;
            case "Ram":
               this._ramPool[this._ramCounter] = param1;
               ++this._ramCounter;
               break;
            case "Shovel":
               this._shovelPool[this._shovelCounter] = param1;
               ++this._shovelCounter;
               break;
            case "Sniper":
               this._sniperPool[this._sniperCounter] = param1;
               ++this._sniperCounter;
               break;
            case "Tank":
               this._tankPool[this._tankCounter] = param1;
               ++this._tankCounter;
         }
      }
   }
}


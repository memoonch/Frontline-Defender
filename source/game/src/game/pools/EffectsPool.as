package src.game.pools
{
   import com.hcLibrary.debug.GameError;
   import com.hcLibrary.display.SpecialEffect;
   import com.hcLibrary.managers.ImageManager;
   import src.components.gui.MinimapIcon;
   import src.game.Bullet;
   import src.game.Flame;
   import src.game.Grenade;
   import src.game.Payload;
   import src.game.Rocket;
   
   public class EffectsPool
   {
      
      private static var _instance:EffectsPool;
      
      private static var _allowInstance:Boolean;
      
      private var _imageManager:ImageManager;
      
      private var _minimapIconPool:Array;
      
      private var _explosionPool:Array;
      
      private var _groundExplosionPool:Array;
      
      private var _muzzle01Pool:Array;
      
      private var _muzzle02Pool:Array;
      
      private var _muzzle03Pool:Array;
      
      private var _muzzle04Pool:Array;
      
      private var _muzzle05Pool:Array;
      
      private var _muzzle06Pool:Array;
      
      private var _enemyHitPool:Array;
      
      private var _groundHitPool:Array;
      
      private var _wallHitPool:Array;
      
      private var _bulletPool:Array;
      
      private var _rocketPool:Array;
      
      private var _flamePool:Array;
      
      private var _grenadePool:Array;
      
      private var _payloadPool:Array;
      
      private var _minimapIconCounter:int;
      
      private var _explosionCounter:int;
      
      private var _groundExplosionCounter:int;
      
      private var _muzzle01Counter:int;
      
      private var _muzzle02Counter:int;
      
      private var _muzzle03Counter:int;
      
      private var _muzzle04Counter:int;
      
      private var _muzzle05Counter:int;
      
      private var _muzzle06Counter:int;
      
      private var _enemyHitCounter:int;
      
      private var _groundHitCounter:int;
      
      private var _wallHitCounter:int;
      
      private var _bulletCounter:int;
      
      private var _rocketCounter:int;
      
      private var _flameCounter:int;
      
      private var _grenadeCounter:int;
      
      private var _payloadCounter:int;
      
      public function EffectsPool()
      {
         super();
         if(EffectsPool._allowInstance)
         {
            this._imageManager = ImageManager.getInstance();
            this._minimapIconPool = new Array();
            this._explosionPool = new Array();
            this._groundExplosionPool = new Array();
            this._muzzle01Pool = new Array();
            this._muzzle02Pool = new Array();
            this._muzzle03Pool = new Array();
            this._muzzle04Pool = new Array();
            this._muzzle05Pool = new Array();
            this._muzzle06Pool = new Array();
            this._enemyHitPool = new Array();
            this._groundHitPool = new Array();
            this._wallHitPool = new Array();
            this._bulletPool = new Array();
            this._rocketPool = new Array();
            this._flamePool = new Array();
            this._grenadePool = new Array();
            this._payloadPool = new Array();
            this._minimapIconCounter = 0;
            this._explosionCounter = 0;
            this._groundExplosionCounter = 0;
            this._muzzle01Counter = 0;
            this._muzzle02Counter = 0;
            this._muzzle03Counter = 0;
            this._muzzle04Counter = 0;
            this._muzzle05Counter = 0;
            this._muzzle06Counter = 0;
            this._enemyHitCounter = 0;
            this._groundHitCounter = 0;
            this._wallHitCounter = 0;
            this._bulletCounter = 0;
            this._rocketCounter = 0;
            this._flameCounter = 0;
            this._grenadeCounter = 0;
            this._payloadCounter = 0;
         }
         else
         {
            GameError.throwError("EffectsPool","constructor","Only one instance of EffectsPool is necessary. Use the \"getInstance()\" method instead of the \"new\" keyword.");
         }
      }
      
      public static function getInstance() : EffectsPool
      {
         if(EffectsPool._instance == null)
         {
            EffectsPool._allowInstance = true;
            EffectsPool._instance = new EffectsPool();
            EffectsPool._allowInstance = false;
         }
         return EffectsPool._instance;
      }
      
      public function getIcon(param1:int) : MinimapIcon
      {
         if(this._minimapIconCounter > 0)
         {
            --this._minimapIconCounter;
         }
         else
         {
            this._minimapIconPool.unshift(new MinimapIcon());
         }
         this._minimapIconPool[this._minimapIconCounter].setIcon(param1);
         return this._minimapIconPool[this._minimapIconCounter];
      }
      
      public function returnIcon(param1:MinimapIcon) : void
      {
         this._minimapIconPool[this._minimapIconCounter] = param1;
         ++this._minimapIconCounter;
      }
      
      public function getEffect(param1:String) : SpecialEffect
      {
         var _loc2_:SpecialEffect = null;
         switch(param1)
         {
            case "EXPLOSION":
               if(this._explosionCounter > 0)
               {
                  --this._explosionCounter;
                  this._explosionPool[this._explosionCounter].reset();
               }
               else
               {
                  this._explosionPool.unshift(new SpecialEffect(this._imageManager.getImage("explosion"),120,118,10,param1));
               }
               _loc2_ = this._explosionPool[this._explosionCounter];
               break;
            case "GROUND_EXPLOSION":
               if(this._groundExplosionCounter > 0)
               {
                  --this._groundExplosionCounter;
                  this._groundExplosionPool[this._groundExplosionCounter].reset();
               }
               else
               {
                  this._groundExplosionPool.unshift(new SpecialEffect(this._imageManager.getImage("ground_explosion"),73,166,8,param1));
               }
               _loc2_ = this._groundExplosionPool[this._groundExplosionCounter];
               break;
            case "ENEMY_HIT":
               if(this._enemyHitCounter > 0)
               {
                  --this._enemyHitCounter;
                  this._enemyHitPool[this._enemyHitCounter].reset();
               }
               else
               {
                  this._enemyHitPool.unshift(new SpecialEffect(this._imageManager.getImage("enemy_hit"),39,41,4,param1));
               }
               _loc2_ = this._enemyHitPool[this._enemyHitCounter];
               break;
            case "GROUND_HIT":
               if(this._groundHitCounter > 0)
               {
                  --this._groundHitCounter;
                  this._groundHitPool[this._groundHitCounter].reset();
               }
               else
               {
                  this._groundHitPool.unshift(new SpecialEffect(this._imageManager.getImage("ground_hit"),18,30,6,param1));
               }
               _loc2_ = this._groundHitPool[this._groundHitCounter];
               break;
            case "WALL_HIT":
               if(this._wallHitCounter > 0)
               {
                  --this._wallHitCounter;
                  this._wallHitPool[this._wallHitCounter].reset();
               }
               else
               {
                  this._wallHitPool.unshift(new SpecialEffect(this._imageManager.getImage("wall_hit"),39,41,4,param1));
               }
               _loc2_ = this._wallHitPool[this._wallHitCounter];
         }
         return _loc2_;
      }
      
      public function returnEffect(param1:SpecialEffect) : void
      {
         param1.rotation = 0;
         switch(param1.name)
         {
            case "EXPLOSION":
               this._explosionPool[this._explosionCounter] = param1;
               ++this._explosionCounter;
               break;
            case "GROUND_EXPLOSION":
               this._groundExplosionPool[this._groundExplosionCounter] = param1;
               ++this._groundExplosionCounter;
               break;
            case "ENEMY_HIT":
               this._enemyHitPool[this._enemyHitCounter] = param1;
               ++this._enemyHitCounter;
               break;
            case "GROUND_HIT":
               this._groundHitPool[this._groundHitCounter] = param1;
               ++this._groundHitCounter;
               break;
            case "WALL_HIT":
               this._wallHitPool[this._wallHitCounter] = param1;
               ++this._wallHitCounter;
         }
      }
      
      public function getBullet(param1:int, param2:int, param3:int) : Bullet
      {
         if(this._bulletCounter > 0)
         {
            --this._bulletCounter;
            this._bulletPool[this._bulletCounter].reset(param1,param2,param3);
         }
         else
         {
            this._bulletPool.unshift(new Bullet(param1,param2,param3));
         }
         return this._bulletPool[this._bulletCounter];
      }
      
      public function returnBullet(param1:Bullet) : void
      {
         this._bulletPool[this._bulletCounter] = param1;
         ++this._bulletCounter;
      }
      
      public function getRocket(param1:int, param2:int, param3:int) : Rocket
      {
         if(this._rocketCounter > 0)
         {
            --this._rocketCounter;
            this._rocketPool[this._rocketCounter].reset(param1,param2,param3);
         }
         else
         {
            this._rocketPool.unshift(new Rocket(param1,param2,param3));
         }
         return this._rocketPool[this._rocketCounter];
      }
      
      public function returnRocket(param1:Rocket) : void
      {
         this._rocketPool[this._rocketCounter] = param1;
         ++this._rocketCounter;
      }
      
      public function getFlame(param1:int, param2:int) : Flame
      {
         if(this._flameCounter > 0)
         {
            --this._flameCounter;
            this._flamePool[this._flameCounter].reset(param1,param2);
         }
         else
         {
            this._flamePool.unshift(new Flame(param1,param2));
         }
         return this._flamePool[this._flameCounter];
      }
      
      public function returnFlame(param1:Flame) : void
      {
         this._flamePool[this._flameCounter] = param1;
         ++this._flameCounter;
      }
      
      public function getGrenade(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:int, param7:Number, param8:Number) : Grenade
      {
         if(this._grenadeCounter > 0)
         {
            --this._grenadeCounter;
            this._grenadePool[this._grenadeCounter].reset(param1,param2,param3,param4,param5,param6,param7,param8);
         }
         else
         {
            this._grenadePool.unshift(new Grenade(param1,param2,param3,param4,param5,param6,param7,param8));
         }
         return this._grenadePool[this._grenadeCounter];
      }
      
      public function returnGrenade(param1:Grenade) : void
      {
         this._grenadePool[this._grenadeCounter] = param1;
         ++this._grenadeCounter;
      }
      
      public function getPayload(param1:int) : Payload
      {
         if(this._payloadCounter > 0)
         {
            --this._payloadCounter;
            this._payloadPool[this._payloadCounter].reset(param1);
         }
         else
         {
            this._payloadPool.unshift(new Payload(param1));
         }
         return this._payloadPool[this._payloadCounter];
      }
      
      public function returnPayload(param1:Payload) : void
      {
         this._payloadPool[this._payloadCounter] = param1;
         ++this._payloadCounter;
      }
   }
}


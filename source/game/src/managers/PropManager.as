package src.managers
{
   import com.hcLibrary.debug.GameError;
   import com.hcLibrary.events.GameEvent;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import src.data.AllyData;
   import src.data.EnemyData;
   import src.data.ShopTroopData;
   import src.data.ShopWeaponData;
   import src.data.XMLData;
   
   public class PropManager extends EventDispatcher
   {
      
      private static var _instance:PropManager;
      
      private static var _allowInstance:Boolean;
      
      private var _enemies:Array;
      
      private var _allies:Array;
      
      private var _shopWeapons:Array;
      
      private var _shopTroops:Array;
      
      private var _enemyXML:XML;
      
      private var _allyXML:XML;
      
      private var _shopXML:XML;
      
      private var _stage:int;
      
      private var _i:int;
      
      public function PropManager()
      {
         super();
         if(PropManager._allowInstance)
         {
            this.Initialize();
         }
         else
         {
            GameError.throwError("PropManager","constructor","Only one instance of PropManager is necessary. Use the \"getInstance()\" method instead of the \"new\" keyword.");
         }
      }
      
      public static function getInstance() : PropManager
      {
         if(PropManager._instance == null)
         {
            PropManager._allowInstance = true;
            PropManager._instance = new PropManager();
            PropManager._allowInstance = false;
         }
         return PropManager._instance;
      }
      
      private function Initialize() : void
      {
         this._enemies = new Array();
         var _loc1_:ByteArray = new XMLData.data_Enemies();
         this._enemyXML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         this._allies = new Array();
         _loc1_ = new XMLData.data_Allies();
         this._allyXML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         this._shopWeapons = new Array();
         this._shopTroops = new Array();
         _loc1_ = new XMLData.data_Shop();
         this._shopXML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         this._stage = 0;
         this._i = 0;
      }
      
      public function Load() : void
      {
         switch(this._stage)
         {
            case 0:
               this.loadEnemies();
               break;
            case 1:
               this.loadAllies();
               break;
            case 2:
               this.loadShop();
               break;
            case 3:
               this.loadTroops();
         }
      }
      
      private function loadEnemies() : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:EnemyData = null;
         var _loc6_:Object = null;
         var _loc1_:int = this._enemyXML.Enemy.length();
         var _loc2_:int = getTimer();
         this._i;
         while(this._i < _loc1_)
         {
            if(getTimer() - _loc2_ > 5)
            {
               return;
            }
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < this._enemyXML.Enemy[this._i].Animation.length())
            {
               _loc6_ = {
                  "name":this._enemyXML.Enemy[this._i].Animation[_loc4_].@name,
                  "startFrame":this._enemyXML.Enemy[this._i].Animation[_loc4_].@startFrame,
                  "endFrame":this._enemyXML.Enemy[this._i].Animation[_loc4_].@endFrame,
                  "delay":this._enemyXML.Enemy[this._i].Animation[_loc4_].@delay,
                  "direction":this._enemyXML.Enemy[this._i].Animation[_loc4_].@direction,
                  "loops":this._enemyXML.Enemy[this._i].Animation[_loc4_].@loops,
                  "nextSequence":this._enemyXML.Enemy[this._i].Animation[_loc4_].@nextSequence
               };
               _loc3_.push(_loc6_);
               _loc4_++;
            }
            _loc5_ = new EnemyData(this._enemyXML.Enemy[this._i].@name,this._enemyXML.Enemy[this._i].health,this._enemyXML.Enemy[this._i].damage,this._enemyXML.Enemy[this._i].speed,this._enemyXML.Enemy[this._i].range,this._enemyXML.Enemy[this._i].loot,this._enemyXML.Enemy[this._i].points,this._enemyXML.Enemy[this._i].isAir == 1,this._enemyXML.Enemy[this._i].bulletType,this._enemyXML.Enemy[this._i].deathSound,this._enemyXML.Enemy[this._i].bulletSpawnX,this._enemyXML.Enemy[this._i].bulletSpawnY,this._enemyXML.Enemy[this._i].width,this._enemyXML.Enemy[this._i].height,this._enemyXML.Enemy[this._i].frames,this._enemyXML.Enemy[this._i].xPosition,this._enemyXML.Enemy[this._i].yPosition,this._enemyXML.Enemy[this._i].boundsWidth,this._enemyXML.Enemy[this._i].boundsHeight,this._enemyXML.Enemy[this._i].image,_loc3_);
            this._enemies.push(_loc5_);
            ++this._i;
         }
         this._i = 0;
         ++this._stage;
      }
      
      private function loadAllies() : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:AllyData = null;
         var _loc6_:Object = null;
         var _loc1_:int = this._allyXML.Ally.length();
         var _loc2_:int = getTimer();
         this._i;
         while(this._i < _loc1_)
         {
            if(getTimer() - _loc2_ > 5)
            {
               return;
            }
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < this._allyXML.Ally[this._i].Animation.length())
            {
               _loc6_ = {
                  "name":this._allyXML.Ally[this._i].Animation[_loc4_].@name,
                  "startFrame":this._allyXML.Ally[this._i].Animation[_loc4_].@startFrame,
                  "endFrame":this._allyXML.Ally[this._i].Animation[_loc4_].@endFrame,
                  "delay":this._allyXML.Ally[this._i].Animation[_loc4_].@delay,
                  "direction":this._allyXML.Ally[this._i].Animation[_loc4_].@direction,
                  "loops":this._allyXML.Ally[this._i].Animation[_loc4_].@loops,
                  "nextSequence":this._allyXML.Ally[this._i].Animation[_loc4_].@nextSequence
               };
               _loc3_.push(_loc6_);
               _loc4_++;
            }
            _loc5_ = new AllyData(this._allyXML.Ally[this._i].@name,this._allyXML.Ally[this._i].damage,this._allyXML.Ally[this._i].range,this._allyXML.Ally[this._i].bulletType,this._allyXML.Ally[this._i].bulletSpawnX,this._allyXML.Ally[this._i].bulletSpawnY,this._allyXML.Ally[this._i].width,this._allyXML.Ally[this._i].height,this._allyXML.Ally[this._i].frames,this._allyXML.Ally[this._i].image,_loc3_);
            this._allies.push(_loc5_);
            ++this._i;
         }
         this._i = 0;
         ++this._stage;
      }
      
      private function loadShop() : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:ShopWeaponData = null;
         var _loc1_:int = this._shopXML.Weapon.length();
         var _loc2_:int = getTimer();
         this._i;
         while(this._i < _loc1_)
         {
            if(getTimer() - _loc2_ > 5)
            {
               return;
            }
            _loc3_ = new Array(this._shopXML.Weapon[this._i].damage.@level_01,this._shopXML.Weapon[this._i].damage.@level_02,this._shopXML.Weapon[this._i].damage.@level_03);
            _loc4_ = new Array(this._shopXML.Weapon[this._i].accuracy.@level_01,this._shopXML.Weapon[this._i].accuracy.@level_02,this._shopXML.Weapon[this._i].accuracy.@level_03);
            _loc5_ = new Array(this._shopXML.Weapon[this._i].rateOfFire.@level_01,this._shopXML.Weapon[this._i].rateOfFire.@level_02,this._shopXML.Weapon[this._i].rateOfFire.@level_03);
            _loc6_ = new Array(this._shopXML.Weapon[this._i].clip.@level_01,this._shopXML.Weapon[this._i].clip.@level_02,this._shopXML.Weapon[this._i].clip.@level_03);
            _loc7_ = new Array(this._shopXML.Weapon[this._i].ammo.@level_01,this._shopXML.Weapon[this._i].ammo.@level_02,this._shopXML.Weapon[this._i].ammo.@level_03);
            _loc8_ = new Array(this._shopXML.Weapon[this._i].cost.@level_01,this._shopXML.Weapon[this._i].cost.@level_02,this._shopXML.Weapon[this._i].cost.@level_03);
            _loc9_ = new ShopWeaponData(this._shopXML.Weapon[this._i].@name,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
            this._shopWeapons.push(_loc9_);
            ++this._i;
         }
         this._i = 0;
         ++this._stage;
      }
      
      private function loadTroops() : void
      {
         var _loc3_:ShopTroopData = null;
         var _loc1_:int = this._shopXML.Troop.length();
         var _loc2_:int = getTimer();
         this._i;
         while(this._i < _loc1_)
         {
            if(getTimer() - _loc2_ > 5)
            {
               return;
            }
            _loc3_ = new ShopTroopData(this._shopXML.Troop[this._i].damage,String(this._shopXML.Troop[this._i].rateOfFire),this._shopXML.Troop[this._i].cost);
            this._shopTroops.push(_loc3_);
            ++this._i;
         }
         this._i = 0;
         ++this._stage;
         this.dispatchEvent(new GameEvent(GameEvent.FINISHED));
      }
      
      public function getEnemy(param1:String) : EnemyData
      {
         var _loc2_:EnemyData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._enemies.length)
         {
            if(this._enemies[_loc3_].name == param1)
            {
               _loc2_ = this._enemies[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == null)
         {
            GameError.throwError("PropManager","getEnemy","An enemy with the name \"" + param1 + "\" does not exist.");
         }
         return _loc2_;
      }
      
      public function getAlly(param1:String) : AllyData
      {
         var _loc2_:AllyData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._allies.length)
         {
            if(this._allies[_loc3_].name == param1)
            {
               _loc2_ = this._allies[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == null)
         {
            GameError.throwError("PropManager","getAlly","An ally with the name \"" + param1 + "\" does not exist.");
         }
         return _loc2_;
      }
      
      public function getShopWeapon(param1:int) : ShopWeaponData
      {
         return this._shopWeapons[param1];
      }
      
      public function getShopTroop(param1:*) : ShopTroopData
      {
         return this._shopTroops[param1];
      }
   }
}


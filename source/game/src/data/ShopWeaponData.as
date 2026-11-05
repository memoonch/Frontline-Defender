package src.data
{
   public class ShopWeaponData
   {
      
      private var _name:String;
      
      private var _damage:Array;
      
      private var _accuracy:Array;
      
      private var _rateOfFire:Array;
      
      private var _clip:Array;
      
      private var _ammo:Array;
      
      private var _cost:Array;
      
      public var level:int;
      
      public function ShopWeaponData(param1:String, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array, param7:Array)
      {
         super();
         this._name = param1;
         this._damage = param2;
         this._accuracy = param3;
         this._rateOfFire = param4;
         this._clip = param5;
         this._ammo = param6;
         this._cost = param7;
         this.level = 0;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getDamage(param1:int) : int
      {
         return this._damage[param1];
      }
      
      public function getAccuracy(param1:int) : int
      {
         return this._accuracy[param1];
      }
      
      public function getRateOfFire(param1:int) : int
      {
         return this._rateOfFire[param1];
      }
      
      public function getClip(param1:int) : int
      {
         return this._clip[param1];
      }
      
      public function getAmmo(param1:int) : int
      {
         return this._ammo[param1];
      }
      
      public function getCost(param1:int) : int
      {
         return this._cost[param1];
      }
   }
}


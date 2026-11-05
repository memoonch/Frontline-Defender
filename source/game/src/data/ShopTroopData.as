package src.data
{
   public class ShopTroopData
   {
      
      private var _damage:String;
      
      private var _rateOfFire:String;
      
      private var _cost:int;
      
      public var unlocked:Boolean;
      
      public function ShopTroopData(param1:String, param2:String, param3:int)
      {
         super();
         this._damage = param1;
         this._rateOfFire = param2;
         this._cost = param3;
         this.unlocked = true;
      }
      
      public function get damage() : String
      {
         return this._damage;
      }
      
      public function get rateOfFire() : String
      {
         return this._rateOfFire;
      }
      
      public function get cost() : int
      {
         return this._cost;
      }
   }
}


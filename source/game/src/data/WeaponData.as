package src.data
{
   public class WeaponData
   {
      
      private var _weaponData:Array;
      
      public function WeaponData()
      {
         var _loc1_:Object = null;
         super();
         this._weaponData = new Array();
         _loc1_ = {
            "purchased":true,
            "damage":3,
            "minimumAccuracy":10,
            "maximumAccuracy":40,
            "recoil":10,
            "rateOfFire":7,
            "reload":15,
            "magazine":12,
            "clipSize":12,
            "ammo":-1,
            "maxAmmo":-1,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":2,
            "minimumAccuracy":4,
            "maximumAccuracy":35,
            "recoil":8,
            "rateOfFire":4,
            "reload":15,
            "magazine":30,
            "clipSize":30,
            "ammo":90,
            "maxAmmo":90,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":2,
            "minimumAccuracy":26,
            "maximumAccuracy":50,
            "recoil":50,
            "rateOfFire":30,
            "reload":45,
            "magazine":8,
            "clipSize":8,
            "ammo":32,
            "maxAmmo":32,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":5,
            "minimumAccuracy":6,
            "maximumAccuracy":50,
            "recoil":12,
            "rateOfFire":5,
            "reload":20,
            "magazine":25,
            "clipSize":25,
            "ammo":75,
            "maxAmmo":75,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":20,
            "minimumAccuracy":2,
            "maximumAccuracy":55,
            "recoil":70,
            "rateOfFire":50,
            "reload":37,
            "magazine":4,
            "clipSize":4,
            "ammo":12,
            "maxAmmo":12,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":30,
            "minimumAccuracy":20,
            "maximumAccuracy":60,
            "recoil":80,
            "rateOfFire":60,
            "reload":75,
            "magazine":2,
            "clipSize":2,
            "ammo":4,
            "maxAmmo":4,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":28,
            "minimumAccuracy":2,
            "maximumAccuracy":60,
            "recoil":60,
            "rateOfFire":40,
            "reload":60,
            "magazine":3,
            "clipSize":3,
            "ammo":6,
            "maxAmmo":6,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":10,
            "minimumAccuracy":25,
            "maximumAccuracy":65,
            "recoil":8,
            "rateOfFire":2,
            "reload":80,
            "magazine":50,
            "clipSize":50,
            "ammo":100,
            "maxAmmo":100,
            "updated":false
         };
         this._weaponData.push(_loc1_);
         _loc1_ = {
            "purchased":false,
            "damage":100,
            "minimumAccuracy":15,
            "maximumAccuracy":60,
            "recoil":40,
            "rateOfFire":25,
            "reload":75,
            "magazine":2,
            "clipSize":2,
            "ammo":4,
            "maxAmmo":4,
            "updated":false
         };
         this._weaponData.push(_loc1_);
      }
      
      public function getProperties(param1:int) : Object
      {
         return this._weaponData[param1];
      }
      
      public function setProperties(param1:int, param2:Object) : void
      {
         this._weaponData[param1] = param2;
      }
   }
}


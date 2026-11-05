package src.data
{
   import com.hcLibrary.debug.GameError;
   import flash.utils.ByteArray;
   
   public class WaveData
   {
      
      private static var _instance:WaveData;
      
      private static var _allowInstance:Boolean;
      
      private var _waveData:Array;
      
      private var _waveXML:XML;
      
      public function WaveData()
      {
         super();
         if(WaveData._allowInstance)
         {
            this.Initialize();
         }
         else
         {
            GameError.throwError("WaveData","constructor","Only one instance of WaveData is necessary. Use the \"getInstance()\" method instead of the \"new\" keyword.");
         }
      }
      
      public static function getInstance() : WaveData
      {
         if(WaveData._instance == null)
         {
            WaveData._allowInstance = true;
            WaveData._instance = new WaveData();
            WaveData._allowInstance = false;
         }
         return WaveData._instance;
      }
      
      private function Initialize() : void
      {
         var _loc2_:Object = null;
         var _loc1_:ByteArray = new XMLData.data_Waves();
         this._waveXML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         this._waveData = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._waveXML.Wave.length())
         {
            _loc2_ = {
               "dagger":this._waveXML.Wave[_loc3_].@dagger,
               "shovel":this._waveXML.Wave[_loc3_].@shovel,
               "ram":this._waveXML.Wave[_loc3_].@ram,
               "bomber":this._waveXML.Wave[_loc3_].@bomber,
               "pistol":this._waveXML.Wave[_loc3_].@pistol,
               "sniper":this._waveXML.Wave[_loc3_].@sniper,
               "humvee":this._waveXML.Wave[_loc3_].@humvee,
               "plane":this._waveXML.Wave[_loc3_].@plane,
               "helicopter":this._waveXML.Wave[_loc3_].@helicopter,
               "tank":this._waveXML.Wave[_loc3_].@tank
            };
            this._waveData.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function getData(param1:int) : Object
      {
         var _loc2_:int = 0;
         if(param1 > 26)
         {
            _loc2_ = (param1 - 27) % 10 + 17;
            return this._waveData[_loc2_];
         }
         return this._waveData[param1];
      }
   }
}


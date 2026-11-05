package src.game
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.display.SpecialEffect;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import src.game.pools.EffectsPool;
   import src.managers.NewSoundManager;
   
   public class Explosion extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _soundManager:NewSoundManager;
      
      private var _effects:Array;
      
      private var _effectsPool:EffectsPool;
      
      private var _explosions:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _counter:int;
      
      public function Explosion(param1:int, param2:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._soundManager = NewSoundManager.getInstance();
         this._explosions = Calc.random(6,10);
         this._width = param1;
         this._height = param2;
         this._counter = 0;
         this._effects = new Array();
         this._effectsPool = EffectsPool.getInstance();
         this.addEventListener(Event.ENTER_FRAME,this.spawnExplosions,false,0,true);
         this._soundManager.playSound("explosion");
      }
      
      private function spawnExplosions(param1:Event) : void
      {
         var _loc2_:SpecialEffect = null;
         ++this._counter;
         if(this._counter >= 2)
         {
            this._counter = 0;
            --this._explosions;
            _loc2_ = this._effectsPool.getEffect("EXPLOSION");
            _loc2_.x = Calc.random(0,this._width);
            _loc2_.y = Calc.random(0,this._height);
            _loc2_.rotation = Calc.random(0,360);
            this._effects.push(_loc2_);
            this.addChild(_loc2_);
         }
         if(this._explosions <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.spawnExplosions);
         }
      }
      
      public function get isFinished() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         if(this._explosions <= 0)
         {
            _loc1_ = this._effects.length - 1;
            _loc2_ = _loc1_;
            while(_loc2_ > -1)
            {
               if(this._effects[_loc2_].isFinished)
               {
                  this.removeChild(this._effects[_loc2_]);
                  this._effectsPool.returnEffect(this._effects[_loc2_]);
                  this._effects.splice(_loc2_,1);
               }
               _loc2_--;
            }
            if(this._effects.length == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function pause() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._effects.length)
         {
            this._effects[_loc1_].pause();
            _loc1_++;
         }
         this.removeEventListener(Event.ENTER_FRAME,this.spawnExplosions);
      }
      
      public function unpause() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._effects.length)
         {
            this._effects[_loc1_].unpause();
            _loc1_++;
         }
         if(this._explosions > 0)
         {
            this.addEventListener(Event.ENTER_FRAME,this.spawnExplosions,false,0,true);
         }
      }
   }
}


package src.managers
{
   import com.hcLibrary.debug.GameError;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class NewSoundManager
   {
      
      private static var _instance:NewSoundManager;
      
      private static var _allowInstance:Boolean;
      
      private static var _soundDict:Dictionary;
      
      private static var _sounds:Array;
      
      private static var _musicVolume:Number;
      
      private static var _soundVolume:Number;
      
      private static var _musicMuted:Boolean;
      
      private static var _soundMuted:Boolean;
      
      public function NewSoundManager()
      {
         super();
         if(NewSoundManager._allowInstance)
         {
            _soundDict = new Dictionary(true);
            _sounds = new Array();
            _musicVolume = 1;
            _soundVolume = 1;
            _musicMuted = false;
            _soundMuted = false;
         }
         else
         {
            GameError.throwError("SoundManager","constructor","Only 1 instance of SoundManager is necessary. Use the \'getInstance\' method instead of the \'new\' keyword.");
         }
      }
      
      public static function getInstance() : NewSoundManager
      {
         if(NewSoundManager._instance == null)
         {
            NewSoundManager._allowInstance = true;
            NewSoundManager._instance = new NewSoundManager();
            NewSoundManager._allowInstance = false;
         }
         return NewSoundManager._instance;
      }
      
      public static function set muteMusic(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SoundTransform = null;
         _musicMuted = param1;
         _loc2_ = 0;
         while(_loc2_ < _sounds.length)
         {
            if(Boolean(_sounds[_loc2_].isMusic) && _sounds[_loc2_].channel != null)
            {
               _loc3_ = _sounds[_loc2_].channel.soundTransform;
               if(_musicMuted)
               {
                  _loc3_.volume = 0;
               }
               else
               {
                  _loc3_.volume = _musicVolume;
               }
               _sounds[_loc2_].channel.soundTransform = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public static function get muteMusic() : Boolean
      {
         return _musicMuted;
      }
      
      public static function set muteSound(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SoundTransform = null;
         _soundMuted = param1;
         _loc2_ = 0;
         while(_loc2_ < _sounds.length)
         {
            if(!_sounds[_loc2_].isMusic && _sounds[_loc2_].channel != null)
            {
               _loc3_ = _sounds[_loc2_].channel.soundTransform;
               if(_soundMuted)
               {
                  _loc3_.volume = 0;
               }
               else
               {
                  _loc3_.volume = _soundVolume;
               }
               _sounds[_loc2_].channel.soundTransform = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public static function get muteSound() : Boolean
      {
         return _soundMuted;
      }
      
      public static function set musicVolume(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SoundTransform = null;
         if(param1 > 100)
         {
            param1 = 100;
         }
         else if(param1 < 0)
         {
            param1 = 0;
         }
         _musicVolume = param1 / 100;
         _loc2_ = 0;
         while(_loc2_ < _sounds.length)
         {
            if(Boolean(_sounds[_loc2_].isMusic) && _sounds[_loc2_].channel != null)
            {
               _loc3_ = _sounds[_loc2_].channel.soundTransform;
               _loc3_.volume = _musicVolume;
               _sounds[_loc2_].channel.soundTransform = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public static function set soundVolume(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SoundTransform = null;
         if(param1 > 100)
         {
            param1 = 100;
         }
         else if(param1 < 0)
         {
            param1 = 0;
         }
         _soundVolume = param1 / 100;
         _loc2_ = 0;
         while(_loc2_ < _sounds.length)
         {
            if(!_sounds[_loc2_].isMusic && _sounds[_loc2_].channel != null)
            {
               _loc3_ = _sounds[_loc2_].channel.soundTransform;
               _loc3_.volume = _soundVolume;
               _sounds[_loc2_].channel.soundTransform = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public function addSound(param1:*, param2:String, param3:Boolean) : void
      {
         var _loc4_:Object = _soundDict[param2];
         if(_loc4_ != null)
         {
            GameError.throwError("SoundManager","addSound","A sound with the name \'" + param2 + "\' already exists.");
            return;
         }
         var _loc5_:Sound = new param1();
         _loc4_ = {
            "name":param2,
            "sound":_loc5_,
            "channel":new SoundChannel(),
            "position":0,
            "paused":false,
            "stopped":true,
            "volume":1,
            "loops":0,
            "isMusic":param3
         };
         _soundDict[param2] = _loc4_;
         _sounds.push(_loc4_);
      }
      
      public function playSound(param1:String, param2:int = 0) : void
      {
         var _loc3_:Object = _soundDict[param1];
         if(_loc3_ == null)
         {
            GameError.throwError("SoundManager","playSound","A sound with the name \'" + param1 + "\' does not exist.");
            return;
         }
         if(Boolean(_loc3_.isMusic) && Boolean(_musicMuted) || !_loc3_.isMusic && _soundMuted)
         {
            _loc3_.volume = 0;
         }
         else if(_loc3_.isMusic)
         {
            _loc3_.volume = _musicVolume;
         }
         else
         {
            _loc3_.volume = _soundVolume;
         }
         _loc3_.loops = param2;
         if(_loc3_.paused)
         {
            _loc3_.channel = _loc3_.sound.play(_loc3_.position,_loc3_.loops,new SoundTransform(_loc3_.volume));
            if(_loc3_.channel != null)
            {
               _loc3_.channel.addEventListener(Event.SOUND_COMPLETE,this.handleSoundComplete);
            }
         }
         else
         {
            _loc3_.channel = _loc3_.sound.play(0,_loc3_.loops,new SoundTransform(_loc3_.volume));
            if(_loc3_.channel != null)
            {
               _loc3_.channel.addEventListener(Event.SOUND_COMPLETE,this.handleSoundComplete);
            }
         }
         _loc3_.paused = false;
         _loc3_.stopped = false;
      }
      
      public function stopSound(param1:String) : void
      {
         var _loc2_:Object = _soundDict[param1];
         if(_loc2_ == null)
         {
            GameError.throwError("SoundManager","stopSound","A sound with the name \'" + param1 + "\' does not exist.");
            return;
         }
         _loc2_.paused = false;
         _loc2_.stopped = true;
         if(_loc2_.channel != null)
         {
            _loc2_.channel.stop();
            _loc2_.position = 0;
         }
      }
      
      public function pauseSound(param1:String) : void
      {
         var _loc2_:Object = _soundDict[param1];
         if(_loc2_ == null)
         {
            GameError.throwError("SoundManager","pauseSound","A sound with the name \'" + param1 + "\' does not exist.");
            return;
         }
         _loc2_.paused = true;
         if(_loc2_.channel != null)
         {
            _loc2_.position = _loc2_.channel.position;
            _loc2_.channel.stop();
         }
      }
      
      public function isSoundPaused(param1:String) : Boolean
      {
         var _loc2_:Object = _soundDict[param1];
         if(_loc2_ == null)
         {
            GameError.throwError("SoundManager","isSoundPaused","A sound with the name \'" + param1 + "\' does not exist.");
            return false;
         }
         return _loc2_.paused;
      }
      
      public function isSoundStopped(param1:String) : Boolean
      {
         var _loc2_:Object = _soundDict[param1];
         if(_loc2_ == null)
         {
            GameError.throwError("SoundManager","isSoundStopped","A sound with the name \'" + param1 + "\' does not exist.");
            return false;
         }
         return _loc2_.stopped;
      }
      
      public function pauseAllSounds() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sounds.length)
         {
            if(!_sounds[_loc1_].stopped)
            {
               this.pauseSound(_sounds[_loc1_].name);
            }
            _loc1_++;
         }
      }
      
      public function unpauseAllSounds() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sounds.length)
         {
            if(_sounds[_loc1_].paused)
            {
               this.playSound(_sounds[_loc1_].name,_sounds[_loc1_].loops);
            }
            _loc1_++;
         }
      }
      
      private function handleSoundComplete(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:SoundChannel = SoundChannel(param1.target);
         _loc3_ = 0;
         while(_loc3_ < _sounds.length)
         {
            if(_sounds[_loc3_].channel == _loc2_)
            {
               if(_sounds[_loc3_].loops == 0)
               {
                  _sounds[_loc3_].channel.removeEventListener(Event.SOUND_COMPLETE,this.handleSoundComplete);
                  _sounds[_loc3_].stopped = true;
                  break;
               }
               if(_sounds[_loc3_].loops != -1)
               {
                  --_sounds[_loc3_].loops;
               }
               else
               {
                  this.playSound(_sounds[_loc3_].name,_sounds[_loc3_].loops);
               }
            }
            _loc3_++;
         }
      }
   }
}


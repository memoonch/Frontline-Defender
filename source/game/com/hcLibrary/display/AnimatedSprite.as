package com.hcLibrary.display
{
   import com.hcLibrary.components.Sequence;
   import com.hcLibrary.debug.GameError;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AnimatedSprite extends Sprite
   {
      
      private var _isPlaying:Boolean;
      
      private var _currentFrame:int;
      
      private var _startFrame:int;
      
      private var _endFrame:int;
      
      private var _totalFrames:int;
      
      private var _frameWidth:Number;
      
      private var _frameHeight:Number;
      
      private var _frameRate:int;
      
      private var _frameCounter:int;
      
      private var _loopCounter:int;
      
      private var _frameCoordinates:Vector.<Point>;
      
      private var _isFlippedX:Boolean;
      
      private var _isFlippedY:Boolean;
      
      private var _sequences:Dictionary;
      
      private var _currentSequence:Sequence;
      
      private var _imageData:BitmapData;
      
      private var _image:Bitmap;
      
      public function AnimatedSprite(param1:Bitmap, param2:Number, param3:Number, param4:int)
      {
         super();
         this._frameWidth = param2;
         this._frameHeight = param3;
         this._image = new Bitmap(new BitmapData(this._frameWidth,this._frameHeight,true,0));
         this._imageData = param1.bitmapData.clone();
         this.addChild(this._image);
         this._isPlaying = false;
         this._isFlippedX = false;
         this._isFlippedY = false;
         this._totalFrames = param4;
         this._frameRate = 1;
         this._currentFrame = 1;
         this._frameCounter = 0;
         this._loopCounter = 0;
         this._sequences = new Dictionary();
         this.calculateFrameCoordinates();
         this.draw();
      }
      
      private function animate(param1:Event) : void
      {
         ++this._frameCounter;
         if(this._frameCounter % this._frameRate == 0)
         {
            this._currentFrame += this._currentSequence.direction;
            this._frameCounter = 0;
            if(this._currentFrame > this._currentSequence.endFrame && this._currentSequence.direction == 1 || this._currentFrame < this._currentSequence.startFrame && this._currentSequence.direction == -1)
            {
               if(this._currentSequence.loops == -1)
               {
                  this._loopCounter = 0;
               }
               if(this._loopCounter == this._currentSequence.loops)
               {
                  if(this._currentSequence.nextSequence != null)
                  {
                     this.gotoAndPlay(this._currentSequence.nextSequence);
                     return;
                  }
                  --this._currentFrame;
                  this.stop();
                  return;
               }
               ++this._loopCounter;
               if(this._currentSequence.direction == 1)
               {
                  this._currentFrame = this._startFrame;
               }
               else
               {
                  this._currentFrame = this._endFrame;
               }
            }
            this.draw();
         }
      }
      
      private function draw() : void
      {
         var _loc1_:Point = this._frameCoordinates[this._currentFrame - 1];
         this._image.bitmapData.copyPixels(this._imageData,new Rectangle(_loc1_.x,_loc1_.y,this._frameWidth,this._frameHeight),new Point());
      }
      
      private function calculateFrameCoordinates() : void
      {
         var _loc3_:int = 0;
         this._frameCoordinates = new Vector.<Point>();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._totalFrames)
         {
            this._frameCoordinates[_loc3_] = new Point(_loc1_,_loc2_);
            _loc1_ += this._frameWidth;
            if(_loc1_ > this._imageData.width - this._frameWidth)
            {
               _loc1_ = 0;
               _loc2_ += this._frameHeight;
            }
            _loc3_++;
         }
      }
      
      public function addSequence(param1:String, param2:int, param3:int, param4:int, param5:int = -1, param6:int = 1, param7:String = null) : void
      {
         var _loc8_:int = 0;
         param1 = param1.toUpperCase();
         _loc8_ = 0;
         while(_loc8_ < this._sequences.length)
         {
            if(this._sequences[_loc8_].name == param1)
            {
               GameError.throwError("AnimatedSprite","addSequence","An animation with the name \'" + param1 + "\' already exists.");
               return;
            }
            _loc8_++;
         }
         if(param6 != 1 && param6 != -1)
         {
            param6 = 1;
         }
         this._sequences[param1] = new Sequence(param1,param2,param3,param5,param4,param6,param7);
         this.sequence = param1;
      }
      
      public function play() : void
      {
         if(!this._isPlaying)
         {
            this._loopCounter = 0;
            this.addEventListener(Event.ENTER_FRAME,this.animate,false,0,true);
            this._isPlaying = true;
         }
         else
         {
            this.stop();
            this.play();
         }
      }
      
      public function gotoAndPlay(param1:String) : void
      {
         this.sequence = param1;
         this.play();
      }
      
      public function stop() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.animate);
         this._frameCounter = 0;
         this._isPlaying = false;
      }
      
      public function gotoAndStop(param1:String) : void
      {
         this.sequence = param1;
         this.play();
         this.stop();
      }
      
      public function pause() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.animate);
      }
      
      public function resume() : void
      {
         if(this._isPlaying)
         {
            this.addEventListener(Event.ENTER_FRAME,this.animate,false,0,true);
         }
      }
      
      public function get sequence() : String
      {
         return this._currentSequence.name;
      }
      
      public function set sequence(param1:String) : void
      {
         param1 = param1.toUpperCase();
         this._currentSequence = this._sequences[param1];
         this._startFrame = this._currentSequence.startFrame;
         this._endFrame = this._currentSequence.endFrame;
         if(this._currentSequence.direction == 1)
         {
            this._currentFrame = this._startFrame;
         }
         else
         {
            this._currentFrame = this._endFrame;
         }
         this._frameRate = this._currentSequence.delay;
         this._loopCounter = 0;
         this.draw();
      }
      
      public function get frame() : int
      {
         return this._currentFrame;
      }
      
      public function get flippedX() : Boolean
      {
         return this._isFlippedX;
      }
      
      public function set flippedX(param1:Boolean) : void
      {
         if(this._isFlippedX == param1)
         {
            return;
         }
         this._isFlippedX = param1;
         var _loc2_:Matrix = this._image.transform.matrix;
         _loc2_.transformPoint(new Point(this._frameWidth / 2,this._frameHeight / 2));
         _loc2_.a *= -1;
         if(this._isFlippedX)
         {
            _loc2_.tx = this._frameWidth;
         }
         else
         {
            _loc2_.tx = 0;
         }
         this._image.transform.matrix = _loc2_;
      }
      
      public function get flippedY() : Boolean
      {
         return this._isFlippedY;
      }
      
      public function set flippedY(param1:Boolean) : void
      {
         if(this._isFlippedY == param1)
         {
            return;
         }
         this._isFlippedY = param1;
         var _loc2_:Matrix = this._image.transform.matrix;
         _loc2_.transformPoint(new Point(this._frameWidth / 2,this._frameHeight / 2));
         _loc2_.d *= -1;
         if(this._isFlippedY)
         {
            _loc2_.ty = this._frameHeight;
         }
         else
         {
            _loc2_.ty = this._frameHeight * -1;
         }
         this._image.transform.matrix = _loc2_;
      }
   }
}


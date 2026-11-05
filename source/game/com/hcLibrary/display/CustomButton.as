package com.hcLibrary.display
{
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CustomButton extends Sprite
   {
      
      private var _image:AnimatedSprite;
      
      private var _disable:Boolean;
      
      public var isMobile:Boolean;
      
      private var _soundManager:SoundManager;
      
      public function CustomButton(param1:Bitmap, param2:Number, param3:Number, param4:int)
      {
         super();
         this._image = new AnimatedSprite(param1,param2,param3,param4);
         this.addChild(this._image);
         this._disable = false;
         this.isMobile = false;
         this._soundManager = SoundManager.getInstance();
      }
      
      public function set idleState(param1:int) : void
      {
         this._image.addSequence("IDLE",param1,param1,0,0);
         this._image.gotoAndStop("IDLE");
      }
      
      public function set overState(param1:int) : void
      {
         this._image.addSequence("OVER",param1,param1,0,0);
         this._image.addSequence("DELAY",param1,param1,5,0,1,"IDLE");
      }
      
      public function set disabledState(param1:int) : void
      {
         this._image.addSequence("DISABLED",param1,param1,0,0);
         this._disable = true;
      }
      
      public function addMouseEvents() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.mouseClick,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
         if(this.isMobile)
         {
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseOver,false,0,true);
            this.addEventListener(MouseEvent.MOUSE_UP,this.mouseOut,false,0,true);
         }
         else
         {
            this.buttonMode = true;
            this.useHandCursor = true;
         }
      }
      
      public function removeMouseEvents() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.mouseClick);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseOver);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.mouseOut);
         this.buttonMode = false;
         this.useHandCursor = false;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this._image.sequence != "DISABLED")
         {
            this._image.gotoAndStop("OVER");
            if(!this.isMobile)
            {
               this._soundManager.playSound("BUTTON_OVER");
            }
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         if(this._image.sequence != "DISABLED" && this._image.sequence != "DELAY")
         {
            this._image.gotoAndStop("IDLE");
         }
      }
      
      private function mouseClick(param1:MouseEvent) : void
      {
         if(this._image.sequence != "DISABLED")
         {
            if(this._disable)
            {
               this._image.gotoAndStop("DISABLED");
               this.buttonMode = false;
               this.useHandCursor = false;
            }
            else if(this.isMobile)
            {
               this._image.gotoAndPlay("DELAY");
            }
            else
            {
               this._image.gotoAndStop("OVER");
            }
            this._soundManager.playSound("BUTTON_CLICK");
            this.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._image.sequence != "DISABLED";
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            this._image.gotoAndStop("IDLE");
            if(!this.isMobile)
            {
               this.buttonMode = true;
               this.useHandCursor = true;
            }
         }
         else
         {
            this._image.gotoAndStop("DISABLED");
            this.buttonMode = false;
            this.useHandCursor = false;
         }
      }
   }
}


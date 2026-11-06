package src.interfaces.components
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import com.hcLibrary.managers.SoundManager;
   import flash.display.Sprite; import flash.display.Bitmap;import flash.display.BitmapData;import flash.geom.Rectangle;import flash.geom.Point;import flash.geom.Matrix;
   import flash.events.MouseEvent;
   
   public class TroopButton extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _soundManager:SoundManager;
      
      private var _image:AnimatedSprite;
      
      private var _text:Sprite;
      
      private var _amount:int;
      
      private var _clearButton:Boolean;
      
      public function TroopButton(param1:int)
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this._soundManager = SoundManager.getInstance();
         this._image = new AnimatedSprite(cardSheet(),49,50,20);
         if(param1 == -1)
         {
            this._image.addSequence("IDLE",19,19,0,0);
            this._image.addSequence("OVER",20,20,0,0);
            this._image.gotoAndStop("IDLE");
            this._clearButton = true;
         }
         else
         {
            this._image.addSequence("LOCKED",param1 * 3 + 1,param1 * 3 + 1,0,0);
            this._image.addSequence("IDLE",param1 * 3 + 2,param1 * 3 + 2,0,0);
            this._image.addSequence("OVER",param1 * 3 + 3,param1 * 3 + 3,0,0);
            this._image.gotoAndStop("LOCKED");
            this._clearButton = false;
         }
         this.addChild(this._image);
         this._amount = 0;
         this._text = this._fontManager.getString(String(this._amount),"SHOP",1,0);
         this._text.x = 38 - this._text.width / 2;
         this._text.y = 7;
         this._text.visible = false;
         this.addChild(this._text);
      }
      
      public function addEventListeners() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
         this.addEventListener(MouseEvent.CLICK,this.mouseClick,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         this.removeEventListener(MouseEvent.CLICK,this.mouseClick);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED")
         {
            this._image.gotoAndStop("OVER");
            this._soundManager.playSound("BUTTON_OVER");
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED")
         {
            this._image.gotoAndStop("IDLE");
         }
      }
      
      private function mouseClick(param1:MouseEvent) : void
      {
         if(this._image.sequence != "LOCKED" && (this._amount > 0 || this._clearButton))
         {
            this._image.gotoAndStop("IDLE");
            this._soundManager.playSound("BUTTON_CLICK");
            this.dispatchEvent(new GameEvent(GameEvent.CLICKED));
         }
      }
      
      public function changeQuantity(param1:int) : void
      {
         this.removeChild(this._text);
         this._amount = param1;
         this._text = this._fontManager.getString(String(this._amount),"SHOP",1,0);
         this._text.x = 38 - this._text.width / 2;
         this._text.y = 7;
         this._text.visible = !this._clearButton;
         this.addChild(this._text);
         if(this._amount == 0)
         {
            this._image.gotoAndStop("LOCKED");
         }
         else
         {
            this._image.gotoAndStop("IDLE");
         }
      }
      
      public function get isLocked() : Boolean
      {
         return this._image.sequence == "LOCKED";
      }
      
      public function unlock() : void
      {
         this._image.gotoAndStop("IDLE");
         this._text.visible = !this._clearButton;
      }

      private static function cardSheet():Bitmap {
       var source:BitmapData=ImageManager.getInstance().getImage("shop_troop_selection_icons").bitmapData;
       var data:BitmapData=new BitmapData(49,1000,true,0);
       for(var i:int=0;i<20;i++){
        var p:Sprite=new Sprite();var hover:Boolean=i==19 || (i<18 && i%3==2);var locked:Boolean=i<18 && i%3==0;
        p.graphics.beginFill(hover?0x263623:0x080d0e);p.graphics.drawRect(0,0,49,50);p.graphics.endFill();p.graphics.lineStyle(1,hover?0x95b674:0x45574b);p.graphics.drawRect(0.5,0.5,48,49);
        if(i<18){
         var frame:int=int(i/3)*3+1;var portrait:BitmapData=new BitmapData(40,30,true,0);portrait.copyPixels(source,new Rectangle((frame%3)*49+4,int(frame/3)*50+16,40,30),new Point());
         var image:Bitmap=new Bitmap(portrait);image.x=4;image.y=17;image.alpha=locked?0.18:1;p.addChild(image);
         p.graphics.lineStyle();p.graphics.beginFill(0x17231b);p.graphics.drawRect(29,3,17,12);p.graphics.endFill();
         if(locked){var lockPixels:BitmapData=new BitmapData(24,29,true,0);lockPixels.copyPixels(source,new Rectangle(12,10,24,29),new Point());lockPixels.threshold(lockPixels,lockPixels.rect,new Point(),"<",0x282828,0,0xffffff,true);var lock:Bitmap=new Bitmap(lockPixels);lock.smoothing=false;lock.x=12;lock.y=17;lock.scaleX=lock.scaleY=1;p.addChild(lock);}
        }else {var t:Sprite=FontManager.getInstance().getString("REMOVE","SHOP",0,0);t.x=(49-t.width)/2;t.y=23;p.addChild(t);}
        var m:Matrix=new Matrix();m.translate(0,i*50);data.draw(p,m);
       }return new Bitmap(data);
      }
   }
}




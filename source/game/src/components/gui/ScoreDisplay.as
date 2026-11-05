package src.components.gui
{
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite; import flash.geom.Point; import flash.geom.Rectangle; import flash.net.URLRequest; import flash.display.Loader; import flash.display.BitmapData; import flash.display.Bitmap;
   import flash.events.Event; import flash.geom.Matrix; import flash.geom.ColorTransform;
   
   public class ScoreDisplay extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _fontManager:FontManager;
      
      private var _plate:Sprite;
      
      private var _scoreText:Sprite;
      
      private var _waveText:Sprite;
      
      private var _currentScore:Number;
      
      private var _totalScore:Number;
      
      public function ScoreDisplay()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._fontManager = FontManager.getInstance();
         this.InitializePlate();
         this.InitializeText();
         this._currentScore = 0;
         this._totalScore = 0;
         this.addEventListener(Event.ENTER_FRAME,this.update,false,0,true);
      }
      
      private function InitializePlate() : void
      {
         mouseEnabled=false;mouseChildren=false;panel(260,28);
         label("SCORE",28,9,1.2,0xf3efdd);label("WAVE",174,9,1.2,0xf3efdd);
         
      }
      
      private function InitializeText() : void
      {
         this._scoreText = label("0",0,0,1,0xf6f1e5,"GUI_DIGITS");
         this._scoreText.x = 85; 
         this._scoreText.y = 6;
         this.addChild(this._scoreText);
         this._waveText = label("1",0,0,1,0xf6f1e5,"GUI_DIGITS");
         this._waveText.x = 222; 
         this._waveText.y = 6;
         this.addChild(this._waveText);
      }
      
      private function update(param1:Event) : void
      {
         if(this._currentScore < this._totalScore)
         {
            if(this._totalScore - this._currentScore <= 10000)
            {
               this._currentScore += 253;
            }
            else
            {
               this._currentScore += 5533;
            }
            if(this._currentScore >= this._totalScore)
            {
               this._currentScore = this._totalScore;
            }
            if(this._scoreText != null && this.contains(this._scoreText))
            {
               this.removeChild(this._scoreText);
            }
            this._scoreText = label(String(this._currentScore),0,0,1,0xf6f1e5,"GUI_DIGITS");
            this._scoreText.x = 85; 
            this._scoreText.y = 6;
            this.addChild(this._scoreText);
         }
      }
      
      public function updateScore(param1:Number) : void
      {
         this._totalScore = param1;
      }
      
      public function updateWave(param1:int) : void
      {
         if(this._waveText != null && this.contains(this._waveText))
         {
            this.removeChild(this._waveText);
         }
         this._waveText = label(String(param1),0,0,1,0xf6f1e5,"GUI_DIGITS");
         this._waveText.x = 222; 
         this._waveText.y = 6;
         this.addChild(this._waveText);
      }
      
      public function pause() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function unpause() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.update,false,0,true);
      }


 private static var fontSheet:BitmapData;
 private static var fontWaiting:Array=[];
 private static var fontLoading:Boolean=false;
 private function panel(w:Number,h:Number):void {
  graphics.lineStyle();graphics.beginFill(0x080d0e,0.94);graphics.drawRect(0,0,w,h);graphics.endFill();
  graphics.lineStyle(1,0x67736d);graphics.drawRect(0.5,0.5,w-1,h-1);
  graphics.lineStyle(1,0x27332e);graphics.drawRect(2.5,2.5,w-5,h-5);
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1);
  var scale:Number=(font=="SHOP"?1:1.2)*size;
  s.scaleX=scale;s.scaleY=scale*1.33;s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255;tint.greenMultiplier=((color>>8)&255)/255;tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;
  addChild(s);return s;
 }

}}


package src.components.gui
{
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
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
         mouseEnabled=false;mouseChildren=false;panel(260,26);
         label("SCORE",30,8,1.25,0xffb321);label("WAVE",176,8,1.25,0x97b969);
         graphics.lineStyle(2,0xffaa00);graphics.moveTo(158,6);graphics.lineTo(153,20);
      }
      
      private function InitializeText() : void
      {
         this._scoreText = this._fontManager.getString("0","GUI_DIGITS",0);
         this._scoreText.x = 85; this._scoreText.scaleX=0.95; this._scoreText.scaleY=1.25;
         this._scoreText.y = 6;
         this.addChild(this._scoreText);
         this._waveText = this._fontManager.getString("1","GUI_DIGITS",0);
         this._waveText.x = 222; this._waveText.scaleX=0.95; this._waveText.scaleY=1.25;
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
            this._scoreText = this._fontManager.getString(String(this._currentScore),"GUI_DIGITS",0);
            this._scoreText.x = 85; this._scoreText.scaleX=0.95; this._scoreText.scaleY=1.25;
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
         this._waveText = this._fontManager.getString(String(param1),"GUI_DIGITS",0);
         this._waveText.x = 222; this._waveText.scaleX=0.95; this._waveText.scaleY=1.25;
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

 private function panel(w:Number,h:Number):void {
  var m:Matrix=new Matrix(); m.createGradientBox(w,h,Math.PI/2);
  graphics.lineStyle(1,0x929b70); graphics.beginGradientFill("linear",[0x30382c,0x101615,0x22271e],[0.96,0.96,0.96],[0,140,255],m);
  graphics.moveTo(9,0);graphics.lineTo(w-9,0);graphics.lineTo(w,9);graphics.lineTo(w-7,h);graphics.lineTo(7,h);graphics.lineTo(0,h-9);graphics.lineTo(9,0);graphics.endFill();
  graphics.lineStyle(0.6,0xcbd2a1,0.35);graphics.moveTo(12,3);graphics.lineTo(w-12,3);
  graphics.lineStyle(2,0xffaa00);graphics.moveTo(9,h-2);graphics.lineTo(29,h-2);
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1); s.scaleX=size; s.scaleY=size*1.33; s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255; tint.greenMultiplier=((color>>8)&255)/255; tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;addChild(s);return s;
 }
   }
}


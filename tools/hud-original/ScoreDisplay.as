package src.components.gui
{
   import com.hcLibrary.managers.FontManager;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
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
         this._plate = new Sprite();
         this._plate.addChild(this._imageManager.getImage("score_plate"));
         this.addChild(this._plate);
      }
      
      private function InitializeText() : void
      {
         this._scoreText = this._fontManager.getString("0","GUI_DIGITS",0);
         this._scoreText.x = 43;
         this._scoreText.y = 3;
         this.addChild(this._scoreText);
         this._waveText = this._fontManager.getString("1","GUI_DIGITS",0);
         this._waveText.x = 161;
         this._waveText.y = 3;
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
            this._scoreText.x = 43;
            this._scoreText.y = 3;
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
         this._waveText.x = 161;
         this._waveText.y = 3;
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
   }
}


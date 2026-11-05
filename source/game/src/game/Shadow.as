package src.game
{
   import flash.display.Sprite;
   
   public class Shadow extends Sprite
   {
      
      private var _radius:int;
      
      private var _image:Sprite;
      
      public function Shadow()
      {
         super();
         this._radius = 10;
         this._image = new Sprite();
         this._image.graphics.beginFill(0,0.7);
         this._image.graphics.drawEllipse(0,0,this._radius,this._radius / 2);
         this._image.graphics.endFill();
         this._image.x = -(this._image.width / 2);
         this._image.y = -(this._image.height / 2);
         this.addChild(this._image);
      }
      
      public function update() : void
      {
         this._radius += 2;
         if(this._radius >= 60)
         {
            this._radius = 60;
         }
         this._image.graphics.clear();
         this._image.graphics.beginFill(0,0.7);
         this._image.graphics.drawEllipse(0,0,this._radius,this._radius / 2);
         this._image.graphics.endFill();
         this._image.x = -(this._image.width / 2);
         this._image.y = -(this._image.height / 2);
      }
      
      public function reset() : void
      {
         this._radius = 10;
         this._image.graphics.clear();
         this._image.graphics.beginFill(0,0.7);
         this._image.graphics.drawEllipse(0,0,this._radius,this._radius / 2);
         this._image.graphics.endFill();
         this._image.x = -(this._image.width / 2);
         this._image.y = -(this._image.height / 2);
      }
   }
}


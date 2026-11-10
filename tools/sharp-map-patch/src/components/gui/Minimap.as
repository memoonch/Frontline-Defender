package src.components.gui
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import src.game.pools.EffectsPool;
   
   public class Minimap extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _plate:AnimatedSprite;
      
      private var _frame:AnimatedSprite;
      
      private var _overlay:Sprite;
      
      private var _icons:Array;
      
      private var _iconContainer:Sprite;
      
      private var _effectsPool:EffectsPool;
      
      public function Minimap()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this.InitializePlate();
         this._icons = new Array();
         this._effectsPool = EffectsPool.getInstance();
      }
      
      private function InitializePlate() : void
      {
         this._plate = new AnimatedSprite(sharpMap(),840,208,2);
         this._plate.scaleX = this._plate.scaleY = 0.25;
         this._plate.addSequence("IDLE",2,2,0,0);
         this._plate.gotoAndStop("IDLE");
         this.addChild(this._plate);
         this._iconContainer = new Sprite();
         this._iconContainer.x = 9;
         this._iconContainer.y = 2;
         this._iconContainer.scrollRect = new Rectangle(0,0,192,48);
         this.addChild(this._iconContainer);
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,0.4);
         this._overlay.graphics.drawRect(0,0,192,48);
         this._overlay.graphics.drawRect(65,1,62,46);
         this._overlay.graphics.endFill();
         this._overlay.graphics.beginFill(16711680);
         this._overlay.graphics.drawRect(64,0,64,48);
         this._overlay.graphics.drawRect(65,1,62,46);
         this._overlay.graphics.endFill();
         this._overlay.x = 9;
         this._overlay.y = 2;
         this.addChild(this._overlay);
         this._frame = new AnimatedSprite(this._imageManager.getImage("minimap"),210,52,2);
         this._frame.addSequence("IDLE",1,1,0,0);
         this._frame.gotoAndStop("IDLE");
         this._frame.visible=false;
         this.addChild(this._frame);
         mouseEnabled=false;mouseChildren=false;
         var border:Sprite=new Sprite();
         border.graphics.lineStyle(1,0x263530,0.9);border.graphics.drawRect(7,0,196,52);
         border.graphics.lineStyle(1.3,0xffb42b);
         border.graphics.moveTo(8,11);border.graphics.lineTo(8,1);border.graphics.lineTo(19,1);
         border.graphics.moveTo(191,1);border.graphics.lineTo(202,1);border.graphics.lineTo(202,11);
         border.graphics.moveTo(8,41);border.graphics.lineTo(8,51);border.graphics.lineTo(19,51);
         border.graphics.moveTo(191,51);border.graphics.lineTo(202,51);border.graphics.lineTo(202,41);addChild(border);
      }
      
      private function sharpMap():Bitmap
      {
         var original:BitmapData = this._imageManager.getImage("minimap").bitmapData;
         var clean:BitmapData = original.clone();
         var strokes:Sprite = new Sprite();
         strokes.graphics.lineStyle(1.15,0x19e832,1,false,"normal","round","round");
         var previous:Array = [];
         for(var x:int=210;x<420;x++)
         {
            var current:Array=[];
            var y:int=0;
            while(y<52)
            {
               if(!mapGreen(original.getPixel32(x,y))) { y++; continue; }
               var first:int=y;
               while(y<52 && mapGreen(original.getPixel32(x,y)))
               {
                  var replacement:uint=original.getPixel32(x,Math.max(0,first-2));
                  clean.setPixel32(x,y,replacement); y++;
               }
               var center:Number=(first+y-1)/2;
               current.push(center);
               var best:Number=1000;
               var match:Number=0;
               for each(var old:Number in previous) if(Math.abs(old-center)<best) { best=Math.abs(old-center); match=old; }
               if(best<3) { strokes.graphics.moveTo(x-1,match); strokes.graphics.lineTo(x,center); }
            }
            previous=current;
         }
         var enlarged:BitmapData = mapDouble(mapDouble(clean));
         enlarged.draw(strokes,new Matrix(4,0,0,4));
         return new Bitmap(enlarged);
      }

      private static function mapGreen(c:uint):Boolean
      {
         var r:int=(c>>16)&255; var g:int=(c>>8)&255; var b:int=c&255;
         return g>100 && g>r*1.8 && g>b*1.8;
      }

      private static function mapDouble(source:BitmapData):BitmapData
      {
         var result:BitmapData=new BitmapData(source.width*2,source.height*2,true,0);
         for(var y:int=0;y<source.height;y++) for(var x:int=0;x<source.width;x++)
         {
            var e:uint=source.getPixel32(x,y);
            var b:uint=source.getPixel32(x,Math.max(0,y-1));
            var d:uint=source.getPixel32(Math.max(0,x-1),y);
            var f:uint=source.getPixel32(Math.min(source.width-1,x+1),y);
            var h:uint=source.getPixel32(x,Math.min(source.height-1,y+1));
            result.setPixel32(x*2,y*2,d==b && b!=f && d!=h?d:e);
            result.setPixel32(x*2+1,y*2,b==f && b!=d && f!=h?f:e);
            result.setPixel32(x*2,y*2+1,d==h && d!=b && h!=f?d:e);
            result.setPixel32(x*2+1,y*2+1,h==f && d!=h && b!=f?f:e);
         }
         return result;
      }

      public function updateFrame(param1:int) : void
      {
         this._overlay.graphics.clear();
         this._overlay.graphics.beginFill(0,0.4);
         this._overlay.graphics.drawRect(0,0,192,48);
         this._overlay.graphics.drawRect(param1 + 1,1,62,46);
         this._overlay.graphics.endFill();
         this._overlay.graphics.beginFill(16711680);
         this._overlay.graphics.drawRect(param1,0,64,48);
         this._overlay.graphics.drawRect(param1 + 1,1,62,46);
         this._overlay.graphics.endFill();
      }
      
      public function drawObject(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:MinimapIcon = this._effectsPool.getIcon(param3);
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.direction = param4;
         this._icons.push(_loc5_);
         this._iconContainer.addChild(_loc5_);
      }
      
      public function clear() : void
      {
         var _loc1_:int = this._icons.length - 1;
         var _loc2_:* = _loc1_;
         while(_loc2_ > -1)
         {
            this._iconContainer.removeChild(this._icons[_loc2_]);
            this._effectsPool.returnIcon(this._icons[_loc2_]);
            this._icons.splice(_loc2_,1);
            _loc2_--;
         }
      }
      
      public function sort() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc1_:* = int(this._iconContainer.numChildren - 1);
         while(_loc1_ > 0)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(this._iconContainer.getChildAt(_loc3_).y > this._iconContainer.getChildAt(_loc3_ + 1).y)
               {
                  this._iconContainer.swapChildrenAt(_loc3_,_loc3_ + 1);
                  _loc2_ = true;
               }
               _loc3_++;
            }
            if(!_loc2_)
            {
               return;
            }
            _loc1_--;
         }
      }
   }
}


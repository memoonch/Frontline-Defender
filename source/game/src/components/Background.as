package src.components
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Background extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _background:Sprite;
      
      private var _container:Sprite;
      
      private var _width:int;
      
      private var _effectsLayer:Sprite;
      
      private var _upperEnemyLayer:Sprite;
      
      private var _middleLayer:Sprite;
      
      private var _lowerEnemyLayer:Sprite;
      
      private var _leftWall:AnimatedSprite;
      
      private var _rightWall:AnimatedSprite;
      
      private var _leftIntercept:Number;
      
      private var _rightIntercept:Number;
      
      private var _slope:Number;
      
      public var lastIndex:int;
      
      public function Background()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._container = new Sprite();
         this._container.addChild(this._imageManager.getImage("background"));
         this._container.x = -10;
         this._container.y = -10;
         this._background = new Sprite();
         this._background.addChild(this._container);
         this._background.x = -Window.width;
         this.addChild(this._background);
         this._width = this._background.width - 20;
         this.lastIndex = -1;
         this._lowerEnemyLayer = new Sprite();
         this._middleLayer = new Sprite();
         this._upperEnemyLayer = new Sprite();
         this._effectsLayer = new Sprite();
         this.InitializeWalls();
         this.Calculate();
         this._background.addChild(this._lowerEnemyLayer);
         this._background.addChild(this._rightWall);
         this._background.addChild(this._middleLayer);
         this._background.addChild(this._leftWall);
         this._background.addChild(this._upperEnemyLayer);
         this._background.addChild(this._effectsLayer);
      }
      
      private function InitializeWalls() : void
      {
         this._leftWall = new AnimatedSprite(this._imageManager.getImage("walls_left"),499,302,3);
         this._leftWall.addSequence("LEVEL_01",1,1,0,0);
         this._leftWall.addSequence("LEVEL_02",2,2,0,0);
         this._leftWall.addSequence("LEVEL_03",3,3,0,0);
         this._leftWall.gotoAndStop("LEVEL_01");
         this._leftWall.x = 1070 - this._leftWall.width;
         this._leftWall.y = 150;
         this._leftWall.mouseChildren = false;
         this._leftWall.mouseEnabled = false;
         this._rightWall = new AnimatedSprite(this._imageManager.getImage("walls_right"),489,310,3);
         this._rightWall.addSequence("LEVEL_01",1,1,0,0);
         this._rightWall.addSequence("LEVEL_02",2,2,0,0);
         this._rightWall.addSequence("LEVEL_03",3,3,0,0);
         this._rightWall.gotoAndStop("LEVEL_01");
         this._rightWall.x = 1410 - this._rightWall.width;
         this._rightWall.y = 140;
         this._rightWall.mouseChildren = false;
         this._rightWall.mouseEnabled = false;
      }
      
      private function Calculate() : void
      {
         var _loc1_:Point = new Point(652,264);
         var _loc2_:Point = new Point(1032,454);
         this._slope = (_loc2_.y - _loc1_.y) / (_loc2_.x - _loc1_.x);
         this._leftIntercept = _loc1_.y - this._slope * _loc1_.x;
         _loc1_ = new Point(1010,264);
         _loc2_ = new Point(1390,454);
         this._rightIntercept = _loc2_.y - this._slope * _loc2_.x;
      }
      
      public function scroll(param1:int) : void
      {
         var _loc2_:int = this._background.x - param1;
         if(_loc2_ >= 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ <= Window.width - this._width)
         {
            _loc2_ = Window.width - this._width;
         }
         this._background.x = _loc2_;
      }
      
      public function get atEdge() : Boolean
      {
         if(this._background.x == 0 || this._background.x == Window.width - this._width)
         {
            return true;
         }
         return false;
      }
      
      public function changeWalls(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this._leftWall.gotoAndStop("LEVEL_01");
               this._rightWall.gotoAndStop("LEVEL_01");
               break;
            case 1:
               this._leftWall.gotoAndStop("LEVEL_02");
               this._rightWall.gotoAndStop("LEVEL_02");
               break;
            case 2:
               this._leftWall.gotoAndStop("LEVEL_03");
               this._rightWall.gotoAndStop("LEVEL_03");
         }
      }
      
      public function addToLayer(param1:DisplayObject, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this._upperEnemyLayer.addChild(param1);
               this.sortEnemyDepth(this._upperEnemyLayer,param1.y);
               break;
            case 1:
               this._lowerEnemyLayer.addChild(param1);
               this.sortEnemyDepth(this._lowerEnemyLayer,param1.y);
               break;
            case 2:
               this._middleLayer.addChild(param1);
               this.sortEnemyDepth(this._middleLayer,param1.y);
               break;
            case 3:
               this._effectsLayer.addChild(param1);
         }
      }
      
      public function removeFromLayer(param1:DisplayObject, param2:*) : void
      {
         switch(param2)
         {
            case 0:
               if(this._upperEnemyLayer.contains(param1))
               {
                  this._upperEnemyLayer.removeChild(param1);
               }
               break;
            case 1:
               if(this._lowerEnemyLayer.contains(param1))
               {
                  this._lowerEnemyLayer.removeChild(param1);
               }
               break;
            case 2:
               if(this._middleLayer.contains(param1))
               {
                  this._middleLayer.removeChild(param1);
               }
               break;
            case 3:
               if(this._effectsLayer.contains(param1))
               {
                  this._effectsLayer.removeChild(param1);
               }
               else if(this._upperEnemyLayer.contains(param1))
               {
                  this._upperEnemyLayer.removeChild(param1);
               }
               else if(this._lowerEnemyLayer.contains(param1))
               {
                  this._lowerEnemyLayer.removeChild(param1);
               }
               else if(this._middleLayer.contains(param1))
               {
                  this._middleLayer.removeChild(param1);
               }
         }
      }
      
      private function sortEnemyDepth(param1:Sprite, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren - 1)
         {
            if(param1.getChildAt(_loc3_).y > param2)
            {
               param1.setChildIndex(param1.getChildAt(param1.numChildren - 1),_loc3_);
               break;
            }
            _loc3_++;
         }
      }
      
      public function checkDistance(param1:int, param2:int, param3:int, param4:Boolean = false) : Number
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = 0;
         if(param2 < 264 && param3 == 1)
         {
            _loc6_ = 652;
         }
         else if(param3 == 1)
         {
            _loc6_ = (param2 - this._leftIntercept) / this._slope;
         }
         else if(param3 == -1)
         {
            _loc6_ = (param2 - this._rightIntercept) / this._slope;
         }
         if(!param4)
         {
            _loc5_ = Calc.absoluteValue(param1 - _loc6_);
         }
         else
         {
            _loc5_ = param1 - _loc6_;
         }
         return _loc5_;
      }
      
      public function shakeScreen() : void
      {
         this.x = Calc.random(0,20) - 10;
         this.y = Calc.random(0,20) - 10;
      }
      
      public function finishedShaking() : void
      {
         this.x = 0;
         this.y = 0;
      }
      
      public function get position() : int
      {
         return -Math.floor(this._background.x / 10);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get x() : Number
      {
         return -this._background.x;
      }
   }
}


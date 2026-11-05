package src.components.gui
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
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
         this._plate = new AnimatedSprite(this._imageManager.getImage("minimap"),210,52,2);
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
         var border:Sprite=new Sprite();border.graphics.lineStyle(1.2,0xe9a61c);border.graphics.drawRoundRect(8,1,194,50,4,4);
         border.graphics.lineStyle(2,0xffc02d);border.graphics.moveTo(8,11);border.graphics.lineTo(8,2);border.graphics.lineTo(19,2);
         border.graphics.moveTo(191,51);border.graphics.lineTo(202,51);border.graphics.lineTo(202,41);addChild(border);
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


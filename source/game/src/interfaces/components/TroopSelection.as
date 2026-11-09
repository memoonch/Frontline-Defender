package src.interfaces.components
{
   import com.hcLibrary.display.AnimatedSprite;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;import com.hcLibrary.managers.FontManager; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Matrix;import flash.geom.Rectangle;import flash.geom.Point;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TroopSelection extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _container:Sprite;
      
      private var _background:Sprite;
      
      private var _troopPlate:TroopPlate;
      
      private var _slots:Array;
      
      private var _characters:Array;
      
      private var _loadout:Array;
      
      private var _activeSlot:int;
      
      private var _placed:Array;
      
      public var stocks:Array;
      
      public var unlocks:Array;
      
      public function TroopSelection()
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._background = new Sprite();
         this._background.graphics.beginFill(0x020706,0.25);this._background.graphics.drawRect(0,0,235,101);this._background.graphics.endFill();
         var instruction:Sprite=FontManager.getInstance().getString("HOVER TO PLACE TROOPS","SHOP",1,0);instruction.x=(235-instruction.width)/2;instruction.y=47;instruction.alpha=1;this._background.graphics.beginFill(0x080d0e,0.92);this._background.graphics.drawRect(instruction.x-6,43,instruction.width+12,15);this._background.graphics.endFill();instruction.mouseEnabled=false;instruction.mouseChildren=false;this._background.addChild(instruction);
         this._container = new Sprite();
         this._container.graphics.beginFill(0,0);
         this._container.graphics.drawRect(0,0,this._background.width,this._background.height);
         this._container.graphics.endFill();
         this.addChild(this._container);
         this.addChild(this._background);
         this.InitializeParts();

         this._activeSlot = -1;
      }
      
      private function InitializeParts() : void
      {
         var _loc2_:AnimatedSprite = null;
         var _loc3_:AnimatedSprite = null;
         this._slots = new Array();
         this._characters = new Array();
         this._loadout = new Array();
         this._placed = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = new AnimatedSprite(deploymentSheet(),66,13,4);
            _loc2_.addSequence("IDLE_EMPTY",3,3,0,0);
            _loc2_.addSequence("OVER_EMPTY",2,2,0,0);
            _loc2_.addSequence("IDLE_FULL",1,1,0,0);
            _loc2_.addSequence("OVER_FULL",4,4,0,0);
            _loc2_.gotoAndStop("IDLE_EMPTY");
            switch(_loc1_)
            {
               case 0:
                  _loc2_.x = 10;
                  _loc2_.y = 43;
                  break;
               case 1:
                  _loc2_.x = 48;
                  _loc2_.y = 62;
                  break;
               case 2:
                  _loc2_.x = 86;
                  _loc2_.y = 81;
                  break;
               case 3:
                  _loc2_.x = 91;
                  _loc2_.y = 43;
                  break;
               case 4:
                  _loc2_.x = 129;
                  _loc2_.y = 62;
                  break;
               case 5:
                  _loc2_.x = 167;
                  _loc2_.y = 81;
            }
            this._slots.push(_loc2_);
            this._container.addChild(_loc2_);
            _loc3_ = new AnimatedSprite(detailedTroops(),256,140,6);
            _loc3_.scaleX=_loc3_.scaleY=0.25;
            _loc3_.addSequence("PISTOL",1,1,0,0);
            _loc3_.addSequence("ASSAULT_RIFLE",2,2,0,0);
            _loc3_.addSequence("SHOTGUN",3,3,0,0);
            _loc3_.addSequence("SNIPER",4,4,0,0);
            _loc3_.addSequence("ROCKET_LAUNCHER",5,5,0,0);
            _loc3_.addSequence("FLAMETHROWER",6,6,0,0);
            _loc3_.gotoAndStop("PISTOL");
            switch(_loc1_)
            {
               case 0:
                  _loc3_.x = 11;
                  _loc3_.y = 15;
                  _loc3_.flippedX = true;
                  break;
               case 1:
                  _loc3_.x = 49;
                  _loc3_.y = 34;
                  _loc3_.flippedX = true;
                  break;
               case 2:
                  _loc3_.x = 87;
                  _loc3_.y = 53;
                  _loc3_.flippedX = true;
                  break;
               case 3:
                  _loc3_.x = 92;
                  _loc3_.y = 15;
                  break;
               case 4:
                  _loc3_.x = 130;
                  _loc3_.y = 34;
                  break;
               case 5:
                  _loc3_.x = 168;
                  _loc3_.y = 53;
            }
            _loc3_.visible = false;
            _loc3_.mouseChildren = false;
            _loc3_.mouseEnabled = false;
            this._characters.push(_loc3_);
            this._container.addChild(_loc3_);
            this._loadout.push(-1);
            this._placed.push(0);
            _loc1_++;
         }
         this._troopPlate = new TroopPlate();
         this._troopPlate.visible = false;
         this._container.addChild(this._troopPlate);
      }
      
      public function addEventListeners() : void
      {
         this._background.addEventListener(MouseEvent.ROLL_OVER,this.Activate,false,0,true);
         this._container.addEventListener(MouseEvent.ROLL_OUT,this.Deactivate,false,0,true);
         var _loc1_:int = 0;
         while(_loc1_ < this._slots.length)
         {
            this._slots[_loc1_].addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
            this._slots[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
            this._slots[_loc1_].addEventListener(MouseEvent.CLICK,this.mouseClick,false,0,true);
            this._slots[_loc1_].buttonMode = true;
            this._slots[_loc1_].useHandCursor = true;
            _loc1_++;
         }
         this._troopPlate.addEventListeners();
         this._troopPlate.addEventListener("TROOP_CLICKED",this.troopPlateHandler,false,0,true);
      }
      
      public function removeEventListeners() : void
      {
         this._background.removeEventListener(MouseEvent.ROLL_OVER,this.Activate);
         this._container.removeEventListener(MouseEvent.ROLL_OUT,this.Deactivate);
         var _loc1_:int = 0;
         while(_loc1_ < this._slots.length)
         {
            this._slots[_loc1_].removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
            this._slots[_loc1_].removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
            this._slots[_loc1_].removeEventListener(MouseEvent.CLICK,this.mouseClick);
            this._slots[_loc1_].buttonMode = false;
            this._slots[_loc1_].useHandCursor = false;
            _loc1_++;
         }
         this._troopPlate.removeEventListeners();
         this._troopPlate.removeEventListener("TROOP_CLICKED",this.troopPlateHandler);
      }
      
      private function Activate(param1:MouseEvent) : void
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.stocks.length)
         {
            _loc2_[_loc3_] = this.stocks[_loc3_] - this._placed[_loc3_];
            _loc3_++;
         }
         this._troopPlate.reset(this.unlocks,_loc2_);
         this._background.visible = false;
      }
      
      private function Deactivate(param1:MouseEvent) : void
      {
         this._background.visible = true;
         this._troopPlate.visible = false;
         if(this._activeSlot != -1)
         {
            if(this._loadout[this._activeSlot] != -1)
            {
               this._slots[this._activeSlot].gotoAndStop("IDLE_FULL");
            }
            else
            {
               this._slots[this._activeSlot].gotoAndStop("IDLE_EMPTY");
               this._slots[this._activeSlot].buttonMode = true;
               this._slots[this._activeSlot].useHandCursor = true;
            }
            this._activeSlot = -1;
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = this._slots.indexOf(param1.target);
         if(this._loadout[_loc2_] != -1)
         {
            this._slots[_loc2_].gotoAndStop("OVER_FULL");
         }
         else
         {
            this._slots[_loc2_].gotoAndStop("OVER_EMPTY");
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         var _loc2_:int = this._slots.indexOf(param1.target);
         if(_loc2_ != this._activeSlot)
         {
            if(this._loadout[_loc2_] != -1)
            {
               this._slots[_loc2_].gotoAndStop("IDLE_FULL");
            }
            else
            {
               this._slots[_loc2_].gotoAndStop("IDLE_EMPTY");
            }
         }
      }
      
      private function mouseClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = this._slots.indexOf(param1.target);
         if(_loc2_ != this._activeSlot)
         {
            this._activeSlot = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < this._slots.length)
            {
               if(_loc3_ != this._activeSlot)
               {
                  this._slots[_loc3_].buttonMode = true;
                  this._slots[_loc3_].useHandCursor = true;
               }
               else
               {
                  this._slots[_loc3_].buttonMode = false;
                  this._slots[_loc3_].useHandCursor = false;
               }
               _loc3_++;
            }
            this._troopPlate.visible = true;
         }
      }
      
      private function troopPlateHandler(param1:Event) : void
      {
         if(this._characters[this._activeSlot].visible)
         {
            switch(this._characters[this._activeSlot].sequence)
            {
               case "PISTOL":
                  --this._placed[0];
                  break;
               case "ASSAULT_RIFLE":
                  --this._placed[1];
                  break;
               case "SHOTGUN":
                  --this._placed[2];
                  break;
               case "SNIPER":
                  --this._placed[3];
                  break;
               case "ROCKET_LAUNCHER":
                  --this._placed[4];
                  break;
               case "FLAMETHROWER":
                  --this._placed[5];
            }
         }
         this._loadout[this._activeSlot] = this._troopPlate.troopType;
         if(this._troopPlate.troopType == -1)
         {
            this._slots[this._activeSlot].gotoAndStop("IDLE_EMPTY");
            this._characters[this._activeSlot].visible = false;
         }
         else
         {
            this._slots[this._activeSlot].gotoAndStop("IDLE_FULL");
            switch(this._troopPlate.troopType)
            {
               case 0:
                  this._characters[this._activeSlot].gotoAndStop("PISTOL");
                  break;
               case 1:
                  this._characters[this._activeSlot].gotoAndStop("ASSAULT_RIFLE");
                  break;
               case 2:
                  this._characters[this._activeSlot].gotoAndStop("SHOTGUN");
                  break;
               case 3:
                  this._characters[this._activeSlot].gotoAndStop("SNIPER");
                  break;
               case 4:
                  this._characters[this._activeSlot].gotoAndStop("ROCKET_LAUNCHER");
                  break;
               case 5:
                  this._characters[this._activeSlot].gotoAndStop("FLAMETHROWER");
            }
            ++this._placed[this._troopPlate.troopType];
            this._characters[this._activeSlot].visible = true;
         }
         this._troopPlate.visible = false;
         this._activeSlot = -1;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.stocks.length)
         {
            _loc2_[_loc3_] = this.stocks[_loc3_] - this._placed[_loc3_];
            _loc3_++;
         }
         this._troopPlate.reset(this.unlocks,_loc2_);
      }
      
      public function get loadout() : Array
      {
         return this._loadout;
      }

      private static function deploymentSheet():Bitmap {
       var data:BitmapData=new BitmapData(66,52,true,0);
       for(var i:int=0;i<4;i++){
        var hover:Boolean=i==1||i==3;var occupied:Boolean=i==0||i==3;var edge:uint=hover?0xa6de6b:(occupied?0x80b75a:0x7e9271);
        var p:Sprite=new Sprite();p.graphics.lineStyle(0.6,edge,hover?1:0.65);p.graphics.beginFill(hover?0x456434:0x101c16,hover?0.55:0.3);
        p.graphics.moveTo(3,2);p.graphics.lineTo(50,2);p.graphics.lineTo(63,10);p.graphics.lineTo(16,10);p.graphics.lineTo(3,2);p.graphics.endFill();
        p.graphics.lineStyle(1,edge,0.95);p.graphics.moveTo(3,5);p.graphics.lineTo(3,2);p.graphics.lineTo(11,2);
        p.graphics.moveTo(55,10);p.graphics.lineTo(63,10);p.graphics.lineTo(60,7);
        if(occupied){p.graphics.lineStyle();p.graphics.beginFill(0x9bd46c);p.graphics.drawRect(30,5,4,2);p.graphics.endFill();}
        var matrix:Matrix=new Matrix();matrix.translate(0,i*13);data.draw(p,matrix);
       }return new Bitmap(data);
      }

      private static var detailedTroopSheet:BitmapData;
      private static function detailedTroops():Bitmap {
       if(detailedTroopSheet)return new Bitmap(detailedTroopSheet);
       var images:ImageManager=ImageManager.getInstance();var sheet:BitmapData=new BitmapData(256,840,true,0);
       var keys:Array=["ally_pistol","ally_assault_rifle","ally_shotgun","ally_sniper","ally_rocket_launcher","ally_flamethrower"];
       var widths:Array=[103,128,118,103,158,78];var heights:Array=[75,75,74,51,90,79];
       for(var i:int=0;i<6;i++){
        var original:BitmapData=images.getImage(keys[i]).bitmapData;
        var frame:BitmapData=new BitmapData(widths[i],heights[i],true,0);frame.copyPixels(original,new Rectangle(0,0,widths[i],heights[i]),new Point());
        var bounds:Rectangle=frame.getColorBoundsRect(0xff000000,0,false);
        var factor:Number=Math.min(240/Math.max(1,bounds.width),132/Math.max(1,bounds.height));
        var m:Matrix=new Matrix();m.scale(factor,factor);m.translate((256-bounds.width*factor)/2-bounds.x*factor,i*140+140-bounds.bottom*factor);
        sheet.draw(frame,m,null,null,null,false);frame.dispose();
       }detailedTroopSheet=sheet;return new Bitmap(sheet);
      }
   }
}


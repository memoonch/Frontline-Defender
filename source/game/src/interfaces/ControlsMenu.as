package src.interfaces
{
   import com.hcLibrary.data.Calc;
   import com.hcLibrary.data.Window;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;import com.hcLibrary.managers.FontManager;
   import flash.events.Event;
   
   public class ControlsMenu extends Sprite
   {
      
      private var _imageManager:ImageManager;
      
      private var _background:Sprite;
      
      private var _container:Sprite;
      
      private var _isActive:Boolean;
      
      private var _animating:Boolean;
      
      public function ControlsMenu(title:String="CONTROLS")
      {
         super();
         this._imageManager = ImageManager.getInstance();
         this._container = new Sprite();
         this._container.x = -Window.width;
         this.addChild(this._container);
         this._background = new Sprite();
         this.drawControls(title);
         this._background.x = Calc.center(Window.width,this._background.width);
         this._background.y = Calc.center(Window.height,this._background.height);
         this._container.addChild(this._background);
         this._isActive = false;
         this._animating = false;
         this.visible = false;
      }
      
      public function Activate() : void
      {
         if(!this._animating)
         {
            this.visible = true;
            this._isActive = true;
            this._animating = true;
            this.addEventListener(Event.ENTER_FRAME,this.moveIn,false,0,true);
         }
      }
      
      public function Deactivate() : void
      {
         if(!this._animating)
         {
            this._isActive = false;
            this._animating = true;
            this.addEventListener(Event.ENTER_FRAME,this.moveOut,false,0,true);
         }
      }
      
      private function moveIn(param1:Event) : void
      {
         var _loc2_:int = this._container.x + 80;
         if(_loc2_ >= 0)
         {
            _loc2_ = 0;
            this._animating = false;
            this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         }
         this._container.x = _loc2_;
      }
      
      private function moveOut(param1:Event) : void
      {
         var _loc2_:int = this._container.x - 80;
         if(_loc2_ <= -Window.width)
         {
            _loc2_ = -Window.width;
            this._animating = false;
            this.visible = false;
            this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         }
         this._container.x = _loc2_;
      }
      
      public function reset() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.moveIn);
         this.removeEventListener(Event.ENTER_FRAME,this.moveOut);
         this.visible = false;
         this._isActive = false;
         this._animating = false;
         this._container.x = -Window.width;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }

      private function drawControls(title:String):void {
       var p:Sprite=this._background;p.graphics.beginFill(0x080d0e,0.98);p.graphics.drawRect(0,0,390,338);p.graphics.endFill();p.graphics.lineStyle(1,0x67736d);p.graphics.drawRect(0.5,0.5,389,337);p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(2.5,2.5,385,333);
       controlText(title,18,18,2);controlText("COMBAT AND CAMERA",18,56,1.2);controlText("WEAPON HOTKEYS",219,56,1.2);
       var actions:Array=["AIM","SHOOT","CHANGE WEAPON","PAN LEFT","PAN RIGHT","GRENADE","PAYLOAD","RELOAD","MUTE","PAUSE"];
       var keys:Array=["MOUSE","LEFT CLICK","MOUSE WHEEL","A / LEFT","D / RIGHT","Q","W","R","M","P / ESC"];
       for(var i:int=0;i<actions.length;i++){
        var y:Number=82+i*20;p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(17,y+14);p.graphics.lineTo(200,y+14);
        controlText(actions[i],18,y,1);var k:Sprite=controlText(keys[i],0,y,1);k.x=200-k.width;
       }
       var weapons:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
       for(i=0;i<weapons.length;i++){
        y=82+i*24;p.graphics.lineStyle();p.graphics.beginFill(0x263623);p.graphics.drawRect(219,y-3,15,16);p.graphics.endFill();controlText(String(i+1),223,y,1);controlText(weapons[i],243,y,1);
       }
      }
      private function controlText(value:String,x:Number,y:Number,scale:Number):Sprite {
       var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.x=x;t.y=y;t.scaleX=scale;t.scaleY=scale*1.33;t.mouseEnabled=false;t.mouseChildren=false;this._background.addChild(t);return t;
      }
   }
}



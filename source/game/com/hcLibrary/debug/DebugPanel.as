package com.hcLibrary.debug
{
   import com.hcLibrary.data.Window;
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.display.GameWindow;
   import com.hcLibrary.events.GameEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class DebugPanel extends Sprite
   {
      
      private static var _instance:DebugPanel;
      
      private static var _allowInstance:Boolean;
      
      private static var _debugButton:CustomButton;
      
      private static var _overlay:Sprite;
      
      private static var _panel:Sprite;
      
      private static var _dragging:Boolean;
      
      private static var _startY:int;
      
      private static var _format:TextFormat;
      
      private static var IMAGE:Class = DebugPanel_IMAGE;
      
      public static const TOP_LEFT:int = 0;
      
      public static const TOP_RIGHT:int = 1;
      
      public static const BOTTOM_LEFT:int = 2;
      
      public static const BOTTOM_RIGHT:int = 3;
      
      public function DebugPanel()
      {
         super();
         if(DebugPanel._allowInstance)
         {
            _format = new TextFormat();
            _format.font = "Arial";
            _overlay = new Sprite();
            _overlay.graphics.beginFill(0,0.8);
            _overlay.graphics.drawRect(0,0,Window.width * GameWindow.scale - 100,Window.height * GameWindow.scale);
            _overlay.graphics.endFill();
            _overlay.x = 50;
            _overlay.visible = false;
            this.addChild(_overlay);
            _panel = new Sprite();
            _panel.x = 10;
            _panel.y = 10;
            _panel.mouseEnabled = false;
            _panel.mouseChildren = false;
            _overlay.addChild(_panel);
            _dragging = false;
            _debugButton = new CustomButton(new IMAGE(),40,40,1);
            _debugButton.idleState = 1;
            _debugButton.overState = 1;
            _debugButton.x = 5;
            _debugButton.y = 5;
            _debugButton.addMouseEvents();
            _debugButton.addEventListener(GameEvent.CLICKED,this.togglePanel);
            this.addChild(_debugButton);
            _overlay.addEventListener(MouseEvent.MOUSE_DOWN,this.startDragging);
            this.addEventListener(Event.ENTER_FRAME,this.alwaysOnTop);
         }
         else
         {
            if(!DebugPanel._instance)
            {
               throw new Error("Error: An attempt to make a new DebugPanel was made and there is not yet an instance of it. Please use the \'getInstance()\' method instead of the \'new\' keyword.");
            }
            GameError.throwError("DebugPanel","constructor","Only 1 instance of DebugPanel is necessary. Use the \'getInstance()\' method instead of the \'new\' keyword.");
         }
      }
      
      public static function getInstance() : DebugPanel
      {
         if(DebugPanel._instance == null)
         {
            DebugPanel._allowInstance = true;
            DebugPanel._instance = new DebugPanel();
            DebugPanel._allowInstance = false;
         }
         return DebugPanel._instance;
      }
      
      public static function traceLine(param1:String, param2:uint = 16777215, param3:int = 14, param4:Boolean = false) : void
      {
         _format.color = param2;
         _format.size = param3;
         var _loc5_:TextField = new TextField();
         _loc5_.text = param1;
         _loc5_.selectable = false;
         _loc5_.border = false;
         _loc5_.background = false;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.setTextFormat(_format);
         if(param4)
         {
            if(_loc5_.width > _instance.parent.width - 130)
            {
               _loc5_.multiline = true;
               _loc5_.wordWrap = true;
               _loc5_.width = _instance.parent.width - 130;
            }
            else
            {
               _loc5_.multiline = false;
               _loc5_.wordWrap = false;
            }
            _loc5_.x = 20;
         }
         else if(_loc5_.width > _instance.parent.width - 110)
         {
            _loc5_.multiline = true;
            _loc5_.wordWrap = true;
            _loc5_.width = _instance.parent.width - 110;
         }
         else
         {
            _loc5_.multiline = false;
            _loc5_.wordWrap = false;
         }
         if(_panel.height != 0)
         {
            _loc5_.y = _panel.height + 1;
         }
         _panel.addChild(_loc5_);
      }
      
      public static function lineBreak() : void
      {
         traceLine("",16777215,8);
         _panel.graphics.lineStyle(0,16777215);
         _panel.graphics.moveTo(0,_panel.height - 1);
         _panel.graphics.lineTo(_overlay.width - 20,_panel.height - 1);
         _panel.graphics.lineStyle();
      }
      
      public function set position(param1:int) : void
      {
         switch(param1)
         {
            case DebugPanel.TOP_RIGHT:
               _debugButton.x = this.parent.width - _debugButton.width - 5;
               _debugButton.y = 5;
               break;
            case DebugPanel.BOTTOM_LEFT:
               _debugButton.x = 5;
               _debugButton.y = this.parent.height - _debugButton.height - 5;
               break;
            case DebugPanel.BOTTOM_RIGHT:
               _debugButton.x = this.parent.width - _debugButton.width - 5;
               _debugButton.y = this.parent.height - _debugButton.height - 5;
               break;
            default:
               _debugButton.x = 5;
               _debugButton.y = 5;
         }
      }
      
      private function alwaysOnTop(param1:Event) : void
      {
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
      }
      
      private function togglePanel(param1:GameEvent) : void
      {
         _overlay.visible = !_overlay.visible;
         if(!_overlay.visible)
         {
            _panel.y = 5;
         }
      }
      
      private function startDragging(param1:MouseEvent) : void
      {
         if(!_dragging)
         {
            _panel.addEventListener(MouseEvent.ROLL_OUT,this.stopDragging);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.stopDragging);
            _dragging = true;
            _startY = mouseY;
            this.addEventListener(Event.ENTER_FRAME,this.scrollPanel);
         }
      }
      
      private function stopDragging(param1:MouseEvent) : void
      {
         _overlay.removeEventListener(MouseEvent.ROLL_OUT,this.stopDragging);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.stopDragging);
         _dragging = false;
         this.removeEventListener(Event.ENTER_FRAME,this.scrollPanel);
      }
      
      private function scrollPanel(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_panel.height > this.parent.height - 10)
         {
            _loc2_ = _panel.y + (mouseY - _startY);
            _startY = mouseY;
            if(_loc2_ < this.parent.height - _panel.height - 5)
            {
               _loc2_ = this.parent.height - _panel.height - 5;
            }
            else if(_loc2_ > 5)
            {
               _loc2_ = 5;
            }
            _panel.y = _loc2_;
         }
      }
   }
}


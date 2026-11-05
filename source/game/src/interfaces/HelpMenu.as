package src.interfaces
{
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.events.Event;
   import src.interfaces.components.Menu;
   
   public class HelpMenu extends Menu
   {
      
      private var _imageManager:ImageManager = ImageManager.getInstance();
      
      private var _closeButton:CustomButton;
      
      public function HelpMenu()
      {
         super(this._imageManager.getImage("help_background"));
         this.InitializeButtons();
      }
      
      private function InitializeButtons() : void
      {
         this._closeButton = new CustomButton(this._imageManager.getImage("exit_button_credits"),189,46,2);
         this._closeButton.idleState = 1;
         this._closeButton.overState = 2;
         this._closeButton.x = 10;
         this._closeButton.y = _background.height - this._closeButton.height - 6;
         _background.addChild(this._closeButton);
      }
      
      override public function addEventListeners() : void
      {
         this._closeButton.enabled = true;
         this._closeButton.addMouseEvents();
         this._closeButton.addEventListener(GameEvent.CLICKED,this.closeButtonHandler,false,0,true);
      }
      
      override public function removeEventListeners() : void
      {
         this._closeButton.removeMouseEvents();
         this._closeButton.removeEventListener(GameEvent.CLICKED,this.closeButtonHandler);
      }
      
      private function closeButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new Event("ACTIVATE_MAIN"));
      }
   }
}


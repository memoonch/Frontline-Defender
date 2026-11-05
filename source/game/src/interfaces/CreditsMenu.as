package src.interfaces
{
   import com.hcLibrary.display.CustomButton;
   import com.hcLibrary.events.GameEvent;
   import com.hcLibrary.managers.ImageManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import src.interfaces.components.Menu;
   
   public class CreditsMenu extends Menu
   {
      
      private static const FACEBOOK_URL:String = "http://www.facebook.com/HardCircle";
      
      private static const TWITTER_URL:String = "http://twitter.com/#!/HardCircle";
      
      private static const HOME_URL:String = "http://www.hardcircle.com/";
      
      private var _imageManager:ImageManager = ImageManager.getInstance();
      
      private var _facebookButton:CustomButton;
      
      private var _twitterButton:CustomButton;
      
      private var _closeButton:CustomButton;
      
      private var _logo:Sprite;
      
      public function CreditsMenu()
      {
         super(this._imageManager.getImage("credits_background"));
         this.InitializeButtons();
      }
      
      private function InitializeButtons() : void
      {
         this._logo = new Sprite();
         this._logo.addChild(this._imageManager.getImage("credits_logo"));
         this._logo.x = 135;
         this._logo.y = 78;
         this._logo.buttonMode = true;
         this._logo.useHandCursor = true;
         _background.addChild(this._logo);
         this._facebookButton = new CustomButton(this._imageManager.getImage("social_buttons"),32,32,4);
         this._facebookButton.idleState = 1;
         this._facebookButton.overState = 2;
         this._facebookButton.x = 282;
         this._facebookButton.y = 193;
         _background.addChild(this._facebookButton);
         this._twitterButton = new CustomButton(this._imageManager.getImage("social_buttons"),32,32,4);
         this._twitterButton.idleState = 3;
         this._twitterButton.overState = 4;
         this._twitterButton.x = 320;
         this._twitterButton.y = 193;
         _background.addChild(this._twitterButton);
         this._closeButton = new CustomButton(this._imageManager.getImage("exit_button_credits"),189,46,2);
         this._closeButton.idleState = 1;
         this._closeButton.overState = 2;
         this._closeButton.x = 10;
         this._closeButton.y = _background.height - this._closeButton.height - 6;
         _background.addChild(this._closeButton);
      }
      
      override public function addEventListeners() : void
      {
         this._facebookButton.enabled = true;
         this._facebookButton.addMouseEvents();
         this._facebookButton.addEventListener(GameEvent.CLICKED,this.facebookButtonHandler,false,0,true);
         this._twitterButton.enabled = true;
         this._twitterButton.addMouseEvents();
         this._twitterButton.addEventListener(GameEvent.CLICKED,this.twitterButtonHandler,false,0,true);
         this._logo.addEventListener(MouseEvent.CLICK,this.logoHandler,false,0,true);
         this._closeButton.enabled = true;
         this._closeButton.addMouseEvents();
         this._closeButton.addEventListener(GameEvent.CLICKED,this.closeButtonHandler,false,0,true);
      }
      
      override public function removeEventListeners() : void
      {
         this._facebookButton.removeMouseEvents();
         this._facebookButton.removeEventListener(GameEvent.CLICKED,this.facebookButtonHandler);
         this._twitterButton.removeMouseEvents();
         this._twitterButton.removeEventListener(GameEvent.CLICKED,this.twitterButtonHandler);
         this._logo.removeEventListener(MouseEvent.CLICK,this.logoHandler);
         this._closeButton.removeMouseEvents();
         this._closeButton.removeEventListener(GameEvent.CLICKED,this.closeButtonHandler);
      }
      
      private function facebookButtonHandler(param1:GameEvent) : void
      {
         navigateToURL(new URLRequest(FACEBOOK_URL),"_blank");
      }
      
      private function twitterButtonHandler(param1:GameEvent) : void
      {
         navigateToURL(new URLRequest(TWITTER_URL),"_blank");
      }
      
      private function logoHandler(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(HOME_URL),"_blank");
      }
      
      private function closeButtonHandler(param1:GameEvent) : void
      {
         this.dispatchEvent(new Event("ACTIVATE_MAIN"));
      }
   }
}


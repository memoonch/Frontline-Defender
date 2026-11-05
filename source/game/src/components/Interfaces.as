package src.components
{
   import com.hcLibrary.events.GameEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import src.interfaces.*;
   
   public class Interfaces extends Sprite
   {
      
      private var _menus:Array;
      
      private var _mainMenu:MainMenu;
      
      private var _creditsMenu:CreditsMenu;
      
      private var _helpMenu:HelpMenu;
      
      private var _resume:Boolean;
      
      public function Interfaces()
      {
         super();
         this._resume = false;
         this._menus = new Array();
         this.InitializeMain();
         this.InitializeCredits();
         this.InitializeHelp();
      }
      
      private function InitializeMain() : void
      {
         this._mainMenu = new MainMenu();
         this._mainMenu.Activate();
         this._menus.push(this._mainMenu);
         this.addChild(this._mainMenu);
      }
      
      private function InitializeCredits() : void
      {
         this._creditsMenu = new CreditsMenu();
         this._creditsMenu.visible = false;
         this._menus.push(this._creditsMenu);
         this.addChild(this._creditsMenu);
      }
      
      private function InitializeHelp() : void
      {
         this._helpMenu = new HelpMenu();
         this._helpMenu.visible = false;
         this._menus.push(this._helpMenu);
         this.addChild(this._helpMenu);
      }
      
      private function DeactivateMenus(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(param1 != null)
         {
            switch(param1.type)
            {
               case "ACTIVATE_MAIN":
                  this.addEventListener(Event.ENTER_FRAME,this.ActivateMain,false,0,true);
                  break;
               case "ACTIVATE_CREDITS":
                  if(!this._creditsMenu.visible)
                  {
                     this.addEventListener(Event.ENTER_FRAME,this.ActivateCredits,false,0,true);
                  }
                  else
                  {
                     _loc2_ = true;
                  }
                  break;
               case "ACTIVATE_HELP":
                  if(!this._helpMenu.visible)
                  {
                     this.addEventListener(Event.ENTER_FRAME,this.ActivateHelp,false,0,true);
                  }
                  else
                  {
                     _loc2_ = true;
                  }
            }
         }
         if(!_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < this._menus.length)
            {
               if(this._menus[_loc3_].visible)
               {
                  this._menus[_loc3_].Deactivate();
               }
               _loc3_++;
            }
         }
      }
      
      private function Resume(param1:Event) : void
      {
         this._resume = true;
      }
      
      private function ActivateMain(param1:Event) : void
      {
         if(this._resume)
         {
            this._resume = false;
            this.removeEventListener(Event.ENTER_FRAME,this.ActivateMain);
            this.hideMenus(this._menus.indexOf(this._mainMenu));
            this._mainMenu.Activate();
         }
      }
      
      private function ActivateCredits(param1:Event) : void
      {
         if(this._resume)
         {
            this._resume = false;
            this.removeEventListener(Event.ENTER_FRAME,this.ActivateCredits);
            this.hideMenus(this._menus.indexOf(this._creditsMenu));
            this._creditsMenu.Activate();
         }
      }
      
      private function ActivateHelp(param1:Event) : void
      {
         if(this._resume)
         {
            this._resume = false;
            this.removeEventListener(Event.ENTER_FRAME,this.ActivateHelp);
            this.hideMenus(this._menus.indexOf(this._helpMenu));
            this._helpMenu.Activate();
         }
      }
      
      private function ActivateGame(param1:Event) : void
      {
         this._mainMenu.Deactivate();
         this.dispatchEvent(new Event("START_GAME"));
      }
      
      public function ReactivateMenus() : void
      {
         this._mainMenu.Activate();
      }
      
      private function hideMenus(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this._menus.length)
         {
            if(_loc2_ != param1 && _loc2_ != this._menus.indexOf(this._mainMenu))
            {
               this._menus[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      public function addEventListeners() : void
      {
         this._mainMenu.addEventListener("ACTIVATE_CREDITS",this.DeactivateMenus,false,0,true);
         this._mainMenu.addEventListener("ACTIVATE_HELP",this.DeactivateMenus,false,0,true);
         this._mainMenu.addEventListener("ACTIVATE_GAME",this.ActivateGame,false,0,true);
         this._mainMenu.addEventListener(GameEvent.RESUME,this.Resume,false,0,true);
         this._creditsMenu.addEventListener("ACTIVATE_MAIN",this.DeactivateMenus,false,0,true);
         this._creditsMenu.addEventListener(GameEvent.RESUME,this.Resume,false,0,true);
         this._helpMenu.addEventListener("ACTIVATE_MAIN",this.DeactivateMenus,false,0,true);
         this._helpMenu.addEventListener(GameEvent.RESUME,this.Resume,false,0,true);
      }
   }
}


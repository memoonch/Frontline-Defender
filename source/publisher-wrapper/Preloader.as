package
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   [SWF(width="640", height="530", backgroundColor="#000000", frameRate="30")]
   public class Preloader extends MovieClip
   {
      
      public static var Wrapper:Object;
      
      public static var FogAPI:fog = new fog();
      
      private static const background:Class = Preloader_background;
      
      private var bg:MovieClip = new MovieClip();
      
      public function Preloader()
      {
         super();
         this.bg.addChild(new background() as Bitmap);
         FogAPI.setPreloaderBackground(this.bg);
         FogAPI.setGameName("FrontlineDefender");
         FogAPI.setCoinGame = true;
         FogAPI.preloaderStart("522df442d16e3",this,false,"action-games",this.startup);
      }
      
      private function startup() : void
      {
         var mainClass:Class = getDefinitionByName("MainGame") as Class;
         addChild(new mainClass(FogAPI) as DisplayObject);
      }
   }
}


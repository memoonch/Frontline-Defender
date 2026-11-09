from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/components/TroopSelection.as');s=p.read_text().replace('import flash.geom.Matrix;','import flash.geom.Matrix;import flash.geom.Rectangle;import flash.geom.Point;')
s=s.replace('new AnimatedSprite(this._imageManager.getImage("shop_troops"),64,35,6)','new AnimatedSprite(detailedTroops(),256,140,6)')
s=s.replace('            _loc3_.addSequence("PISTOL"','            _loc3_.scaleX=_loc3_.scaleY=0.25;\n            _loc3_.addSequence("PISTOL"')
helper='''
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
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/sharp-troops-patch/src/interfaces/components').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/sharp-troops-patch/src/interfaces/components/TroopSelection.as');shutil.copy2(p,'tools/deployment-patch/src/interfaces/components/TroopSelection.as');shutil.copy2(p,'tools/shop-patch/src/interfaces/components/TroopSelection.as')

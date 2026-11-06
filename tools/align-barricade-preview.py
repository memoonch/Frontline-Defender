from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text();a=s.index('      private static function highResolutionBarricade():Bitmap {');b=s.index('\n      }',a)+len('\n      }')
s=s[:a]+'''      private static function highResolutionBarricade():Bitmap {
       var original:BitmapData=ImageManager.getInstance().getImage("shop_minimap").bitmapData;
       var sheet:BitmapData=new BitmapData(940,1212,true,0);var scale:Matrix=new Matrix();scale.scale(4,4);
       sheet.draw(original,scale,null,null,null,false);return new Bitmap(sheet);
      }'''+s[b:];p.write_text(s);shutil.copy2(p,'tools/barricade-preview-patch/src/interfaces/ShopMenu.as');shutil.copy2(p,'tools/shop-patch/src/interfaces/ShopMenu.as')

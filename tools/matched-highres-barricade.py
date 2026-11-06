from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text();a=s.index('      private static function highResolutionBarricade():Bitmap {');b=s.index('\n      }',a)+len('\n      }')
s=s[:a]+'''      private static function highResolutionBarricade():Bitmap {
       var images:ImageManager=ImageManager.getInstance();var sheet:BitmapData=new BitmapData(940,1212,true,0);
       for(var tier:int=0;tier<3;tier++){
        var scene:Sprite=new Sprite();var background:Bitmap=images.getImage("background");background.x=-10;background.y=-10;scene.addChild(background);
        var right:AnimatedSprite=new AnimatedSprite(images.getImage("walls_right"),489,310,3);right.addSequence("STILL",tier+1,tier+1,0,0);right.gotoAndStop("STILL");right.x=921;right.y=140;scene.addChild(right);
        var left:AnimatedSprite=new AnimatedSprite(images.getImage("walls_left"),499,302,3);left.addSequence("STILL",tier+1,tier+1,0,0);left.gotoAndStop("STILL");left.x=571;left.y=150;scene.addChild(left);
        var frame:BitmapData=new BitmapData(940,404,true,0);var crop:Matrix=new Matrix();crop.translate(-640,-80);frame.draw(scene,crop,null,null,null,false);sheet.copyPixels(frame,frame.rect,new Point(0,tier*404));frame.dispose();
       }return new Bitmap(sheet);
      }'''+s[b:];p.write_text(s)
for folder in ['tools/barricade-preview-patch/src/interfaces','tools/shop-patch/src/interfaces']:shutil.copy2(p,folder+'/ShopMenu.as')

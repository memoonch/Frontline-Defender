from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('new AnimatedSprite(this._imageManager.getImage("shop_minimap"),235,101,3)','new AnimatedSprite(highResolutionBarricade(),940,404,3)')
s=s.replace('this._wallIcon.x = 257;','this._wallIcon.scaleX=this._wallIcon.scaleY=0.25;\n         this._wallIcon.x = 257;')
helper='''
      private static function highResolutionBarricade():Bitmap {
       var images:ImageManager=ImageManager.getInstance();var sheet:BitmapData=new BitmapData(940,1212,true,0);
       for(var tier:int=0;tier<3;tier++){
        var scene:Sprite=new Sprite();var background:Bitmap=images.getImage("background");background.x=-10;background.y=-10;scene.addChild(background);
        var right:AnimatedSprite=new AnimatedSprite(images.getImage("walls_right"),489,310,3);right.addSequence("STILL",tier+1,tier+1,0,0);right.gotoAndStop("STILL");right.x=921;right.y=140;scene.addChild(right);
        var left:AnimatedSprite=new AnimatedSprite(images.getImage("walls_left"),499,302,3);left.addSequence("STILL",tier+1,tier+1,0,0);left.gotoAndStop("STILL");left.x=571;left.y=150;scene.addChild(left);
        var frame:BitmapData=new BitmapData(940,404,true,0);var m:Matrix=new Matrix();m.scale(940/1000,404/480);m.translate(-520*940/1000,0);frame.draw(scene,m,null,null,null,false);
        sheet.copyPixels(frame,frame.rect,new flash.geom.Point(0,tier*404));frame.dispose();
       }return new Bitmap(sheet);
      }
'''
# Import Point rather than use qualified expression in old compiler.
s=s.replace('import flash.geom.Matrix;','import flash.geom.Matrix;import flash.geom.Point;').replace('new flash.geom.Point','new Point')
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/barricade-preview-patch/src/interfaces').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/barricade-preview-patch/src/interfaces/ShopMenu.as')

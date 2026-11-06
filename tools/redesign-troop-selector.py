from pathlib import Path
import shutil
root=Path('source/game/src/interfaces/components')
p=root/'TroopButton.as';s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import flash.display.Bitmap;import flash.display.BitmapData;import flash.geom.Rectangle;import flash.geom.Point;import flash.geom.Matrix;')
s=s.replace('this._imageManager.getImage("shop_troop_selection_icons")','cardSheet()')
helper='''
      private static function cardSheet():Bitmap {
       var source:BitmapData=ImageManager.getInstance().getImage("shop_troop_selection_icons").bitmapData;
       var data:BitmapData=new BitmapData(49,1000,true,0);
       for(var i:int=0;i<20;i++){
        var p:Sprite=new Sprite();var hover:Boolean=i==19 || (i<18 && i%3==2);var locked:Boolean=i<18 && i%3==0;
        p.graphics.beginFill(hover?0x263623:0x080d0e);p.graphics.drawRect(0,0,49,50);p.graphics.endFill();p.graphics.lineStyle(1,hover?0x95b674:0x45574b);p.graphics.drawRect(0.5,0.5,48,49);
        if(i<18){
         var frame:int=int(i/3)*3+1;var portrait:BitmapData=new BitmapData(40,30,true,0);portrait.copyPixels(source,new Rectangle((frame%3)*49+4,int(frame/3)*50+16,40,30),new Point());
         var image:Bitmap=new Bitmap(portrait);image.x=4;image.y=17;image.alpha=locked?0.35:1;p.addChild(image);
         p.graphics.lineStyle();p.graphics.beginFill(0x17231b);p.graphics.drawRect(29,3,17,12);p.graphics.endFill();
         if(locked){var lock:Sprite=new Sprite();lock.x=19;lock.y=27;lock.graphics.lineStyle(1,0xb4bdab);lock.graphics.drawRect(0,0,10,8);lock.graphics.drawRect(2,-5,6,5);p.addChild(lock);}
        }else {var t:Sprite=FontManager.getInstance().getString("REMOVE","SHOP",0,0);t.x=(49-t.width)/2;t.y=23;p.addChild(t);}
        var m:Matrix=new Matrix();m.translate(0,i*50);data.draw(p,m);
       }return new Bitmap(data);
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
p=root/'TroopPlate.as';s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite;import flash.display.Bitmap;import flash.display.BitmapData;import flash.geom.Matrix;import com.hcLibrary.managers.FontManager;')
s=s.replace('this._background.addChild(this._imageManager.getImage("shop_troop_selection_plate"));','''this._background.graphics.beginFill(0x080d0e,0.98);this._background.graphics.drawRect(0,0,153,76);this._background.graphics.endFill();
         var heading:Sprite=FontManager.getInstance().getString("SELECT TROOP","SHOP",1,0);heading.x=(153-heading.width)/2;heading.y=8;this._background.addChild(heading);''')
s=s.replace('this._imageManager.getImage("shop_troop_selection_arrows")','arrowSheet()')
helper='''
      private static function arrowSheet():Bitmap {
       var data:BitmapData=new BitmapData(19,176,true,0);
       for(var i:int=0;i<4;i++){var p:Sprite=new Sprite();p.graphics.beginFill(i%2==0?0x101a14:0x263623);p.graphics.drawRect(0,0,19,44);p.graphics.endFill();p.graphics.lineStyle(1,0x45574b);p.graphics.drawRect(0.5,0.5,18,43);p.graphics.lineStyle(2,0xc4d2b8);var right:Boolean=i>=2;p.graphics.moveTo(right?6:12,16);p.graphics.lineTo(right?12:6,22);p.graphics.lineTo(right?6:12,28);var m:Matrix=new Matrix();m.translate(0,i*44);data.draw(p,m);}return new Bitmap(data);
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/troop-selector-patch/src/interfaces/components').mkdir(parents=True,exist_ok=True)
for name in ['TroopButton','TroopPlate']:shutil.copy2(root/(name+'.as'),Path('tools/troop-selector-patch/src/interfaces/components')/(name+'.as'))

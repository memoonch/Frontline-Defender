from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/components/TroopSelection.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Matrix;')
s=s.replace('this._imageManager.getImage("shop_troop_placement")','deploymentSheet()')
a=s.index('         var hints:Sprite=');b=s.index('this.addChildAt(hints,0);',a)+len('this.addChildAt(hints,0);');s=s[:a]+s[b:]
helper='''
      private static function deploymentSheet():Bitmap {
       var data:BitmapData=new BitmapData(66,52,true,0);
       for(var i:int=0;i<4;i++){
        var hover:Boolean=i==1||i==3;var occupied:Boolean=i==0||i==3;var edge:uint=hover?0xa6de6b:(occupied?0x80b75a:0x7e9271);
        var p:Sprite=new Sprite();p.graphics.lineStyle(0.6,edge,hover?1:0.65);p.graphics.beginFill(hover?0x456434:0x101c16,hover?0.55:0.3);
        p.graphics.moveTo(3,2);p.graphics.lineTo(50,2);p.graphics.lineTo(63,10);p.graphics.lineTo(16,10);p.graphics.lineTo(3,2);p.graphics.endFill();
        p.graphics.lineStyle(1,edge,0.95);p.graphics.moveTo(3,5);p.graphics.lineTo(3,2);p.graphics.lineTo(11,2);
        p.graphics.moveTo(55,10);p.graphics.lineTo(63,10);p.graphics.lineTo(60,7);
        if(occupied){p.graphics.lineStyle();p.graphics.beginFill(0x9bd46c);p.graphics.drawRect(30,5,4,2);p.graphics.endFill();}
        var matrix:Matrix=new Matrix();matrix.translate(0,i*13);data.draw(p,matrix);
       }return new Bitmap(data);
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/deployment-patch/src/interfaces/components').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/deployment-patch/src/interfaces/components/TroopSelection.as');shutil.copy2(p,'tools/shop-patch/src/interfaces/components/TroopSelection.as')

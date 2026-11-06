from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('import flash.display.Sprite;','import flash.display.Sprite; import flash.display.Bitmap; import flash.display.BitmapData; import flash.geom.Matrix;')
s=s.replace('super(this._imageManager.getImage("shop_background"));','super(shopBackground());')
# Match the full game viewport while preserving the shop local coordinates used by its data updates.
s=s.replace('         this._options = new Options();','         _background.x=8; _background.y=8; _background.scaleX=624/509; _background.scaleY=464/441;\n         this._options = new Options();')
buttons=[('shop_play_button',147,46,2,'NEXT WAVE'),('shop_arsenal_arrow_button',102,16,3,''),('shop_troops_arrow_button',83,16,3,''),('shop_buy_button',42,18,3,'BUY'),('shop_upgrade_button',114,23,3,'UPGRADE'),('shop_barricade_button',51,18,3,'')]
for key,w,h,n,label in buttons:
 s=s.replace('this._imageManager.getImage("'+key+'")','shopButton('+str(w)+','+str(h)+','+str(n)+',"'+label+'")')
helper='''
      private static function shopFrame(p:Sprite,x:Number,y:Number,w:Number,h:Number,color:uint=0x080d0e):void {
       p.graphics.lineStyle();p.graphics.beginFill(color,0.98);p.graphics.drawRect(x,y,w,h);p.graphics.endFill();
       p.graphics.lineStyle(1,0x67736d);p.graphics.drawRect(x+0.5,y+0.5,w-1,h-1);
       p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(x+2.5,y+2.5,w-5,h-5);
      }
      private static function shopText(p:Sprite,value:String,x:Number,y:Number,scale:Number=1):void {
       var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.x=x;t.y=y;t.scaleX=t.scaleY=scale;p.addChild(t);
      }
      private static function shopBackground():Bitmap {
       var p:Sprite=new Sprite();shopFrame(p,0,0,509,441);
       shopText(p,"SHOP",17,14,2.5);shopText(p,"SCORE",228,15);shopText(p,"MONEY",355,15);shopText(p,"$",394,15);
       shopFrame(p,12,56,111,226);shopText(p,"ARSENAL",36,70,1.3);
       shopFrame(p,125,56,121,226);shopFrame(p,127,58,117,78,0x121b17);
       var labels:Array=["POWER","ACC","CLIP SIZE","TOTAL AMMO","STOCK"];
       for(var i:int=0;i<5;i++){p.graphics.lineStyle(1,0x27332e);p.graphics.moveTo(129,145+i*17);p.graphics.lineTo(241,145+i*17);shopText(p,labels[i],130,150+i*17);}
       shopFrame(p,253,56,244,139);shopText(p,"TROOPS",280,70,1.3);
       shopText(p,"DMG",349,154);shopText(p,"R/S",396,154);shopText(p,"STOCK",447,154);shopText(p,"$",349,177);
       shopFrame(p,253,201,244,184);shopText(p,"BARRICADE",335,213,1.3);shopText(p,"REPAIR",259,346);shopText(p,"$",377,346);
       shopFrame(p,12,289,234,140);shopText(p,"MISSION REPORT",57,302,1.3);
       var report:Array=["WAVE","SCORE","MONEY EARNED","GRUNTS KILLED","VEHICLES DESTROYED","BARRICADE HEALTH"];
       for(i=0;i<6;i++){p.graphics.lineStyle(1,0x27332e);p.graphics.moveTo(21,338+i*17);p.graphics.lineTo(236,338+i*17);shopText(p,report[i],23,326+i*17);}
       var data:BitmapData=new BitmapData(509,441,true,0);data.draw(p);return new Bitmap(data);
      }
      private static function shopButton(w:int,h:int,frames:int,value:String):Bitmap {
       var data:BitmapData=new BitmapData(w,h*frames,true,0);
       for(var i:int=0;i<frames;i++){
        var p:Sprite=new Sprite();shopFrame(p,0,0,w,h,i==0?0x101815:(i==1?0x263623:0x35452d));
        if(value.length>0){var size:Number=value=="NEXT WAVE"?1.6:1;var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.scaleX=t.scaleY=size;t.x=(w-t.width)/2;t.y=(h-t.height)/2;p.addChild(t);}
        else if(w>70){p.graphics.lineStyle();p.graphics.beginFill(i==2?0xa0ce6b:0xc7d0bf);p.graphics.drawRect(5,5,5,6);p.graphics.drawRect(10,6,3,4);p.graphics.endFill();}
        var m:Matrix=new Matrix();m.translate(0,i*h);data.draw(p,m);
       }return new Bitmap(data);
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s);shutil.copy2(p,'tools/shop-patch/src/interfaces/ShopMenu.as')

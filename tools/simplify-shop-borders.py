from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ShopMenu.as');s=p.read_text()
s=s.replace('p.graphics.lineStyle(1,0x67736d);p.graphics.drawRect(x+0.5,y+0.5,w-1,h-1);','p.graphics.lineStyle(1,(w==509?0x67736d:0x35433b));p.graphics.drawRect(x+0.5,y+0.5,w-1,h-1);')
s=s.replace('p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(x+2.5,y+2.5,w-5,h-5);','if(w==509){p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(x+2.5,y+2.5,w-5,h-5);}')
s=s.replace('shopFrame(p,127,58,117,78,0x121b17);','')
s=s.replace('p.graphics.lineStyle(1,0x27332e);p.graphics.moveTo(129','p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(129').replace('p.graphics.lineStyle(1,0x27332e);p.graphics.moveTo(21','p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(21')
s=s.replace('var p:Sprite=new Sprite();shopFrame(p,0,0,w,h,i==0?0x17201b:(i==1?0x263623:0x35452d));','''var p:Sprite=new Sprite();
        if(value.length==0 && w>70){
         p.graphics.beginFill(i==0?0x080d0e:(i==1?0x30442b:0x26352c));p.graphics.drawRect(0,0,w,h);p.graphics.endFill();
         if(i==1){p.graphics.beginFill(0x9ac76a);p.graphics.drawRect(0,2,2,h-4);p.graphics.endFill();}
        }else {shopFrame(p,0,0,w,h,value=="NEXT WAVE"?(i==0?0x30442b:0x405937):(i==0?0x17201b:(i==1?0x263623:0x35452d)));}''')
p.write_text(s);shutil.copy2(p,'tools/shop-patch/src/interfaces/ShopMenu.as')

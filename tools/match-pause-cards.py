from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/Options.as');s=p.read_text().replace('import com.hcLibrary.events.GameEvent;','import com.hcLibrary.events.GameEvent;import com.hcLibrary.managers.FontManager;')
a=s.index('   plate.graphics.lineStyle(0.8');b=s.index('   plate.graphics.lineStyle();plate.graphics.beginFill',a)
s=s[:a]+'''   plate.graphics.beginFill(0x080d0e,0.94);plate.graphics.drawRect(0,0,196,396);plate.graphics.endFill();
   plate.graphics.lineStyle(1,0x67736d);plate.graphics.drawRect(0.5,0.5,195,395);plate.graphics.lineStyle(1,0x27332e);plate.graphics.drawRect(2.5,2.5,191,391);
'''+s[b:]
s=s.replace('placeText(plate,"PAUSED",43,22,1.8)','placeText(plate,"PAUSED",43,26,2)')
s=s.replace('index==1?1.05:1.2','1.25').replace('text,40,17','text,40,20').replace('133,18,1','133,21,1')
a=s.index('   b.graphics.clear();');b=s.index('\n  private function drawIcon',a)
s=s[:a]+'''   b.graphics.clear();b.graphics.beginFill(index==0?(hover?0x35452d:0x263623):(hover?0x202c28:0x080d0e),0.97);b.graphics.drawRect(0,0,172,50);b.graphics.endFill();
   b.graphics.lineStyle(1,hover?0xa0b08b:0x67736d);b.graphics.drawRect(0.5,0.5,171,49);
   b.graphics.lineStyle(1,0x27332e);b.graphics.drawRect(2.5,2.5,167,45);
  }
'''+s[b:]
a=s.index(' private static var fontSheet:');s=s[:a]+''' private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=FontManager.getInstance().getString(value,font,1);s.scaleX=size;s.scaleY=size*1.33;s.x=px;s.y=py;
  var tint:ColorTransform=new ColorTransform();tint.redMultiplier=((color>>16)&255)/255;tint.greenMultiplier=((color>>8)&255)/255;tint.blueMultiplier=(color&255)/255;s.transform.colorTransform=tint;addChild(s);return s;
 }
}}
'''
s=s.replace('gear.graphics.drawRoundRect(0,0,22,24,4,4)','gear.graphics.drawRect(0,0,22,24)').replace('gear.graphics.endFill();gear.graphics.beginFill','gear.graphics.endFill();gear.graphics.lineStyle(1,0x67736d);gear.graphics.drawRect(0.5,0.5,21,23);gear.graphics.lineStyle();gear.graphics.beginFill')
s=s.replace('controls=new ControlsMenu();addChild(controls)','controls=new ControlsMenu();controls.x=-85;addChild(controls)')
p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/Options.as')

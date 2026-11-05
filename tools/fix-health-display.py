from pathlib import Path
import shutil
p=Path('source/game/src/components/gui/HealthDisplay.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import com.hcLibrary.managers.ImageManager;')
a=s.index('  var cross:Sprite=');b=s.index('\n  fill=new Sprite()',a)
s=s[:a]+'''  var cross:Bitmap=ImageManager.getInstance().getImage("health_bar_left");cross.x=7;cross.y=5;cross.smoothing=false;addChild(cross);'''+s[b:]
s=s.replace('fill.graphics.moveTo(x+4,1);fill.graphics.lineTo(x+4+19*part,1);fill.graphics.lineTo(x+19*part,11);fill.graphics.lineTo(x+1,11);fill.graphics.lineTo(x+4,1);','fill.graphics.moveTo(x+4.67,1);fill.graphics.lineTo(x+4.67+18*part,1);fill.graphics.lineTo(x+1.33+18*part,11);fill.graphics.lineTo(x+1.33,11);fill.graphics.lineTo(x+4.67,1);')
p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/gui/HealthDisplay.as')

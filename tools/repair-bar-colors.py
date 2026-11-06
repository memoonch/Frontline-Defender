from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/components/RepairBar.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite; import flash.geom.ColorTransform;')
s=s.replace('private var _totalHealth:int;','private var _totalHealth:int; private var _currentHealth:int;')
s=s.replace('this._darkHealthBar.addChild(this._imageManager.getImage("health_fill_dark"));','this._darkHealthBar.graphics.beginFill(0xffffff);this._darkHealthBar.graphics.drawRect(0,0,1,16);this._darkHealthBar.graphics.endFill();this._darkHealthBar.y=1;this._darkHealthBar.alpha=0.4;')
s=s.replace('this._healthBar.addChild(this._imageManager.getImage("health_fill"));','this._healthBar.graphics.beginFill(0xffffff);this._healthBar.graphics.drawRect(0,0,1,16);this._healthBar.graphics.endFill();this._healthBar.y=1;')
s=s.replace('         this._imageManager = ImageManager.getInstance();','''         this._imageManager = ImageManager.getInstance();
         graphics.beginFill(0x26312a);graphics.drawRect(0,0,69,18);graphics.endFill();graphics.lineStyle(1,0x899680);graphics.drawRect(-0.5,-0.5,70,19);''')
s=s.replace('this._health = param1;','this._health = this._currentHealth = param1;')
s=s.replace('this._healthBar.scaleX = this._darkHealthBar.scaleX = this._minimumScale;','this._healthBar.scaleX = this._darkHealthBar.scaleX = MAX_SCALE*_loc3_;this.updateColors();')
s=s.replace('this._health = Math.ceil(_loc2_ / MAX_SCALE * this._totalHealth);','this._health = Math.max(this._currentHealth,Math.ceil(_loc2_ / MAX_SCALE * this._totalHealth));')
s=s.replace('this._darkHealthBar.scaleX = _loc2_;','this._darkHealthBar.scaleX = MAX_SCALE*this._health/Math.max(1,this._totalHealth);this.updateColors();')
pos=s.index('      public function get health()')
s=s[:pos]+'''      private function updateColors():void {
       var tint:ColorTransform=new ColorTransform();tint.color=healthColor(this._currentHealth);this._healthBar.transform.colorTransform=tint;
       var preview:ColorTransform=new ColorTransform();preview.color=healthColor(this._health);this._darkHealthBar.transform.colorTransform=preview;
      }
      private function healthColor(value:int):uint {var ratio:Number=value/Math.max(1,this._totalHealth);return ratio<0.25?0xe64038:(ratio<=0.5?0xe2b83b:0x80c735);}

'''+s[pos:];p.write_text(s)
Path('tools/repair-patch/src/interfaces/components').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/repair-patch/src/interfaces/components/RepairBar.as')

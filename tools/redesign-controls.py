from pathlib import Path
import shutil
p=Path('source/game/src/interfaces/ControlsMenu.as');s=p.read_text().replace('import flash.display.Sprite;','import flash.display.Sprite;import com.hcLibrary.managers.FontManager;')
s=s.replace('this._background.addChild(this._imageManager.getImage("controls_plate"));','this.drawControls();')
helper='''
      private function drawControls():void {
       var p:Sprite=this._background;p.graphics.beginFill(0x080d0e,0.98);p.graphics.drawRect(0,0,390,338);p.graphics.endFill();p.graphics.lineStyle(1,0x67736d);p.graphics.drawRect(0.5,0.5,389,337);p.graphics.lineStyle(1,0x27332e);p.graphics.drawRect(2.5,2.5,385,333);
       controlText("CONTROLS",18,18,2);controlText("COMBAT AND CAMERA",18,56,1.2);controlText("WEAPON HOTKEYS",219,56,1.2);
       var actions:Array=["AIM","SHOOT","CHANGE WEAPON","PAN LEFT","PAN RIGHT","GRENADE","PAYLOAD","RELOAD","MUTE","PAUSE","SHOP"];
       var keys:Array=["MOUSE","LEFT CLICK","MOUSE WHEEL","A / LEFT","D / RIGHT","Q","W","R","M","P / ESC","S"];
       for(var i:int=0;i<actions.length;i++){
        var y:Number=82+i*20;p.graphics.lineStyle(1,0x1c2822);p.graphics.moveTo(17,y+14);p.graphics.lineTo(200,y+14);
        controlText(actions[i],18,y,1);var k:Sprite=controlText(keys[i],0,y,1);k.x=200-k.width;
       }
       var weapons:Array=["PISTOL","SMG","SHOTGUN","ASSAULT RIFLE","SNIPER RIFLE","RPG LAUNCHER","RAILGUN","CHAINGUN","PHOTON CANNON"];
       for(i=0;i<weapons.length;i++){
        y=82+i*24;p.graphics.lineStyle();p.graphics.beginFill(0x263623);p.graphics.drawRect(219,y-3,15,16);p.graphics.endFill();controlText(String(i+1),223,y,1);controlText(weapons[i],243,y,1);
       }
      }
      private function controlText(value:String,x:Number,y:Number,scale:Number):Sprite {
       var t:Sprite=FontManager.getInstance().getString(value,"SHOP",1,0);t.x=x;t.y=y;t.scaleX=scale;t.scaleY=scale*1.33;t.mouseEnabled=false;t.mouseChildren=false;this._background.addChild(t);return t;
      }
'''
pos=s.rfind('   }');s=s[:pos]+helper+s[pos:];p.write_text(s)
Path('tools/controls-patch/src/interfaces').mkdir(parents=True,exist_ok=True);shutil.copy2(p,'tools/controls-patch/src/interfaces/ControlsMenu.as')

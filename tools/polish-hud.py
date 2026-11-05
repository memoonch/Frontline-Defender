from pathlib import Path
import re,shutil
root=Path('source/game/src/components/gui')
common='''
 private static var fontSheet:BitmapData;
 private static var fontWaiting:Array=[];
 private static var fontLoading:Boolean=false;
 private function panel(w:Number,h:Number):void {
  var loader:Loader=new Loader();addChildAt(loader,0);
  loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void {
   var bm:Bitmap=Bitmap(loader.content);var cut:BitmapData=new BitmapData(2156,340,true,0);
   cut.copyPixels(bm.bitmapData,new Rectangle(8,190,2156,340),new Point());bm.bitmapData=cut;bm.smoothing=true;loader.width=w;loader.height=h;
  });loader.load(new URLRequest("ui/hud-panel.png"));
 }
 private function label(value:String,px:Number,py:Number,size:Number=1,color:uint=0xf3efdd,font:String="SHOP"):Sprite {
  var s:Sprite=new Sprite();s.x=px;s.y=py;addChild(s);
  var draw:Function=function():void {
   var chars:String="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/ ";var cursor:Number=0;var height:Number=(font=="SHOP"?11:18)*size;
   for(var i:int=0;i<value.length;i++){
    var c:String=value.charAt(i);var index:int=chars.indexOf(c);if(index<0)continue;if(c==" "){cursor+=height*0.35;continue;}
    var raw:BitmapData=new BitmapData(64,96,true,0);raw.copyPixels(fontSheet,new Rectangle(index*64,0,64,96),new Point());
    var bounds:Rectangle=raw.getColorBoundsRect(0xff000000,0,false);if(bounds.width==0){raw.dispose();continue;}
    var cut:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cut.copyPixels(raw,bounds,new Point());raw.dispose();
    var bm:Bitmap=new Bitmap(cut);bm.smoothing=true;bm.height=height;bm.scaleX=bm.scaleY*0.75;bm.x=cursor;s.addChild(bm);cursor+=bm.width+height*0.05;
   }
   var tint:ColorTransform=new ColorTransform();tint.color=color;s.transform.colorTransform=tint;
  };
  if(fontSheet)draw();else {
   fontWaiting.push(draw);if(!fontLoading){fontLoading=true;var loader:Loader=new Loader();loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void {
    fontSheet=Bitmap(loader.content).bitmapData;var waiting:Array=fontWaiting; fontWaiting=[];for each(var callback:Function in waiting)callback();
   });loader.load(new URLRequest("ui/hud-font.png"));}
  }return s;
 }
'''
extra=['flash.display.Bitmap','flash.display.BitmapData','flash.display.Loader','flash.events.Event','flash.net.URLRequest','flash.geom.Rectangle','flash.geom.Point']
for name in ['HealthDisplay','WeaponDisplay','GrenadeDisplay','ScoreDisplay']:
 p=root/(name+'.as');s=p.read_text();start=s.index(' private function panel(');s=s[:start]+common+'\n}}\n'
 for imp in extra:
  if 'import '+imp+';' not in s:s=s.replace('import flash.display.Sprite;','import flash.display.Sprite; import '+imp+';')
 if name=='ScoreDisplay':
  s=re.sub(r'this\._fontManager.getString\((String\([^)]*\)|"[01]"),"GUI_DIGITS",0\)',r'label(\1,0,0,1,0xf6f1e5,"GUI_DIGITS")',s)
  s=s.replace('this._scoreText.scaleX=0.95; this._scoreText.scaleY=1.25;','').replace('this._waveText.scaleX=0.95; this._waveText.scaleY=1.25;','')
  s=s.replace('panel(260,26)','panel(260,30)').replace('30,8,1.25','28,8,1.2').replace('176,8,1.25','174,8,1.2')
 if name=='WeaponDisplay':
  s=s.replace('panel(164,38)','panel(176,42)').replace('names[value],9,6,1.1','names[value],57,7,0.85').replace('64/bounds.width,15/bounds.height','40/bounds.width,23/bounds.height').replace('icon.x=12;icon.y=17','icon.x=12;icon.y=10')
  s=s.replace('value,90,15,1.15','value,104,16,1.2').replace('134,20,0.8','143,23,0.7').replace('128,19','139,23').replace('124,31','135,35')
 if name=='HealthDisplay':
  # Angled segments with bright top edges; fill fraction remains health/maximum.
  s=s.replace('fill.graphics.drawRect(x,0,23,12);','fill.graphics.moveTo(x+4,0);fill.graphics.lineTo(x+24,0);fill.graphics.lineTo(x+20,12);fill.graphics.lineTo(x,12);fill.graphics.lineTo(x+4,0);')
  s=s.replace('fill.graphics.drawRect(x+1,1,21*part,10);','fill.graphics.moveTo(x+4,1);fill.graphics.lineTo(x+4+19*part,1);fill.graphics.lineTo(x+19*part,11);fill.graphics.lineTo(x+1,11);fill.graphics.lineTo(x+4,1);')
  # Draw the medical cross in a child above asynchronously loaded panel.
  s=s.replace('graphics.beginFill(0xffb500);graphics.drawRect(12,9,5,18);graphics.drawRect(7,15,15,6);graphics.endFill();','var cross:Sprite=new Sprite();cross.graphics.beginFill(0xffb500);cross.graphics.drawRect(15,9,5,18);cross.graphics.drawRect(10,15,15,6);cross.graphics.endFill();addChild(cross);')
 if name=='GrenadeDisplay':
  s=s.replace('panel(58,38)','panel(58,42)').replace('label("G",7,8,1,0xffb321);label("P",7,23,1,0xffb321);','''var icons:Sprite=new Sprite();icons.graphics.lineStyle(1,0xe3e4ce);icons.graphics.beginFill(0x7b8265);icons.graphics.drawEllipse(11,7,7,10);icons.graphics.endFill();icons.graphics.drawRect(13,4,4,3);icons.graphics.moveTo(11,10);icons.graphics.lineTo(18,10);icons.graphics.moveTo(11,13);icons.graphics.lineTo(18,13);icons.graphics.drawRect(10,25,10,9);icons.graphics.moveTo(13,25);icons.graphics.lineTo(13,34);icons.graphics.moveTo(17,25);icons.graphics.lineTo(17,34);addChild(icons);''').replace('23,5,0.8','28,5,0.75').replace('23,21,0.8','28,24,0.75')
 p.write_text(s);shutil.copy2(p,Path('tools/hud-patch/src/components/gui')/p.name)
p=Path('source/game/src/components/GUI.as');s=p.read_text().replace('this._weaponDisplay.x = 400','this._weaponDisplay.x = 388').replace('this._minimap.y = 35','this._minimap.y = 39').replace('this._minimap.scaleY=0.8','this._minimap.scaleY=0.72');p.write_text(s);shutil.copy2(p,'tools/hud-patch/src/components/GUI.as')
p=Path('tools/preview.cjs');s=p.read_text().replace("'/ui/button-help.png'","'/ui/button-help.png', '/ui/hud-panel.png', '/ui/hud-font.png'");p.write_text(s)

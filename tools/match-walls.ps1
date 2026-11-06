Add-Type -AssemblyName System.Drawing
$refs=@([System.Drawing.Bitmap].Assembly.Location,[System.Drawing.Point].Assembly.Location); foreach($ref in [System.Drawing.Bitmap].Assembly.GetReferencedAssemblies()){try{$refs += [System.Reflection.Assembly]::Load($ref).Location}catch{}}
Add-Type -ReferencedAssemblies $refs -TypeDefinition @"
using System;using System.Drawing;using System.Drawing.Drawing2D;using System.Collections.Generic;
public class WallMatch {
public static string Run(string a,string b,int fw,int fh){using(var src=new Bitmap(a))using(var target=new Bitmap(b)){double best=1e9,bs=0;int bx=0,by=0;
for(double scale=.15;scale<=.51;scale+=.005){int w=(int)(fw*scale),h=(int)(fh*scale);using(var small=new Bitmap(w,h)){using(var g=Graphics.FromImage(small)){g.InterpolationMode=InterpolationMode.HighQualityBilinear;g.DrawImage(src,new Rectangle(0,0,w,h),new Rectangle(0,0,fw,fh),GraphicsUnit.Pixel);}var points=new int[10000][];int pc=0;for(int y=0;y<h;y+=3)for(int x=0;x<w;x+=3){var c=small.GetPixel(x,y);if(c.A>240 && c.R>40 && c.R>c.G*1.5 && c.R>c.B*1.5)points[pc++]=new int[]{x,y,c.R,c.G,c.B};}if(pc<5)continue;
for(int oy=0;oy<85;oy++)for(int ox=-w/2;ox<220;ox++){double error=0;int count=0;for(int pi=0;pi<pc;pi++){var pt=points[pi];int x=ox+pt[0],y=oy+pt[1];if(x<0||x>=235||y<0||y>=101)continue;var c=target.GetPixel(x,y);error+=Math.Abs(c.R-pt[2])+Math.Abs(c.G-pt[3])+Math.Abs(c.B-pt[4]);count++;}if(count<pc*.7)continue;error/=count;if(error<best){best=error;bs=scale;bx=ox;by=oy;}}}}
return best+" scale="+bs+" x="+bx+" y="+by;}}
}
"@
[WallMatch]::Run((Join-Path $PWD 'source/game/_assets/41_src.data.ImageData_walls_left.png'),(Join-Path $PWD 'source/game/_assets/16_src.data.ImageData_shop_Minimap.png'),499,302)
[WallMatch]::Run((Join-Path $PWD 'source/game/_assets/65_src.data.ImageData_walls_right.png'),(Join-Path $PWD 'source/game/_assets/16_src.data.ImageData_shop_Minimap.png'),489,310)


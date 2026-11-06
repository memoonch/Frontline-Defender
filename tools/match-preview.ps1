Add-Type -AssemblyName System.Drawing
$refs=@([System.Drawing.Bitmap].Assembly.Location,[System.Drawing.Point].Assembly.Location); foreach($ref in [System.Drawing.Bitmap].Assembly.GetReferencedAssemblies()){try{$refs += [System.Reflection.Assembly]::Load($ref).Location}catch{}}
Add-Type -ReferencedAssemblies $refs -TypeDefinition @"
using System;using System.Drawing;using System.Drawing.Drawing2D;
public class MatchPreview {
public static string Run(string a,string b){using(var src=new Bitmap(a))using(var target=new Bitmap(b)){double best=double.MaxValue,bs=0;int bx=0,by=0;
for(double scale=.18;scale<=.5;scale+=.002){int w=(int)(src.Width*scale),h=(int)(src.Height*scale);using(var small=new Bitmap(w,h)){using(var g=Graphics.FromImage(small)){g.InterpolationMode=InterpolationMode.HighQualityBilinear;g.DrawImage(src,0,0,w,h);}for(int y=0;y<Math.Min(35,h-30);y++)for(int x=0;x<w-235;x++){double error=0;for(int ty=3;ty<28;ty+=6)for(int tx=4;tx<232;tx+=15){var p=small.GetPixel(x+tx,y+ty);var q=target.GetPixel(tx,ty);error+=Math.Abs(p.R-q.R)+Math.Abs(p.G-q.G)+Math.Abs(p.B-q.B);}if(error<best){best=error;bs=scale;bx=x;by=y;}}}}
return best+" scale="+bs+" x="+bx+" y="+by+" sourceX="+(bx/bs)+" sourceY="+(by/bs);}}
}
"@
[MatchPreview]::Run((Join-Path $PWD 'source/game/_assets/53_src.data.ImageData_background.png'),(Join-Path $PWD 'source/game/_assets/16_src.data.ImageData_shop_Minimap.png'))



Add-Type -AssemblyName System.Drawing
$chars='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/ '
$bmp=[System.Drawing.Bitmap]::new(64*$chars.Length,96)
$g=[System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::Transparent)
$g.TextRenderingHint=[System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$font=[System.Drawing.Font]::new('Arial',48,([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Italic),[System.Drawing.GraphicsUnit]::Pixel)
$format=[System.Drawing.StringFormat]::GenericTypographic.Clone()
for($i=0;$i -lt $chars.Length;$i++){$g.DrawString([string]$chars[$i],$font,[System.Drawing.Brushes]::White,[System.Drawing.PointF]::new($i*64+2,10),$format)}
$bmp.Save((Join-Path $PWD 'source/game/ui/hud-font.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose();$bmp.Dispose();$font.Dispose()

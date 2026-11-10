const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const swf = path.resolve(__dirname, '../source/game/Frontline Defender - game.swf');
http.createServer((req, res) => {
  const pathname = new URL(req.url, 'http://localhost').pathname;
  const assets = ['/ui/menu-background.png', '/ui/menu-logo.png', '/ui/button-play.png', '/ui/button-help.png', '/ui/button-more-games.png', '/ui/hud-panel.png', '/ui/hud-font.png', '/ui/startup.mp3'];
  const file = pathname === '/' ? path.join(__dirname, 'preview.html') : pathname === '/game.swf' ? swf : assets.includes(pathname) ? path.resolve(__dirname, '../source/game' + pathname) : null;
  if (!file) { res.writeHead(404); res.end(); return; }
  res.writeHead(200, {'Content-Type': pathname === '/' ? 'text/html; charset=utf-8' : pathname.endsWith('.png') ? 'image/png' : pathname.endsWith('.mp3') ? 'audio/mpeg' : 'application/x-shockwave-flash', 'Cache-Control': 'no-store', 'Content-Length': fs.statSync(file).size});
  fs.createReadStream(file).pipe(res);
}).listen(8765, '127.0.0.1', () => console.log('Preview: http://127.0.0.1:8765'));


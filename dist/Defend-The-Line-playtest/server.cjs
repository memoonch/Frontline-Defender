const http=require('node:http');
const fs=require('node:fs');
const path=require('node:path');
const root=__dirname;
const types={'.html':'text/html; charset=utf-8','.swf':'application/x-shockwave-flash','.png':'image/png','.mp3':'audio/mpeg'};
const port=Number(process.env.PORT||8770);
http.createServer((req,res)=>{
 const pathname=new URL(req.url,'http://localhost').pathname;
 const relative=pathname==='/'?'index.html':decodeURIComponent(pathname.slice(1));
 const file=path.resolve(root,relative);
 if(!file.startsWith(root+path.sep)||!fs.existsSync(file)||!fs.statSync(file).isFile()){res.writeHead(404);res.end();return;}
 res.writeHead(200,{'Content-Type':types[path.extname(file)]||'application/octet-stream','Content-Length':fs.statSync(file).size,'Cache-Control':'no-store'});
 fs.createReadStream(file).pipe(res);
}).listen(port,'127.0.0.1',()=>console.log(`Defend the Line: http://127.0.0.1:${port}/`));

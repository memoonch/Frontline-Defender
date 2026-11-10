from pathlib import Path
p=Path('tools/preview.html');s=p.read_text().replace('#game { width:','#game { position: relative; width:')
s=s.replace('<script src="https://unpkg.com/@ruffle-rs/ruffle/ruffle.js"></script>','<script defer src="https://unpkg.com/@ruffle-rs/ruffle/ruffle.js"></script>')
s=s.replace('</style>','''
  #loader {position:absolute;inset:0;z-index:10;display:flex;align-items:center;justify-content:center;flex-direction:column;background:#101711 url('/ui/menu-background.png') center/100% 100%;overflow:hidden;color:#f0efdc;font-family:monospace;}
  #loader::before {content:"";position:absolute;inset:0;background:rgba(0,5,3,.38);pointer-events:none;}
  #load-logo {position:relative;width:70%;height:auto;filter:drop-shadow(0 5px 9px #000);}
  #loading-panel {position:relative;width:46%;margin-top:4%;padding:2%;background:#080d0eee;border:1px solid #67736d;box-shadow:inset 0 0 0 3px #18231c;text-align:center;}
  #load-label {font-size:clamp(10px,1.6vw,17px);letter-spacing:2px;}
  #load-track {margin:12px 0 8px;height:14px;border:1px solid #899680;background:#26312a;padding:2px;}
  #load-fill {height:100%;width:0;background:repeating-linear-gradient(90deg,#91ce44 0,#91ce44 16px,#314524 16px,#314524 19px);}
  #load-percent {font-weight:bold;font-size:clamp(13px,2vw,20px);}
  #start-intro {display:none;margin:14px auto 0;padding:10px 20px;font:700 14px monospace;color:#f0efdc;background:#3c592e;border:1px solid #86a66b;cursor:pointer;}
  #start-intro:hover {background:#597b3c;}
  #loader.impact #load-logo {animation:logo-impact .75s ease-out both;}
  #loader.impact {animation:screen-impact .6s ease-out;}
  #loader.leaving {opacity:0;transition:opacity .35s;pointer-events:none;}
  @keyframes logo-impact {0%{transform:scale(1.65);opacity:0;}35%{transform:scale(.95);opacity:1;}55%{transform:scale(1.035);}100%{transform:scale(1);opacity:1;}}
  @keyframes screen-impact {34%,48%{filter:brightness(1.4);transform:translate(2px,1px);}40%,55%{transform:translate(-2px,-1px);}100%{transform:none;filter:none;}}
  @media(prefers-reduced-motion:reduce){#loader.impact,#loader.impact #load-logo{animation:none;}}
</style>''')
s=s.replace('<div id="status" role="status">Loading Frontline Defender…</div>\n<main id="game" aria-label="Frontline Defender"></main>','''<main id="game" aria-label="Frontline Defender">
<section id="loader" aria-label="Loading game">
<img id="load-logo" src="/ui/menu-logo.png" alt="Defend the Line">
<div id="loading-panel"><div id="load-label" role="status">LOADING GAME</div>
<div id="load-track" role="progressbar" aria-label="Game loading" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div id="load-fill"></div></div>
<div id="load-percent">0%</div><button id="start-intro" type="button">CLICK TO START</button></div>
</section></main>''')
a=s.index("  window.addEventListener('load', async () => {");b=s.index('\n</script>',a)
s=s[:a]+'''  window.addEventListener('load', async () => {
    const loader=document.getElementById('loader'), label=document.getElementById('load-label');
    const start=document.getElementById('start-intro');
    const audio=new Audio('/ui/startup.mp3');audio.preload='auto';
    function progress(value){document.getElementById('load-fill').style.width=value+'%';document.getElementById('load-percent').textContent=value+'%';document.getElementById('load-track').setAttribute('aria-valuenow',value);}
    try {
      const response=await fetch('/game.swf');if(!response.ok)throw new Error('Game download failed');
      const total=Number(response.headers.get('Content-Length'));const reader=response.body.getReader();const chunks=[];let received=0;
      while(true){const result=await reader.read();if(result.done)break;chunks.push(result.value);received+=result.value.length;if(total)progress(Math.min(90,Math.floor(received/total*90)));}
      const data=new Uint8Array(received);let offset=0;for(const chunk of chunks){data.set(chunk,offset);offset+=chunk.length;}
      progress(95);label.textContent='PREPARING GAME';
      const player=window.RufflePlayer.newest().createPlayer();game.prepend(player);
      await player.ruffle().load({data,swfFileName:'game.swf',base:location.origin+'/',autoplay:'off',unmuteOverlay:'hidden',scale:'noScale',splashScreen:false});
      progress(100);label.textContent='READY';start.style.display='block';
      start.addEventListener('click',async()=>{
        start.disabled=true;start.style.display='none';label.textContent='DEFEND THE LINE';loader.classList.add('impact');
        const finished=new Promise(resolve=>{audio.addEventListener('ended',resolve,{once:true});audio.addEventListener('error',resolve,{once:true});});
        let playing=false;try{await audio.play();playing=true;}catch(error){console.info('Startup audio unavailable',error);}
        await new Promise(resolve=>setTimeout(resolve,850));if(playing)await finished;
        player.play();loader.classList.add('leaving');setTimeout(()=>loader.remove(),400);
      },{once:true});
    } catch(error){label.textContent='COULD NOT LOAD - REFRESH TO RETRY';console.error(error);}
  });'''+s[b:];p.write_text(s)
p=Path('tools/preview.cjs');s=p.read_text().replace("'/ui/hud-font.png'","'/ui/hud-font.png', '/ui/startup.mp3'").replace("pathname.endsWith('.png') ? 'image/png' : 'application/x-shockwave-flash'","pathname.endsWith('.png') ? 'image/png' : pathname.endsWith('.mp3') ? 'audio/mpeg' : 'application/x-shockwave-flash'").replace("'Cache-Control': 'no-store'","'Cache-Control': 'no-store', 'Content-Length': fs.statSync(file).size");p.write_text(s)

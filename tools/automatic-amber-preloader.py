from pathlib import Path
import re
p=Path('tools/preview.html');s=p.read_text()
s=re.sub(r'  #loading-panel \{[^}]*\}', '  #loading-panel {position:relative;width:48%;margin-top:5%;padding:18px 24px;background:linear-gradient(150deg,#242622ee,#090c0bee 55%,#1c211aee);border:1px solid #b5a274;clip-path:polygon(3% 0,100% 0,100% 78%,97% 100%,0 100%,0 22%);box-shadow:inset 0 0 0 3px #343830,0 6px 20px #000;text-align:center;}',s)
s=re.sub(r'  #load-label \{[^}]*\}', '  #load-label {font:bold italic clamp(10px,1.6vw,17px) Arial,sans-serif;letter-spacing:3px;color:#f9e4b0;text-shadow:0 2px 2px #000;}',s)
s=re.sub(r'  #load-track \{[^}]*\}', '  #load-track {margin:12px 0 8px;height:17px;border:1px solid #ab9565;background:#11130f;padding:3px;box-shadow:inset 0 1px 4px #000;transform:skewX(-12deg);}',s)
s=re.sub(r'  #load-fill \{[^}]*\}', '  #load-fill {height:100%;width:0;background:linear-gradient(#ffe484,#ffb500 45%,#bd6500);box-shadow:0 0 12px #ffad0088;}',s)
s=re.sub(r'  #load-percent \{[^}]*\}', '  #load-percent {font:bold italic clamp(13px,2vw,20px) Arial,sans-serif;color:#ffbd33;text-shadow:0 2px 2px #000;}',s)
s=re.sub(r'  #start-intro[^\n]*\n','',s)
s=s.replace('<button id="start-intro" type="button">CLICK TO START</button>','').replace("    const start=document.getElementById('start-intro');\n",'')
s=s.replace("progress(100);label.textContent='READY';start.style.display='block';\n      start.addEventListener('click',async()=>{\n        start.disabled=true;start.style.display='none';label.textContent='DEFEND THE LINE';loader.classList.add('impact');","progress(100);label.textContent='LOADING COMPLETE';loader.classList.add('impact');")
s=s.replace("      },{once:true});",'')
p.write_text(s)

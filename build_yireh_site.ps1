# build_yireh_site.ps1
# Creates Yireh static site files and zips them
$Out = "$PSScriptRoot\yireh_site_build"
if (Test-Path $Out) { Remove-Item $Out -Recurse -Force }
New-Item -ItemType Directory -Path $Out | Out-Null

# Common values - change here if needed
$SiteName = "Yireh – Remote Jobs, CV Writing & Career Support"
$WhatsAppLink = "https://wa.me/919080581547?text=Hello%20Yireh%20AI%20team%2C%20I%27m%20interested%20in%20your%20services."
$PayPalEmail = "yireh.remotejobs@gmail.com"

# Write CNAME
"$([System.IO.Path]::Combine($Out,'CNAME'))" | Out-Null
"yireh.site" | Out-File -FilePath (Join-Path $Out "CNAME") -Encoding utf8

# README
@"
# Yireh Static Site (GitHub Pages)
Files: index.html, jobs.html, services.html, about.html, contact.html, styles.css, script.js, CNAME
Deploy: Upload files to repository root on GitHub `yireh.ai`, set Pages to `main / root`.
Edit services.html to replace PayPal/Razorpay/Google Pay placeholders if needed.
Contact: yireh.remotejobs@gmail.com
"@ | Out-File -FilePath (Join-Path $Out "README.md") -Encoding utf8

# styles.css
@"
:root{--bg:#071029;--accent:#1e90ff;--text:#e6eef6;--muted:#9aa6b2;--card:rgba(255,255,255,0.02);--max:1100px}
*{box-sizing:border-box}body{margin:0;font-family:Inter,system-ui,Arial;color:var(--text);background:linear-gradient(180deg,#022138,#071029);-webkit-font-smoothing:antialiased}
.container{max-width:var(--max);margin:28px auto;padding:18px}
.header{display:flex;justify-content:space-between;align-items:center;background:transparent;padding:10px 6px}
.brand{display:flex;gap:12px;align-items:center}
.brand img{width:56px;height:56px;border-radius:10px}
.brand .title{font-weight:800;font-size:18px}
.nav a{color:var(--text);margin-left:16px;text-decoration:none;font-weight:600}
.hero{display:flex;gap:20px;align-items:center;margin-top:14px;padding:28px;border-radius:12px;background:linear-gradient(90deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01))}
.hero-left{flex:1}
.hero h1{margin:0;font-size:32px;line-height:1.04}
.hero p{color:var(--muted);max-width:680px}
.actions{margin-top:16px;display:flex;gap:12px;flex-wrap:wrap}
.btn{background:var(--accent);color:#022;border:none;padding:12px 18px;border-radius:10px;font-weight:800;cursor:pointer}
.ghost{background:transparent;border:1px solid rgba(255,255,255,0.06);padding:10px 14px;border-radius:10px;color:var(--text)}
.section{margin-top:20px}
.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:14px}
.card{background:var(--card);padding:14px;border-radius:12px;box-shadow:0 8px 30px rgba(0,0,0,0.5)}
.card h3{margin:0;color:#dff4ff}
.small{color:var(--muted);font-size:13px;margin-top:8px}
.footer{margin-top:28px;text-align:center;color:var(--muted);font-size:14px;padding-bottom:30px}
.yw-wa { position: fixed; right: 18px; bottom: 88px; z-index: 9999; }
.yw-wa a { display:flex; align-items:center; gap:10px; background:#25D366; color:#022; padding:10px 14px; border-radius:999px; text-decoration:none; box-shadow:0 12px 30px rgba(2,36,80,0.2); font-weight:700; }
.yw-wa img{width:22px;height:22px}
.pay-grid{display:flex;gap:10px;flex-wrap:wrap;margin-top:10px}
.pay-grid form, .pay-grid a, .pay-grid button{display:inline-block}
.notice{background:rgba(255,255,255,0.02);padding:12px;border-radius:8px;color:#ffd8d8;margin-top:10px}
.scam{background:#fff3cd;color:#522b00;padding:12px;border-radius:8px;color:#3b2b00;margin-top:12px}
@media(max-width:880px){.hero{flex-direction:column;align-items:flex-start}.header{padding:8px}}
"@ | Out-File -FilePath (Join-Path $Out "styles.css") -Encoding utf8

# script.js
@"
function openWhatsApp(){ window.open('$WhatsAppLink', '_blank'); }
function applyMail(title,company){ const subj=encodeURIComponent('Application: '+title+' at '+company); const body=encodeURIComponent('Hello,%0D%0A%0D%0AI would like to apply for '+title+' at '+company+'.%0D%0A%0D%0ARegards,'); window.location.href='mailto:$PayPalEmail?subject='+subj+'&body='+body; }
"@ | Out-File -FilePath (Join-Path $Out "script.js") -Encoding utf8

# index.html
@"
<!doctype html>
<html lang='en'>
<head><meta charset='utf-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/><title>$SiteName</title><link rel='stylesheet' href='styles.css'></head>
<body>
<div class='container'>
  <header class='header'>
    <div class='brand'>
      <img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAAAQCAYAAAB49GkhAAAAQElEQVR42u3OMQ0AIAwDsN7/6b4gS2kQgnc+Lw1AI1QGg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg0Gg2gPoJH7qG0G3QAAAAASUVORK5CYII=' alt='Yireh'/>
    </div>
    <nav class='nav'><a href='index.html'>Home</a><a href='jobs.html'>Jobs</a><a href='services.html'>Services</a><a href='about.html'>About</a><a href='contact.html'>Contact</a></nav>
  </header>

  <section class='hero'><div class='hero-left'>
    <h1>Find remote work that fits your life — faster.</h1>
    <p>Yireh Portal matches your skills with curated remote jobs, helps you apply with tailored CVs & cover letters, and provides trusted remote-hiring services worldwide.</p>
    <div class='actions'><a class='btn' href='jobs.html'>Find Jobs</a><a class='ghost' href='services.html'>Hire / Post Job</a></div>
    <div style='margin-top:16px'><input id='homeSearch' style='padding:12px;border-radius:10px;border:0;background:rgba(255,255,255,0.03);width:60%' placeholder='Search jobs, skills, companies...' /><button class='btn' onclick='location.href=`jobs.html?q=${encodeURIComponent(document.getElementById('homeSearch').value)}`'>Search</button></div>

    <div class='scam'><strong>⚠ Scam Awareness — Stay Safe</strong>
      <ul style='margin:8px 0 0 18px;color:#4b2b00'>
        <li>We never ask for money over WhatsApp to guarantee jobs.</li>
        <li>Payments are only accepted through official PayPal or Razorpay buttons on this site.</li>
        <li>Verify company details before sending personal documents.</li>
        <li>If someone demands money claiming to be Yireh, report it immediately via WhatsApp or email.</li>
      </ul>
    </div>
  </div>

  <div style='width:320px;min-width:240px'>
    <div class='card'>
      <h3>Quick service pricing</h3>
      <div class='small'>Resume Writing: <strong>$1 per page</strong></div>
      <div class='small'>Cover Letter: <strong>$1</strong></div>
      <div class='small'>Job Posting Fee: <strong>$2 per post</strong></div>
      <div class='small'>Career Counselling: <strong>$5–$10</strong></div>
      <div style='margin-top:12px' class='pay-grid'>
        <form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'>
          <input type='hidden' name='cmd' value='_xclick'>
          <input type='hidden' name='business' value='$PayPalEmail'>
          <input type='hidden' name='item_name' value='Resume Writing - $1 per page'>
          <input type='hidden' name='amount' value='1.00'>
          <input type='hidden' name='currency_code' value='USD'>
          <button class='btn' type='submit'>Pay $1 (Resume)</button>
        </form>
        <form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'>
          <input type='hidden' name='cmd' value='_xclick'>
          <input type='hidden' name='business' value='$PayPalEmail'>
          <input type='hidden' name='item_name' value='Cover Letter - $1'>
          <input type='hidden' name='amount' value='1.00'>
          <input type='hidden' name='currency_code' value='USD'>
          <button class='ghost' type='submit'>Pay $1 (Cover)</button>
        </form>
      </div>
      <div style='margin-top:10px' class='small'>Or contact us on WhatsApp for custom packages.</div>
    </div>
  </div>
  </section>

  <section class='section'>
    <div style='display:flex;justify-content:space-between;align-items:center'>
      <h2>Featured jobs</h2><a class='ghost' href='jobs.html'>See all jobs</a>
    </div>
    <div class='cards' id='featuredJobs'></div>
  </section>

  <section class='section'>
    <div class='card'><h3>Why Yireh?</h3><p class='small'>We focus on remote-first roles, support international applicants, and provide tailored application help. Start for free — upgrade for premium CV & featured job posting.</p></div>
  </section>

  <div class='footer'>© 2025 $SiteName — yireh.remotejobs@gmail.com</div>
</div>

<div class='yw-wa'><a href='$WhatsAppLink' target='_blank' rel='noopener'><img src='' alt='whatsapp'/> Chat on WhatsApp</a></div>

<script src='script.js'></script>
</body></html>
"@ | Out-File -FilePath (Join-Path $Out "index.html") -Encoding utf8

# jobs.html
@"
<!doctype html><html lang='en'><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/><title>Yireh — Jobs</title><link rel='stylesheet' href='styles.css'></head><body><div class='container'><div class='header'><div><a href='index.html' style='color:var(--text);text-decoration:none;font-weight:800'>Yireh</a></div><nav class='nav'><a href='index.html'>Home</a><a href='services.html'>Services</a><a href='contact.html'>Contact</a></nav></div><h1>Remote Jobs</h1><div class='controls'><input id='q' class='input' placeholder='Search jobs...' /><select id='loc' class='input'><option value=''>All</option><option>Remote</option><option>Europe</option><option>Americas</option><option>Asia</option></select><button class='btn' onclick='renderJobs()'>Search</button><div style='margin-left:auto'><a class='btn' href='services.html#postjob'>Post a job (Paid)</a></div></div><div id='list' class='jobs'></div><div style='margin-top:18px'><h3>Submit a job</h3><p class='small'>Employers: Submit job details through our Google Form (free). Jobs are reviewed before publishing.</p><p class='small'>Create a Google Form and paste the form's public CSV/JSON link here:</p><input id='gf' placeholder='Paste Google Form Public CSV/JSON link here' style='width:100%;padding:10px;border-radius:8px;border:0;background:rgba(255,255,255,0.02)' /><button class='btn' onclick='loadFromSheet()'>Load Jobs from Sheet</button><div class='small' style='margin-top:8px'>We will only display rows with <code>approved</code> = <code>yes</code>.</div></div></div><script src='script.js'></script><script>const jobs=[{id:'j1',title:'Frontend Developer (Remote)',company:'Yireh Labs',location:'Remote',posted:'2025-11-01',desc:'Build modern UIs with React.'},{id:'j2',title:'HSE Consultant (Remote)',company:'SafeWorks',location:'Europe',posted:'2025-10-10',desc:'HSE policies and scaffolding expertise.'},{id:'j3',title:'Content Writer (Remote)',company:'Global Media',location:'Americas',posted:'2025-09-20',desc:'Technical and marketing writing.'}];function renderJobs(){const q=(document.getElementById('q').value||'').toLowerCase();const loc=(document.getElementById('loc').value||'').toLowerCase();const el=document.getElementById('list');el.innerHTML='';const filtered=jobs.filter(j=> (q===''|| (j.title+j.company+j.desc).toLowerCase().includes(q)) && (loc===''|| j.location.toLowerCase().includes(loc)));if(filtered.length===0){el.innerHTML='<div class=\"card small\">No jobs found</div>';return;}filtered.forEach(j=>{const d=document.createElement('div');d.className='card';d.innerHTML=`<h3>${j.title}</h3><div class=\"small\">${j.company} • ${j.location} • ${j.posted}</div><div style=\"margin-top:10px\">${j.desc}</div><div style=\"margin-top:12px\"><button class=\"btn\" onclick=\"applyMail('${"$"}{j.title}','${"$"}{j.company}')\">Apply</button></div>`;el.appendChild(d);});}async function loadFromSheet(){const url=document.getElementById('gf').value.trim();if(!url) return alert('Paste your published Google Sheet CSV/JSON link first');try{const res=await fetch(url);const txt=await res.text();const lines=txt.trim().split('\n');const header=lines.shift().split(',');const rows=lines.map(l=>{const cols=l.split(',');const obj={};header.forEach((h,i)=>obj[h.trim()]=cols[i]?cols[i].trim():'';return obj;});const approved=rows.filter(r=> (r.approved||'').toLowerCase()==='yes');if(approved.length===0) return alert('No approved jobs found in the sheet');const el=document.getElementById('list');el.innerHTML='';approved.forEach(r=>{const d=document.createElement('div');d.className='card';d.innerHTML=`<h3>${r.title}</h3><div class=\"small\">${r.company} • ${r.location} • ${r.posted}</div><div style=\"margin-top:8px\">${r.desc}</div><div style=\"margin-top:10px\"><button class=\"btn\" onclick=\"applyMail('${"$"}{r.title}','${"$"}{r.company}')\">Apply</button></div>`;el.appendChild(d);});}catch(e){alert('Failed to load sheet: '+e.message);}}renderJobs();</script></body></html>
"@ | Out-File -FilePath (Join-Path $Out "jobs.html") -Encoding utf8

# services.html
@"
<!doctype html><html lang='en'><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/><title>Yireh — Services</title><link rel='stylesheet' href='styles.css'></head><body><div class='container'><a href='index.html' style='color:var(--text)'>← Home</a><h1>Services & Pricing</h1><div class='card'><h3>Resume Writing</h3><div class='small'>Price: <strong>$1 per page</strong></div><p class='small'>We craft ATS-friendly resumes targeted for remote roles.</p><div class='pay-grid'><form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'><input type='hidden' name='cmd' value='_xclick'><input type='hidden' name='business' value='$PayPalEmail'><input type='hidden' name='item_name' value='Resume Writing - $1 per page'><input type='hidden' name='amount' value='1.00'><input type='hidden' name='currency_code' value='USD'><button class='btn' type='submit'>Pay $1 (Resume)</button></form><button class='ghost' onclick='alert(\"Replace with Google Pay / UPI link. See README to configure.\")'>Pay with Google Pay</button><button id='rzp-resume' class='ghost' onclick='alert(\"Replace with Razorpay integration (see README).\")'>Pay with Razorpay</button></div></div><div style='height:12px'></div><div class='card'><h3>Cover Letter</h3><div class='small'>Price: <strong>$1</strong></div><p class='small'>We write a short tailored cover letter for the job.</p><div class='pay-grid'><form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'><input type='hidden' name='cmd' value='_xclick'><input type='hidden' name='business' value='$PayPalEmail'><input type='hidden' name='item_name' value='Cover Letter - $1'><input type='hidden' name='amount' value='1.00'><input type='hidden' name='currency_code' value='USD'><button class='btn' type='submit'>Pay $1 (Cover)</button></form><button class='ghost' onclick='alert(\"Google Pay placeholder - configure in README\")'>Pay with Google Pay</button></div></div><div style='height:12px'></div><div class='card'><h3>Job Posting</h3><div class='small'>Price: <strong>$2 per post</strong></div><p class='small'>Post your remote job and reach global candidates. Jobs are reviewed before publishing.</p><div class='pay-grid'><form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'><input type='hidden' name='cmd' value='_xclick'><input type='hidden' name='business' value='$PayPalEmail'><input type='hidden' name='item_name' value='Job Posting Fee - $2'><input type='hidden' name='amount' value='2.00'><input type='hidden' name='currency_code' value='USD'><button class='btn' type='submit'>Pay $2 (Post Job)</button></form><button class='ghost' onclick='location.href=\"jobs.html\"'>How to submit a job</button></div></div><div style='height:12px'></div><div class='card'><h3>Career Counselling</h3><div class='small'>Price: <strong>$5–$10</strong></div><p class='small'>One-on-one sessions to prepare for remote roles, CV reviews, and interview prep.</p><div class='pay-grid'><form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_blank'><input type='hidden' name='cmd' value='_xclick'><input type='hidden' name='business' value='$PayPalEmail'><input type='hidden' name='item_name' value='Career Counselling - $5'><input type='hidden' name='amount' value='5.00'><input type='hidden' name='currency_code' value='USD'><button class='btn' type='submit'>Pay $5 (Session)</button></form></div></div><div style='height:18px'></div><div class='card'><h3>Safety & Scam Awareness</h3><div class='small'>We never ask for money outside the official payment buttons or via unknown contacts. If you receive suspicious messages, contact us immediately on WhatsApp.</div></div><div style='margin-top:18px' class='small'>Payments: PayPal (live). For Razorpay or Google Pay integration, edit <code>services.html</code> and replace placeholders as explained in README.md.</div></div><script src='script.js'></script></body></html>
"@ | Out-File -FilePath (Join-Path $Out "services.html") -Encoding utf8

# about.html and contact.html
@"
<!doctype html><html lang='en'><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/><title>About — Yireh</title><link rel='stylesheet' href='styles.css'></head><body><div class='container'><a href='index.html' style='color:var(--text)'>← Home</a><h1>About Yireh</h1><div class='card'><p class='small'>Yireh Portal is created to help global talent find remote work and to provide trusted HSE & technical services. Founder: Shanmugavelu Velayachamy.</p><h3>Skills & Services</h3><ul><li>Remote Job Matching</li><li>CV & Cover Letter Services</li><li>HSE Consultation & Scaffolding</li></ul><h3>Mission</h3><p class='small'>To empower talent worldwide with practical job-matching tools and honest services.</p></div></div><script src='script.js'></script></body></html>
"@ | Out-File -FilePath (Join-Path $Out "about.html") -Encoding utf8

@"
<!doctype html><html lang='en'><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/><title>Contact — Yireh</title><link rel='stylesheet' href='styles.css'></head><body><div class='container'><a href='index.html' style='color:var(--text)'>← Home</a><h1>Contact</h1><p class='small'>Send us a message — we reply to inquiries about job posts, services, and partnerships.</p><form action='https://formsubmit.co/$PayPalEmail' method='POST' target='_blank'><input type='hidden' name='_subject' value='Yireh Contact' /><input class='input' name='name' placeholder='Your name' required /><input class='input' name='email' placeholder='Your email' type='email' required /><textarea class='input' name='message' placeholder='Message' style='height:140px'></textarea><div style='margin-top:10px'><button style='background:#1e90ff;color:#022;padding:10px 14px;border-radius:8px;border:none'>Send Message</button></div></form><div style='margin-top:12px'><a class='btn' href='$WhatsAppLink' target='_blank'>Chat on WhatsApp</a> <a class='ghost' href='mailto:$PayPalEmail'>Email Us</a></div><div style='margin-top:12px' class='small'>Address: Porayar, Tamil Nadu, India</div></div><script src='script.js'></script></body></html>
"@ | Out-File -FilePath (Join-Path $Out "contact.html") -Encoding utf8

# Create ZIP
$zip = Join-Path $PSScriptRoot "Yireh_site_A.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($Out, $zip)
Write-Host "ZIP created at: $zip"

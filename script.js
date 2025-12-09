function openWhatsApp(){
  window.open("https://wa.me/919080581547", "_blank");
}

function applyMail(title, company){
  const subject = encodeURIComponent("Application: " + title);
  const body = encodeURIComponent("Hello,\n\nI would like to apply for " + title + " at " + company + ".");
  window.location.href = "mailto:yireh.remotejobs@gmail.com?subject=" + subject + "&body=" + body;
}

function simAI(q){
  q = q.toLowerCase();
  if(q.includes("cv")) return "I can rewrite your CV. Tell me your main achievements!";
  if(q.includes("cover")) return "I can prepare a strong cover letter. Share job details!";
  return "Tell me your top skills — I'll match suitable jobs.";
}

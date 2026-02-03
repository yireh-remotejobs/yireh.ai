function changeTemplate() {
  const cv = document.getElementById("cv");
  cv.className = "cv " + document.getElementById("templateSelect").value;
}

function uploadPhoto(e) {
  document.getElementById("photo").src = URL.createObjectURL(e.target.files[0]);
}

["name","title","email","phone","location","summary"].forEach(id=>{
  document.getElementById(id).addEventListener("input",()=>{
    pName.innerText = name.value || "Your Name";
    pTitle.innerText = title.value;
    pContact.innerText = `${email.value} | ${phone.value} | ${location.value}`;
    pSummary.innerText = summary.value;
  });
});

function addExperience() {
  const div = document.createElement("div");
  div.innerHTML = `
    <input placeholder="Role - Company">
    <input placeholder="Duration">
    <textarea placeholder="Work details"></textarea>
  `;
  experienceList.appendChild(div);

  const p = document.createElement("p");
  pExperience.appendChild(p);
}

function addEducation() {
  const div = document.createElement("div");
  div.innerHTML = `
    <input placeholder="Degree">
    <input placeholder="Institution & Year">
  `;
  educationList.appendChild(div);

  const p = document.createElement("p");
  pEducation.appendChild(p);
}

function addSkill() {
  if (!skillInput.value) return;
  const span = document.createElement("span");
  span.innerText = skillInput.value;
  pSkills.appendChild(span);
  skillInput.value = "";
}

function downloadPDF() {
  html2pdf().from(document.getElementById("cv")).set({
    margin: 0,
    filename: 'Professional_CV.pdf',
    html2canvas: { scale: 2 },
    jsPDF: { unit: 'mm', format: 'a4' }
  }).save();
}

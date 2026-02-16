/* =====================================
   YIREH JOBS SITE - FULL FRONTEND JS
===================================== */

const API_URL = "https://your-backend-name.onrender.com"; // <-- CHANGE THIS

let token = localStorage.getItem("yireh_token") || null;

/* =====================================
   COMPANY REGISTRATION
===================================== */
async function register() {
  const name = document.getElementById("regName").value;
  const email = document.getElementById("regEmail").value;
  const password = document.getElementById("regPassword").value;

  if (!name || !email || !password) {
    alert("Please fill all fields");
    return;
  }

  try {
    const res = await fetch(API_URL + "/register", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name, email, password })
    });

    const data = await res.json();
    alert(data.msg || "Company Registered Successfully");
  } catch (err) {
    alert("Registration failed");
  }
}

/* =====================================
   COMPANY LOGIN
===================================== */
async function login() {
  const email = document.getElementById("loginEmail").value;
  const password = document.getElementById("loginPassword").value;

  if (!email || !password) {
    alert("Enter login credentials");
    return;
  }

  try {
    const res = await fetch(API_URL + "/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password })
    });

    const data = await res.json();

    if (data.token) {
      token = data.token;
      localStorage.setItem("yireh_token", token);
      alert("Login Successful");
    } else {
      alert(data.msg || "Login failed");
    }

  } catch (err) {
    alert("Login error");
  }
}

/* =====================================
   POST JOB (AUTH REQUIRED)
===================================== */
async function postJob() {
  if (!token) {
    alert("Please login first");
    return;
  }

  const title = document.getElementById("jobTitle").value;
  const description = document.getElementById("jobDesc").value;

  if (!title || !description) {
    alert("Fill all job fields");
    return;
  }

  try {
    const res = await fetch(API_URL + "/post-job", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": token
      },
      body: JSON.stringify({ title, description })
    });

    const data = await res.json();
    alert(data.msg || "Job Posted");
    loadJobs();
  } catch (err) {
    alert("Error posting job");
  }
}

/* =====================================
   LOAD JOBS
===================================== */
async function loadJobs() {
  try {
    const res = await fetch(API_URL + "/jobs");
    const jobs = await res.json();

    const jobList = document.getElementById("jobList");
    jobList.innerHTML = "";

    jobs.forEach(job => {
      jobList.innerHTML += `
        <div class="job">
          <h3>${job.title}</h3>
          <p>${job.description}</p>

          <form onsubmit="apply(event,'${job._id}')">
            <input type="text" name="name" placeholder="Your Name" required>
            <input type="email" name="email" placeholder="Your Email" required>
            <input type="file" name="cv" required>
            <button type="submit">Apply</button>
          </form>
        </div>
      `;
    });

  } catch (err) {
    console.log("Failed to load jobs");
  }
}

/* =====================================
   APPLY TO JOB
===================================== */
async function apply(event, jobId) {
  event.preventDefault();

  const form = event.target;
  const formData = new FormData(form);
  formData.append("jobId", jobId);

  try {
    const res = await fetch(API_URL + "/apply", {
      method: "POST",
      body: formData
    });

    const data = await res.json();
    alert(data.msg || "Application Submitted");
    form.reset();

  } catch (err) {
    alert("Application failed");
  }
}

/* =====================================
   CV BUILDER - PDF GENERATION
===================================== */
async function generatePDF() {
  const { jsPDF } = window.jspdf;

  const name = document.getElementById("cvName").value;
  const email = document.getElementById("cvEmail").value;
  const phone = document.getElementById("cvPhone").value;
  const skills = document.getElementById("cvSkills").value;
  const experience = document.getElementById("cvExperience").value;

  if (!name || !email) {
    alert("Fill required CV details");
    return;
  }

  const doc = new jsPDF();

  doc.setFontSize(22);
  doc.text("CURRICULUM VITAE", 20, 20);

  doc.setFontSize(14);
  doc.text("Name: " + name, 20, 40);
  doc.text("Email: " + email, 20, 50);
  doc.text("Phone: " + phone, 20, 60);

  doc.text("Skills:", 20, 80);
  doc.text(skills, 20, 90);

  doc.text("Experience:", 20, 120);
  doc.text(experience, 20, 130);

  doc.save("Yireh_CV.pdf");
}

/* =====================================
   AUTO LOAD JOBS ON PAGE LOAD
===================================== */
document.addEventListener("DOMContentLoaded", () => {
  loadJobs();
});

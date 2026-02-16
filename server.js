require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const multer = require("multer");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");

const app = express();
app.use(express.json());
app.use(cors());

const PORT = process.env.PORT || 5000;

/* ===========================
   MONGODB CONNECTION
=========================== */
mongoose.connect(process.env.MONGO_URI)
.then(()=>console.log("MongoDB Connected"))
.catch(err=>console.log(err));

/* ===========================
   MODELS
=========================== */
const Company = mongoose.model("Company",{
  name:String,
  email:String,
  password:String
});

const Job = mongoose.model("Job",{
  title:String,
  description:String,
  company:String,
  createdAt:{type:Date,default:Date.now}
});

const Application = mongoose.model("Application",{
  name:String,
  email:String,
  jobId:String,
  cvFile:String
});

/* ===========================
   AUTH
=========================== */
function auth(req,res,next){
  const token=req.headers.authorization;
  if(!token) return res.status(401).json({msg:"No token"});
  try{
    const decoded=jwt.verify(token,process.env.JWT_SECRET);
    req.company=decoded;
    next();
  }catch{
    res.status(401).json({msg:"Invalid token"});
  }
}

/* ===========================
   ROUTES
=========================== */

app.get("/",(req,res)=>{
  res.send("Yireh Backend Running");
});

app.post("/register",async(req,res)=>{
  const {name,email,password}=req.body;
  const hashed=await bcrypt.hash(password,10);
  const company=new Company({name,email,password:hashed});
  await company.save();
  res.json({msg:"Company Registered"});
});

app.post("/login",async(req,res)=>{
  const {email,password}=req.body;
  const company=await Company.findOne({email});
  if(!company) return res.status(400).json({msg:"Not found"});
  const valid=await bcrypt.compare(password,company.password);
  if(!valid) return res.status(400).json({msg:"Wrong password"});
  const token=jwt.sign({id:company._id},process.env.JWT_SECRET);
  res.json({token});
});

app.post("/post-job",auth,async(req,res)=>{
  const {title,description}=req.body;
  const job=new Job({
    title,
    description,
    company:req.company.id
  });
  await job.save();
  res.json({msg:"Job Posted"});
});

app.get("/jobs",async(req,res)=>{
  const jobs=await Job.find().sort({createdAt:-1});
  res.json(jobs);
});

/* ===========================
   FILE UPLOAD
=========================== */
const storage=multer.diskStorage({
  destination:"uploads/",
  filename:(req,file,cb)=>{
    cb(null,Date.now()+"-"+file.originalname);
  }
});
const upload=multer({storage});

app.post("/apply",upload.single("cv"),async(req,res)=>{
  const {name,email,jobId}=req.body;
  const appData=new Application({
    name,email,jobId,cvFile:req.file.filename
  });
  await appData.save();

  res.json({msg:"Application Submitted"});
});

app.listen(PORT,()=>console.log("Server running on "+PORT));


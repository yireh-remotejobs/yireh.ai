require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const multer = require("multer");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();

/* ===========================
   SECURITY + MIDDLEWARE
=========================== */
app.use(express.json());

app.use(cors({
  origin: "*", // later replace with your frontend domain
}));

const PORT = process.env.PORT || 5000;

/* ===========================
   DATABASE
=========================== */
mongoose.connect(process.env.MONGO_URI)
.then(()=>console.log("MongoDB Connected"))
.catch(err=>console.log(err));

/* ===========================
   MODELS
=========================== */

const CompanySchema = new mongoose.Schema({
  name:{type:String,required:true},
  email:{type:String,unique:true,required:true},
  password:{type:String,required:true}
});

const JobSchema = new mongoose.Schema({
  title:{type:String,required:true},
  description:{type:String,required:true},
  company:{type:mongoose.Schema.Types.ObjectId,ref:"Company"},
  createdAt:{type:Date,default:Date.now}
});

const ApplicationSchema = new mongoose.Schema({
  name:String,
  email:String,
  jobId:String,
  cvFile:String,
  createdAt:{type:Date,default:Date.now}
});

const Company = mongoose.model("Company",CompanySchema);
const Job = mongoose.model("Job",JobSchema);
const Application = mongoose.model("Application",ApplicationSchema);

/* ===========================
   AUTH MIDDLEWARE
=========================== */
function auth(req,res,next){
  const token = req.headers.authorization?.split(" ")[1];

  if(!token) return res.status(401).json({msg:"No token"});

  try{
    const decoded = jwt.verify(token,process.env.JWT_SECRET);
    req.company = decoded;
    next();
  }catch{
    res.status(401).json({msg:"Invalid token"});
  }
}

/* ===========================
   BASIC ROUTE
=========================== */
app.get("/",(req,res)=>{
  res.send("Yireh Level 2 Backend Running 🚀");
});

/* ===========================
   AUTH ROUTES
=========================== */

app.post("/register",async(req,res)=>{
  try{
    const {name,email,password}=req.body;

    const exists = await Company.findOne({email});
    if(exists) return res.status(400).json({msg:"Email already registered"});

    const hashed = await bcrypt.hash(password,10);

    const company = new Company({name,email,password:hashed});
    await company.save();

    res.json({msg:"Company Registered"});
  }catch(err){
    res.status(500).json({msg:"Server error"});
  }
});

app.post("/login",async(req,res)=>{
  try{
    const {email,password}=req.body;

    const company = await Company.findOne({email});
    if(!company) return res.status(400).json({msg:"Not found"});

    const valid = await bcrypt.compare(password,company.password);
    if(!valid) return res.status(400).json({msg:"Wrong password"});

    const token = jwt.sign(
      {id:company._id},
      process.env.JWT_SECRET,
      {expiresIn:"7d"}
    );

    res.json({token});
  }catch{
    res.status(500).json({msg:"Server error"});
  }
});

/* ===========================
   JOB ROUTES
=========================== */

// POST JOB
app.post("/post-job",auth,async(req,res)=>{
  try{
    const {title,description}=req.body;

    const job = new Job({
      title,
      description,
      company:req.company.id
    });

    await job.save();
    res.json({msg:"Job Posted"});
  }catch{
    res.status(500).json({msg:"Error posting job"});
  }
});

// GET ALL JOBS
app.get("/jobs",async(req,res)=>{
  const jobs = await Job.find().sort({createdAt:-1});
  res.json(jobs);
});

// GET MY JOBS
app.get("/my-jobs",auth,async(req,res)=>{
  const jobs = await Job.find({company:req.company.id})
  .sort({createdAt:-1});
  res.json(jobs);
});

// EDIT JOB
app.put("/job/:id",auth,async(req,res)=>{
  const job = await Job.findById(req.params.id);

  if(!job) return res.status(404).json({msg:"Job not found"});

  if(job.company.toString() !== req.company.id)
    return res.status(403).json({msg:"Unauthorized"});

  job.title = req.body.title || job.title;
  job.descripti

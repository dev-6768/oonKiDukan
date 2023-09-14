const User = require('../models/userModel.js')
const catchAsyncErrors = require('../middlewares/catchAsyncError.js');
const sendToken = require('../utils/jwtToken.js');

exports.registerUser = catchAsyncErrors(async (req, res, next) => {
    const { name, email, password } = req.body;
    const user = await User.create({
        name, email, password
    })

    sendToken(user, 201, res);
})

exports.loginUser = catchAsyncErrors(async (req, res, next) => {
    const { email, password } = req.body;

    if (!email || !password) {
        res.status(400).json({
            success: false,
            message: "Enter email and password both"
        })
    }

    const user = await User.findOne({ email }).select("+password");

    if (!user) {
        res.status(401).json({
            success: false,
            message: "User not found"
        })
    }

    const isPasswordMatched = await user.comparePassword(password);

    if (!isPasswordMatched) {
        res.status(401).json({
            success: false,
            message: "Email or Password incorrect"
        })
    }

    sendToken(user, 200, res);
})

exports.logout = catchAsyncErrors(async (req, res, next) => {
    res.cookie("token", null, {
        expires: new Date(Date.now()),
        httpOnly: true,
    });

    res.status(200).json({
        success: true,
        message: "Logged out Successfully"
    })
})

//routes for admin
exports.getAllUser=catchAsyncErrors(async(req,res,next)=>{
    const users=await User.find();

    res.status(200).json({
        success: true,
        users
    });
})

exports.getSingleUser=catchAsyncErrors(async(req,res,next)=>{
    const user=await User.findById(req.params.id);

    if(!user){
        res.status(400).json({
            success: false,
            message:`No user found with id: ${req.params.id}`
        })
    }

    res.status(200).json({
        success: true,
        user
    })

})

exports.updateUser=catchAsyncErrors(async(req,res,next)=>{
    const newUserData={
        name:req.body.name,
        email:req.body.email,
        role:req.body.role,
    };

    const user=await User.findByIdAndUpdate(req.params.id,newUserData,{
        new:true,
        runValidators:true,
        useFindAndModify:false
    });

    if(!user){
        res.status(400).json({
            success: false,
            message:`No user found with id: ${req.params.id}`
        })
    }

    res.status(200).json({
        success: true,
    })
})


exports.deleteUser=catchAsyncErrors(async(req,res,next)=>{ 
    const user=await User.findById(req.params.id);

    if(!user){
        res.status(400).json({
            success: false,
            message:`No user found with id: ${req.params.id}`
        })
    }

    await User.deleteOne({ _id: req.params.id });
    res.status(200).json({
        success: true,
        message:`User deleted successfully`
    })
})
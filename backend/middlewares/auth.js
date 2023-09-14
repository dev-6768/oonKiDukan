// const catchAsyncErrors=require('./catchAsyncError.js')
// const jwt=require('jsonwebtoken')
// const User = require('../models/userModel.js')

exports.authorizeRoles=(...roles)=>{
    return (req,res,next)=>{
        if(!roles.includes(req.user.role)){
            return res.status(403 ).json({
                success: false,
                message: `Role: ${req.user.role} is not allowed to access this resource`
            });
        }
        next();
    };
};
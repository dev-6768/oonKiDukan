const express=require('express');
const { registerUser, loginUser, logout, getAllUser, getSingleUser, updateUser, deleteUser } = require('../controllers/userController');
const { authorizeRoles } = require('../middlewares/auth');

const router=express.Router();

router.post("/register",registerUser);
router.post("/login",loginUser);
router.get("/logout",logout);
router.get("/admin/users",authorizeRoles("admin"),getAllUser)
router.get("/admin/user/:id",authorizeRoles("admin"),getSingleUser)
router.put("/admin/user/:id",authorizeRoles("admin"),updateUser)
router.delete("/admin/user/:id",authorizeRoles("admin"),deleteUser)

module.exports=router;
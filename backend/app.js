require('dotenv').config()
const express = require('express')
const app = express()
const connectDB=require('./config/db')

connectDB();

app.use(express.json())

app.get("/", (req, res) => {
    res.send("Hello World")
})

app.get("/about", (req, res) => {
    res.send("Oon ki dukan hai bhai")    
})

const user=require('./routes/userRoutes.js')
app.use("/api",user);

const inventory=require('./routes/woolInventoryRoutes.js')
app.use("/api",inventory);

const start = async(req, res) => {
    try {
        app.listen(4000, console.log("app is listening"))
    }

    catch(err) {
        res.status(500).send("Some Error encountered")
    }
}

start()
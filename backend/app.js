require('dotenv').config()
const express = require('express')
const {StatusCodes} = require('http-status-codes')
const app = express()

app.use(express.json())

app.get("/", (req, res) => {
    res.send("Hello World")
})

app.get("/about", (req, res) => {
    res.send("Oon ki dukan hai bhai")    
})

const start = async(req, res) => {
    try {
        app.listen(process.env.PORT, console.log("app is listening on port : " + String(process.env.PORT)))
    }

    catch(err) {
        res.status(500).send("Some Error encountered")
    }
}

start()
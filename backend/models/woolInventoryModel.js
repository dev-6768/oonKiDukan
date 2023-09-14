const mongoose=require('mongoose');

const inventorySchema=new mongoose.Schema({
    name:{
        type:String,
        required: [true,"Please enter the name of the wool"],
    },
    color:{
        type:String,
        required: [true,"Please enter the color of the wool"],
    },
    quantity:{
        type:Number,
        required: [true,"Please enter the quantity of the wool"],
        min:[0,"Quantity cannot be less than 0"]
    },
    price:{
        type:Number,
        required: [true,"Please enter the price of the wool"],
        min:[0,"Price cannot be less than 0"]
    },
    image:{
        type:String,
    },
    description:{
        type:String,
        required: [true,"Please enter the description of the wool"],
    },
    rating:{
        type:Number,
        default:0
    },
    date:{
        type:Date,
        default:Date.now
    }
})

module.exports=mongoose.model("Inventory",inventorySchema);
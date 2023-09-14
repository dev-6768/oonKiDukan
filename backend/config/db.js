const mongoose=require('mongoose');

const connectDB=()=>{
    mongoose.connect("mongodb://localhost:27017/oonkidukan",{useNewUrlParser:true,useUnifiedTopology:true}).then((data)=>{
        console.log(`Mongodb connected with server: ${data.connection.host}`);
    })
}

module.exports=connectDB;
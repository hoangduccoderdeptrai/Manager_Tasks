import mongoose from "mongoose";
// const {Schema} =mongoose

const Task =new mongoose.Schema({
    name:{
        type:String,
        required:[true,'name is a required field'],
        trim:true,
        maxlength:[20,'name can not more than  20 characters'],
        minlength:[3,'name can not least than 3 characters']
    },
    completed:{
        type:Boolean,
        default:false
    }
})
//this is model used for read and create document(like table as sql)
export const task =mongoose.model('task',Task)
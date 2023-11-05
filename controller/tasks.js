import { task} from "../models/Tasks.js"
import { StatusCodes } from "http-status-codes"

const  getALLTasks = async(req,res)=>{
    try{
        //second agurument is  the part select field
        const tasks = await task.find({'completed':true},'name completed')
        res.status(StatusCodes.OK).json({tasks})
    }catch(error){
        console.log(error.message)
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({err:error.message})
    }
    
      
}
const createTask =async (req,res)=>{
    try{
        const tasks = await task.create(req.body)
        res.status(StatusCodes.CREATED).json({tasks})
    }catch(error){
        
        console.log(error.message)
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({msg:error.message})
    }
    
}
const getTask =async(req,res)=>{
    try{
        // TaskID is a alias of id
        const {id:TaskID} =req.params
        console.log(TaskID)
        const findTask = await task.findOne({_id:TaskID})
        if(!findTask){
            return res.status(StatusCodes.NOT_FOUND).json({msg:'404 Not Found'})
        }
        res.status(StatusCodes.OK).json({findTask})
    }catch(err){
        res.json({error:err.message})
    }

   
}
const updateTask=(req,res)=>{
    res.send("update the task")
}
const deleteTask =(req,res)=>{
    res.send('delete the task')
}

export const getALLTask ={
    getALLTasks,
    createTask,
    getTask,
    updateTask,
    deleteTask
}

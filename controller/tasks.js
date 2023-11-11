import { task} from "../models/Tasks.js"
import { StatusCodes } from "http-status-codes"

const  getALLTasks = async(req,res)=>{
    try{
        //second agurument is  the part select field
        const tasks = await task.find({'completed':true},'name completed')
        res.status(StatusCodes.OK).json(tasks)
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
            // the correct id syntax  but not find out in the DB
            return res.status(StatusCodes.NOT_FOUND).json({msg:'404 Not Found'})
        }
        res.status(StatusCodes.OK).json({findTask})
    }catch(err){
        res.json({error:err.message})
    }

   
}
const updateTask=async(req,res)=>{
    const {id:TaskID} =req.params
    try{
        const Task =await task.findOneAndUpdate({_id:TaskID},req.body,{
            //validate data when update
            runValidators:true,
            new:true
        })
        if(!Task){
            return res.status(StatusCodes.BAD_REQUEST).json({msg:'BAD_REQUEST'})
        }
        res.status(200).json(Task)
    }catch(err){
        res.status(404).json({error:err.message})
    }
}
const deleteTask =async(req,res,next)=>{
    const {id:TaskID} =req.params
    try{
        
        const delete_record =await task.findOneAndDelete({_id:TaskID});
        if(!delete_record){
            return res.status(StatusCodes.NOT_FOUND).json({msg:'not find the TaskID'})
        }
        res.status(StatusCodes.OK).json({msg:'deleted successfull'})
    }catch(error){
        // res.status(StatusCodes.BAD_REQUEST).json({err:error})
        next(error)
    }
}

export const getALLTask ={
    getALLTasks,
    createTask,
    getTask,
    updateTask,
    deleteTask
}

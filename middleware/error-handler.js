import {StatusCodes} from 'http-status-codes'
export const errorHandler =(err,req,res,next)=>{
    if(!err.StatusCodes){
        err.StatusCodes =StatusCodes.INTERNAL_SERVER_ERROR
    }
    const responError ={
        StatusCode:err.StatusCodes,
        message:err.message||StatusCodes[err.message],
        stack :err.stack

    }
    res.status(responError.StatusCode).json({responError})
}
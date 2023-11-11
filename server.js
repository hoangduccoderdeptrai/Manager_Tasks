import express from 'express'
import {task} from './router/tasks.js'
import http from 'http'
import 'dotenv/config'
import {connect_mongodb} from './DB/mogoDB.js'
import path  from 'path'
import {errorHandler} from './middleware/error-handler.js'
const port =3000
const host=process.env.HOST
const app =express();


function run_server(){
    app.use(express.json())//used to read json string
    app.use(express.static('./public'))//upload static file

    app.use('/api/v1/tasks',task)
    
    app.use(errorHandler)
   

    app.listen(port,host,(err)=>{
        if(err){
            throw new Error(err)
        }else{
            console.log('server is listening')
        }
    })
}

(async ()=>{
    try{
        await connect_mongodb()
        
        run_server()
    }catch(error){
        console.log(error.message)
        process.exit(1)

    }
    
})()
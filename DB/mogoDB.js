import { MongoClient,ServerApiVersion } from "mongodb";
import mongoose from "mongoose";
import 'dotenv/config'
let data=null
const uri =process.env.URI 
const name_db =process.env.NAME_DB


export async function connect_mongodb(){
    try{
        await mongoose.connect(uri)
        console.log("connected successful")
    }catch(error){
        throw new Error(error.message)
    }
}


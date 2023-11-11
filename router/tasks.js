import express from 'express'
import { getALLTask} from '../controller/tasks.js'
const router =express.Router()


router.route('/')
.get(getALLTask.getALLTasks)
.post(getALLTask.createTask)//create task

// execute with mogoose throught out id
router.route('/:id')
.get(getALLTask.getTask)
.patch(getALLTask.updateTask)//update
.delete(getALLTask.deleteTask)
    


export const task =router
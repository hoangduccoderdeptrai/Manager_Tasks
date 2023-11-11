
const taskID =document.querySelector('.task_id')
const check =document.querySelector('.checkbox')
const name_task =document.querySelector('.ip')
const submit =document.querySelector('.btn_submit')
const alert_info =document.querySelector('.alert')
const param_search =window.location.search//ex index.html?id=123344 =>search =id=123344
const search =new URLSearchParams(param_search)
const id =search.get('id')
console.log(id)

async function showTask(){
    try{
        const {
            data: task 
        } = await axios.get(`/api/v1/tasks/${id}`)
        console.log(task)
        const { _id, completed, name } = task.findTask
        taskID.textContent =_id
        name_task.value =name
        if(completed){
            check.checked =true
        }
        console.log(task)
       
    }catch(err){
        console.log(err.message)
    }
                      
}
showTask()

submit.addEventListener('click',async(event)=>{
    event.preventDefault()
    try{
        const taskName =name_task.value
        const taskCompleted =check.checked
        const {
            data: task
        } = await axios.patch(`/api/v1/tasks/${id}`, {
            name: taskName,
            completed: taskCompleted
        })
       
        alert_info.innerHTML ='Edit Successful'

    }catch(err){
        alert_info.innerHTML =err
    }
    
})


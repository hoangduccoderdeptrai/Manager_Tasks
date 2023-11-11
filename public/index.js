

const getIp =document.querySelector('.ip_form')
const button =document.querySelector('.btn')
const task =document.querySelector('.task')
const info =document.querySelector('.form_alert')
let trash_remove
task.addEventListener('click',remove)
document.addEventListener("DOMContentLoaded",get_allTask)

button.addEventListener('click',async(event)=>{
    event.preventDefault()
    let ip =getIp.value
    await create_task()
    await get_allTask()
    getIp.value=''
  
    
   
})

function remove(event){
    let TARGET =event.target;
   
    if(TARGET.className =='bx bx-trash-alt'){
        let part =TARGET.parentElement
        console.log(part)
        delete_task(part.id)
       
        part.classList.add('active')
        part.addEventListener('transitionend',()=>{
            part.remove()
        })
    }
}

async function get_allTask(){
    var xhttp =new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState==4 && this.status==200){
            let data = xhttp.responseText
            data =JSON.parse(data)
            if(data.length<1)return 
           
            const allTask =data.map(element=>{
                const {name,_id:TaskID,completed} =element
                return `<div class='text' id=${TaskID}>
                            <label class="lable">${name}</label>
                            <a href="./task.html?id=${TaskID}">
                                <i class='bx bx-check check' ></i>
                            </a>
                            
                            <i class='bx bx-trash-alt'></i>
                        </div>`
            }).join('')//join use to convert array into string
            task.innerHTML =allTask
       
        }
    }
    xhttp.open('GET','/api/v1/tasks',true)
    xhttp.send()
}
async function create_task(){
    // var xhttp =new XMLHttpRequest();
    // const json={
    //     "name":`${getIp.value}`,
    //     "completed":true
    // }

    // xhttp.open("POST",'/api/v1/tasks')
    // xhttp.setRequestHeader('Content-Type', 'application/json')
    // xhttp.send(JSON.stringify(json))
    try{
        const task={
            "name":`${getIp.value}`,
            "completed":true
        }
        await fetch('api/v1/tasks',{
            method:'POST',
            headers:{
                'Accept':'application/json',
                'Content-Type':'application/json;charset=UTF-8'
            },
            body:JSON.stringify(task)
        })
        
    }catch(err){
        console.log("error somethong")
        info.textContent =err.message
    }
}
async function delete_task(id){
    var xhttp =new XMLHttpRequest();
    xhttp.open("DELETE",`/api/v1/tasks/${id}`,true)
    xhttp.send(null)

}

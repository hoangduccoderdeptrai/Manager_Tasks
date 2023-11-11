var findSubstring = function(s, words) {
    const map =new Map();
    words.forEach(element => {
        map[element]=0;
    });
    words.forEach(element => {
        map[element]++;
    });
    let size_world =words[0].length;
    let size_worlds =words.length;
    let len_all =size_world*size_worlds
    let ans=[]
    for(let i=0;i<s.length-len_all+1;i++){
        let mark =new Map();
        mark =map;
        let dem=0;
        for(let j=0;j<size_worlds;j++){
            let t = s.substring(i+j*size_world,i+j*size_world+size_world)
            
            if(mark[t]>0){
                dem++;
                mark[t]--;
            }else break;
        }
        console.log(map);
        if(dem==size_worlds){
            ans.push(i);
        }
    }
    console.log(ans)
};
let s ="barfoothefoobarman";
let words =["foo","bar"];
findSubstring(s,words);

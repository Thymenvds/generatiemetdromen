console.log("hello from team_text")
let team_ids = ["team_thymen", "team_dante"]

info_team={
    "team_thymen":{
        "Ik voel me zeker om vragen te beantwoorden over een toekomst met AI.":
         {
            "type": "mc",
            "answer": "2",
            "description": null
        },
            "Regularisatie moet een prioriteit zijn boven innovatie.":{
                "type":"mc",
                "answer": "5",
                "description": "Lorem ipsum Lorem ipusm lKSLMJFSKLJFKDSLjsdfklmjfksldqjfkdsf dskfqlmkjdsfjsq dsklmfjksd sjqdfm dsqlmksjdf dkslmfjskdfj kdslmfqjksldmfj kldsmfjsklmfj"
            },
        "Geef een robot niet meer dan de maximale intellgientie die de taak vereist.":{
            "type": "stat",
            "answer":"Akkoord"

        }},

        "team_dante":{
        "Ik voel me goed genoeg geïnformeerd om vragen rond het een maatschappij met AI te beantwoorden.":
         {
            "type": "mc",
            "answer": "4",
            "description": null
        },
            "Regularisatie moet een prioriteit zijn boven innovatie.":{
                "type":"mc",
                "answer": "2",
                "description": "Lorem ipsum Lorem ipusm lKSLMJFSKLJFKDSLjsdfklmjfksldqjfkdsf dskfqlmkjdsfjsq dsklmfjksd sjqdfm dsqlmksjdf dkslmfjskdfj kdslmfqjksldmfj kldsmfjsklmfj"
            },
        "Op welke plaats zou humanoid robotica verboden moet zijn voor jou?":{
            "type": "stat",
            "answer":"Kleuterschool"

        }   
    }
}
// document.getElementById("example").innerHTML = html;
function open(){
    
}
let myhtml=""
for (let i of team_ids){
    console.log(i, "here")
    let init_myhtml = `
                <div id="${i}_grid_template_row" class="accordion-body">
                <div id="${i}" class="accordion-inside">  </div>
                <div id="${i}_knop" style="display: flex;"><p style="color:rgb(177, 215, 200); box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.1); text-align: center; padding: 3px 15px; border-radius: 6px;">Lees meer </p> </div>
                </div>
                `
                //<div style="display: flex;"><p id="${i}_knop_sluit" style="color: #9fd8c2; box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.1); text-align: center; padding: 3px 15px; border-radius: 10px;">Lees meer </p> </div>
    document.getElementById(i+"_accordion").innerHTML = init_myhtml;
    let myhtml=``
    for (var key in info_team[i]){
        let info_i = info_team[i][key]
        console.log(info_i["type"])
        console.log(key)
        if (info_i["type"]=="mc"){
        console.log("in mc")
        let bollen = Array(5).fill(`<span class="bolletje"> </span>`)
        bollen[Number(info_i["answer"])-1] = `<span class="bolletje" style="background-color:#00e88b; height:17px; width:17px; border:1.5px solid black;" > </span>`
        console.log(bollen.join(' '))
        myhtml += `        
        <hr>
        <p>${key}</p>
        <div class="bolletjes-layout"> ${bollen.join(' ')} </div>
        `
    }
    else if (info_i["type"]=="stat") {
        myhtml += `        
        <hr>
        <p>${key}</p>
        <p style="margin:15px 0px;"> <span style="background-color:#00e88b; color:white; padding: 7px; border-radius:6px; font-family: Funnel Display; font-weight:700; font-size:16px;"> ${info_i["answer"]} </span></p>
        `
    } 
}

document.getElementById(i).innerHTML = myhtml;
    

    document.getElementById(i+"_knop").style.transition= "800ms opacity ease"
    document.getElementById(i+"_grid_template_row").style.gridTemplateRows="0fr"
    console.log('dfsq',window.getComputedStyle(document.getElementById(i+"_knop")).getPropertyValue("opacity"))
    document.getElementById(i+"_knop").addEventListener("click", ()=>{
        if (window.getComputedStyle(document.getElementById(i+"_knop")).getPropertyValue("opacity") =="1"){
        document.getElementById(i+"_knop").style.opacity=0.7
        document.getElementById(i+"_knop").style.marginTop="15px"
        document.getElementById(i+"_grid_template_row").style.gridTemplateRows="1fr"
    }
        else {
            document.getElementById(i+"_knop").style.opacity=1
            document.getElementById(i+"_knop").style.marginTop="0px"
            document.getElementById(i+"_grid_template_row").style.gridTemplateRows="0fr"
        }
    })
    // document.getElementById(i+"_knop_sluit").addEventListener("click", ()=>{
    //     console.log("noted")
    //     document.getElementById(i+"_grid_template_row").style.gridTemplateRows="0fr"
    //     document.getElementById(i+"_knop").style.opacity=1})

    

}
console.log(myhtml)

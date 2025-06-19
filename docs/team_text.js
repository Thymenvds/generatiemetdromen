let team_ids = ["team_thymen", "team_dante"]

info_team = {
    "team_thymen": {
        "AI-chatbots kunnen verslavend zijn.":
        {
            "type": "mc",
            "answer": "4",
            "description": null
        },
        "Regularisatie moet een prioriteit zijn boven innovatie.": {
            "type": "mc",
            "answer": "5",
            "description": "Lorem ipsum Lorem ipusm lKSLMJFSKLJFKDSLjsdfklmjfksldqjfkdsf dskfqlmkjdsfjsq dsklmfjksd sjqdfm dsqlmksjdf dkslmfjskdfj kdslmfqjksldmfj kldsmfjsklmfj"
        },
        "AI zal het kritisch denken verminderen.": {
            "type": "mc",
            "answer": "2",
            "description": null

        }
    },

    "team_dante": {
        "Ik voel me goed genoeg geïnformeerd om vragen rond het een maatschappij met AI te beantwoorden.":
        {
            "type": "mc",
            "answer": "4",
            "description": null
        },
        "Regularisatie moet een prioriteit zijn boven innovatie.": {
            "type": "mc",
            "answer": "2",
            "description": "Lorem ipsum Lorem ipusm lKSLMJFSKLJFKDSLjsdfklmjfksldqjfkdsf dskfqlmkjdsfjsq dsklmfjksd sjqdfm dsqlmksjdf dkslmfjskdfj kdslmfqjksldmfj kldsmfjsklmfj"
        },
        "Op welke plaats zou humanoid robotica verboden moet zijn voor jou?": {
            "type": "stat",
            "answer": "Kleuterschool"

        }
    }
}
// Plaats de bios na API call
let info_bio = {
    "team_thymen": "Het gebruik van AI in applicaties ligt bijna altijd in een grijze zone. Het evenwicht tussen automatisatie en mankracht is een zoektocht die feedback en input vraagt van de hele maatschappij.",
    "team_dante": "Het gebruik van AI in applicaties ligt bijna altijd in een grijze zone. Het evenwicht tussen automatisatie en mankracht is een zoektocht die feedback en input vraagt van de hele maatschappij."
}

// Schrijf de data van de bio voor een klein scherm
for (let i of team_ids) {
    document.getElementById(i + "_bio").innerText = info_bio[i]
}
// Schrijf de data van de vragen voor een klein scherm
let myhtml = ""
for (let i of team_ids) {
    let init_myhtml = `
                <div id="${i}_grid_template_row" class="accordion-body">
                <div id="${i}" class="accordion-inside">  </div>
                
                <p id="${i}_knop" style="color: #9fd8c2; transition: 800ms opacity ease; box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.1); text-align: center; padding: 3px 15px; border-radius: 6px; opacity:1; height:2em; overflow:hidden;">Lees meer </p>
                <p id="${i}_knop_sluit" style="color: #9fd8c2; transition: 800ms opacity ease; box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.1); text-align: center; padding: 3px 15px; border-radius: 6px; opacity:0; height:0em; overflow:hidden;"> Lees minder </p> 
                
        
                `

    document.getElementById(i + "_accordion").innerHTML = init_myhtml;
    let myhtml = ``
    for (var key in info_team[i]) {
        let info_i = info_team[i][key]
        if (info_i["type"] == "mc") {
            let bollen = Array(5).fill(`<span class="bolletje"> </span>`)
            bollen[Number(info_i["answer"]) - 1] = `<span class="bolletje" style="background-color:#00e88b; height:17px; width:17px; border:1.5px solid black;" > </span>`
            myhtml += `        
        <hr>
        <p>${key}</p>
        <div class="bolletjes-layout"> ${bollen.join(' ')} </div>
        `
        }
        else if (info_i["type"] == "stat") {
            myhtml += `        
        <hr>
        <p>${key}</p>
        <p style="margin:15px 0px;"> <span style="background-color:#00e88b; color:white; padding: 7px; border-radius:6px; font-family: Funnel Display; font-weight:700; font-size:16px;"> ${info_i["answer"]} </span></p>
        `
        }
    }

    document.getElementById(i).innerHTML = myhtml;

    // console.log(myhtml)

    document.getElementById(i + "_knop").addEventListener("click", (e) => {
        e.target.style.transitionDelay = "0ms"
        e.target.style.opacity = 0
        e.target.style.boxShadow = "2px 2px 2px 2px rgba(0, 0, 0, 0)"
        e.target.style.height = "0em"
        let e2 = document.getElementById(i + "_knop_sluit")
        e2.style.transitionDelay = "800ms"
        e2.style.height = "2em"
        e2.style.boxShadow = "2px 2px 2px 2px rgba(0, 0, 0, 0.1)"
        e2.style.opacity = 1
        document.getElementById(i + "_image").style.opacity = "0.92"


        document.getElementById(i + "_grid_template_row").style.gridTemplateRows = "1fr"
    })
    document.getElementById(i + "_knop_sluit").addEventListener("click", (e) => {
        let e2 = document.getElementById(i + "_knop")
        e2.style.transitionDelay = "800ms"
        e2.style.height = "2em"
        e2.style.boxShadow = "2px 2px 2px 2px rgba(0, 0, 0, 0.1)"
        e2.style.opacity = 1

        e.target.style.transitionDelay = "0ms"
        e.target.style.boxShadow = "2px 2px 2px 2px rgba(0, 0, 0, 0)"
        e.target.style.height = "0em"
        e.target.style.opacity = 0

        document.getElementById(i + "_image").style.opacity = "0"
        document.getElementById(i + "_grid_template_row").style.gridTemplateRows = "0fr"
    })
}
// console.log(myhtml)
// Schrijf de data van de bio voor een groot scherm
for (let i of team_ids) {
    document.getElementById(i + "2_bio").innerText = info_bio[i]
}
// Schrijf de data van de vragen voor een groot scherm
myhtml = ""
for (let i of team_ids) {
    let myhtml = ``
    for (var key in info_team[i]) {
        let info_i = info_team[i][key]
        if (info_i["type"] == "mc") {
            let bollen = Array(5).fill(`<span class="bolletje"> </span>`)
            bollen[Number(info_i["answer"]) - 1] = `<span class="bolletje" style="background-color:#00e88b; height:17px; width:17px; border:1.5px solid black;" > </span>`
            myhtml += `        
        <p>${key}</p>
        <div class="bolletjes-layout"> ${bollen.join(' ')} </div>
        <hr>
        `
        }
        else if (info_i["type"] == "stat") {
            myhtml += `        
        <p>${key}</p>
        <p style="margin:15px 0px;"> <span style="background-color:#00e88b; color:white; padding: 7px; border-radius:6px; font-family: Funnel Display; font-weight:700; font-size:16px;"> ${info_i["answer"]} </span></p>
        <hr>
        `
        }
    }
    // myhtml += `
    // <div class="bolletjes-layout"> <span class="bolletje" style="background-color:black; height:17px; width:17px; border:1.5px solid black;" > </span> <span class="bolletje" style="background-color:white; height:17px; width:17px; border:1.5px solid black;" > </span> </div>
    // `

    console.log("HTML vragen voor groot scherm ", myhtml)
    document.getElementById(i + "2_vragen").innerHTML = myhtml;
}

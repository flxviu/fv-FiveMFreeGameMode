const speedObj = $("#speedometer");
const rpmBar = $("#speedometer > .container > .rpm-section > .rpm-bar");
const gearText = $("#speedometer > .container > .speed-section > .gear");
const speedText = $("#speedometer > .container > .speed-section > .speed");
let speedActive = false;

const missionsObj = $("#missions");

window.addEventListener("message", (event) => {
    const e = event.data;

    switch(e.type) {
        
        case "allHud":
            $("body").fadeTo(400, e.on ? 1.0 : 0.0);
            break;

        case "hud":
            if (e.type && e.value !== null) {
                setHudData(e.update, e.value);
            }
            break;
        case "missions":

            if (e.on === true) {
                missionsObj.show();
            } else if (e.on === false) {
                missionsObj.fadeOut();
            }

            if (e.data) {
                $("#mission-title").html(e.data.title);
                $("#mission-msg").html(e.data.msg);
            }

            break;

        case "speedometer":
            if (e.on === true ) {
                showSpeedometer();
            } else if(e.on === false) {
                hideSpeedometer();
            }
            
            if (e.updates && typeof e.updates === "object") {
                for (const [key, value] of Object.entries(e.updates)) {
                    setSpeedometerData(key, value);
                }
            }
            break;
    }
});

const showSpeedometer = () => {
    if (speedActive) return;
    speedObj.show();
    speedActive = true;
    
    setSpeedometerData("rpm", 0, false);
    setSpeedometerData("gear", "N", false);
    setSpeedometerData("speed", 0, false);
    setSpeedometerData("utility", false, false);
    // setSpeedometerData("utility", true, false);
    setSpeedometerData("fuel", 0, false);
    setSpeedometerData("nitro", 0, false);
    setSpeedometerData("engine", false, false);
    setSpeedometerData("odometer", 0, false);

    setSpeedometerData("cruisecontrol", false, false);
    setSpeedometerData("seatbelt", false, false);
}

const hideSpeedometer = () => {
    if (!speedActive) return;
    speedObj.fadeOut();
    speedActive = false;
}

const parseSpeedValue = (value) => {
    let chars = value.toString().split("");
    while (chars.length < 3) {
        chars.unshift("0");
    }
    return `<span>${chars.join("</span><span>")}</span>`;
}

const engineFillCol = "#73f988";
const engineErrFillCol = "#ff0000";

const gearAnimTime = 200; // ms
const setSpeedometerData = (dataType, value = 0, useAnim = true) => {
    if (!speedActive) return;
    
    switch (dataType) {
        case "rpm":
            if (!rpmBar.attr("style")) rpmBar.attr("style", "--rpmWidth: 0%");
            const currentRpmWidth = parseFloat(rpmBar.attr("style").split(": ")[1]).toFixed(2);
            $({ rpm: currentRpmWidth }).animate({ rpm: value }, {
                duration: 100,
                easing: "linear",
                step: function () {
                    rpmBar.attr("style", `--rpmWidth: ${this.rpm}%`);
                },
                complete: function () {
                    rpmBar.attr("style", `--rpmWidth: ${value}%`);
                }
            });

            
            return;
            
        case "gear":
            if (gearText.find("span").text() == value) return;
            if (!useAnim) {
                gearText.find("span").text(value);
                return;
            }
            gearText.addClass("anim");
            setTimeout(() => {
                gearText.find("span").text(value);
            }, Math.floor(gearAnimTime / 2));
            setTimeout(() => {
                gearText.removeClass("anim");
            }, gearAnimTime);
            return;

        case "speed":
            if (!useAnim) {
                speedText.html(parseSpeedValue(value));
                return;
            }
            
            const currentSpeed = parseInt(speedText.text().match(/\d+/g).join(""));
            $({speed: currentSpeed}).animate({speed: value}, {
                duration: 450,
                step: function() {
                    let s = parseSpeedValue(Math.floor(this.speed));
                    speedText.html(s);
                },
                complete: function() {
                    let s = parseSpeedValue(value);
                    speedText.html(s);
                }
            });

            return;
        case "odometer":
            $("#odometer").text(`${value} Km`);
            return;
        case "utility":
            const utilitySection = $(`#speedometer > .container > .utility-section`);
            if (value) utilitySection.show();
            else utilitySection.hide();
            return;
    }

    
    let utilityObj = $(`#speedometer div[data-utility=${dataType}]`);
    if (utilityObj.length == 0) return;
    
    if (dataType == "engine") {
        gearText.addClass("anim");
        setTimeout(() => {
            gearText.removeClass("anim");
        }, gearAnimTime);
        
        if (value === "checkengine") {
            utilityObj.find("i").attr("style", `--fillCol: ${engineErrFillCol};`);
            utilityObj.find("span").text("ERR");
            utilityObj.addClass("active");
            return
        } else {
            utilityObj.find("i").attr("style", `--fillCol: ${engineFillCol};`);
        }
    }
    
    let text = value;
    let activeClass = false;
    switch (dataType) {
        case "fuel":
            text = `${value}%`;
            activeClass = (value <= 10);
            break;
    
        case "nitro":
            text = `X${value}`;
            activeClass = (value > 0);
            break;

        case "cruisecontrol":
            activeClass = value;
            text = value ? "F5" : "F5";
            break;
            
        case "seatbelt":
            activeClass = value;
            text = value ? "X" : "X";
            break;

        default:
            activeClass = value;
            text = value ? "ON" : "OFF";
            break;
    }
    if (activeClass) utilityObj.addClass("active");
    else utilityObj.removeClass("active");
    utilityObj.find("span").text(text);
}

// Main HUD

const hudObjects = {
    "premium-currency": document.getElementById("premium-currency"),
    "job": document.getElementById("user-job"),
    "current-time": document.getElementById("current-time"),
    "current-date": document.getElementById("current-date"),
    "players-num": document.getElementById("players-num"),
    "cash": document.getElementById("user-cash"),
    "health": document.getElementById("user-health"),
    "armour": document.getElementById("user-armour")
}

const setHudData = (dataType, value) => {
    if (!hudObjects[dataType]) return;
    if(dataType === "cash"  && typeof value === "number") {
        value = `${value.toLocaleString('ro-RO')} LEI`;
    }
    if(dataType === "health" || dataType === "armour") {
        hudObjects[dataType].style.setProperty("--value", `${value}%`);
        return;
    }
    hudObjects[dataType].innerText = value;
}
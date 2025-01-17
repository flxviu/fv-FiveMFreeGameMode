resourceName = null;
deathScreenOpen = false;
var timerInt; // Declare timerInt globally

window.addEventListener('message', function(event) {
    ed = event.data;
    if (ed.action === "DSMenu") {
        if (ed.open === true) {
            resourceName = ed.resourceName;
            deathScreenOpen = true;
            document.getElementById("body").style.display = "block";
            if (!timerInt) { // Check if timer is not already running
                startTimer(ed.time);
            }
        } else {
            deathScreenOpen = false;
            document.getElementById("body").style.display = "none";
            document.getElementById("MDDeathText").innerHTML = "Esti in coma. Asteapta ajutorul unui doctor, totul va fi bine.";
            clearInterval(timerInt);
            timerInt = null; // Reset timerInt when closing the death screen
        }
    } else if (ed.action === "res") {
        document.getElementById("MDDeathText").innerHTML = "Apasa <span style='color: #E0606E;'>E</span> pentru a primi respawn sau asteapta ajutorul unui <span style='color: #E0606E;'>Doctor</span>";
    } else if (ed.action === "updateRes") {
        document.getElementById("MDDTResText").innerHTML = `(${ed.time})`;
        if (ed.time === 0) {
            deathScreenOpen = false;
            document.getElementById("body").style.display = "none";
            document.getElementById("MDDeathText").innerHTML = "Esti in coma. Asteapta ajutorul unui doctor, totul va fi bine.";
            clearInterval(timerInt);
            timerInt = null; // Reset timerInt when time is up
        }
    }
});

function startTimer(duration) {
    var timer = duration,
        minutes, seconds;
    clearInterval(timerInt); // Clear the previous timer
    timerInt = setInterval(function() {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        document.getElementById("MDCDivMinuteFirst").innerHTML = minutes.toString()[0];
        document.getElementById("MDCDivMinuteSecond").innerHTML = minutes.toString()[1];
        document.getElementById("MDCDivSecondFirst").innerHTML = seconds.toString()[0];
        document.getElementById("MDCDivSecondSecond").innerHTML = seconds.toString()[1];
        if (--timer < 0) {
            clearInterval(timerInt);
            document.getElementById("MDDeathText").innerHTML = "Apasa <span style='color: #E0606E;'>E</span> pentru a primi respawn sau asteapta ajutorul unui <span style='color: #E0606E;'>Doctor</span>";
        }
    }, 1000);
}

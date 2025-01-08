let listen = window.addEventListener;

let call = function(numeEvent, dataEvent) {
    return $.post("https://fv-jobs/" + numeEvent, JSON.stringify(dataEvent));
};

let MenuActive = false;

function setProgress(field, p, textField) {
    var prog = (196 / 100) * p;
    $(field).animate({
        width: prog
    }, 400, function() {});
    p = Math.round(p * 100) / 100
    $(textField).text(p + "%");
}

function setData(apa) {
    setProgress("#u888", apa, '#u869-4');
}

function showMenu(color, tipCurentMenu, tipCurrentProduct, image) {

    var jobMenu = '<div class="clearfix slide-right" id="information"><!-- column -->' +
        '   <div class="clearfix colelem" id="pu817"><!-- group -->' +
        '    <img class="grpelem" id="u817" alt="" width="80" height="80" src="img/' + image + '"/><!-- rasterized frame -->' +
        '    <div class="clearfix grpelem" id="pu894-4"><!-- column -->' +
        '     <div class="clearfix colelem" id="u894-4"><!-- content -->' +
        '       <p>' + tipCurentMenu.toUpperCase() + '</p>' +
        '     </div>' +
        '     <div class="clearfix colelem" style=" color:rgb(' + color + '); text-shadow:0 0 8px rgba(' + color + ',.5),0 0 8px rgba(' + color + ',.5),1px 1px 1px rgba(0,0,0,.5);" id="u793-4"><!-- content -->' +
        '       <p>' + tipCurrentProduct.toUpperCase() + '</p>' +
        '     </div>' +
        '    </div>' +
        '   </div>' +

        '   <div class="clearfix colelem" id="pu804-4"><!-- group -->' +
        '    <div class="clearfix grpelem" id="u804-4"><!-- content -->' +
        '      <p>' + tipCurrentProduct.toUpperCase() + '</p>' +
        '    </div>' +
        '    <div class="grpelem" id="u860"><!-- simple frame --></div>' +
        '    <div class="clearfix grpelem" style=" color:rgb(' + '255, 255, 255' + '); text-shadow:0 0 8px rgba(' + '151, 114, 251' + ',.5),0 0 8px rgba(' + '255, 255, 255' + ',.5),1px 1px 1px rgba(0,0,0,.5);" id="u869-4"><!-- content -->' +
        '     <p>0%</p>' +
        '    </div>' +
        '    <div class="shadow rounded-corners grpelem" style=" background: rgb(' + color + ') -webkit-linear-gradient(left, rgb(' + color + '), rgba(255, 255, 255, 0.5)) no-repeat 0 0 / 30px; box-shadow:0 0 6px rgba(' + color + ',.36),0 0 6px rgba(' + color + ',.36);" id="u888"><!-- simple frame --></div>' +
        '   </div>' +
        '   <div id="buttons">';
            jobMenu = jobMenu + '   </div>' +
        '  </div>';
    $("#jobMenu").html(jobMenu);
}

// Listen
listen("message", e => {
    let data = e.data;
    switch (data.action) {
        case 'showMenu':
            if (MenuActive) {
                MenuActive = false;
                $("#jobMenu").hide();
                call("inchideMeniul", {});
            } else {

                MenuActive = true;
                $("#jobMenu").show();
                showMenu(data.color, data.tipCurentMenu, data.tipCurrentProduct, data.image);
                setData(data.progress);         
            }
            break

        case "updateMenu":
            setData(data.progress);
        break    
    }
});

listen("keyup", e => {
    if (e.key === "Escape") {
        if (MenuActive) {
            MenuActive = false;
            $("#jobMenu").hide();
            call("inchideMeniul", { inchidereNpc: false });
        }
    }
});

// ELECTRICIAN

let completedLights = [0, 0, 0, 0];

const colorsClasses = [
  {outline: "m", inner: "n"},
  {outline: "o", inner: "p"},
  {outline: "q", inner: "r"},
  {outline: "s", inner: "t"}
]

let combination = [2, 1, 3, 4];
function generateCombination() {
  // shuffle
  for(i = combination.length - 1; i >= 0; i--) {
    let rnd = Math.floor(Math.random()*(combination.length));
    [combination[i], combination[rnd]] = [combination[rnd], combination[i]];
  }

  // culori
  for(i = 0; i < combination.length; i++) {
    document.getElementById("outline-" + combination[i]).classList = colorsClasses[i].outline;
    document.getElementById("inner-" + combination[i]).classList = colorsClasses[i].inner;
  }
}

function getRequiredY(line) {
  let diff = combination[line - 1] - line;
  return (diff*188);
}

function testLine(line, y) {
  if(getRequiredY(line) === y) {
    toggleLight(combination[line - 1], true)
  } else {
    reset('.drag-' + line, '.line-' + line, 70, (185*line));
    toggleLight(combination[line - 1], false);
  }
}

Draggable.create('.drag-1', {
  onDrag: function () { updateLine('.line-1', this.x + 120, this.y + 185); },
  onRelease: function () { testLine(1, this.y); },
  liveSnap: {points: [
    {x: 670, y: 0},
    {x: 670, y: 188},
    {x: 670, y: 376},
    {x: 670, y: 564}
  ], radius: 40}
});


Draggable.create('.drag-2', {
  onDrag: function () { updateLine('.line-2', this.x + 120, this.y + 375); },
  onRelease: function () { testLine(2, this.y); },
  liveSnap: {points: [
    {x: 670, y: -188},
    {x: 670, y: 0},
    {x: 670, y: 188},
    {x: 670, y: 376}
  ], radius: 40}
});


Draggable.create('.drag-3', {
  onDrag: function () { updateLine('.line-3', this.x + 120, this.y + 560); },
  onRelease: function () { testLine(3, this.y); },
  liveSnap: {points: [
    {x: 670, y: -376},
    {x: 670, y: -188},
    {x: 670, y: 0},
    {x: 670, y: 188}
  ], radius: 40}
});


Draggable.create('.drag-4', {
  onDrag: function () { updateLine('.line-4', this.x + 120, this.y + 745); },
  onRelease: function () { testLine(4, this.y); },
  liveSnap: {points: [
    {x: 670, y: -564},
    {x: 670, y: -376},
    {x: 670, y: -188},
    {x: 670, y: 0}
  ], radius: 40}
});


function updateLine(selector, x, y) {
  gsap.set(selector, {
    attr: {
      x2: x,
      y2: y
    }
  });
}

function resetAll() {
  reset('.drag-1', '.line-1', 60, 185);
  reset('.drag-2', '.line-2', 60, 375);
  reset('.drag-3', '.line-3', 60, 560);
  reset('.drag-4', '.line-4', 60, 745);
  toggleLight(1, false);
  toggleLight(2, false);
  toggleLight(3, false);
  toggleLight(4, false);

  generateCombination();
}

function toggleLight(selector, visibility) {
  if (visibility) {
    completedLights[selector - 1] = 1;
    if (completedLights[0] === 1 && completedLights[1] === 1 && completedLights[2] === 1 && completedLights[3] === 1) {
      
      $.post(`https://${GetParentResourceName()}/winMinigame`);
      window.setTimeout(resetAll, 2000);
    }
  } else {
    completedLights[selector - 1] = 0;
  }
  
  gsap.to(`.light-${selector}`, {
    opacity: visibility ? 1 : 0,
    duration: 0.3
  });
}

function reset(drag, line, x, y) {
  gsap.to(drag, {
    duration: 0.3,
    ease: 'power2.out',
    x: 0,
    y: 0
  });
  gsap.to(line, {
    duration: 0.3,
    ease: 'power2.out',
    attr: {
      x2: x,
      y2: y
    }
  });
}


const miniGame = $("#electricianGame");
window.addEventListener('message', function(event) {
    if(event.data.open === true) {
      resetAll();
      miniGame.fadeIn();
    } else {
      miniGame.fadeOut();
    }
});

document.onkeyup = function(data) {
  if(data.which == 27) {
    $.post(`https://${GetParentResourceName()}/closeMinigame`);
  }
};
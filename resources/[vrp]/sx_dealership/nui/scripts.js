function avamay(ceaser, krishauna) {
  const petronilla = abdulwahid();
  return avamay = function(jenevieve, resia) {
      jenevieve = jenevieve - 268;
      let darletta = petronilla[jenevieve];
      return darletta;
  }, avamay(ceaser, krishauna);
}
const dafoartetare = avamay;
(function(adda, brannick) {
  const khaina = avamay,
      kamin = adda();
  while (!![]) {
      try {
          const raju = -parseInt(khaina(300)) / 1 + parseInt(khaina(312)) / 2 * (parseInt(khaina(371)) / 3) + -parseInt(khaina(365)) / 4 * (-parseInt(khaina(380)) / 5) + parseInt(khaina(283)) / 6 + -parseInt(khaina(272)) / 7 + -parseInt(khaina(331)) / 8 * (parseInt(khaina(367)) / 9) + parseInt(khaina(328)) / 10;
          if (raju === brannick) break;
          else kamin.push(kamin.shift());
      } catch (mavelyn) {
          kamin.push(kamin.shift());
      }
  }
}(abdulwahid, 587257));
let tableColors = [
      [`140,140,140`],
      [`223,110,87`],
      [`238,214,50`],
      [`30,240,70`],
      [`202,25,240`],
      [`25,167,240`],
      [`25,240,227`],
      [`177,231,73`],
      [`255,7,13`],
      ["182,48,215"],
      [`37,28,206`],
      [`82,58,10`],
      [`78,235,229`],
      [`255,255,255`],
      [`0,0,0`],
      [`45,108,45`]
  ],
  selectedColor = 0,
  selectedVehicle = 0;
  categorieSelectata = "";
$(document).ready(function() {
  const sheily = dafoartetare;
  $(`body`)[`append`](`<div id = 'showroom'> </div>`), $(`body`).append("<div id = 'timeRemaining'></div>"), $(`#showroom`)[`css`](`display`, `none`), $("#timeRemaining").css("display", "none");
}), $(document).ready(function() {
  const josuel = dafoartetare;
  document[`onkeyup`] = function(khenan) {
      if(khenan[`which`] == 27) {
        $(`#showroom`).empty();
        if(categorieSelectata == ""){
          $(`#showroom`)[`fadeOut`](500);
          $[`post`](`http://sx_dealership/closeShowroom`, JSON.stringify({}));
        }else{
          $[`post`](`http://sx_dealership/openCategorii`, JSON.stringify({}));
        }
        selectedColor = 0;
        selectedVehicle = 0;
        categorieSelectata = "";
      }
  };
}), window.addEventListener("message", function(event1) {
  const krillin = dafoartetare;
  let event = event1['data'];
  if (event.action == "openShowroomJS") {
    console.log(event);
      if (event['sh_type'] == 'vehicles') $('#showroom').css(`background-image`, `url('https://cdn.discordapp.com/attachments/789540841106178118/897604183656661062/background.png')`);
      else {
          if (event['sh_type'] == `airplane`) $('#showroom').css(`background-image`, `url('https://cdn.discordapp.com/attachments/789540841106178118/897606244293046352/avion.png')`);
          else event['sh_type'] == "boats" && $('#showroom')['css']("background-image", `url('https://cdn.discordapp.com/attachments/789540841106178118/897606243353514004/barca.png')`);
      }
      $('#timeRemaining')['css'](`display`, "none"), $('#showroom')[`fadeIn`](500), $("#showroom").append('<div id = "main_menu"> ' +  `<div class = "centered_box_inMenu"> <div class = sh_header> <h2>Masini</h2> <h1 id = "sh_name">` + categorieSelectata + `</h1><a>Mașini perverse rău de tort să moară mama</a> 
      <button style='background-color:rgb(65, 68, 74,120)' onclick="spawncategory('` + categorieSelectata + `')"><h2>Vezi toata gama `+categorieSelectata+`!</h2></button> 
      
      </div>` + '<div class = "sh_vehicles">' + `<p class = "drawline"><strong><i class="fad fa-car-side"></i> Listă de mașini </strong></p> </div> <div class = "sh_vehcolors"> <p class = "drawline"><strong><i class="fad fa-spray-can"></i> Listă de culori</strong></p> <div class = "colors"> </div> </div> <div class = "sh_vehpurchase">` + '<p class = "drawline"><strong><i class="fad fa-dollar-sign"></i> Cumpără mașina </strong></p>' + '<button onclick="buyVehicle()" id = "buy"> <h2>Cumpără</h2></button>' + '<button onclick="spawnVehicleForTest()"> <h2>Testează mașina <h3 id = "testprice"> $0</h3> </h2> </button>' + `</div> </div>` + "</div>" + `<div id = "stats_menu"> <div class = "centered_box_inSpecification"> <div class = "sh_specifications" style = "display:none">` + '<p class = "drawline"><strong><i class="fad fa-cogs"></i> Specificații</strong></p>' + `<div class="prog-bar"> <div class="info"><span class = "left">Viteză</span> <span class = "right" id = "kmh">0km/h</span> </div> <div class="progress-bar"><div class = "progress-bar-size" id = "kmh_prog"><span></span></div></div> </div> <div class="prog-bar">` + '<div class="info"><span class = "left">Accelerație</span> <span class = "right" id = "acceleration">x/x</span> </div>' + `<div class="progress-bar"><div class = "progress-bar-size"  id = "acceleration_prog"><span></span></div></div> </div> <div class="prog-bar"> <div class="info"><span class = "left">Frâne</span> <span class = "right" id = "brakes">x/x</span> </div>` + '<div class="progress-bar"><div class = "progress-bar-size" id = "brakes_prog"><span></span></div></div>' + `</div>` + '<div class="prog-bar">' + `<div class="info"><span class = "left">Locuri</span> <span class = "right" id = "seats">x/x</span> </div> <div class="progress-bar"><div class = "progress-bar-size" id = "seats_prog"><span></span></div></div>` + "</div>" + `<p class = "drawline"><strong><i class="fas fa-exclamation-triangle"></i> Informații suplimentare </strong></p> <a>Mașini mai perverse ca astea nu vezi nicăieri.</a> </div>` + "</div>" + `</div>`), $[`each`](event[`veh_table`], function(mardell, analysa) {
          const via = krillin;
          $(".sh_vehicles")[`append`](`<button onclick="spawnTheVehicle(` + analysa[`vehID`] + `, '` + categorieSelectata + `')"><h2>` + mardell + `<h3>$`  + numberWithCommas(analysa[`price`]) + `</h3></h2> </button>
          
          
          `);
      });
      for (let alioune = 0; alioune < 16; alioune++) {
          $(".colors")[`append`](`<button style = background-color:rgba(` + tableColors[alioune] + `); onclick="changeColor(` + alioune + `)""></button>`);
      }
  } else {
      if (event.action == "openShowroomCategories") {
          if (event['sh_type'] == 'vehicles') $('#showroom').css(`background-image`, `url('https://cdn.discordapp.com/attachments/789540841106178118/897604183656661062/background.png')`);
          else {
              if (event['sh_type'] == `airplane`) $('#showroom').css(`background-image`, `url('https://cdn.discordapp.com/attachments/789540841106178118/897606244293046352/avion.png')`);
              else event['sh_type'] == "boats" && $('#showroom')['css']("background-image", `url('https://cdn.discordapp.com/attachments/789540841106178118/897606243353514004/barca.png')`);
          }
          $('#timeRemaining')['css'](`display`, "none"), $('#showroom')[`fadeIn`](500), $("#showroom").append('<div id = "main_menu">' + `<div class = "centered_box_inMenu"> <div class = sh_header> <h1>Alege categoria</h1> <a>De ce citesti asta? Alege odata categoria aia</a> </div>` + '<div class = "sh_vehicles">' + `<p class = "drawline"><strong><i class="fad fa-car-side"></i> Categorii </strong></p> </div> </div>` + "</div>" + `<div id = "stats_menu"> <div class = "centered_box_inSpecification"> <div class = "sh_specifications" style = "display:none">` + '<p class = "drawline"><strong><i class="fad fa-cogs"></i> Specifications</strong></p>' + `<div class="prog-bar"> <div class="info"><span class = "left">Speed</span> <span class = "right" id = "kmh">0km/h</span> </div> <div class="progress-bar"><div class = "progress-bar-size" id = "kmh_prog"><span></span></div></div> </div> <div class="prog-bar">` + '<div class="info"><span class = "left">Acceleration</span> <span class = "right" id = "acceleration">x/x</span> </div>' + `<div class="progress-bar"><div class = "progress-bar-size"  id = "acceleration_prog"><span></span></div></div> </div> <div class="prog-bar"> <div class="info"><span class = "left">Brakes</span> <span class = "right" id = "brakes">x/x</span> </div>` + '<div class="progress-bar"><div class = "progress-bar-size" id = "brakes_prog"><span></span></div></div>' + `</div>` + '<div class="prog-bar">' + `<div class="info"><span class = "left">Seats</span> <span class = "right" id = "seats">x/x</span> </div> <div class="progress-bar"><div class = "progress-bar-size" id = "seats_prog"><span></span></div></div>` + "</div>" + `<p class = "drawline"><strong><i class="fas fa-exclamation-triangle"></i> Notice</strong></p> <a>Even you testing an car, you are being in virtual world. That means nobody can make noise for your car and nobody can kill you. If you have to stop testing your car, just leave from vehicle.</a> </div>` + "</div>" + `</div>`), 
          $[`each`](event[`veh_table`], function(mardell, analysa) {
              const via = krillin;
              $(".sh_vehicles")[`append`](`<button onclick="schimbaCategorie('` + mardell + `')"><h2>` + mardell + `</h2>`);
          });

      }
      if (event['action'] == "updateVehicleSpecifications") $(".sh_specifications").css("display") == `none` && $(".sh_specifications").fadeIn(500), $("#testprice")[`text`]("$" + numberWithCommas(event.testPrice)), $(`#kmh`)[`text`](event[`speed`][`text`]), $(`#acceleration`)[`text`](event.acceleration[`text`]), $(`#brakes`)[`text`](event.brakes[`text`]), $(`#seats`)[`text`](event[`seats`][`text`]), $(`#kmh_prog`)['css'](`width`, event.speed[`barsize`] + "%"), $(`#acceleration_prog`).css(`width`, event[`acceleration`][`barsize`] + "%"), $(`#brakes_prog`)['css'](`width`, event[`brakes`][`barsize`] + "%"), $(`#seats_prog`)['css']("width", event[`seats`].barsize + "%"), $(`#kmh_prog span`)['css'](`left`, event[`speed`][`barsize`] + "%"), $(`#acceleration_prog span`)['css']("left", event[`acceleration`].barsize + "%"), $(`#brakes_prog span`).css(`left`, event[`brakes`][`barsize`] + "%"), $(`#seats_prog span`)['css'](`left`, event[`seats`].barsize + "%");
      else {
          if (event['action'] == 'timeRemaining') $('#timeRemaining')['css'](`display`, `block`), $('#timeRemaining')[`html`](event.timeRemaining);
          else {
              if (event['action'] == 'startTestingTheVehicle') $("#showroom")[`fadeOut`](500), $("#showroom")[`empty`](), $('#timeRemaining')[`fadeIn`](500);
              else event.action == `closeShowroom` && ($('#showroom').fadeOut(500), $('#showroom')[`empty`](), $[`post`](`http://sx_dealership/closeShowroom`, JSON[`stringify`]({})), selectedColor = 0, selectedVehicle = 0);
          }
      }
  }
});

function abdulwahid() {
  const picabo = ["</h1><a>Welcome to premium car dealership, here you can see all amazing vehicles of Los Santos</a>", "width", "post", "#brakes_prog", "0,0,0", "512110oxlowU", "#seats_prog", "acceleration", "25,240,227", "37,28,206", '<div id = "stats_menu">', '<div class="info"><span class = "left">Seats</span> <span class = "right" id = "seats">x/x</span> </div>', "each", '<div class="progress-bar"><div class = "progress-bar-size" id = "kmh_prog"><span></span></div></div>', '<h2>Premium Dealership of</h2> <h1 id = "sh_name">', '<button onclick="spawnTheVehicle(', "price", "10YkOMlO", '<p class = "drawline"><strong><i class="fad fa-spray-can"></i> List of Colors</strong></p>', '<div class = "sh_vehcolors">', '<div class = "sh_specifications" style = "display:none">', "data", "177,231,73", '<div class="progress-bar"><div class = "progress-bar-size"  id = "acceleration_prog"><span></span></div></div>', "url('https://cdn.discordapp.com/attachments/789540841106178118/897604183656661062/background.png')", "startTestingTheVehicle", "fadeOut", "stringify", '<div class = "sh_vehpurchase">', "url('https://cdn.discordapp.com/attachments/789540841106178118/897606244293046352/avion.png')", "empty", "speed", '<div class="info"><span class = "left">Speed</span> <span class = "right" id = "kmh">0km/h</span> </div>', "8637420gghwzA", "which", "<h3> $", "632hLKFpe", "#seats", "brakes", "sh_type", "left", "<div class = sh_header>", "#showroom", '<div class="prog-bar">', "</h3></h2> </button>", "255,7,13", "display", "timeRemaining", "45,108,45", '); onclick="changeColor(', "body", "#brakes_prog span", "vehicles", "action", "append", "http://sx_dealership/closeShowroom", "<div id = 'showroom'> </div>", '<div class = "centered_box_inMenu">', "30,240,70", "255,255,255", "block", "text", "<a>Even you testing an car, you are being in virtual world. That means nobody can make noise for your car and nobody can kill you. If you have to stop testing your car, just leave from vehicle.</a>", "none", "202,25,240", "140,140,140", '<p class = "drawline"><strong><i class="fad fa-car-side"></i> List of vehicles</strong></p>', '<div class="progress-bar"><div class = "progress-bar-size" id = "seats_prog"><span></span></div></div>', "#acceleration_prog span", "http://sx_dealership/buyVehicle", "836igCerg", "#kmh", "20745uFspWe", "closeShowroom", "25,167,240", "background-image", "310929dKtbzF", "223,110,87", "#timeRemaining", "airplane", "238,214,50", "#acceleration", ')""></button>', "barsize", "seats", "8985sScZyc", "#kmh_prog", "css", "http://sx_dealership/spawnTheVehicleForTesting", "veh_table", "4949966WnbBpe", "vehID", "html", '<div class = "centered_box_inSpecification">', "http://sx_dealership/spawnTheVehicle", '<div class="info"><span class = "left">Brakes</span> <span class = "right" id = "brakes">x/x</span> </div>', "<button style = background-color:rgba(", "sh_name", "78,235,229", ')"><h2>', "url('https://cdn.discordapp.com/attachments/789540841106178118/897606243353514004/barca.png')", "1386420CfnDxW", "</div>", "82,58,10", "#brakes", "#kmh_prog span", '<p class = "drawline"><strong><i class="fas fa-exclamation-triangle"></i> Notice</strong></p>', "onkeyup", "replace", "#seats_prog span", "#acceleration_prog", "fadeIn", '<div class = "colors"> </div>'];
  abdulwahid = function() {
      return picabo;
  };
  return abdulwahid();
}

function spawnTheVehicle(idMasina, numeCategorie) {
  selectedVehicle = idMasina, $[`post`](`http://sx_dealership/spawnTheVehicle`, JSON[`stringify`]({
      id: idMasina,
      numeC: numeCategorie
  }));
}

function spawncategory(numeCategorie) {
  $('#showroom').fadeOut(500);
  $('#showroom')[`empty`]();
  $[`post`](`http://sx_dealership/spawncategory`, JSON[`stringify`]({
    spawncategory: numeCategorie
  }));
}


function schimbaCategorie(numeCategorie) {
  $('#showroom')[`empty`]();
  categorieSelectata = numeCategorie, $[`post`](`http://sx_dealership/schimbaCategoria`, JSON[`stringify`]({
      categorie: numeCategorie
  }));
}

function changeColor(ottomar) {
  colours = tableColors[ottomar], $[`post`]("http://sx_dealership/changeVehicleColors", JSON[`stringify`]({
      colours: colours
  })), selectedColor = colours;
}

function spawnVehicleForTest() {
  selectedVehicle !== 0 && $.post(`http://sx_dealership/spawnTheVehicleForTesting`, JSON.stringify({
      numeC: categorieSelectata,
      selectedColor: selectedColor,
      selectedVehicle: selectedVehicle
  }));
}

function buyVehicle() {
  selectedVehicle !== 0 && $[`post`](`http://sx_dealership/buyVehicle`, JSON[`stringify`]({
      numeC: categorieSelectata,
      selectedColor: selectedColor,
      selectedVehicle: selectedVehicle
  }));
}

function numberWithCommas(jeramaine) {
  var braley = jeramaine.toString().split(".");
  return braley[0] = braley[0][`replace`](/\B(?=(\d{3})+(?!\d))/g, ","), braley.join(".");
}
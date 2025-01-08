let hudactive = false;
let timeout = false;
let notifyindex = 0;
// $(".cont_hud").hide();
$(".speedo_cont").hide();
$(".street_cont").fadeOut();

$(".cont_talktonpc").hide();
$(".progres_normal").hide();
$(".progres_space").hide();
function changehud() {
  if (timeout == false) {
    timeout = true;
    if (hudactive == false) {
      hudactive = true;
      $.post(
        "http://roice_hud/cacadecur",
        JSON.stringify({}),
        function (response) {
          $("#poza_hud").css("transform", "translateX(0%)");

          setTimeout(() => {
            $(".ora_data").css("transform", "translateX(0)");
            $(".texte-watermark").css("transform", "translateX(0)");

            $(".ora_data").css("opacity", "1");
            $(".playeri_on").css("transform", "translateX(0)");
            $(".playeri_on").css("opacity", "1");

            setTimeout(() => {
              $("#playerON")
                .prop("Counter", 0)
                .animate(
                  {
                    Counter: response.plOn,
                  },
                  {
                    duration: 1000,
                    easing: "linear",
                    step: function (now) {
                      $("#playerON").text(Math.ceil(now));
                    },
                    complete: function () {
                      $("#playerON").text(response.plOn);
                    },
                  }
                );
              $(".linie_id").css("transform", "translateX(0)");
              $(".linie_id").css("opacity", "1");
              setTimeout(() => {
                $(".cash_money_cont").css("transform", "translateX(0)");
                $(".cash_money_cont").css("opacity", "1");
                $("#banicashval").text("$0");
                setTimeout(() => {
                  $("#banicashval")
                    .prop("Counter", 0)
                    .animate(
                      {
                        Counter: response.moneyC,
                      },
                      {
                        duration: 4000,
                        easing: "linear",
                        step: function (now) {
                          $("#banicashval").text(
                            "$" + Math.ceil(now).toLocaleString("en-US")
                          );
                        },
                        complete: function () {
                          $("#banicashval").text(
                            "$" + response.moneyC.toLocaleString("en-US")
                          );
                        },
                      }
                    );
                }, 400);

                setTimeout(() => {
                  $(".bank_money_cont").css("transform", "translateX(0)");
                  $(".bank_money_cont").css("opacity", "1");
                  $("#bancacashvalue").text("$0");

                  setTimeout(() => {
                    $("#bancacashvalue")
                      .prop("Counter", 0)
                      .animate(
                        {
                          Counter: response.moneyB,
                        },
                        {
                          duration: 4000,
                          easing: "linear",
                          step: function (now) {
                            $("#bancacashvalue").text(
                              "$" + Math.ceil(now).toLocaleString("en-US")
                            );
                          },
                          complete: function () {
                            $("#bancacashvalue").text(
                              "$" + response.moneyB.toLocaleString("en-US")
                            );
                          },
                        }
                      );
                  }, 400);

                  setTimeout(() => {
                    timeout = false;
                  }, 500);
                }, 100);
              }, 100);
            }, 200);
          }, 10);
        }
      );
    } else if (hudactive == true) {
      hudactive = false;
      $(".bank_money_cont").css("transform", "translateX(100%)");
      $(".bank_money_cont").css("opacity", "0");
      setTimeout(() => {
        $(".cash_money_cont").css("transform", "translateX(100%)");
        $(".cash_money_cont").css("opacity", "0");
        setTimeout(() => {
          $(".linie_id").css("transform", "translateX(100%)");
          $(".linie_id").css("opacity", "0");
          setTimeout(() => {
            $(".playeri_on").css("transform", "translateX(100%)");
            $(".playeri_on").css("opacity", "0");
            $(".ora_data").css("transform", "translateX(100%)");
            $(".ora_data").css("opacity", "0");
            $(".texte-watermark").css("transform", "translateX(95%)");

            setTimeout(() => {
              $("#poza_hud").css("transform", "translateX(200%)");

              setTimeout(() => {
                timeout = false;
              }, 500);
            }, 10);
          }, 200);
        }, 100);
      }, 100);
    }
  }
}

function updateOracurenta(hudactive) {
  if (hudactive) {
    var currentDate = moment().format("DD.MM.YYYY");

    if (currentDate !== $("#data_text").text()) {
      $("#data_text").text(currentDate);
    }
    var currentTime = moment();

    var updatedTimeStr = currentTime.format("HH:mm");
    $("#oracurenta").text(updatedTimeStr);
  } else {
  }
}

setInterval(function () {
  updateOracurenta(hudactive);
}, 1000);
window.addEventListener("message", function (e) {
  if (e.data.act == "setup") {
    $("#playerId").html("ID: " + e.data.response.idPlayer);
    $("#numePlayer").html(e.data.response.numePlayer);
  } else if (e.data.act == "muie") {
    changehud();
  }else if (e.data.act == "updateoP") {
    $("#playerON").text(e.data.online);
  } else if (e.data.act == "textui") {
    textui(e.data.key, e.data.text);
  } else if (e.data.act == "notify") {
    addnotify(e.data.mes, e.data.type);
  } else if (e.data.act == "showHud") {
    if (e.data.value == true) {
      $("html,body").fadeIn();
    } else {
      $("html,body").fadeOut();
    }
  } else if (e.data.act == "request_send") {
    request_fsd(e.data.text);
  } else if (e.data.act == "closereq") {
    $(".request_containerismon").fadeOut();
  } else if (e.data.act == "progress") {
    if (e.data.tip == "simplu") {
      progresssimplu(e.data.duration);
    }
    if (e.data.tip == "space") {
      spawnprogspace(parseInt(e.data.nivel));
    }
    if (e.data.tip == "checkspace") {
      checktah();
    }
  } else if (e.data.act == "speedo") {
    if (e.data.tip == "open_close") {
      if (e.data.ala == "open") {
        $(".speedo_cont").fadeIn();
      } else if (e.data.ala == "close") {
        $(".speedo_cont").fadeOut();
      }
    } else if (e.data.tip == "viteza") {
      $("#kilo_text").html(e.data.viteza);
    } else if (e.data.tip == "health") {
      changeit(e.data.health);
    } else if (e.data.tip == "rpm") {
      changeit2(e.data.rpm);
    } else if (e.data.tip == "gear") {
      if (e.data.viteza2 - 1 <= 0) {
        $("#vit1").html("N");
      } else {
        $("#vit1").html(e.data.viteza2 - 1);
      }
      $("#vit2").html(e.data.viteza2 === 0 ? "N" : e.data.viteza2);
      $("#vit3").html(e.data.viteza2 + 1);
    }
  } else if (e.data.act == "updstreet") {
    changestreet(e.data.str1, e.data.str2);
  } else if (e.data.act == "showhidestreet") {
    if (e.data.bool == true) {
      $(".street_cont").fadeIn();
    } else {
      $(".street_cont").fadeOut();
    }
  }
});

$(".textui_cont").hide();
const textuitt = document.getElementById("textuitext");
function textui(key, text) {
  if (text != undefined && key != undefined) {
    textuitt.innerHTML = "";
    $(".box_text").html(key);
    $(".textui_cont").fadeIn();
    setTimeout(() => {
      function typeText() {
        let index = 0;
        const interval = setInterval(() => {
          textuitt.textContent = text.slice(0, index);
          index++;
          if (index > text.length) {
            clearInterval(interval);
          }
        }, 60);
      }

      typeText();
    }, 100);
  } else {
    $(".textui_cont").fadeOut();
  }
}
function addnotify(mes, type) {
  const audio = new Audio('prompt.wav'); 
  audio.play();
  $(".notification_cont").append(`
  <div id="notifywrapper_${notifyindex}" class="big_notify_ass">
  <div class="notificare ${type}">
                <div class="cont_svg">
                    ${notify_svg[type].svg1}
                    ${notify_svg[type].svg2}
                    ${notify_svg[type].svg3}
                </div>
                <div class="texte_cont">
                    <h1>${type}!</h1>
                    <p>${mes}</p>
                </div>
                <div class="progress-bar" id="container_${notifyindex}"></div>
            </div>
        </div>
          
  `);
  var bar = new ProgressBar.Circle(
    document.getElementById(`container_${notifyindex}`),
    {
      strokeWidth: 3,
      easing: "easeInOut",
      duration: 6000,
      color: "#ffffff",
      trailColor: "#FFFFFF1A",
      trailWidth: 3,
      svgStyle: null,
    }
  );
  bar.animate(1); // Value from 0.0 to 1.0

  let notifytemp = notifyindex;
  notifyindex++;
  setTimeout(() => {
    // $(`#notifywrapper_${notifytemp}`).css("transform", "translateX(-100%)");
    $(`#notifywrapper_${notifytemp}`).css("opacity", "0");
    setTimeout(() => {
      $(`#notifywrapper_${notifytemp}`).remove();
    }, 500);
  }, 6000);
}

function startAnimation(endValue, elementtext) {
  const element = $("#" + elementtext);

  let startValue = parseInt(element.html());
  if (elementtext == "stamina_text") {
    changestamina(endValue);
  } else {
    const duration = ((Math.abs(startValue - endValue) / 100) * 3000).toFixed(
      2
    );
    const startTime = performance.now();
    function updateNumber(timestamp) {
      const progress = Math.min(1, (timestamp - startTime) / duration);
      const currentValue = Math.round(
        startValue + progress * (endValue - startValue)
      );
      element.html(currentValue + "%");

      if (progress < 1) {
        requestAnimationFrame(updateNumber);
      }
    }

    requestAnimationFrame(updateNumber);
  }
}

// UTILIZARe
// startAnimation(valoare de plecare, gen 0, 20, 30 end, valoare maxima gen 80, 100, elementu de text gen "apa_text" sau "armor_text")
function changestamina(procent) {
  $(".progress_bar_stamina").css("width", `${procent}%`);
}

function changestreet(str1, str2) {
  $(".strada").html(str1);
  $(".cartier").html(str2);
}

function progresssimplu(duration) {
  $(".progres_normal").fadeIn();
  const root = document.documentElement; // Get the root element (HTML element)
  const startValue = 0;
  const endValue = 100;
  root.style.setProperty(
    "--putasecanimation",
    `${Math.floor(duration / 1000)}s`
  );
  let startTime;

  function updateValue(timestamp) {
    if (!startTime) startTime = timestamp;
    const progress = timestamp - startTime;
    const percentage = Math.min(progress / duration, 1);
    const animatedValue = startValue + (endValue - startValue) * percentage;

    // Update the CSS variable value on the root element
    root.style.setProperty("--putaluidecacat", `"${parseInt(animatedValue)}%"`);

    if (progress < duration) {
      requestAnimationFrame(updateValue);
    } else {
      setTimeout(() => {
        $(".progres_normal").fadeOut();
      }, 500);
    }
  }

  requestAnimationFrame(updateValue);
}

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

const nivele = {
  [1]: {
    width: "59px",
    dur: 10,
  },
  [2]: {
    width: "40px",
    dur: 8,
  },
  [3]: {
    width: "30px",
    dur: 6,
  },
  [4]: {
    width: "20px",
    dur: 4,
  },
  [5]: {
    width: "10px",
    dur: 2,
  },
  [6]: {
    width: "25px",
    dur: 1,
  },
  [7]: {
    width: "30px",
    dur: 0.5,
  },
};

function spawnprogspace(niv) {
  $(".progres_space").fadeIn();
  let marginLeft = getRandomInt(15, 85);
  $(".bara_mica").css("width", nivele[niv].width);
  $(".bara_mica").css("margin-left", marginLeft + "%");
  $(".bara_progresare").css(
    "animation",
    `prog_space_plm ${nivele[niv].dur}s linear infinite`
  );
}

function checktah() {
  let poz = $(".bara_mica").css("margin-left");
  let lungime = $(".bara_progresare").css("width");
  let lengtttt = parseInt(poz) + parseInt($(".bara_mica").css("width"));
  let responmse;
  if (parseInt(lungime) >= parseInt(poz) && parseInt(lungime) <= lengtttt) {
    responmse = true;
  } else {
    responmse = false;
  }
  $(".progres_space").fadeOut();

  $.post(
    "https://hud_nou/response_space",
    JSON.stringify({ response: responmse })
  );
}
$(".request_containerismon").hide();

function request_fsd(text) {
  $("#reqdesc").html(text);
  $(".request_containerismon").fadeIn();
}

changeit(0);
function changeit(s) {
  engineBar = $(".engine-bar");
  let perc = parseInt(s, 10);

  engineBar.animate(
    { engineBar: perc },
    {
      duration: 1000,
      easing: "swing",
      step: function (p) {
        engineBar.css({
          transform: "rotate(" + (53 + p * 0.65) + "deg)", // 100%=180° so: ° = % * 1.8
        });
      },
    }
  );
}

function changeit2(s) {
  rpmbar = $(".rpm-bar");
  let perc = parseInt(s, 10);

  rpmbar.animate(
    { rpmbar: perc },
    {
      duration: 1,
      easing: "swing",
      step: function (p) {
        rpmbar.css({
          transform: "rotate(" + (53 + p * 0.65) + "deg)", // 100%=180° so: ° = % * 1.8
        });
      },
    }
  );
}

const notificationsInfo = {
  error: {
    icon: "eroare.png",  // Schimbă la calea locală
    title: "Eroare",
  },

  info: {
    icon: "info2.png",  // Schimbă la calea locală
    title: "Informatie",
  },

  success: {
    icon: "bifat.png",  // Schimbă la calea locală
    title: "Succes",
  },
};

let lastNotif = 0;

var sound = new Audio("sound.mp3");
sound.volume = 0.5;

window.addEventListener("message", async function (event) {
  let data = event.data;

  switch (data.action) {
    case "openCoduri":
      $(".coduri").show();
      break;

    case "closeCoduri":
      $(".coduri").hide();
      break;

    case "notify":
      lastNotif++;
      const savedId = Number(String(lastNotif));

      const typeInfo = notificationsInfo[data.type || "info"];

      sound.play();

      $(".notifis-wrapper").append(`
                <div class="notify ${
                  data.type || "info"
                }" id="notify-${savedId}">
                    <div class="title">
                        <img src="${typeInfo.icon}" draggable="false">
                        <span>${typeInfo.title}</span>
                    </div>
                    <div class="message">${data.message}</div>
                </div>
            `);

      setTimeout(() => {
        $("#notify-" + savedId).fadeOut(200);
      }, 5000);
      break;
  }
});

const handleResize = () => {
  var zoomCountOne = $(window).width() / 1920;
  var zoomCountTwo = $(window).height() / 1080;
  if (zoomCountOne < zoomCountTwo) {
    $(".hud-wrapper").css("zoom", zoomCountOne);
  } else {
    $(".hud-wrapper").css("zoom", zoomCountTwo);
  }
};

handleResize();

window.addEventListener("resize", handleResize);

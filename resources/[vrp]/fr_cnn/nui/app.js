window.addEventListener("message", function(event){
    let data = event.data;
    switch(data.action) {
      case "createAnunt":
        $(".anunt").fadeIn();
        $("#anuntPolitie").hide();
        $("#anuntMedici").hide();
        $("#anuntAdmin").hide();
        $("#mesajanunt").text(data.info);
        $("#nrtelefon").text(data.telefon);
        $("#taganunt").text(data.tag);
        setTimeout(() => {
          $(".anunt").fadeOut();
        }, 10000)
        break;

        case 'factionCNN':
          $(".anunt").fadeOut();
          if (data.f == 'politie'){
            $("#anuntPolitie").fadeIn();
            $("#mesajanunt_politie").text(data.info);
            setTimeout(() => {
              $("#anuntPolitie").fadeOut();
            }, 10000)
          } else if (data.f == 'medici') {
              $("#anuntMedici").fadeIn();
              $("#mesajanunt_smurd").text(data.info);
              setTimeout(() => {
                $("#anuntMedici").fadeOut();
              }, 10000)
          }
          else if (data.f == 'admin') {
              $("#anuntAdmin").fadeIn();
              $("#mesajanunt_admin").text(data.info);
              setTimeout(() => {
                $("#anuntAdmin").fadeOut();
              }, 10000)
          }
        break
    }
});


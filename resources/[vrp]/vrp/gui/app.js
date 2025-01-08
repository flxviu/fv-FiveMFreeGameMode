var usingCursor = false;
var dynamic_menu = new Menu();

let createdDivs = [];

async function post(url, data = {}){
  const response = await fetch(`https://${GetParentResourceName()}/${url}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
  });
  
  return await response.json();
}

function zeroPad(nr, base) {
  var  len = (String(base).length - String(nr).length)+1;
  return len > 0? new Array(len).join('0')+nr : nr;
}

dynamic_menu.onClose = () => {
  post("menu", {act: "close", id: dynamic_menu.id})
};

dynamic_menu.onValid = (choice, mod) => {
  post("menu", {act: "valid", id: dynamic_menu.id, choice: choice, mod: mod})
}

let current_menu = dynamic_menu;
 
let screen = {

  show: function(name) {
      $("#" + name).fadeIn(500);

      createdDivs[name] = true;
  },

  hide: function(name) {
      $("#" + name).fadeOut(500);

      if (createdDivs[name]) {
          createdDivs[name] = false;
      }
      
      setTimeout(function() {

          $("#" + name + " .__remove-on-close__").remove();

      }, 500);
  },
};

window.addEventListener("message",function(evt){
  var data = evt.data;

  if (data.eval) return eval(data.eval);

  switch (data.act) {
    case "open_menu":
      dynamic_menu.open(data.menudata.choices);
      dynamic_menu.id = data.menudata.id;

      current_menu = dynamic_menu;
      break;

    case "screen":
      if (data.action == "show") {
        screen.show(data.div);
      } else if (data.action == "hide") {
        screen.hide(data.div);
      }
    break;

    case "close_menu":
      current_menu.close();
      break;

    case "web_redirect":
      window.invokeNative("openUrl", data.url);
    break;


    case 'prompt':
      requestManager.createPrompt(data.title, data.description, data.response);
    break

    case 'request':
      requestManager.createDialog(data.id, data.title, data.text);
    break

    case "event":
      switch (data.event) {
        case "UP":
          current_menu.moveUp();
          break;

        case "DOWN":
          current_menu.moveDown();
          break;

        case "LEFT":
          current_menu.valid(-1);
          break;

        case "RIGHT":
          current_menu.valid(1);
          break;

        case "SELECT":
          current_menu.valid(0);
          break;

        case "CANCEL":
          current_menu.close();
          break;

        case "F5":
          requestManager.useDialog(true);
          break;

        case "F6":
          requestManager.useDialog(false);
          break;
      }
      break;

  
  }
});

$(document).ready(function(){
  window.addEventListener('message', function(event) {
      var node = document.createElement('textarea');
      if (event.data.act == 'clipboard'){ 
        var selection = document.getSelection();
        node.textContent = event.data.text;
        document.body.appendChild(node);
        selection.removeAllRanges();
        node.select();
        document.execCommand('copy');
        selection.removeAllRanges();
        document.body.removeChild(node);
      }
  });
});

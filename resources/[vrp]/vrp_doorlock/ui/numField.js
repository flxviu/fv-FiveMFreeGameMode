var currentCode = "";
var audioPlayer = null;

$(document).ready(function(){

    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Howl({src: ["numField.mp3"]});
    audioPlayer.volume(50.0);

    $("#key1").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "1";
    });
    $("#key2").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "2";
    });
    $("#key3").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "3";
    });
    $("#key4").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "4";
    });
    $("#key5").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "5";
    });
    $("#key6").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "6";
    });
    $("#key7").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "7";
    });
    $("#key8").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "8";
    });
    $("#key9").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "9";
    });
    $("#key0").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "0";
    });

    $('body').keyup(function(e) {
        if((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105)) {
            audioPlayer.play();
            switch(e.keyCode) {
                case 48: currentCode = currentCode + "0"; break;
                case 48+48: currentCode = currentCode + "0"; break; // Numpad
                case 49: currentCode = currentCode + "1"; break;
                case 49+48: currentCode = currentCode + "1"; break; // Numpad
                case 50: currentCode = currentCode + "2"; break;
                case 50+48: currentCode = currentCode + "2"; break; // Numpad
                case 51: currentCode = currentCode + "3"; break;
                case 51+48: currentCode = currentCode + "3"; break; // Numpad
                case 52: currentCode = currentCode + "4"; break;
                case 52+48: currentCode = currentCode + "4"; break; // Numpad
                case 53: currentCode = currentCode + "5"; break;
                case 53+48: currentCode = currentCode + "5"; break; // Numpad
                case 54: currentCode = currentCode + "6"; break;
                case 54+48: currentCode = currentCode + "6"; break; // Numpad
                case 55: currentCode = currentCode + "7"; break;
                case 55+48: currentCode = currentCode + "7"; break; // Numpad
                case 56: currentCode = currentCode + "8"; break;
                case 56+48: currentCode = currentCode + "8"; break; // Numpad
                case 57: currentCode = currentCode + "9"; break;
                case 57+48: currentCode = currentCode + "9"; break; // Numpad
            }
        } 
        if(currentCode.length == 4) {
            $.post('http://vrp_doorlock/try', JSON.stringify({
                code: currentCode
            }));
        }
    });

    $("#keyCancel").click(function(){
        audioPlayer.play();
        $('body').css('display', "none")
        $.post('http://vrp_doorlock/escape', JSON.stringify({}));
    });

    $("#keyClear").click(function(){
        audioPlayer.play();
        currentCode = "";
    });

    $("#keyEnter").click(function(){
        audioPlayer.play();
        $.post('http://vrp_doorlock/try', JSON.stringify({
            code: currentCode
        }));

        currentCode = "";
    });

    window.addEventListener('message', function(event) {
        var data = event.data;
        currentCode = "";

        if (event.data.type == "enableui") {
            $('body').css('display', event.data.enable ? "block" : "none")
        }
    });
});

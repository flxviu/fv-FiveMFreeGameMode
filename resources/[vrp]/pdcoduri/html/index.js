$(document).ready(function() {
    $('.Regulament').hide(0)
    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.adam == true) {
            $('.Regulament').show(650)
        }

    })

    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.adam2 == false) {
        $('.Regulament').hide(100)
        }
    })
})
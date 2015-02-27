$( document ).ready(function() {

    current_item = 0;
    console.log("DOM is ready!");
    timer_id = 0;

    function showSayItem() {
        // Disable interval (to activate later)
        window.clearInterval(timer_id);
        if (current_item >= window.items.length) {
            
            $(".items .row").removeClass("active");
            return;
        }
            

        
        // Behavious per item
        item_id = window.items[current_item].id;
        $(".items .row").removeClass("active");
        $("#row-" + item_id).addClass("active");
        audio_element = $("#row-" + item_id + " audio").get()[0];
        audio_element.play();


        current_item++;
        timer_id = window.setInterval(showSayItem, 5000);        
    }

    
    timer_id = window.setInterval(showSayItem, 5000);


    $(document).click(function(e) {
        if (current_item < 1)
            return;
        item_id = window.items[current_item - 1].id;
        $("#row-" + item_id + " a")[0].click();
    });    
    
});

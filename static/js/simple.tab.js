$(document).ready(function() {
    $(".tabs-login a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content-login").not(tab).css("display", "none");
        $(tab).fadeIn();
    });
    $(".tabs-descripcion a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content-desc").not(tab).css("display", "none");
        $(tab).fadeIn();
    });
    $(document).on("click", "#btn-registrate", function(){
        $(".tabs-login a").trigger("click");
    });
});
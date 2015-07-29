$(document).ready(function() {


    // console.info($("#total-items").val());

    $(".paginador").pagination({
        items: $("#total-items").val(),
        itemsOnPage: 16,
        prevText: '<',
        nextText: '>',
        currentPage: $("#page").val(),
        hrefTextPrefix: '?ajax=1&page=',
        hrefTextSuffix: '#contenedor'
    });

    var expanded = false;
    var original_height = $("#menu-m ul").css('height')
    $("#menu-m ul").css('height', 0);
    $("#menu-m ul").css('visibility', 'visible');

    //$("#menu-m ul").slideDown("fast");

    $(".cover-material").click(function(event) {

        event.stopPropagation();

        // Slide down menu if hidden
        if (!expanded) {
            $("#filtrar-btn-menu").fadeIn("slow");
            $("#menu-m ul").animate({
                "height": original_height
            }, "slow");
            expanded = true;
        }
        // Slide up menu if shown
        else {
            $("#filtrar-btn-menu").fadeOut("slow");
            $("#menu-m ul").animate({
                "height": 0
            }, "slow");
            expanded = false;
        }

    });

    $("#menu-m").click(function(event) {
        event.stopPropagation();
    });

    $(document).click(function() {
        if (expanded) {
            $("#filtrar-btn-menu").fadeOut("slow");
            $("#menu-m ul").animate({
                "height": 0
            }, "slow");
            expanded = false;
        }
    });
    $(".cerrar-filtrar-btn-menu").click(function() {
        if (expanded) {
            $("#filtrar-btn-menu").fadeOut("fast");
            $("#menu-m ul").animate({
                "height": 0
            }, "fast");
            expanded = false;
        }
    });

    $(document).on('click', '.url_producto', function(){
        var name = $(this).attr('name');
        var id = $(this).attr('id');
        var category = $(this).attr('category');
        var brand = $(this).attr('brand');
        var variant = $(this).attr('variant');
        var tag = $(this).attr('tag');
        if ( document.location.href.indexOf("localhost:8502") == -1) {
            onProductClick(id, name, category, brand, variant, tag);
        }
    });
});

function onProductClick(id, name, category, brand, variant, tag) {
    ga('ec:addProduct', {
        'id': id,
        'name': name,
        'category': category,
        'brand': brand,
        'variant': variant
    });

    console.log('click tag ' + tag);

    ga('ec:setAction', 'click', {list: tag});

    ga('send', 'pageview');
}
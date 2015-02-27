$(document).ready(function(){

    $(".carritoicono").click(function(){
        if($(".carritoproductos").css("display")=="none"){
            $(".carritoproductos").slideDown();
        } else {
            $(".carritoproductos").slideUp();
        }
    });

    $("body").mouseup(function (e)
    {
        var container = $(".carritoproductos");

        if (!container.is(e.target) // if the target of the click isn't the container...
            && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            if(!$(".fancybox-overlay").length)
                container.slideUp();
        }
    });
    

    $("a.logout").click(function(){
        if(typeof(Storage) !== "undefined") {
            window.localStorage.setItem("user_id","0");
        }
    });


    var device_touch = false;

    try {
        document.createEvent("TouchEvent");
        device_touch = true;
    } catch (e) {
        device_touch = false;
    }

    if (!device_touch){
        $('.fancybox').fancybox({padding: 3, width: 600, href: $('.fancybox').attr('href') + '&ajax=0'});
    }

    $(document).on("click","button.eliminarproducto,a.borrarproducto",function(){
        var cart_id = $(this).attr("cart-id");
        var from_cart = $(this).hasClass("eliminarproducto");

        var ga_name = $(this).parent().find("p.nombreproductoencola").html();
        var ga_variant = $(this).parent().find("p.color").html().replace("color: ", " ");
        var ga_price = $(this).parent().find("p.precio").html().replace("$", " ").replace(".", "");
        var ga_quantity = $(this).parent().find("p.cantidad").html().replace("x", " ");

        $.ajax({
            url:"/cart/remove",
            data:"cart_id="+cart_id,
            cache: false,
            success:function(html){
                if(html=="ok"){
                    fancyAlert("Producto ha sido eliminado del carro");
                    if(from_cart){
                        GetCartByUserId(window.localStorage.getItem("user_id"));
                    } else {
                        location.reload();
                    }

                    ga('ec:addProduct', {
                        // 'id': ga_id,
                        'name': ga_name,
                        'brand': 'Giani Da Firenze',
                        // 'category': ga_category,
                        'variant': ga_variant,
                        'price': ga_price,
                        'quantity': ga_quantity,
                        // 'coupon': 'SUMMER2013',
                        // 'position': 1
                    });

                    ga('ec:setAction', 'remove');
                    ga('send', 'event', 'UX', 'click', 'remove from cart');

                } else {
                    fancyAlert(html);
                }
            }
        });
        
    });


    if($("#contenedor").length>0){
        if($(document).width()>480){
            $("body,html").animate({
                scrollTop: $("#contenedor").offset().top
            }, 1000);
        }
    }

    if($("div.userInfo").length>0){
        $("body,html").animate({
            scrollTop: $("div.userInfo").offset().top
        }, 1000);
    }

    if($("#user_id").length>0){
        $("#user_id").val(window.localStorage.getItem("user_id"));
    }

    $(document).on("click",".loginfb",function(e){

        e.preventDefault();

        var link = $(this).attr("href");

        location.href = link + "&user_id=" + $("#user_id").val();
    });

    $(document).on("click",".page-link",function(e){

        e.preventDefault();

        var url = $(this).attr("href");
        
        /*var parts = url.split("#");

        var uri = "";

        var query = "";

        if(parts.length){
            uri = url.split("#")[0].replace(/[?|&]/g,"&").replace("&","?");
        } else {
            uri = url.replace(/[?|&]/g,"&").replace("&","?");
            if(uri.indexOf("ajax")==-1){
                url = uri+"&ajax=1";    
            }
        }

        try{
            query = parts[1];
        } catch(e){
            console.info(e);
        }*/

        

            

        console.info(url);

        $.ajax({
            url: url,
            type: "get",
            cache: false,
            beforeSend: function(){
                $("#ajax_productos").addClass("disable");
            },
            success: function(respuesta){
                $(".paginador").pagination("destroy");
                $(".paginador").remove();
                $("#ajax_productos").html(respuesta).removeClass("disable").addClass("active"); //.delay(100).fadeIn(200);
                
                /*$("#ajax_productos").animate({
                        opacity: 1
                    }, 3000, function() {
                });*/
            }
        });

        return false;
    });

    if(typeof(Storage) !== "undefined") {

        if(!window.localStorage.getItem("user_id")){
            window.localStorage.setItem("user_id","0");
        } else {

            $.ajax({
                url: '/user/save-guess',
                cache: false,
                async: false,
                data: "user_id="+window.localStorage.getItem("user_id"),
                success: function(html){
                    var objeto = $.parseJSON(html);
                    if(objeto["success"]){
                        window.localStorage.setItem("user_id",objeto["success"].toString());
                    }
                }
            });
        }

        GetCartByUserId(window.localStorage.getItem("user_id"));
    }


    // codigo analytics
    // if ( document.location.href.indexOf("gianidafirenze.cl") != -1) {
    if ( document.location.href.indexOf("localhost:8502") != -1) { //Para trabajar en localhost
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-60108520-1', 'auto');
        ga('send', 'pageview');

        console.info("google analytics");
    }

    // Cuando hace click en tienda se realiza ga, luego se direcciona a la tienda
    $(".btn-tienda").on( "click", function()
    {

        ga('ec:addImpression', {
            // 'id': 'P12345',
            'name': 'Pagina Tienda',
            // 'list': 'Search Results',
            // 'brand': 'Giani Da Firenze',
            // 'category': 'Apparel/T-Shirts',
            // 'variant': 'black',
            // 'position': 1,
            // 'price': '',
        });

        ga('send', 'pageview');

        window.location.href='/store';
    });
});
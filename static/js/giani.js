$(document).ready(function(){

    $(".carritoicono").click(function(e)
    {
        e.preventDefault();
        if($(".carritoproductos").css("display")=="none"){
            $(".carritoproductos").slideDown();
        } else {
            $(".carritoproductos").slideUp();
        }
    });

    $("#region").countries({
        'city_selector':'#provincia',
        'town_selector':'#comuna'
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
            window.localStorage.setItem("userid","0");
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

/*        var ga_name = $(this).parent().find("p.nombreproductoencola").html();
        var ga_variant = $(this).parent().find("p.color").html().replace("color: ", " ");
        var ga_price = $(this).parent().find("p.precio").html().replace("$", " ").replace(".", "");
        var ga_quantity = $(this).parent().find("p.cantidad").html().replace("x", " ");*/

        $.ajax({
            url:"/cart/remove",
            data:"cart_id="+cart_id,
            cache: false,
            success:function(html){
                if(html=="ok"){
                    //fancyAlert("Producto ha sido eliminado del carro");
                    if(from_cart){
                        GetCartByUserId(window.localStorage.getItem("userid"));
                    } else {
                        location.reload();
                    }

                    /*if ( document.location.href.indexOf("localhost:8502") != -1) {
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
                    }*/
                    

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
        $("#user_id").val(window.localStorage.getItem("userid"));
    }

    $(document).on("click",".loginfb",function(e){

        e.preventDefault();

        var link = $(this).attr("href");

        location.href = link + "&user_id=" + $("#user_id").val();
    });

    $(document).on("click",".page-link",function(e){

        e.preventDefault();

        var uri = window.location.href.split("#")[0];

        document.location.href = uri + "#" + $(".simple-pagination span.current").first().text();

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

        

            

        // console.info(url);

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
                
                $("body,html").animate({
                    scrollTop: $("#contenedor").offset().top
                }, 1000);
            }
        });

        return false;
    });

    if(typeof(Storage) !== "undefined") {

        if(!window.localStorage.getItem("userid")){
            window.localStorage.setItem("userid","0");
        } else {

            $.ajax({
                url: '/user/save-guess',
                cache: false,
                async: false,
                data: "user_id="+window.localStorage.getItem("userid"),
                success: function(html){
                    var objeto = $.parseJSON(html);
                    if(objeto["success"]){
                        window.localStorage.setItem("userid",objeto["success"].toString());
                    }
                }
            });
        }

        GetCartByUserId(window.localStorage.getItem("userid"));
    }


    // codigo analytics

    if ( document.location.href.indexOf("gianidafirenze.cl") != -1) {
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-60108520-1', 'auto');
        ga('send', 'pageview');
        ga('require', 'ec');

        console.info("google analytics");
    }

    // Cuando hace click en tienda se realiza ga, luego se direcciona a la tienda
    $(".btn-tienda").on( "click", function()
    {

        if ( document.location.href.indexOf("gianidafirenze.cl") != -1) {

            ga('send', 'pageview', {
              page: '/store',
              title: 'Tienda'
            });

            console.log("send page view pagina tienda");

        }

        window.location.href='/store';
    });

    $(document).on("change", "input[type=radio][name=shipping_type]", function(){
        if($(this).is(':checked')){
            if($(this).val()==='chilexpress'){
                $("#InputCity").trigger("change");
                $("div.domicilio").fadeOut("slow", function(){
                    $("div.chilexpress").fadeIn();
                });
                $("div.domicilio > div").removeClass("required");
                $("div.chilexpress > div").addClass("required");
            } else {
                $("div.chilexpress").fadeOut("slow", function(){
                    $("div.domicilio").fadeIn();
                });
                $("div.domicilio > div").addClass("required");
                $("div.chilexpress > div").removeClass("required");
            }
        }
    });

    $("#manualPaymentForm").on("submit", function(e){
        e.preventDefault();

        var form = $(this);
        var contact = $("input[name=contact]").val();
        if(contact===undefined||contact.trim()===''){
            alert("Debe ingresar un email o un tel\xE9fono");
        } else {
            $.ajax({
                url: form.attr("action"),
                type: "post",
                dataType: "json",
                data: form.serialize(),
                success: function(response){
                    var json_str = JSON.stringify(response);
                    var json_obj = $.parseJSON(json_str);
                    if(json_obj[0].status!==undefined){
                        if(json_obj[0].status==='sent'){
                            alert("Gracias por contactarnos, pronto una ejecutiva se comunicar\xE1 contigo");
                        } else {
                            alert("Ha ocurrido un error al intentar enviar contacto, por favor reintenta m\xE1s tarde");
                        }
                    } else {
                        alert("Ha ocurrido un error al intentar enviar contacto, por favor reintenta m\xE1s tarde");
                    }
                }
            });
        }
    });

});

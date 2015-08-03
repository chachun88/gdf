$(document).ready(function(){


    //fancyAlert("holi");

    $("button.add-to-cart-wholesaler").click(function(){

        var product_id = $(this).attr('product-id');

        $('input[name=quantity]').each(function(index, value){

            var quantity = $(this).val();
            var size = $(this).attr('size');

            // Obtencion de datos para ga
            var datos_analytics = $("div.datos-analytic");
            var ga_tag = $(".ga-tag", datos_analytics).html();
            var ga_id = $(".ga-id", datos_analytics).html();
            var ga_name = $(".ga-name", datos_analytics).html();
            var ga_category = $(".ga-category", datos_analytics).html();
            var ga_variant = $(".ga-variant", datos_analytics).html();
            var ga_price = $(".ga-price", datos_analytics).html();
            ga_price = ga_price * quantity;

            $.ajax({
                url:"/cart/add",
                cache: false,
                data:"product_id="+product_id+"&size="+size+"&quantity="+quantity+"&user_id="+window.localStorage.getItem("userid"),
                success:function(html){
                    if(html!="ok"){
                        fancyAlert(html);
                    } else {
                        GetCartByUserId(window.localStorage.getItem("userid"));
                        //fancyAlert("Producto ha sido a\xF1adido al carro");
                        $("#icono-carro-movil").addClass("parpadea");

                        if($(window).width()>460){
                            $('html,body').animate({ scrollTop: 0 }, 'slow');
                            if($(".carritoproductos").css("display")=="none"){
                                $(".carritoproductos").slideDown();
                            }
                        }
                        if ( document.location.href.indexOf("localhost:8502") == -1) {
                            ga('ec:addProduct', {
                                'id': ga_id,
                                'name': ga_name,
                                'brand': 'Giani Da Firenze',
                                'category': ga_category,
                                'variant': ga_variant,
                                'price': ga_price,
                                'quantity': quantity,
                                'list': ga_tag
                                // 'position': 1
                            });

                            ga('ec:setAction', 'add');
                            ga('send', 'event', 'UX', 'click', 'add to cart');

                            console.log("add to cart");
                        }
                    }
                }
            });
        });
    });

    $("button.add-to-cart").click(function(){
        var product_id = $(this).attr("product-id");
        var size = $("#size").val();
        var quantity = $("#quantity").val();

        // Obtencion de datos para ga
        var datos_analytics = $("div.datos-analytic");
        var ga_tag = $(".ga-tag", datos_analytics).html();
        var ga_id = $(".ga-id", datos_analytics).html();
        var ga_name = $(".ga-name", datos_analytics).html();
        var ga_category = $(".ga-category", datos_analytics).html();
        var ga_variant = $(".ga-variant", datos_analytics).html();
        var ga_price = $(".ga-price", datos_analytics).html();
        ga_price = ga_price * quantity;

        $.ajax({
            url:"/cart/add",
            cache: false,
            data:"product_id="+product_id+"&size="+size+"&quantity="+quantity+"&user_id="+window.localStorage.getItem("userid"),
            success:function(html){
                if(html!="ok"){
                    fancyAlert(html);
                } else {
                    GetCartByUserId(window.localStorage.getItem("userid"));
                    //fancyAlert("Producto ha sido a\xF1adido al carro");
                    $("#icono-carro-movil").addClass("parpadea");

                    if($(window).width()>460){
                        $('html,body').animate({ scrollTop: 0 }, 'slow');
                        if($(".carritoproductos").css("display")=="none"){
                            $(".carritoproductos").slideDown();
                        }
                    }
                    if ( document.location.href.indexOf("localhost:8502") == -1) {
                        ga('ec:addProduct', {
                            'id': ga_id,
                            'name': ga_name,
                            'brand': 'Giani Da Firenze',
                            'category': ga_category,
                            'variant': ga_variant,
                            'price': ga_price,
                            'quantity': quantity,
                            'list': ga_tag
                            // 'position': 1
                        });

                        ga('ec:setAction', 'add');
                        ga('send', 'event', 'UX', 'click', 'add to cart');

                        console.log("add to cart");
                    }
                }
            }
        });
    });

    var size_changed = function(){
        var sku = $(this).attr("sku");
        var size = $(this).val();
        $.ajax({
            url:"/kardex/getunitsbysize",
            cache: false,
            data:"sku="+sku+"&size="+size,
            success:function(html){
                if(html.indexOf("error") > -1){
                    fancyAlert(html);
                    $("#quantity").empty();
                    var total_unidades = parseInt(html);
                    $("#quantity").append($("<option></option>").attr("value",0).text(0));
                } else {
                    $("#quantity").empty();
                    var total_unidades = parseInt(html);
                    for (i = 1; i <= total_unidades; i++) {
                        $("#quantity").append($("<option></option>").attr("value",i).text(i));
                    }
                }
            }
        });
    };

    $("#size").change(size_changed);
    $("#size").trigger( "change" );

    //$("#size").ready(size_changed);


    if($("input[name='quanitySniper']").length){
        $("input[name='quanitySniper']").TouchSpin({
            buttondown_class: "btn btn-link",
            buttonup_class: "btn btn-link"
        });
    }

    if($("select#address").length){

        GetAddressById($("select#address").val());

        $("select#address").change(function(){
            if($("select#address").val()!=""){
                _id = $(this).val();
                GetAddressById(_id);
            }
        });     
    }

    $("#same_address").change(function(){
        var checked = $("#same_address:checked").val();
        if(checked=="on"){
            $("#formulario_direccion").fadeOut();
        } else {
            $("#formulario_direccion").fadeIn();
        }
    });

    $("#same_address").trigger("change");

    $("img.otro-angulo").click(function(){
        var image_src = $(this).attr("data-src");
        $("img.foto-producto").attr("src",image_src);
    });

    $("ul.tabs-menu-li li:first a").addClass("active").trigger("click");

    // boton del step 3
    $(".btn-resumen").on( "click", function(evt)
    {
        evt.preventDefault();
        if ( document.location.href.indexOf("localhost:8502") == -1) {
            googleAnalyticsCheckout();
        }
        $("#form-resumen").submit();
    });

    // boton del step 4
    $(".btn-pago").on( "click", function(evt)
    {
        evt.preventDefault();
        if ( document.location.href.indexOf("localhost:8502") == -1) {
            googleAnalyticsCheckout();
        }
        $("#form-pago").submit();
    });

    // boton del step 5
    $(".btn-pagar").on( "click", function(evt)
    {
        evt.preventDefault();
        // payment();
        $("#form-pagar").submit();
    });

    $("input[name='quantity']").TouchSpin({
        verticalbuttons: true,
        verticalupclass: 'glyphicon glyphicon-plus',
        verticaldownclass: 'glyphicon glyphicon-minus',
        min: 1
    }).on('change', function() {
        var precio = parseInt($(this).attr('price'));
        var quantity = parseInt($(this).val());
        var fila = $(this).closest('tr').find('.subtotal');

        var subtotal = precio * quantity;

        fila.text(subtotal.formatMoney(0));

        // $.ajax({
        //     type: 'post',
        //     url: '/cart/update',
        //     data: 'cart_id=' + cart_id + '&quantity=' + quantity,
        //     dataType: 'json',
        //     success: function(response) {
        //         var response_json = $.parseJSON(JSON.stringify(response));
        //         if ("error" in response_json) {
        //             alert(response_json["error"]);
        //         } else {
        //             $('#total-price').text('$ ' + response["success"]["total"]);
        //             $('.sum-subtotal').text('$ ' + response["success"]["total"]);
        //             $('.subtotal.' + cart_id).text('$ ' + response["success"]["subtotal"]);
        //         }
        //     }
        // });
    });

});

var fancyAlert = function(msg) {


    var html = "<div class=\"iconosalarmas\">"
             + "<i class=\"\"></i>"
             + "</div>"
             +"<div style=\"width: 100%; height: 100%; margin:0px;width:240px;text-align:center;\">"
             + msg
             + "<div style=\"margin-top: 40px; text-align:center; width: 100%;\">"
             + "<input style=\"text-transform:uppercase;background-color: #d55d7c;margin:0px;padding:5px;width:70%; height: 40px; border: 1px solid white; color: white; font-size: 15px;\" type=\"button\" onclick=\"jQuery.fancybox.close();\" value=\"Cerrar\">"
             + "</div>"
             + "</div>";

    jQuery.fancybox({
        'modal' : true,
        'content' : html
      

    });
}

var fancyAlertStock = function(msg) {


    var html = "<div class=\"iconosalarmas\">"
             + "<i class=\"\"></i>"
             + "</div>"
             +"<div style=\"width: 100%; height: 100%; margin:0px;width:240px;text-align:center;\">"
             + msg
             + "<div style=\"text-align:center;margin-top:15px; width: 100%;\">"
             + "<input style=\"text-transform:uppercase;background-color: rgb(198, 198, 198);margin:0px;padding:5px;width:70%; height: 40px; border: 1px solid white; color: white; font-size: 15px;\" type=\"button\" onclick=\"location.href='/auth/checkout?next=/checkout/address';\" value=\"Pagar\">"
             + "<input style=\"text-transform:uppercase;background-color: rgb(198, 198, 198);margin:0px;padding:5px;width:70%; height: 40px; border: 1px solid white; color: white; font-size: 15px;\" type=\"button\" onclick=\"location.href='/store';\" value=\"Seguir comprando\">"
             + "</div>"
             + "</div>";

    jQuery.fancybox({
        'modal' : true,
        'content' : html
    });
}

var GetCartByUserId = function(){

    if(Storage !== "undefined") {

        if(!window.localStorage.getItem("user_id")){
            window.localStorage.setItem("user_id","0");
        } else {

            $.ajax({
                cache: false,
                url:"/cart/getbyuserid",
                data:"user_id="+window.localStorage.getItem("user_id"),
                success: function(html){
                    if(html.indexOf("error") > -1 )
                        fancyAlert("Se produjo un error al intentar obtener el carro de compra");
                    else
                        $(".carritoproductos").html(html);
                }
            });
        }
    }
}

var ValidateCheckoutPayment = function(){
    var checked = $('#checkboxes-1:checked').val();

    if(checked==undefined){
        fancyAlert("Debe aceptar t\xE9rminos y condiciones");
        return false;
    }

    return true;
}

var ValidateTerms = function(){
    var checked = $('#term-1:checked').val();

    if(checked==undefined){
        fancyAlert("Debe aceptar los t\xE9rminos y condiciones");
        return false;
    }

    return true;
}

var GetAddressById = function(_id){
    $.ajax({
        url:"/checkout/getaddressbyid",
        data:"id="+_id,
        cache: false,
        success: function(html){
            var obj = jQuery.parseJSON( html );

            if(obj){

                if(obj.success){
                    $("#InputAddress").val(obj.success.address);
                    $("#InputCity").val(obj.success.city_id);
                    $('#InputCity').trigger('change');
                    $("#InputZip").val(obj.success.zip_code);
                    $("#InputMobile").val(obj.success.telephone);
                    $("#InputEmail").val(obj.success.email);
                    $("#InputLastName").val(obj.success.lastname);
                    $("#InputName").val(obj.success.name);
                    $("#InputTown").val(obj.success.town);
                    $("#InputRut").val(obj.success.rut);
                } else {
                    alert(obj.error);
                }

            }
        }
    });
}

var ValidateRequired = function(id_formulario){
    var valid = true;
    $("div.required :text, div.required textarea",$("#"+id_formulario)).each(function(){
        var valor = $(this).val().trim();

        if(valor==""){
            valid = false;
        }
    });

    if(!valid){
        fancyAlert("Debe llenar todos los campos requeridos");
    }

    return valid;
}

var enviarFormulario = function(id_formulario){

    var same_address = false;

    if($("#same_address").length){
        if($("#same_address:checked").val()=="on"){
            same_address = true;
        }
    }

    if(!same_address){
        if(ValidateRequired(id_formulario)){
            /*googleAnalyticsCheckout();*/
            $("#"+id_formulario).submit();
        }
    } else {
        /*googleAnalyticsCheckout();*/
        $("#"+id_formulario).submit();
    }

}

var votar = function(product_id){

    if($(".fotomegusta").hasClass("enabled")){

        $.ajax({
            url:"/store/voteproduct",
            cache: false,
            data: "product_id="+product_id+"&user_id="+window.localStorage.getItem("user_id"),
            success: function(html){
                response = $.parseJSON(html)
                if(response.error){
                    fancyAlert(response.error);
                } else {
                    $(".fotomegusta img").attr("src","/static/images/corazon2.png");
                    getvotes(product_id);
                }
            }
        });
    }
}

var ifvoted = function(product_id){
    $.ajax({
        url:"/store/product/ifvoted",
        cache: false,
        data: "product_id="+product_id+"&user_id="+window.localStorage.getItem("user_id"),
        success: function(html){
            response = $.parseJSON(html)
            if(response.success){
                $(".fotomegusta").removeClass("enabled");
                $(".fotomegusta img").attr("src","/static/images/corazon2.png");
            }
        }
    });
}

var getvotes = function(product_id){
    $.ajax({
        url:"/store/product/getvotes",
        data: "product_id="+product_id,
        cache: false,
        success: function(html){
            response = $.parseJSON(html)
            if(response.success){
                $("#votes-quantity").html(response.success);
            }
        }
    });
};

var filtrar = function(object){
    $.ajax({
        url: object.attr("action"),
        type: object.attr("method"),
        cache: false,
        data: object.serialize(),
        success: function(res){
            //response = $.parseJSON(JSON.stringify(res));
            $("#ajax_productos").html(res);
            $("#ajax_productos").css("display","none");
            $("#ajax_productos").fadeIn("slow");
        
        }
    });

    //console.info("log");
};

var checkStock = function(){

    $.ajax({
        url: "/checkout/checkstock",
        data: "user_id=" + window.localStorage.getItem("user_id"),
        dataType: "json",
        type: "get",
        async: false,
        success: function(html){

            response_str = JSON.stringify(html);
            response = $.parseJSON(response_str);
            if(response.error){
                errores = response.error;

                res = "";

                for(var i = 0; i < errores.length; i++){
                    res += errores[i]["sku"] + " "+ errores[i]["error"] + "<br/>";
                }

                fancyAlert(res);

            } else {
                location.href = '/auth/checkout?next=/checkout/address';
            }
        }
    });
};

var enterpriseRegistration = function(form){
    var nombre = $("input[name=name]", form);
    var giro = $("input[name=bussiness]", form);
    var rut = $("input[name=rut]", form);
    var email = $("input[name=email]", form);
    var direccion = $("input[name=address]", form);
    var region = $("select[name=select-state] option:selected", form);
    var provincia = $("select[name=select-city] option:selected", form);
    var comuna = $("select[name=select-town] option:selected", form);
    var clave = $("input[name=password]", form);
    var rep_clave = $("input[name=re-password]", form);

    if(nombre.val()==""){
        nombre.addClass("alert-danger");
    } else if(giro.val()==""){
        giro.addClass("alert-danger");
    } else if(rut.val()==""){
        rut.addClass("alert-danger");
    } else if(email.val()==""){
        email.addClass("alert-danger");
    } else if(direccion.val()==""){
        direccion.addClass("alert-danger");
    } else if(region.val()==""){
        region.addClass("alert-danger");
    } else if(provincia.val()==""){
        provincia.addClass("alert-danger");
    } else if(comuna.val()==""){
        comuna.addClass("alert-danger");
    } else if(clave.val()==""){
        clave.addClass("alert-danger");
    } else if(clave.val()!=rep_clave.val()){
        clave.addClass("alert-danger");
        rep_clave.addClass("alert-danger");
    } else {
        $("input[name=state]", form).val(region.text());
        $("input[name=city]", form).val(provincia.text());
        $("input[name=town]", form).val(comuna.text());
        
        $.ajax({
            url: form.attr("action"),
            data: form.serialize(),
            type: form.attr("method"),
            dataType: "json",
            success: function(html){
                response_str = JSON.stringify(html);
                response = $.parseJSON(response_str);
                if(response.error){
                    alert(response.error);
                } else {
                    alert("Gracias por registrate. Pronto nos contactaremos contigo");
                }
            }
        })   
    }
};
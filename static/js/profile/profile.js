$(document).ready(function(){
    
    $(".formulario-contrasena").hide();
    $(".formulario-contacto").hide();

    $(".btn-cambiar-contrasena").click(function(){
        $(this).hide();
        $(".formulario-contrasena").show();
    });

    $(".btn-cancelar-cambio-contrasena").click(function(){
        $(".formulario-contrasena").hide();
        $(".btn-cambiar-contrasena").show();
    });

    $(".btn-guardar-contrasena").click(function(evt){

        evt.preventDefault();
        var data = $("form.cambiar-contrasena").serialize();

        $.ajax({
            url: "/profile/change_pass",
            type: "post",
            data: data,
            success: function(html){
                alert(html);
            }
        });

    });

    $(".btn-editar-contacto").click(function(){
        var id = $(this).parent().parent().attr("id-contacto");
        var name = $(this).parent().parent().attr("name");
        var address = $(this).parent().parent().attr("address");
        var town = $(this).parent().parent().attr("town");
        var city = $(this).parent().parent().attr("city");
        var zipcode = $(this).parent().parent().attr("zipcode");
        var telephone = $(this).parent().parent().attr("telephone");
        
        $(".formulario-contacto #name").val(name);
        $(".formulario-contacto #address").val(address);
        $(".formulario-contacto #town").val(town);
        $(".formulario-contacto #city").val(city);
        $(".formulario-contacto #zip-code").val(zipcode);
        $(".formulario-contacto #telephone").val(telephone);
        $(".contactos").hide();
        $(".formulario-contacto").show();
    });

    $(".btn-cancelar-editar-contacto").click(function(){
        $(".formulario-contacto").hide();
        $(".contactos").show();
    });

    $(".btn-guardar-contacto").click(function(evt){

        evt.preventDefault();
        var data = $("form.editar-contacto").serialize();

        $.ajax({
            url: "/profile/edit_contact",
            type: "post",
            data: data,
            success: function(html){
                alert(html);
            }
        });

    });
});
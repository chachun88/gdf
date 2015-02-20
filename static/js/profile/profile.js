$(document).ready(function(){
    
    $(".formulario-contrasena").hide();
    $(".formulario-direccion").hide();

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

});
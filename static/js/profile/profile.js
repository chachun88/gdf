$(document).ready(function(){
    
    $(".campo-contrasena").hide();

    $(".btn-cambiar-contrasena").click(function(){
        $(this).hide();
        $(".campo-contrasena").show();
    });

    $(".btn-cancelar-cambio-contrasena").click(function(){
        $(".campo-contrasena").hide();
        $(".btn-cambiar-contrasena").show();
    });
});
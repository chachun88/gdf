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
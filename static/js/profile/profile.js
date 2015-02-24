$(document).ready(function(){

    // Funcion que limpia todos los formulario 
    var limpiarFormulario = function(){
        $("#oldpass").val("");
        $("#newpass").val("");
        $("#confirmpass").val("");
        $("#id-contacto").val("");
        $("#name").val("");
        $("#address").val("");
        $("#town").val("");
        $("#city").val("");
        $("#zip-code").val("");
        $("#telephone").val("");
    };

    // Al cargar la pagina los formulario deben quedar oculto
    $(".formulario-contrasena").hide();
    $(".formulario-contacto").hide();

    // Muestra el formulario para cambiar clave y oculta el boton
    $(".btn-cambiar-contrasena").on( "click", function()
    {
        $(this).hide();
        $(".formulario-contrasena").show();
    });

    // Oculta el formulario y muestra el boton para cambiar clave
    $(".btn-cancelar-cambio-contrasena").on( "click", function(evt)
    {
        evt.preventDefault();

        $(".formulario-contrasena").hide();
        $(".btn-cambiar-contrasena").show();
    });

    /* Manda los claves al handler, ahi es donde se valida 
     * Si tiene exito, limpia los formularios y cierra el formulario
     */
    $(".btn-guardar-contrasena").on( "click", function(evt)
    {
        evt.preventDefault();

        var data = $("form.cambiar-contrasena").serialize();

        $.ajax({
            url: "/profile/change_pass",
            type: "post",
            data: data,
            success: function(html)
            {
                limpiarFormulario();
                fancyAlert(html);

                if(html == "El cambio fue exitoso")
                {
                    $(".formulario-contrasena").hide();
                    $(".btn-cambiar-contrasena").show();
                }
            }
        });

    });

    $(".btn-editar-contacto").on( "click", function()
    {
        var id = $(this).parent().parent().attr("id-contacto");
        var name = $("#name-" + id).html();
        var address = $("#address-" + id).html();
        var town = $("#town-" + id).html();
        var city = $("#city-" + id).attr("id-ciudad");
        var zipcode = $("#zip-code-" + id).html();
        var telephone = $("#telephone-" + id).html();

        $("#id-contacto").val(id);
        $("#name").val(name);
        $("#address").val(address);
        $("#town").val(town);
        $("#city").val(city);
        $("#zip-code").val(zipcode);
        $("#telephone").val(telephone);
        
        $(".contactos").hide();
        $(".formulario-contacto").show();
    });

    $(".btn-cancelar-editar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        $(".formulario-contacto").hide();
        $(".contactos").show();
    });

    $(".btn-guardar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        var id = $("#id-contacto").val();
        var name = $("#name").val();
        var address = $("#address").val();
        var town = $("#town").val();
        var city = $("#city").val();
        var zipcode = $("#zip-code").val();
        var telephone = $("#telephone").val();

        var ciudad = document.getElementById("city-" + id);

        var data = $("form.editar-contacto").serialize();

        $.ajax({
            url: "/profile/edit_contact",
            type: "post",
            data: data,
            async: false,
            success: function(html)
            {
                var obj = jQuery.parseJSON( html );

                if(obj.success)
                {
                    $("#name-" + id).html(name);
                    $("#address-" + id).html(address);
                    $("#town-" + id).html(town);
                    $("#city-" + id).html(obj.success.name);
                    $("#zip-code-" + id).html(zipcode);
                    $("#telephone-" + id).html(telephone);

                    ciudad.setAttribute("id-ciudad", city);
                    limpiarFormulario();

                    $(".formulario-contacto").hide();
                    $(".contactos").show();

                    fancyAlert("El cambio fue exitoso");
                }
                else
                {
                    fancyAlert("No es posible realizar el cambio");
                }
            }
        });
    });

    $(".btn-eliminar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        var fila_tabla = $(this).parent().parent();

        if(confirm("Estas seguro de que desea eliminar este contacto?"))
        {
            var id = fila_tabla.attr("id-contacto");

            $.ajax({
                url: "/profile/delete?id=" + id,
                type: "post",
                success: function(html)
                {
                    if (html =="El contacto fue eliminado exitosamente")
                        fila_tabla.remove();
                    fancyAlert(html);
                }
            });
        }
    });
});

$(document).ready(function(){

    // Funcion que limpia todos los formulario 
    var limpiarFormulario = function(){
        $("#oldpass").val("");
        $("#newpass").val("");
        $("#confirmpass").val("");
        $(".formulario-contacto #id-contacto").val("");
        $(".formulario-contacto #name").val("");
        $(".formulario-contacto #address").val("");
        $(".formulario-contacto #town").val("");
        $(".formulario-contacto #city").val("");
        $(".formulario-contacto #zip-code").val("");
        $(".formulario-contacto #telephone").val("");
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
        var city = $("#city-" + id).html();
        var zipcode = $("#zip-code-" + id).html();
        var telephone = $("#telephone-" + id).html();

        $(".formulario-contacto #id-contacto").val(id);
        $(".formulario-contacto #name").val(name);
        $(".formulario-contacto #address").val(address);
        $(".formulario-contacto #town").val(town);
        $(".formulario-contacto #city").val(city);
        $(".formulario-contacto #zip-code").val(zipcode);
        $(".formulario-contacto #telephone").val(telephone);
        
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

        var id = $(".formulario-contacto #id-contacto").val();
        var name = $(".formulario-contacto #name").val();
        var address = $(".formulario-contacto #address").val();
        var town = $(".formulario-contacto #town").val();
        var city = $(".formulario-contacto #city").val();
        var zipcode = $(".formulario-contacto #zip-code").val();
        var telephone = $(".formulario-contacto #telephone").val();

        var data = $("form.editar-contacto").serialize();

        $.ajax({
            url: "/profile/edit_contact",
            type: "post",
            data: data,
            async: false,
            success: function(html)
            {
                if(html == "El cambio fue exitoso")
                {
                    $("#name-" + id).html(name);
                    $("#address-" + id).html(address);
                    $("#town-" + id).html(town);
                    $("#city-" + id).html(city);
                    $("#zip-code-" + id).html(zipcode);
                    $("#telephone-" + id).html(telephone);
                    
                    limpiarFormulario();

                    $(".formulario-contacto").hide();
                    $(".contactos").show();
                }

                fancyAlert(html);
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

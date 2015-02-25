$(document).ready(function()
{
    // Funcion que limpia todos los formulario 
    var limpiarFormulario = function()
    {
        // Los campos de formulario contrasena
        $("#oldpass").val("");
        $("#newpass").val("");
        $("#confirmpass").val("");

        // Los campos de formulario contacto
        $("#id-contacto").val("");
        $("#name").val("");
        $("#address").val("");
        $("#town").val("");
        $("#city").val("");
        $("#zip-code").val("");
        $("#telephone").val("");

        // Los campos de formulario agregar contacto
        $("#InputName").val("");
        $("#InputLastName").val("");
        $("#InputEmail").val("");
        $("#InputRut").val("");
        $("#InputAddress").val("");
        $("#InputTown").val("");
        $("#InputCity").val("");
        $("#InputZip").val("");
        $("#InputAdditionalInformation").val("");
        $("#InputMobile").val("");
    };

    // Al cargar la pagina los formulario deben quedar oculto
    $(".formulario-contrasena").hide();
    $(".formulario-contacto").hide();
    $(".formulario-agregar-contacto").hide();


    // Muestra el formulario para cambiar clave y oculta el boton
    $(".btn-cambiar-contrasena").on( "click", function()
    {
        $(this).hide();
        $(".formulario-contrasena").show();
    });

    /* Manda los claves al handler, ahi es donde se valida 
     * Si tiene exito, limpia los formularios y cierra el formulario
     */
    $(".btn-guardar-contrasena").on( "click", function(evt)
    {
        evt.preventDefault();

        var vacio = false;

        $(".contrasena-requerido").each(function() {
            if ($( this ).val()==="")
                vacio = true;
        });

        if(!vacio)
        {
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
        }
        else
        {
            limpiarFormulario();
            fancyAlert("Debes completar todos los campos");
        }
    });

    // Oculta el formulario y muestra el boton para cambiar clave
    $(".btn-cancelar-cambio-contrasena").on( "click", function(evt)
    {
        evt.preventDefault();

        $(".formulario-contrasena").hide();
        $(".btn-cambiar-contrasena").show();
    });

    $(document).on( "click", ".btn-editar-contacto", function()
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

    $(".btn-guardar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        var vacio = false;

        $(".dato-requerido").each(function() {
            if ($( this ).val()==="")
                vacio = true;
        });

        if(!vacio)
        {
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
        }
        else
        {
            fancyAlert("Debes completar todos los campos");
        }
    });

    $(".btn-cancelar-editar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        $(".formulario-contacto").hide();
        $(".contactos").show();
    });

    $(".btn-agregar-contacto").on( "click", function()
    {
        $(this).hide();
        $(".tabla").hide();
        $(".formulario-agregar-contacto").show();
    });

    $(".btn-cancelar-agregar-contacto").on( "click", function(evt)
    {
        evt.preventDefault();

        limpiarFormulario();
        $(".btn-agregar-contacto").show();
        $(".tabla").show();
        $(".formulario-agregar-contacto").hide();
    });

    $(".btn-agregar").on( "click", function(evt)
    {
        evt.preventDefault();
        var vacio = false;

        $(".info-requerido").each(function() {
            if ($( this ).val()==="")
                vacio = true;
        });

        if(!vacio)
        {
            var name = $("#InputName").val();
            var address = $("#InputAddress").val();
            var town = $("#InputTown").val();
            var city = $("#InputCity").val();
            var zipcode = $("#InputZip").val();
            var telephone = $("#InputMobile").val();

            var data = $("form.agregar-contacto").serialize();

            $.ajax({
                url: "/profile/add_contact",
                type: "post",
                data: data,
                async: false,
                success: function(html)
                {

                    // if(obj.success)
                    // {
                    //     var city_name = obj.success.name;
                    //     var id = obj.success.id_contact;

                    //     var nuevafila = "<tr class=\"contactos\" id-contacto=\"";
                    //     nuevafila += id + "\">";
                    //     nuevafila += "<td id=\"name-" + id + "\">" + name + "</td>";
                    //     nuevafila += "<td id=\"address-" + id + "\">" + address + "</td>";
                    //     nuevafila += "<td id=\"town-" + id + "\">" + town + "</td>";
                    //     nuevafila += "<td id=\"city-" + id + "\" id-ciudad=\"" + city + "\">" + city_name + "</td>";
                    //     nuevafila += "<td id=\"zip-code-" + id + "\">" + zipcode + "</td>";
                    //     nuevafila += "<td id=\"telephone-" + id + "\">" + telephone + "</td>";
                    //     nuevafila += "<td><button class=\"btn-editar-contacto\">Editar</button></td>";
                    //     nuevafila += "<td><button class=\"btn-eliminar-contacto\">Eliminar</button></td>";
                    //     nuevafila += "</tr>";

                    $(".tabla").append(html);

                    limpiarFormulario();
                    $(".btn-agregar-contacto").show();
                    $(".tabla").show();
                    $(".formulario-agregar-contacto").hide();

                    fancyAlert("El contacto ha sido agregado correctamente");
                    // }
                    // else
                    // {
                    //     fancyAlert("No es posible agregar el contacto");
                    // }
                }
            });
        }
        else
        {
            fancyAlert("Debes completar los campos requeridos");
        }
    });
});

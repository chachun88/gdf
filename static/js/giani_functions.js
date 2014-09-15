var GetCartByUserId = function(user_id){

	$.ajax({
		url:"/cart/getbyuserid",
		data:"user_id="+user_id,
		success: function(html){
			if(html.indexOf("error") > -1 )
				alert("Se produjo un error al intentar obtener el carro de compra");
			else
				$(".carritoproductos").html(html);
		}
	});
}

var GetAddressById = function(_id){
	$.ajax({
		url:"/contact/getbyid",
		data:"id="+_id,
		success: function(html){
			if(html!="error"){
				var obj = jQuery.parseJSON( html );
				$("#InputAddress").val(obj.address);
				$("#InputCity").val(obj.city);
				$("#InputZip").val(obj.zip_code);
				$("#InputMobile").val(obj.telephone);
				$("#InputEmail").val(obj.email);
				$("#InputLastName").val(obj.lastname);
				$("#InputName").val(obj.name)
			}
		}
	});
}

var ValidateRequired = function(id_formulario){
	var valid = true;
	$("div.required :input").each(function(){
		var valor = $(this).val().trim();
		if(valor==""){
			valid = false;
		}
	});

	if(!valid){
		alert("Debe llenar todos los campos requeridos");
	}

	return valid;
}

var enviarFormulario = function(id_formulario){

	if(ValidateRequired(id_formulario)){
		$("#"+id_formulario).submit();
	}

	return false;
}
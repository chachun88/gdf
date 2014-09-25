var fancyAlert = function(msg) {


	var html = "<div style=\"margin:1px;width:240px;\">"
	         + msg
	         + "<div style=\"text-align:right;margin-top:10px;\">"
	         + "<input style=\"margin:3px;padding:0px;\" type=\"button\" onclick=\"jQuery.fancybox.close();\" value=\"Cerrar\">"
	         + "</div>"
	         + "</div>";

    jQuery.fancybox({
        'modal' : true,
        'content' : html
    });
}


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

var ValidateCheckoutPayment = function(){
	var checked = $('#checkboxes-1:checked').val()
	var comprobante = $("#comprobante").val().trim();

	if(checked==undefined||comprobante==""){
		alert("Debe ingresar comprobante y aceptar t\xE9rminos y condiciones");
		return false;
	}

	return true;
}

var GetAddressById = function(_id){
	$.ajax({
		url:"/checkout/getaddressbyid",
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

var votar = function(product_id){

	if($(".fotomegusta").hasClass("enabled")){

		$.ajax({
			url:"/store/voteproduct",
			data: "product_id="+product_id+"&user_id="+localStorage.user_id,
			success: function(html){
				response = $.parseJSON(html)
				if(response.error){
					alert(response.error);
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
		data: "product_id="+product_id+"&user_id="+localStorage.user_id,
		success: function(html){
			response = $.parseJSON(html)
			console.log(response.success);
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
		success: function(html){
			response = $.parseJSON(html)
			if(response.success){
				$("#votes-quantity").html(response.success);
			}
		}
	});
}
var fancyAlert = function(msg) {


	var html = "<div class=\"iconosalarmas\">"
			 + "<i class=\"icon-exclamation-sign\"></i>"
			 + "</div>"
			 +"<div style=\"width: 100%; height: 100%; margin:0px;width:240px;text-align:center;\">"
	         + msg
	         + "<div style=\"text-align:center;margin-top:15px; width: 100%;\">"
	         + "<input style=\"text-transform:uppercase;background-color: rgb(198, 198, 198);margin:0px;padding:5px;width:70%; height: 40px; border: 1px solid white; color: white; font-size: 15px;\" type=\"button\" onclick=\"jQuery.fancybox.close();\" value=\"Cerrar\">"
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
				fancyAlert("Se produjo un error al intentar obtener el carro de compra");
			else
				$(".carritoproductos").html(html);
		}
	});
}

var ValidateCheckoutPayment = function(){
	var checked = $('#checkboxes-1:checked').val();
	var comprobante = $("#comprobante").val().trim();

	if(checked==undefined||comprobante==""){
		fancyAlert("Debe ingresar comprobante y aceptar t\xE9rminos y condiciones");
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
		success: function(html){
			var obj = jQuery.parseJSON( html );

			//console.log(obj);

			if(obj){

				if(obj.success){
					$("#InputAddress").val(obj.success.address);
					$("#InputCity").val(obj.success.city);
					$("#InputZip").val(obj.success.zip_code);
					$("#InputMobile").val(obj.success.telephone);
					$("#InputEmail").val(obj.success.email);
					$("#InputLastName").val(obj.success.lastname);
					$("#InputName").val(obj.success.name);
					$("#InputTown").val(obj.success.town);
				} else {
					alert(obj.error);
				}

			}
		}
	});
}

var ValidateRequired = function(id_formulario){
	var valid = true;
	$("div.required :text, div.required textarea").each(function(){
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
			$("#"+id_formulario).submit();
		}
	} else {
		$("#"+id_formulario).submit();
	}

}

var votar = function(product_id){

	if($(".fotomegusta").hasClass("enabled")){

		$.ajax({
			url:"/store/voteproduct",
			data: "product_id="+product_id+"&user_id="+localStorage.user_id,
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
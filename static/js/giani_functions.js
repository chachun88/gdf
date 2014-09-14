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
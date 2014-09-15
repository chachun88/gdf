$(document).ready(function(){
	$("button.add-to-cart").click(function(){
		var product_id = $(this).attr("product-id");
		var size = $("#size").val()
		var quantity = $("#quantity").val()
		$.ajax({
			url:"/cart/add",
			data:"product_id="+product_id+"&size="+size+"&quantity="+quantity+"&user_id="+localStorage.guess_id,
			success:function(html){
				if(html!="ok"){
					alert(html)
				} else {
					GetCartByUserId(localStorage.guess_id);
					alert("Producto ha sido a\xF1adido al carro")
				}
			}
		})
	});

	$("#size").change(function(){
		var sku = $(this).attr("sku");
		var size = $(this).val();
		$.ajax({
			url:"/kardex/getunitsbysize",
			data:"sku="+sku+"&size="+size,
			success:function(html){
				if(html.indexOf("error") > -1){
					alert(html);
					$("#quantity").empty();
					var total_unidades = parseInt(html);
					$("#quantity").append($("<option></option>").attr("value",0).text(0));
				} else {
					$("#quantity").empty();
					var total_unidades = parseInt(html);
					for (i = 1; i <= total_unidades; i++) { 
					    $("#quantity").append($("<option></option>").attr("value",i).text(i));
					}
				}
			}
		});
	});

	$(document).on("click","button.eliminarproducto,a.borrarproducto",function(){
		var cart_id = $(this).attr("cart-id");
		var from_cart = $(this).hasClass("eliminarproducto");
		
		$.ajax({
			url:"/cart/remove",
			data:"cart_id="+cart_id,
			success:function(html){
				if(html=="ok"){
					alert("Producto ha sido eliminado del carro");
					if(from_cart){
						GetCartByUserId(localStorage.guess_id);
					} else {
						location.reload()
					}
				} else {
					alert(html);
				}
			}
		});
		
	});

	if($("input[name='quanitySniper']").length){
		$("input[name='quanitySniper']").TouchSpin({
	        buttondown_class: "btn btn-link",
	        buttonup_class: "btn btn-link"
	    });
	}
});
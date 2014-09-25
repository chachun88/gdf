$(document).ready(function(){
	$(".carritoicono").click(function(){
		$(".carritoproductos").slideToggle();
	});


	if(typeof(Storage) !== "undefined") {

		var usuario_existe = false;

		if(localStorage.user_id){
			$.ajax({
				url:"/user/exists",
				data:"user_id="+localStorage.user_id,
				async:false,
				success:function(html){
					if(html=="true"){
						usuario_existe = true;
					}
				}
			});
		}

		if(usuario_existe){
			GetCartByUserId(localStorage.user_id);
		} else {
			$.ajax({
				url: '/user/save-guess',
				success: function(html){
					if(html!="error"){
						localStorage.user_id = html;
					}
				}
			});
		}
	}


	var device_touch = false

	try {
		document.createEvent("TouchEvent");
		device_touch = true;
	} catch (e) {
		device_touch = false;
	}

	if (!device_touch){
		if($('.fancybox').length)
			$('.fancybox').fancybox({padding: 3, width: 600, href: $('.fancybox').attr('href') + '&ajax=0'});
	}

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
						GetCartByUserId(localStorage.user_id);
					} else {
						location.reload()
					}
				} else {
					alert(html);
				}
			}
		});
		
	});

	$(document).on("click","button.comprar", function(){
		location.href="/checkout/address";
	});

});
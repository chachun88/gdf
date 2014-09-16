$(document).ready(function(){
	$(".carritoicono").click(function(){
		$(".carritoproductos").slideToggle();
	});


	if(typeof(Storage) !== "undefined") {
		if(!localStorage.guess_id){
			$.ajax({
				url: '/user/save-guess',
				success: function(html){
					if(html!="error"){
						localStorage.guess_id = html;
					}
				}
			});
		} else {
			GetCartByUserId(localStorage.guess_id);
		}
	}


	var device_touch = false

	try {
		document.createEvent("TouchEvent");
		device_touch = true;
	} catch (e) {
		device_touch = false;
	}

	if (!device_touch)
		$('.fancybox').fancybox({padding: 3, width: 600, href: '/auth/login?ajax=0'});

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

	

});
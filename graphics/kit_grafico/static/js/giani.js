$(document).ready(function(){

	$(".carritoicono").click(function(){
		$(".carritoproductos").slideToggle();
	});


	if(typeof(Storage) !== "undefined") {

		if(!localStorage.userid){
			localStorage.userid = 0;
		}

		$.ajax({
			url: '/user/save-guess',
			data: "user_id="+localStorage.userid,
			success: function(html){
				//console.log("success");
				var objeto = $.parseJSON(html);
				if(objeto.success){
					localStorage.userid = objeto.success;
				}
			}
		});

		
		GetCartByUserId(localStorage.userid);
		
	}

	$("a.logout").click(function(){
		if(typeof(Storage) !== "undefined") {
			localStorage.userid = 0;
		}
	});


	var device_touch = false

	try {
		document.createEvent("TouchEvent");
		device_touch = true;
	} catch (e) {
		device_touch = false;
	}

	if (!device_touch){
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
					fancyAlert("Producto ha sido eliminado del carro");
					if(from_cart){
						GetCartByUserId(localStorage.userid);
					} else {
						location.reload()
					}
				} else {
					fancyAlert(html);
				}
			}
		});
		
	});

	$(document).on("click","button.comprar", function(){
		location.href="/checkout/address";
	});

});
$(document).ready(function(){

	$(".carritoicono").click(function(){
		$(".carritoproductos").slideToggle();
	});


	if(typeof(Storage) !== "undefined") {

		if(!localStorage.user_id){
			localStorage.user_id = 0;
		}

		$.ajax({
			url: '/user/save-guess',
			data: "user_id="+localStorage.user_id,
			success: function(html){
				//console.log("success");
				var objeto = $.parseJSON(html);
				if(objeto.success){
					localStorage.user_id = objeto.success;
				}
			}
		});

		
		GetCartByUserId(localStorage.user_id);
		
	}

	$("a.logout").click(function(){
		if(typeof(Storage) !== "undefined") {
			localStorage.user_id = 0;
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
						GetCartByUserId(localStorage.user_id);
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

	$("#same_address").trigger("change");



/*	if($("#contenedor").length>0){
		$("body").animate({
	        scrollTop: $("#contenedor").offset().top
	    }, 1000);
	}*/

	$(document).on("click",".page-link",function(e){

		e.preventDefault();

		var url = $(this).attr("href");

		$.ajax({
			url: url,
			data: "ajax=1",
			type: "get",
			success: function(respuesta){
				$(".paginador").pagination("destroy");
				$(".paginador").remove();
				$("#ajax_productos").html(respuesta);
				/*$(".contenedor_productos").css("opacity",0);
				$(".contenedor_productos").animate({
                        opacity: 1
                    }, 1500, function() {
                });*/
			}
		});

		return false;
	});

});
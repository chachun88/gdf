$(document).ready(function(){

	$(".carritoicono").click(function(){
		if($(".carritoproductos").css("display")=="none"){
			$(".carritoproductos").slideDown();
		} else {
			$(".carritoproductos").slideUp();
		}
	});

	$("body").mouseup(function (e)
	{
		var container = $(".carritoproductos");

	    if (!container.is(e.target) // if the target of the click isn't the container...
	        && container.has(e.target).length === 0) // ... nor a descendant of the container
	    {
	    	if(!$(".fancybox-overlay").length)
	    		container.slideUp();
	    }
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

	if($("#contenedor").length>0){
		$("body,html").animate({
	        scrollTop: $("#contenedor").offset().top
	    }, 1000);
	}

	if($("div.userInfo").length>0){
		$("body,html").animate({
	        scrollTop: $("div.userInfo").offset().top
	    }, 1000);
	}

	$(document).on("click",".page-link",function(e){

		e.preventDefault();

		var url = $(this).attr("href");

		$.ajax({
			url: url,
			data: "ajax=1",
			type: "get",
			beforeSend: function(){
				$("#ajax_productos").fadeOut().hide();
				console.log("fade out");
			},
			success: function(respuesta){
				$(".paginador").pagination("destroy");
				$(".paginador").remove();
				$("#ajax_productos").html(respuesta).delay(1000).fadeIn();
				console.log("fade in");
				
				/*$("#ajax_productos").animate({
                        opacity: 1
                    }, 3000, function() {
                });*/
			}
		});

		return false;
	});



});
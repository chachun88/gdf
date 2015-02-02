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

		if(!window.localStorage.getItem("user_id")){
			window.localStorage.setItem("user_id","0");
		}

		$.ajax({
			url: '/user/save-guess',
			cache: false,
			data: "user_id="+window.localStorage.getItem("user_id"),
			success: function(html){
				var objeto = $.parseJSON(html);
				if(objeto.success){
					window.localStorage.setItem("user_id",objeto.success.toString());
				}
			}
		});

		
		GetCartByUserId(window.localStorage.getItem("user_id"));
		
	}

	$("a.logout").click(function(){
		if(typeof(Storage) !== "undefined") {
			window.localStorage.setItem("user_id","0");
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
			cache: false,
			success:function(html){
				if(html=="ok"){
					fancyAlert("Producto ha sido eliminado del carro");
					if(from_cart){
						GetCartByUserId(window.localStorage.getItem("user_id"));
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
		if($(document).width()>480){
			$("body,html").animate({
				scrollTop: $("#contenedor").offset().top
			}, 1000);
		}
	}

	if($("div.userInfo").length>0){
		$("body,html").animate({
	        scrollTop: $("div.userInfo").offset().top
	    }, 1000);
	}

	

	$(document).on("click",".page-link",function(e){

		e.preventDefault();

		var url = $(this).attr("href");
		
		/*var parts = url.split("#");

		var uri = "";

		var query = "";

		if(parts.length){
			uri = url.split("#")[0].replace(/[?|&]/g,"&").replace("&","?");
		} else {
			uri = url.replace(/[?|&]/g,"&").replace("&","?");
			if(uri.indexOf("ajax")==-1){
				url = uri+"&ajax=1";	
			}
		}

		try{
			query = parts[1];
		} catch(e){
			console.info(e);
		}*/

		

			

		console.info(url);

		$.ajax({
			url: url,
			type: "get",
			cache: false,
			beforeSend: function(){
				$("#ajax_productos").addClass("disable");
			},
			success: function(respuesta){
				$(".paginador").pagination("destroy");
				$(".paginador").remove();
				$("#ajax_productos").html(respuesta).removeClass("disable").addClass("active"); //.delay(100).fadeIn(200);
				
				/*$("#ajax_productos").animate({
                        opacity: 1
                    }, 3000, function() {
                });*/
			}
		});

		return false;
	});
});
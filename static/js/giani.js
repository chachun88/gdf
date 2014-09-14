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
	    }
	}

	$('.fancybox').fancybox({padding: 3});

});
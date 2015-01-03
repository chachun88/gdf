$(document).ready(function(){
	$("#address").minimalect({
		placeholder:"Agregar nueva dirección",
		theme: "bubble",
		searchable: false,
		onchange: function(){
			$('#address').trigger('change');
		}
	});

	$("#InputCity").minimalect({
		placeholder:"Seleccione una ciudad",
		theme: "bubble",
		searchable: false,
		onchange: function(){
			$('#InputCity').trigger('change');
		}
	});

	$(".minict_wrapper").click(function(){
		if($(".minict_wrapper.active ul li.minict_empty").hasClass('minict_first'))
			$(".minict_wrapper.active ul li.minict_empty").parent().css("display","none");
	});

	
});
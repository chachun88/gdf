$(document).ready(function(){
	$("#address").minimalect({
		placeholder:"Agregar nueva direcci&oacute;n",
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
});
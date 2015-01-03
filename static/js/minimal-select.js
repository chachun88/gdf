$(document).ready(function(){
	$("#address").minimalect({
		placeholder:"Agregar nueva dirección",
		theme: "bubble",
		searchable: false,
		remove_empty_option: false,
		onchange: function(){
			$('#address').trigger('change');
		}
	});

	$("#InputCity").minimalect({
		placeholder:"Seleccione una ciudad",
		theme: "bubble",
		searchable: false,
		remove_empty_option: false,
		onchange: function(){
			$('#InputCity').trigger('change');
		}
	});
});
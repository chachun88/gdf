$(document).ready(function(){
	$("#address").minimalect({
		placeholder:"Agregar nueva direcci&oacute;n",
		theme: "bubble",
		onchange: function(){
			$('#address').trigger('change');
		}
	});
});
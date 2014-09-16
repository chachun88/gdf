// pasar a giani.js
$(document).ready(function(){

	// repetir password
	$('input[name=password]').change( function(){
		$('input[name=re-password]').attr( "pattern", $(this).val() );
	} );

	// repetir email
	// $('input[name=email]').change( function(){
	//  $('input[name=re-email]').attr( "pattern", $(this).val() );
	// } );

	// login submit
	$( ".form-login" ).submit( function(evt)
	{
		evt.preventDefault();

		var tthis = $(this);

		var data = { "ajax":"true",
					 "email":$("input[name=email]", tthis).val(),
					 "password":$("input[name=password]", tthis).val() };

		$.post( "/auth/login", data, function(rtn){
			if (rtn == "ok") 
			{
				window.parent.document.location.href = "/"; // TODO:poner aqui redirect a pagina anterior
			}
		} );
		return false;
	});

	$( ".form-register" ).submit(function(evt)
	{
		evt.preventDefault();

		var tthis = $( this );
		var data = { "ajax":"true",
					 "name":$("input[name=name]", tthis).val(),
					 "email":$("input[name=email]", tthis).val(),
					 "password":$("input[name=password]", tthis).val(),
					 "re-password":$("input[name=re-password]", tthis).val(),
					 "tos":$("input[name=tos]", tthis).val()}

		$.post( "/auth/registro", data, function(rtn){
			if (rtn == "ok") 
			{
				window.parent.document.location.href = "/";
			}
			else
			{
				alert( rtn );
			}
		});
	});

	$(".parent-link").click(function(evt){
		evt.preventDefault();
		window.parent.document.location.href = $(this).attr( "href" );
	});

});
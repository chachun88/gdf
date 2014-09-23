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
					 "password":$("input[name=password]", tthis).val(),
					 "user_id":localStorage.user_id };

		$.post( $( this ).attr( 'action' ), data, function(rtn){

			var rtn_pair = $.parseJSON(rtn)

			if (rtn_pair["status"] == "ok") 
			{
				localStorage.user_id = rtn_pair["user_id"];
				window.parent.document.location.href = rtn_pair["next"]; // TODO:poner aqui redirect a pagina anterior
			}
			else
			{
				alert( rtn_pair["message"] );
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

		$.post( $( this ).attr( 'action' ), data, function(rtn){

			var rtn_pair = rtn.split( ":" );

			if (rtn_pair[0] == "ok") 
			{
				window.parent.document.location.href = rtn_pair[1];
			}
			else
			{
				alert( rtn_pair[1] );
			}
		});

		return false;
	});

	$(".parent-link").click(function(evt){
		evt.preventDefault();
		window.parent.document.location.href = $(this).attr( "href" ) + "&user_id=" + localStorage.user_id;
	});

});
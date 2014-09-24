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

		var email = $("input[name=email]", tthis).val().trim();
		var password = $("input[name=password]", tthis).val().trim();

		evt.preventDefault();

		if(email!=""&&password!=""){

			var tthis = $(this);

			var data = { "ajax":"true",
						 "email":email,
						 "password":password,
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
		} else {
			alert("Debe ingresar email y contrase\xF1a");
		}
		return false;
	});

	$( ".form-register" ).submit(function(evt)
	{
		evt.preventDefault();

		var tthis = $( this );

		var email = $("input[name=email]", tthis).val().trim();
		var password = $("input[name=password]", tthis).val().trim();
		var name = $("input[name=name]", tthis).val().trim();
		var repassword = $("input[name=re-password]", tthis).val().trim();
		var tos = $("input[name=tos]", tthis).val();

		if(name==""){
			alert("Debe ingresar nombre de usuario");
			return false;
		}

		if(email==""){
			alert("Debe ingresar email");
			return false;
		}

		if(password==""){
			alert("Debe ingresar contrase\xF1a");
			return false;
		} else if(password!=repassword){
			alert("Error en al confimar contrase\xF1a");
			return false;
		}

		if(tos!="on"){
			alert("Debe aceptar los t\xE9rminos y condiciones");
			return false;
		}


			
		var data = { "ajax":"true",
					 "name":name,
					 "email":email,
					 "password":password,
					 "re-password":repassword,
					 "tos":tos}

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
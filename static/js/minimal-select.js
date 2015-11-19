$(document).ready(function(){
	$("#address").minimalect({
		placeholder:"Agregar nueva dirección",
		theme: "bubble",
		searchable: false,
		onchange: function(){
			$('#address').trigger('change');
		}
	});

	// $("#InputCity").minimalect({
	// 	placeholder:"Seleccione una ciudad",
	// 	theme: "bubble",
	// 	searchable: false,
	// 	onchange: function(){
	// 		$('#InputCity').trigger('change');
	// 	}
	// });

	$('#InputCity, #inputChilexpress').select2({
		'width': "100%"
	});

	$(".minict_wrapper").click(function(){
		$(".minict_wrapper.active ul li.minict_empty.minict_first").parent().css("display","none");
	});

	$(document).on("change", "#InputCity", function(){

		var city_id = $(this).val();
		$.ajax({
			url: "/checkout/listpostofficebycityid",
			type: "get",
			data: "city_id=" + city_id,
			dataType: "json",
			success: function(response){
				json_str = JSON.stringify(response);
				json_obj = $.parseJSON(json_str);

				if (json_obj.success !== undefined){
					$("#inputChilexpress").empty();
					$("#inputChilexpress").append('<option></option>').change();
					for(var i=0; i<json_obj.success.length; i++){
						$("#inputChilexpress").append('<option value="' + json_obj.success[i].id + '">' + json_obj.success[i].name+ '</option>').val('').change();
					}
				}
			}
		})
	});

	$("#inputChilexpress").on("change", function(){
		var post_office_id = $(this).val();

		if(post_office_id !== undefined && post_office_id !== ''){
			$.ajax({
				url: "/checkout/getaddressbypostofficeid",
				type: "get",
				data: "post_office_id=" + post_office_id,
				dataType: "json",
				success: function(response){
					json_str = JSON.stringify(response);
					json_obj = $.parseJSON(json_str);

					if (json_obj.success !== undefined){
						$("#poAddress").text(json_obj.success);
					}
				}
			});
		}
	});
});
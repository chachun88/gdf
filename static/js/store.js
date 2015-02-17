$(document).ready(function(){

	console.info($("#total-items").val());

	$(".paginador").pagination({
      items: $("#total-items").val(),
      itemsOnPage: 16,
      prevText: '<',
      nextText: '>',
      currentPage: $("#page").val(),
      hrefTextPrefix:'?ajax=1&page=',
      hrefTextSuffix: '#contenedor'
    });

	var expanded = false;
	var original_height = $("#menu-m ul").css('height')
	$("#menu-m ul").css('height',0);

	//$("#menu-m ul").slideDown("fast");

	$(".cover-material").click(function(event) {

		event.stopPropagation();

		// Slide down menu if hidden
		if (!expanded) {
			$("#menu-m ul").animate({
				"height": original_height
			}, "slow");
			expanded = true;
		}
		// Slide up menu if shown
		else {
			$("#menu-m ul").animate({
				"height": 0
			}, "slow");
			expanded = false;
		}
	});

	$("#menu-m").click(function(){
		event.stopPropagation();
	});
	
	$(document).click(function(){
		if(expanded){
			$("#menu-m ul").animate({
				"height": 0
			}, "slow");
			expanded = false;	
		}
	});

});
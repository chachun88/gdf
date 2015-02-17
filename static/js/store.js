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

	var expanded = true;
	// When clicked on the menu-trigger
	$("#menu-m ul").hide();
	$("#menu-m").click(function(event) {

			// Slide down menu if hidden
			if (!expanded) 
			{
				event.stopPropagation();
				$("#menu-m ul").slideUp("slow");
				expanded = true;
			}
			// Slide up menu if shown
			else 
			{
				$("#menu-m ul").slideDown("fast");
				expanded = false;
			}
	});

});
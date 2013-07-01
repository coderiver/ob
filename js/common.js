$(document).ready(function() {
	// for select selected "post"
	$(".js-select").change(function(){
	    var text = $(this).val();
	    $(".js-row__select").text(text);
	});
});


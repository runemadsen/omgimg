$(document).ready(function() {

	$("#modal").hide();
	
	$('.reply').click(function()
	{	
		var image_id = $(this).attr("data-image-id");
		$("#modal").show();
    return false;
	});
	
	$('#image_search').submit(function() 
	{
		$.ajax({
			url: "/search/" + $("#searchterm").val(),
		  success: function(data){
				$("#search_results").html(data);
				
				$('.search_image_link').click(function() {
					alert("clicked");
					
					// set parent_id to the passed reply image
					
					// set url in form
					
					// post form
					
					// show updating
					
					return false;
				});
		  },
			error:function (xhr, ajaxOptions, thrownError){
				alert(thrownError);
			}
		});
		
		return false;
	});
	
});
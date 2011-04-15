$(document).ready(function() {

	$("#modal").hide();
	
	$('.reply').click(function()
	{	
		var image_id = $(this).attr("data-image-id");
		$("#parent_id").attr("value", image_id);
		$("#modal").show(200);
		
		$('#clear').click(function()
		{	
			$("#modal").hide(200);
	    return false;
		});
		
    return false;
	});
	
	$('#image_search').submit(function() 
	{
		$.ajax({
			url: "/search/" + $("#searchterm").val(),
		  success: function(data){
				$("#search_results").html(data);
				
				$('.search_image_link').click(function() {
					
					var parent_id = $("#parent_id").attr("value");
					var url = $(this).find("img").attr("src");
					
					$.ajax({
						url: "/images",
						data: {"parent_id" : parent_id, "url" : url},
						type: "POST",
					  success: function(data){
							$("#modal").hide(200);
					  },
						error:function (xhr, ajaxOptions, thrownError){
							alert(thrownError);
						}
					});
					
					return false;
				});
		  },
			error:function (xhr, ajaxOptions, thrownError){
				alert(thrownError);
			}
		});
		
		return false;
	});
	
	$(".vote_link").click(function() {
		
		var image_id = $(this).attr("data-image-id");
		var rating_box = $(this).parent();
		
		$.ajax({
			url: "/images/"+ image_id + "/rating",
			type: "POST",
		  success: function(data){
				rating_box.hide();
		  },
			error:function (xhr, ajaxOptions, thrownError){
				alert(thrownError);
			}
		});
		
		return false;
	});
	
});
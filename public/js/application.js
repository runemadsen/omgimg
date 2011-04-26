$(document).ready(function() {

	$("#modal").hide();
	
	$("#show_searchterms").click(function() {
		$(".searchterm_box").toggle();
		if($(this).hasClass('highlight'))
		{
			$(this).removeClass('highlight');
		}
		else
		{
			$(this).addClass('highlight');
		}
		return false;
	});
	
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
						data: {"parent_id" : parent_id, "url" : url, "searchterm" : $("#searchterm").val()},
						type: "POST",
					  success: function(data){
							$("#modal").hide(200);
							location.reload();
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
		var rating_num = $(this).parent().find('.rating_num').first();
		var rating_box = $(this).parent().parent().find('.rating_box').first();
		
		$(this).hide();
		
		$.ajax({
			url: "/images/"+ image_id + "/rating",
			type: "POST",
		  success: function(data){
			
				var rating = parseInt(data);
				
				rating_box.css("background-image", "url(/images/ratings/"+ (rating > 50 ? 50 : rating) +".gif)");
				rating_num.html(data);
		  },
			error:function (xhr, ajaxOptions, thrownError){
				alert(thrownError);
			}
		});
		
		return false;
	});
	
});
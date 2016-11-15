$(document).ready(function()
{
	    //작성 예시 버튼 이벤트
	$(".txt_box > button").click(function(){
	    $(this).nextAll(".hiding_box").fadeIn();
	});
	$(".close_btn").click(function(){   
	    $(this).parents(".hiding_box").fadeOut();
	});
});
    

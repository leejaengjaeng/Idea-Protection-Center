var disableAllInput = function()
{
	$('#idea_kind').addClass('disabled');
	$('#idea_kind').attr('disabled',true);
	$('#comment_idea_kind').addClass('disabled');
	$('#comment_idea_kind').attr('disabled',true);
	$('#re_idea_kind').hide();
    $('#re_idea_kind_inventor').hide();
   
	$('#field_selected').addClass('disabled');
	$('#field_selected').attr('disabled',true);	
	$('#kind').addClass('disabled');
	$('#kind').attr('disabled',true);
	$('#comment_fieldAndKind').addClass('disabled');
	$('#comment_fieldAndKind').attr('disabled',true);
	$('#re_field_selected').hide();
	$('#re_field_selected').hide();	
	$('#re_kind').hide();
	
	$('#meaning').addClass('disabled');
	$('#meaning').attr('disabled',true);
	$('#comment_meaning').addClass('disabled');
	$('#comment_meaning').attr('disabled',true);
	$('#re_meaning').hide();
	
    $('#agree').hide();
}
var enableReComment = function()
{
	$('#re_idea_kind_inventor').show();
	$('#re_idea_kind').show();
	$('#re_field_selected').show();
	$('#re_kind').show();
	$('#re_meaning').show();
    $('#agree').show();
}

var hideCommentBoxes = function()
{
   $('#comment_idea_kind').hide();
   $('#comment_fieldAndKind').hide();
   $('#comment_meaning').hide();
}
var showCommentBoxes = function()
{
   $('#comment_idea_kind').show();
   $('#comment_fieldAndKind').show();
   $('#comment_meaning').show();
}

var hideReBoxes = function()
{
	$('#re_idea_kind_inventor').hide();
	$('#re_idea_kind').hide();
	$('#re_field_selected').hide();
	$('#re_field_txt').hide();
    $('#re_type_txt').hide();
    $('#re_kind').hide();
    $('#re_meaning').hide();
    
}

var showReBoxes = function()
{
	$('#re_idea_kind_inventor').show();
	$('#re_idea_kind').show();
	$('#re_field_selected').show();
 	$('#re_kind').show();
    $('#re_meaning').show();
    $('#re_field_txt').show();
    $('#re_type_txt').show();
    
}


//클릭에 따라 내용 바꿔주기
var showClickedList = function(cid)
{
	$.ajax({
    url : "/copyRight/detail.ajax/"+cid,
    type:"GET",
    success:function(retVal)
    {
    	if(retVal==null) alert('auth Error');
    	else
    	{
    		showReBoxes();
    		showCommentBoxes();
    		
    		var role = retVal.role;
    		var vo = retVal.vo;
         	
    		$('#idea_kind').text(vo.title);
       	    $('#field_selected').children('option').text(vo.field);
       	    $('#kind').text(vo.type);
       	    $('#meaning').text(vo.meaning);
       	    if(role == "inventor")
    		{
    			$('#comment_idea_kind').text(vo.re_title);
    			$('#comment_fieldAndKind').text("분야:"+vo.re_field+"\n종류:"+vo.re_type);
    			$('#comment_meaning').text(vo.re_meaning);        	
    			
    			if(retVal.isLast=="true" && retVal.turn!="inventor") hideCommentBoxes();		
    		}
       	    else if(role == "pl")
       	    {
       	    	var prevVo = retVal.prevVo;
    			$('#comment_idea_kind').text(prevVo.re_title);
    			$('#comment_fieldAndKind').text("분야 : "+prevVo.re_field+"\n종류 : "+prevVo.re_type);
    			$('#comment_meaning').text(prevVo.re_meaning);        	
       	    }
       	    else alert('role Error \n'+role)
       	    
        	if(retVal.isLast=="true" && retVal.turn==role)
        	{
        		showReBoxes();
        		enableReComment();
         	}
        	else
         	{
        		hideReBoxes();
   		 	  	$('#agree').hide();
     		}
    	}
    },
    error: function(request,status,error)
    {
         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
 });   
}




/*

////////////////////////////////////////////////////////////////
//저장
var ideaSave = function(role)
{
   if(role == "inventor")
   {
	   var q = confirm("확인 버튼을 누르시면 변리사가 코멘트를 완료하기 전까지 수정할 수 없습니다.")
		if (q == true) {
			
		} else {
			return false;
		}
      //alert('저장 후 변리사가 코멘트를 완료하기 전까지 수정 할 수 없습니다.');   
   }   
   else if(role == "pl")
   {
	   var p = confirm("확인 버튼을 누르시면 고객이 내용을 수정하기까지 수정 할 수 없습니다.")
		if (p == true) {
			
		} else {
			return false;
		}
      //alert('저장 후 고객이 내용을 수정하기까지 수정 할 수 없습니다.');   
   }
   else
   {
      alert('role Error ->'+role);      
   }

   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};

   data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['rid'] = $('#IdeaModifyList').find('.clickedIdea').children('input').val();
   //발명가인 경우 
   if(role=="inventor")
   {
      data['role']         	 = "inventor";
      data['typeOfInvent']   = $('#AfterCommentTypeOfInvent').val();
      data['title']          = $('#AfterCommentTitle').val();
      data['summary']        = $('#AfterCommentSummary').val();
      data['whyInvent']      = $('#AfterCommentWhyInvent').val();
      data['problem']        = $('#AfterCommentProblem').val();
      data['solution']       = $('#AfterCommentSolution').val();
      data['effect']         = $('#AfterCommentEffect').val();
      data['core_element']   = $("#AfterCommentCore_Element").val();
      data['hope_content']   = $("#AfterCommentHope_content").val();
      data['picture_explain']= $("#AfterCommentPicture_explain").val();   
      data['hope_content']	 = $("#AfterCommentHope_content").val();
   }
   //변리사인 경우
   else if(role=="pl")
   {
      data['role']          	 = "pl";
      data['re_typeOfInvent'] 	 = $('#AfterCommentTypeOfInvent').val();
      data['re_title']       	 = $('#AfterCommentTitle').val();
      data['re_summary']       	 = $('#AfterCommentSummary').val();
      data['re_whyInvent']    	 = $('#AfterCommentWhyInvent').val();
      data['re_problem']       	 = $('#AfterCommentProblem').val();
      data['re_solution']        = $('#AfterCommentSolution').val();
      data['re_effect']       	 = $('#AfterCommentEffect').val();
      data['re_core_element'] 	 = $('#AfterCommentCore_Element').val();
      data['re_file']        	 = $('#AfterCommentFiles').val();
      data['re_hope_content']	 = $('#AfterCommentHope_content').val();
      data['re_picture_explain'] = $('#AfterCommentPicture_explain').val();   
      data['re_hope_content']	 = $("#AfterCommentHope_content").val();
   }
   else
   {
     data['role'] = "error";
   }
    $.ajax({
      url : "/ideaSave",
      type:"POST",
      headers: headers,
      data : data,
      success:function(retVal)
      {
    	  alert(retVal);
    	  if(role=="inventor"){
    		  document.getElementById("commentForm").submit();  
    	  }
          
          if(role=="pl"){
        	  location.href ="/mainPage";
          }
    	  //location.href ="/mainPage";
      },
      error: function(request,status,error)
      {
         alert('저장에 실패하였습니다')
      }
   });   
}
*/

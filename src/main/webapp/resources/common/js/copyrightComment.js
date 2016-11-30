var disableAllInput = function()
{
	$('#idea_kind').addClass('disabled');
	$('#idea_kind').attr('disabled',true);
	$('#comment_idea_kind').addClass('disabled');
	$('#comment_idea_kind').attr('disabled',true);
	$('#re_idea_kind_inventor').addClass('disabled');
	$('#re_idea_kind_inventor').attr('disabled',true);
   
	$('#field_selected').addClass('disabled');
	$('#field_selected').attr('disabled',true);	
	$('#kind').addClass('disabled');
	$('#kind').attr('disabled',true);
	$('#comment_fieldAndKind').addClass('disabled');
	$('#comment_fieldAndKind').attr('disabled',true);
	$('#re_field_selected').addClass('disabled');
	$('#re_field_selected').attr('disabled',true);	
	$('#re_kind').addClass('disabled');
	$('#re_kind').attr('disabled',true);
	
	$('#meaning').addClass('disabled');
	$('#meaning').attr('disabled',true);
	$('#comment_meaning').addClass('disabled');
	$('#comment_meaning').attr('disabled',true);
	$('#re_meaning').addClass('disabled');
	$('#re_meaning').attr('disabled',true);
	
    $('#agree').hide();
}
var enableReComment = function()
{
	$('#re_idea_kind_inventor').removeClass('disabled');
	$('#re_idea_kind_inventor').attr('disabled',false);

	$('#re_field_selected').removeClass('disabled');
	$('#re_field_selected').attr('disabled',false);	
	$('#re_kind').removeClass('disabled');
	$('#re_kind').attr('disabled',false);

	$('#re_meaning').removeClass('disabled');
	$('#re_meaning').attr('disabled',false);

    $('#agree').show();
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
        	var role = retVal.role;
            if(role == "inventor")
            {
         	   var vo = retVal.vo;
                
         	   $('#idea_kind').text(vo.title);
         	   $('#comment_idea_kind').text(vo.re_title);
         	     	
         	   $('#field_selected').text(vo.field);
         	   $('#kind').text(vo.type);
         	   $('#comment_fieldAndKind').text("분야:"+vo.re_field+"\n종류:"+vo.re_type);
         	  	
         	   $('#meaning').text(vo.meaning);
         	   $('#comment_meaning').text(vo.re_meaning);
         	  
         	   if(retVal.isLast=="true")
         	   {
         		   $('#re_idea_kind_inventor').show();
          	       $('#re_field_selected').show();
             	   $('#re_kind').show();
                    $('#re_meaning').show();
         	 	   $('#agree').show();
         	   }
         	   else
         	   {
         		   $('#re_idea_kind_inventor').hide();
     	 	       $('#re_field_selected').hide();
     	    	   $('#re_kind').hide();
     	           $('#re_meaning').hide();
     		 	   $('#agree').hide();
     		   }
            }
            else if(role == "pl")
            {
         	   var vo = retVal.vo;
                
         	   $('#idea_kind').text(vo.title);
         	   $('#comment_idea_kind').text(vo.re_title);
         	     	
         	   $('#field_selected').text(vo.field);
         	   $('#kind').text(vo.type);
         	   $('#comment_fieldAndKind').text("분야:"+vo.re_field+"\n종류:"+vo.re_type);
         	  	
         	   $('#meaning').text(vo.meaning);
         	   $('#comment_meaning').text(vo.re_meaning);
         	  
         	   if(retVal.isLast=="true")
         	   {
         		   $('#re_idea_kind_inventor').show();
          	       $('#re_field_selected').show();
             	   $('#re_kind').show();
                    $('#re_meaning').show();
         	 	   $('#agree').show();
         	   }
         	   else
         	   {
         		   $('#re_idea_kind_inventor').hide();
     	 	       $('#re_field_selected').hide();
     	    	   $('#re_kind').hide();
     	           $('#re_meaning').hide();
     		 	   $('#agree').hide();
     		   }
            }
            else
               alert('role Error');
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

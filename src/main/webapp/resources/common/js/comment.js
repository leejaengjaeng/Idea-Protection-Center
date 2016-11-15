//beforeComment는 항상 disable
var enableInput = function()
{
   $('#AfterCommentTypeOfInvent').removeClass('disabled');
   $('#AfterCommentTypeOfInvent').attr('disabled',false);
   $('#AfterCommentTitle').removeClass('disabled');
   $('#AfterCommentTitle').attr('disabled',false);
   $('#AfterCommentSummary').removeClass('disabled');
   $('#AfterCommentSummary').attr('disabled',false);
   $('#AfterCommentWhyInvent').removeClass('disabled');
   $('#AfterCommentWhyInvent').attr('disabled',false);
   $('#AfterCommentProblem').removeClass('disabled');
   $('#AfterCommentProblem').attr('disabled',false);
   $('#AfterCommentSolution').removeClass('disabled');
   $('#AfterCommentSolution').attr('disabled',false);
   $('#AfterCommentEffect').removeClass('disabled');
   $('#AfterCommentEffect').attr('disabled',false);
   $('#AfterCommentCore_Element').removeClass('disabled');
   $('#AfterCommentCore_Element').attr('disabled',false);
   $('#AfterCommentFiles').removeClass('disabled');
   $('#AfterCommentFiles').attr('disabled',false);
   $('#AfterCommentHope_content').removeClass('disabled');
   $('#AfterCommentHope_content').attr('disabled',false);
   $('#AfterCommentPicture_explain').removeClass('disabled');
   $('#AfterCommentPicture_explain').attr('disabled',false);
   $('#AfterCommentHope_content').removeClass('disabled');
   $('#AfterCommentHope_content').attr('disabled',false);

   $('#tmpSave').show();
   $('#agree').show();      

}

var disableInput = function()
{
   $('#AfterCommentTypeOfInvent').addClass('disabled');
   $('#AfterCommentTypeOfInvent').attr('disabled',true);
   $('#AfterCommentTitle').addClass('disabled');
   $('#AfterCommentTitle').attr('disabled',true);
   $('#AfterCommentSummary').addClass('disabled');
   $('#AfterCommentSummary').attr('disabled',true);
   $('#AfterCommentWhyInvent').addClass('disabled');
   $('#AfterCommentWhyInvent').attr('disabled',true);
   $('#AfterCommentProblem').addClass('disabled');
   $('#AfterCommentProblem').attr('disabled',true);
   $('#AfterCommentSolution').addClass('disabled');
   $('#AfterCommentSolution').attr('disabled',true);
   $('#AfterCommentEffect').addClass('disabled');
   $('#AfterCommentEffect').attr('disabled',true);
   $('#AfterCommentCore_Element').addClass('disabled');
   $('#AfterCommentCore_Element').attr('disabled',true);
   $('#AfterCommentFiles').addClass('disabled');
   $('#AfterCommentFiles').attr('disabled',true);
   $('#AfterCommentHope_content').addClass('disabled');
   $('#AfterCommentHope_content').attr('disabled',true);
   $('#AfterCommentPicture_explain').addClass('disabled');
   $('#AfterCommentPicture_explain').attr('disabled',true);
   $('#AfterCommentHope_content').addClass('disabled');
   $('#AfterCommentHope_content').attr('disabled',true);   
   $('#tmpSave').hide();
   $('#agree').hide();      
   $('#gogogo').hide();

}
var enableApplyBtn = function()
{
	$('#gogogo').show();
}
/*
var disableInputApply = function()
{
	disableInput();
	$('#gogogo').hide();
}
*/
var btnHide=function(){
   $('.removeBtn').hide();
}

var tempApply=function(role){
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var data2={};
   var headers = {};

   data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['rid'] = $('#IdeaModifyList').find('.clickedIdea').children('input').val();
    $.ajax({
      url : "/tempApply",
      type:"POST",
      headers: headers,
        data : data,
        success:function(retVal)
        {
             alert("가출원 상태로 등록되었습니다.");
          
          //location.href ="/getFile?file_name="+retVal.file_name;
          location.href ="/getFile/"+retVal.file_name;
        },
        error: function(request,status,error)
      {
          alert('실패하였습니다.')
     }
   });   
    //location.href ="/mainPage";
}
var lastconfirm=function(role){
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var data2={};
	var headers = {};

	data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['rid'] = $('#IdeaModifyList').find('.clickedIdea').children('input').val();
    
    $.ajax({
		url : "/lastConfirm",
		type:"POST",
		headers: headers,
 	    data : data,
 	    success:function(retVal)
 	    {
	 	   	alert("발명가에게 필요 서류를 업로드 할때까지 기다려주시기 바랍니다.");
	 	    location.href ="/mainPage";
 	    },
 	    error: function(request,status,error)
		{
 			alert('실패하였습니다.')
 	}
	});
	
}
var gotoApply=function(role){
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var data2={};
	var headers = {};

	data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['rid'] = $('#IdeaModifyList').find('.clickedIdea').children('input').val();
    
    $.ajax({
		url : "/gotoApply",
		type:"POST",
		headers: headers,
 	    data : data,
 	    success:function(retVal)
 	    {
 	     	alert("특허 준비하기 페이지로 넘어갑니다.");
	  	    location.href ="/upload/uploadFile";
 	    },
 	    error: function(request,status,error)
		{
 			alert('실패하였습니다.')
		}
	});
	
}
//임시 저장
var tmpSave = function(role)
{
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
      data['role']        	  = "inventor";
      data['typeOfInvent']    = $('#AfterCommentTypeOfInvent').val();
      data['title']           = $('#AfterCommentTitle').val();
      data['summary']      	  = $('#AfterCommentSummary').val();
      data['whyInvent']       = $('#AfterCommentWhyInvent').val();
      data['problem']         = $('#AfterCommentProblem').val();
      data['solution']        = $('#AfterCommentSolution').val();
      data['effect']          = $('#AfterCommentEffect').val();
      data['core_element']    = $("#AfterCommentCore_Element").val();
      data['hope_content']    = $("#AfterCommentHope_content").val();
      data['picture_explain'] = $("#AfterCommentPicture_explain").val();
      data['hope_content']	  = $("#AfterCommentHope_content").val();
   }
   //변리사인 경우
   else if(role=="pl")
   {
      data['role']         	  	= "pl";
      data['re_typeOfInvent'] 	= $('#AfterCommentTypeOfInvent').val();
      data['re_title']        	= $('#AfterCommentTitle').val();
      data['re_summary']      	= $('#AfterCommentSummary').val();
      data['re_whyInvent']    	= $('#AfterCommentWhyInvent').val();
      data['re_problem']      	= $('#AfterCommentProblem').val();
      data['re_solution']     	= $('#AfterCommentSolution').val();
      data['re_effect']       	= $('#AfterCommentEffect').val();
      data['re_core_element'] 	= $('#AfterCommentCore_Element').val();
      data['re_file']           = $('#AfterCommentFiles').val();
      data['re_hope_content']   = $('#AfterCommentHope_content').val();
      data['re_picture_explain']= $('#AfterCommentPicture_explain').val();
      data['re_hope_content']	= $("#AfterCommentHope_content").val();
   }
   else
   {
      data['role'] = "error";
   }

    $.ajax({
      url : "/tmpSave",
      type:"POST",
      headers: headers,
        data : data,
        success:function(retVal)
        {
             if(role == "inventor")
          {
             alert(retVal+'\n 저장 후 변리사의 코멘트를 받을 수 있습니다.');   
          }
          else if(role = "pl")
          {
             alert(retVal+'\n 저장 후 고객이 코멘트를 확인 할 수 있습니다.');   
          }
        },
        error: function(request,status,error)
      {
          alert('임시 저장에 실패하였습니다.')
      }
   });   
    
}
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

var hideBeforeCmt = function()
{
   var hideEl = document.getElementsByClassName('before_cmt')
   for(var i =0; i <hideEl.length ; i++)
      hideEl[i].style.display="none";
}
var showBeforeCmt = function()
{
   var hideEl = document.getElementsByClassName('before_cmt')
   for(var i =0; i <hideEl.length ; i++)
      hideEl[i].style.display="";
}


//클릭에 따라 내용 바꿔주기
var showClickedList = function(rid)
{
	$.ajax({
      url : "/detailByRid/"+rid,
      type:"GET",
      success:function(retVal)
      {
         var role = retVal.user;
         if(role == "inventor")
         {
            if(retVal.isFirst == "false")
            {
               var beforeComment = retVal.beforeReg;
               $('#BeforeCommentTypeOfInvent').text(beforeComment.typeOfInvent);
               $('#BeforeCommentTitle').text(beforeComment.title);
               $('#BeforeCommentSummary').text(beforeComment.summary);
               $('#BeforeCommentWhyInvent').text(beforeComment.whyInvent);
               $('#BeforeCommentProblem').text(beforeComment.problem);
               $('#BeforeCommentSolution').text(beforeComment.solution);
               $('#BeforeCommentEffect').text(beforeComment.effect);
               $('#BeforeCommentCore_Element').text(beforeComment.core_element);
               $('#BeforeCommentFiles').text(beforeComment.re_file);
               $('#BeforeCommentHope_content').text(beforeComment.hope_content);
               $('#BeforeCommentPicture_explain').text(beforeComment.picture_explain);
               
               $('#CurrentTypeOfInvent').text(beforeComment.re_typeOfInvent);
               $('#CurrentCommentTitle').text(beforeComment.re_title);
               $('#CurrentCommentSummary').text(beforeComment.re_summary);
               $('#CurrentCommentWhyInvent').text(beforeComment.re_whyInvent);
               $('#CurrentCommentProblem').text(beforeComment.re_problem);
               $('#CurrentCommentSolution').text(beforeComment.re_solution);
               $('#CurrentCommentEffect').text(beforeComment.re_effect);
               $('#CurrentCommentCore_Element').text(beforeComment.re_core_element);
               $('#CurrentCommentHope_content').text(beforeComment.re_hope_content);
               $('#CurrentCommentPicture_explain').text(beforeComment.re_picture_explain);
             
               showBeforeCmt();
            }
            else hideBeforeCmt();
           
         
            var currentAnswer = retVal.currentAnswer;
            $('#AfterCommentTypeOfInvent').text(currentAnswer.typeOfInvent);
            $('#AfterCommentTitle').text(currentAnswer.title);
            $('#AfterCommentSummary').text(currentAnswer.summary);
            $('#AfterCommentWhyInvent').text(currentAnswer.whyInvent);
            $('#AfterCommentProblem').text(currentAnswer.problem);
            $('#AfterCommentSolution').text(currentAnswer.solution);
            $('#AfterCommentEffect').text(currentAnswer.effect);
            $('#AfterCommentCore_Element').text(currentAnswer.core_element);
            $('#AfterCommentFiles').text(currentAnswer.re_file);
            $('#AfterCommentHope_content').text(currentAnswer.hope_content);
            $('#AfterCommentPicture_explain').text(currentAnswer.picture_explain);
            
         }
         else if(role == "pl")
         {
            if(retVal.isFirst == "false")
            {
               var beforeComment = retVal.beforeComment;
               $('#BeforeCommentTypeOfInvent').text(beforeComment.re_typeOfInvent);
               $('#BeforeCommentTitle').text(beforeComment.re_title);
               $('#BeforeCommentSummary').text(beforeComment.re_summary);
               $('#BeforeCommentWhyInvent').text(beforeComment.re_whyInvent);
               $('#BeforeCommentProblem').text(beforeComment.re_problem);
               $('#BeforeCommentSolution').text(beforeComment.re_solution);
               $('#BeforeCommentEffect').text(beforeComment.re_effect);
               $('#BeforeCommentCore_Element').text(beforeComment.re_core_element);
               $('#BeforeCommentFiles').text(beforeComment.re_file);
               $('#BeforeCommentPicture_explain').text(beforeComment.re_picture_explain);
               $('#BeforeCommentHope_content').text(beforeComment.re_hope_content);
               showBeforeCmt();
            }
            else
            {
               hideBeforeCmt();
            }
      
            var currentAnswer = retVal.currentAnswer;
            $('#CurrentTypeOfInvent').text(currentAnswer.typeOfInvent);
            $('#CurrentCommentTitle').text(currentAnswer.title);
            $('#CurrentCommentSummary').text(currentAnswer.summary);
            $('#CurrentCommentWhyInvent').text(currentAnswer.whyInvent);
            $('#CurrentCommentProblem').text(currentAnswer.problem);
            $('#CurrentCommentSolution').text(currentAnswer.solution);
            $('#CurrentCommentEffect').text(currentAnswer.effect);
            $('#CurrentCommentCore_Element').text(currentAnswer.core_element);
            $('#CurrentCommentHope_content').text(currentAnswer.hope_content);
            $('#CurrentCommentPicture_explain').text(currentAnswer.picture_explain);
            
            $('#AfterCommentTypeOfInvent').text(currentAnswer.re_typeOfInvent);
            $('#AfterCommentTitle').text(currentAnswer.re_title);
            $('#AfterCommentSummary').text(currentAnswer.re_summary);
            $('#AfterCommentWhyInvent').text(currentAnswer.re_whyInvent);
            $('#AfterCommentProblem').text(currentAnswer.re_problem);
            $('#AfterCommentSolution').text(currentAnswer.re_solution);
            $('#AfterCommentEffect').text(currentAnswer.re_effect);
            $('#AfterCommentCore_Element').text(currentAnswer.re_core_element);
            $('#AfterCommentFiles').text(currentAnswer.re_file);
            $('#AfterCommentPicture_explain').text(currentAnswer.re_picture_explain);
            $('#AfterCommentHope_content').text(currentAnswer.re_hope_content);
            
         }
         else
            alert('ajax Error');
      },
      error: function(request,status,error)
      {
           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
   });   
}


//beforeComment는 항상 disable
var enableInput = function()
{
	$('#AfterCommentTypeOfInvent').children("textarea").removeClass('disabled');
	$('#AfterCommentTypeOfInvent').children("textarea").attr('disabled',false);
	$('#AfterCommentTitle').children("textarea").removeClass('disabled');
	$('#AfterCommentTitle').children("textarea").attr('disabled',false);
	$('#AfterCommentSummary').children("textarea").removeClass('disabled');
	$('#AfterCommentSummary').children("textarea").attr('disabled',false);
	$('#AfterCommentWhyInvent').children("textarea").removeClass('disabled');
	$('#AfterCommentWhyInvent').children("textarea").attr('disabled',false);
	$('#AfterCommentProblem').children("textarea").removeClass('disabled');
	$('#AfterCommentProblem').children("textarea").attr('disabled',false);
	$('#AfterCommentSolution').children("textarea").removeClass('disabled');
	$('#AfterCommentSolution').children("textarea").attr('disabled',false);
	$('#AfterCommentEffect').children("textarea").removeClass('disabled');
	$('#AfterCommentEffect').children("textarea").attr('disabled',false);
	$('#AfterCommentCore_Element').children("textarea").removeClass('disabled');
	$('#AfterCommentCore_Element').children("textarea").attr('disabled',false);
	$('#AfterCommentFiles').children("textarea").removeClass('disabled');
	$('#AfterCommentFiles').children("textarea").attr('disabled',false);

	$('#tmpSave').show();
	$('#agree').show();		

}

var disableInput = function()
{
	$('#AfterCommentTypeOfInvent').children("textarea").addClass('disabled');
	$('#AfterCommentTypeOfInvent').children("textarea").attr('disabled',true);
	$('#AfterCommentTitle').children("textarea").addClass('disabled');
	$('#AfterCommentTitle').children("textarea").attr('disabled',true);
	$('#AfterCommentSummary').children("textarea").addClass('disabled');
	$('#AfterCommentSummary').children("textarea").attr('disabled',true);
	$('#AfterCommentWhyInvent').children("textarea").addClass('disabled');
	$('#AfterCommentWhyInvent').children("textarea").attr('disabled',true);
	$('#AfterCommentProblem').children("textarea").addClass('disabled');
	$('#AfterCommentProblem').children("textarea").attr('disabled',true);
	$('#AfterCommentSolution').children("textarea").addClass('disabled');
	$('#AfterCommentSolution').children("textarea").attr('disabled',true);
	$('#AfterCommentEffect').children("textarea").addClass('disabled');
	$('#AfterCommentEffect').children("textarea").attr('disabled',true);
	$('#AfterCommentCore_Element').children("textarea").addClass('disabled');
	$('#AfterCommentCore_Element').children("textarea").attr('disabled',true);
	$('#AfterCommentFiles').children("textarea").addClass('disabled');
	$('#AfterCommentFiles').children("textarea").attr('disabled',true);

	$('#tmpSave').hide();
	$('#agree').hide();		

}
var tempApply=function(role){
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
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
	 	   	location.href="/";
 	    },
 	    error: function(request,status,error)
		{
 			alert('임시 저장에 실패하였습니다.')
 			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
		data['role'] 			= "inventor";
		data['typeOfInvent'] 	= $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['title'] 			= $('#AfterCommentTitle').children("textarea").val();
		data['summary'] 		= $('#AfterCommentSummary').children("textarea").val();
		data['whyInvent']		= $('#AfterCommentWhyInvent').children("textarea").val();
		data['problem'] 		= $('#AfterCommentProblem').children("textarea").val();
		data['solution'] 		= $('#AfterCommentSolution').children("textarea").val();
		data['effect'] 			= $('#AfterCommentEffect').children("textarea").val();
		data['core_element'] 	= $("#AfterCommentCore_Element").children("textarea").val();
	}
	//변리사인 경우
	else if(role=="pl")
	{
		data['role'] 			= "pl";
		data['re_typeOfInvent'] = $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['re_title'] 		= $('#AfterCommentTitle').children("textarea").val();
		data['re_summary'] 		= $('#AfterCommentSummary').children("textarea").val();
		data['re_whyInvent'] 	= $('#AfterCommentWhyInvent').children("textarea").val();
		data['re_problem'] 		= $('#AfterCommentProblem').children("textarea").val();
		data['re_solution']		= $('#AfterCommentSolution').children("textarea").val();
		data['re_effect'] 		= $('#AfterCommentEffect').children("textarea").val();
		data['re_core_element'] = $('#AfterCommentCore_Element').children("textarea").val();
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
 			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
 	
}
//저장
var ideaSave = function(role)
{
	if(role == "inventor")
	{
		alert('(확인, 취소로 바꾸기) 저장 후 변리사가 코멘트를 완료하기 전까지 수정 할 수 없습니다.');	
	}	
	else if(role == "pl")
	{
		alert('(확인, 취소로 바꾸기) 저장 후 고객이 내용을 수정하기까지 수정 할 수 없습니다.');	
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
		data['role'] 			= "inventor";
		data['typeOfInvent'] 	= $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['title'] 			= $('#AfterCommentTitle').children("textarea").val();
		data['summary'] 		= $('#AfterCommentSummary').children("textarea").val();
		data['whyInvent']		= $('#AfterCommentWhyInvent').children("textarea").val();
		data['problem'] 		= $('#AfterCommentProblem').children("textarea").val();
		data['solution'] 		= $('#AfterCommentSolution').children("textarea").val();
		data['effect'] 			= $('#AfterCommentEffect').children("textarea").val();
		data['core_element'] 	= $("#AfterCommentCore_Element").children("textarea").val();
	}
	//변리사인 경우
	else if(role=="pl")
	{
		data['role'] 			= "pl";
		data['re_typeOfInvent'] = $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['re_title'] 		= $('#AfterCommentTitle').children("textarea").val();
		data['re_summary'] 		= $('#AfterCommentSummary').children("textarea").val();
		data['re_whyInvent'] 	= $('#AfterCommentWhyInvent').children("textarea").val();
		data['re_problem'] 		= $('#AfterCommentProblem').children("textarea").val();
		data['re_solution']		= $('#AfterCommentSolution').children("textarea").val();
		data['re_effect'] 		= $('#AfterCommentEffect').children("textarea").val();
		data['re_core_element'] = $('#AfterCommentCore_Element').children("textarea").val();
	}
	else
	{
		alert(role);
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
 			location.href ="/mainPage";
 	    },
 	    error: function(request,status,error)
		{
 			alert('저장에 실패하였습니다')
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
 	
}
function imgsave(){
	 alert("s");
	 
}
var hideBeforeCmt = function()
{
	var hideEl = document.getElementsByClassName('before_cmt')
	for(var i =0; i <hideEl.length ; i++)
		hideEl[i].style.display="none";
}
var hideCurrentCmt = function()
{
	var hideEl = document.getElementsByClassName('current_cmt')
	for(var i =0; i <hideEl.length ; i++)
		hideEl[i].style.display="none";	
}
var showBeforeCmt = function()
{
	var hideEl = document.getElementsByClassName('before_cmt')
	for(var i =0; i <hideEl.length ; i++)
		hideEl[i].style.display="";
}
var showCurrentCmt = function()
{
	var hideEl = document.getElementsByClassName('current_cmt')
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
					$('#BeforeCommentTypeOfInvent').children('textarea').text(beforeComment.typeOfInvent);
					$('#BeforeCommentTitle').children('textarea').text(beforeComment.title);
					$('#BeforeCommentSummary').children('textarea').text(beforeComment.summary);
					$('#BeforeCommentWhyInvent').children('textarea').text(beforeComment.whyInvent);
					$('#BeforeCommentProblem').children('textarea').text(beforeComment.problem);
					$('#BeforeCommentSolution').children('textarea').text(beforeComment.solution);
					$('#BeforeCommentEffect').children('textarea').text(beforeComment.effect);
					$('#BeforeCommentCore_Element').children('textarea').text(beforeComment.core_element);
				
					$('#CurrentTypeOfInvent').children("textarea").text(beforeComment.re_typeOfInvent);
					$('#CurrentTitle').children("textarea").text(beforeComment.re_title);
					$('#CurrentSummary').children("textarea").text(beforeComment.re_summary);
					$('#CurrentWhyInvent').children("textarea").text(beforeComment.re_whyInvent);
					$('#CurrentProblem').children("textarea").text(beforeComment.re_problem);
					$('#CurrentSolution').children("textarea").text(beforeComment.re_solution);
					$('#CurrentEffect').children("textarea").text(beforeComment.re_effect);
					$('#CurrentCore_Element').children("textarea").text(beforeComment.re_core_element);
					
					showBeforeCmt();
					showCurrentCmt();
				}
				else
				{
					hideBeforeCmt();
					hideCurrentCmt();
				}
			
				var currentAnswer = retVal.currentAnswer;
				$('#AfterCommentTypeOfInvent').children('textarea').text(currentAnswer.typeOfInvent);
				$('#AfterCommentTitle').children('textarea').text(currentAnswer.title);
				$('#AfterCommentSummary').children('textarea').text(currentAnswer.summary);
				$('#AfterCommentWhyInvent').children('textarea').text(currentAnswer.whyInvent);
				$('#AfterCommentProblem').children('textarea').text(currentAnswer.problem);
				$('#AfterCommentSolution').children('textarea').text(currentAnswer.solution);
				$('#AfterCommentEffect').children('textarea').text(currentAnswer.effect);
				$('#AfterCommentCore_Element').children('textarea').text(currentAnswer.core_element);
				
			}
			else if(role == "pl")
			{
				if(retVal.isFirst == "false")
				{
					var beforeComment = retVal.beforeComment;
					$('#BeforeCommentTypeOfInvent').children('textarea').text(beforeComment.re_typeOfInvent);
					$('#BeforeCommentTitle').children('textarea').text(beforeComment.re_title);
					$('#BeforeCommentSummary').children('textarea').text(beforeComment.re_summary);
					$('#BeforeCommentWhyInvent').children('textarea').text(beforeComment.re_whyInvent);
					$('#BeforeCommentProblem').children('textarea').text(beforeComment.re_problem);
					$('#BeforeCommentSolution').children('textarea').text(beforeComment.re_solution);
					$('#BeforeCommentEffect').children('textarea').text(beforeComment.re_effect);
					$('#BeforeCommentCore_Element').children('textarea').text(beforeComment.re_core_element);

					showBeforeCmt();

				}
				else
				{
					hideBeforeCmt();
				}
		
				var currentAnswer = retVal.currentAnswer;
				$('#CurrentTypeOfInvent').children("textarea").text(currentAnswer.typeOfInvent);
				$('#CurrentTitle').children("textarea").text(currentAnswer.title);
				$('#CurrentSummary').children("textarea").text(currentAnswer.summary);
				$('#CurrentWhyInvent').children("textarea").text(currentAnswer.whyInvent);
				$('#CurrentProblem').children("textarea").text(currentAnswer.problem);
				$('#CurrentSolution').children("textarea").text(currentAnswer.solution);
				$('#CurrentEffect').children("textarea").text(currentAnswer.effect);
				$('#CurrentCore_Element').children("textarea").text(currentAnswer.core_element);
			
				$('#AfterCommentTypeOfInvent').children('textarea').text(currentAnswer.re_typeOfInvent);
				$('#AfterCommentTitle').children('textarea').text(currentAnswer.re_title);
				$('#AfterCommentSummary').children('textarea').text(currentAnswer.re_summary);
				$('#AfterCommentWhyInvent').children('textarea').text(currentAnswer.re_whyInvent);
				$('#AfterCommentProblem').children('textarea').text(currentAnswer.re_problem);
				$('#AfterCommentSolution').children('textarea').text(currentAnswer.re_solution);
				$('#AfterCommentEffect').children('textarea').text(currentAnswer.re_effect);
				$('#AfterCommentCore_Element').children('textarea').text(currentAnswer.re_core_element);
			}
			else
				alert('ajax Error');
		},
		error: function(request,status,error)
		{
		       //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
}

var delImg = function(path,id,btnid)
{
	//alert(path+","+id);
	var element= document.getElementById(id);
	element.parentNode.removeChild(element);
	var btnelement= document.getElementById(btnid);
	btnelement.parentNode.removeChild(btnelement);
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};
	data[csrfParameter] = csrfToken;
    data["path"] = path;
    headers[csrfHeader] = csrfToken;
    $.ajax({
	    url : "/deleteFile",
	    dataType : "json",
	    type : "POST",
	    headers: headers,
	    data : data,
	    success: function(data) {
	        alert("성공:"+data.result);
	    },
	    error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"error:"+error);
	    }
	}); 
}

var readUrl = function(input,id) 
{	
	//alert(id);
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#'+id).attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}
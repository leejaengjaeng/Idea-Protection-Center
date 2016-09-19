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
	
	$('#RegTypeOfInvent').find('textarea').removeClass('disabled');
	$('#RegTypeOfInvent').find('textarea').attr('disabled',false);
	$('#RegTitle').children('textarea').removeClass('disabled');
	$('#RegTitle').children('textarea').attr('disabled',false);
	$('#RegSummary').children('textarea').removeClass('disabled');
	$('#RegSummary').children('textarea').attr('disabled',false);
	$('#RegWhyInvent').children('textarea').removeClass('disabled');
	$('#RegWhyInvent').children('textarea').attr('disabled',false);
	$('#RegProblem').children('textarea').removeClass('disabled');
	$('#RegProblem').children('textarea').attr('disabled',false);
	$('#RegSolution').children('textarea').removeClass('disabled');
	$('#RegSolution').children('textarea').attr('disabled',false);
	$('#RegEffect').children('textarea').removeClass('disabled');
	$('#RegEffect').children('textarea').attr('disabled',false);
	$('#RegCore_Element').children('textarea').removeClass('disabled');
	$('#RegCore_Element').children('textarea').attr('disabled',false);	
	
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
	
	$('#RegTypeOfInvent').find('textarea').addClass('disabled');
	$('#RegTypeOfInvent').find('textarea').attr('disabled',true);
	$('#RegTitle').children('textarea').addClass('disabled');
	$('#RegTitle').children('textarea').attr('disabled',true);
	$('#RegSummary').children('textarea').addClass('disabled');
	$('#RegSummary').children('textarea').attr('disabled',true);
	$('#RegWhyInvent').children('textarea').addClass('disabled');
	$('#RegWhyInvent').children('textarea').attr('disabled',true);
	$('#RegProblem').children('textarea').addClass('disabled');
	$('#RegProblem').children('textarea').attr('disabled',true);
	$('#RegSolution').children('textarea').addClass('disabled');
	$('#RegSolution').children('textarea').attr('disabled',true);
	$('#RegEffect').children('textarea').addClass('disabled');
	$('#RegEffect').children('textarea').attr('disabled',true);
	$('#RegCore_Element').children('textarea').addClass('disabled');
	$('#RegCore_Element').children('textarea').attr('disabled',true);	
	
	$('#tmpSave').hide();
	$('#agree').hide();		

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
		data['role'] = "inventor";
		data['typeOfInvent'] = $('#RegTypeOfInvent').children("textarea").val();
		data['title'] = $('#RegTitle').children("textarea").val();
		data['summary'] = $('#RegSummary').children("textarea").val();
		data['whyInvent'] = $('#RegWhyInvent').children("textarea").val();
		data['problem'] = $('#RegProblem').children("textarea").val();
		data['solution'] = $('#RegSolution').children("textarea").val();
		data['effect'] = $('#RegEffect').children("textarea").val();
		data['core_element'] = $("#RegCore_Element").children("textarea").val();
	}
	//변리사인 경우
	else if(role=="pl")
	{
		data['role'] = "pl";
		data['re_typeOfInvent'] = $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['re_title'] = $('#AfterCommentTitle').children("textarea").val();
		data['re_summary'] = $('#AfterCommentSummary').children("textarea").val();
		data['re_whyInvent'] = $('#AfterCommentWhyInvent').children("textarea").val();
		data['re_problem'] = $('#AfterCommentProblem').children("textarea").val();
		data['re_solution'] = $('#AfterCommentSolution').children("textarea").val();
		data['re_effect'] = $('#AfterCommentEffect').children("textarea").val();
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
		data['role'] = role;
		data['typeOfInvent'] = $('#RegTypeOfInvent').children("textarea").val();
		data['title'] =	$('#RegTitle').children("textarea").val();
		data['summary'] = $('#RegSummary').children("textarea").val();
		data['whyInvent'] = $('#RegWhyInvent').children("textarea").val();
		data['problem'] = $('#RegProblem').children("textarea").val();
		data['solution'] = $('#RegSolution').children("textarea").val();
		data['effect'] = $('#RegEffect').children("textarea").val();
		data['core_element'] = $("#RegCore_Element").children("textarea").val();
	}
	//변리사인 경우
	else if(role=="pl")
	{
		data['role'] = role;
		data['re_typeOfInvent'] = $('#AfterCommentTypeOfInvent').children("textarea").val();
		data['re_title'] = $('#AfterCommentTitle').children("textarea").val();
		data['re_summary'] = $('#AfterCommentSummary').children("textarea").val();
		data['re_whyInvent'] = $('#AfterCommentWhyInvent').children("textarea").val();
		data['re_problem'] = $('#AfterCommentProblem').children("textarea").val();
		data['re_solution'] = $('#AfterCommentSolution').children("textarea").val();
		data['re_effect'] = $('#AfterCommentEffect').children("textarea").val();
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


//클릭에 따라 내용 바꿔주기
var showClickedList = function(rid)
{
	$.ajax({
		url : "/detailByRid/"+rid,
		type:"GET",
		success:function(retVal)
		{
			if(retVal != "")
			{
				var currentComment = retVal.item;
				$('#RegTypeOfInvent').children("textarea").text(currentComment.typeOfInvent);
				$('#RegTitle').children("textarea").text(currentComment.title);
				$('#RegSummary').children("textarea").text(currentComment.summary);
				$('#RegWhyInvent').children("textarea").text(currentComment.whyInvent);
				$('#RegProblem').children("textarea").text(currentComment.problem);
				$('#RegSolution').children("textarea").text(currentComment.solution);
				$('#RegEffect').children("textarea").text(currentComment.effect);
				$('#RegCore_Element').children("textarea").text(currentComment.core_element);
			
				var afterComment = retVal.afterComment;
				$('#AfterCommentTypeOfInvent').children('textarea').text(afterComment.re_typeOfInvent);
				$('#AfterCommentTitle').children('textarea').text(afterComment.re_title);
				$('#AfterCommentSummary').children('textarea').text(afterComment.re_summary);
				$('#AfterCommentWhyInvent').children('textarea').text(afterComment.re_whyInvent);
				$('#AfterCommentProblem').children('textarea').text(afterComment.re_problem);
				$('#AfterCommentSolution').children('textarea').text(afterComment.re_solution);
				$('#AfterCommentEffect').children('textarea').text(afterComment.re_effect);
				$('#AfterCommentCore_Element').children('textarea').text(afterComment.re_core_element);
			
				var beforeComment = retVal.beforeComment;
				if(beforeComment == null)
				{
					$('#BeforeCommentTypeOfInvent').children('textarea').text("이전 코멘트");
					$('#BeforeCommentTitle').children('textarea').text("이전 코멘트");
					$('#BeforeCommentSummary').children('textarea').text("이전 코멘트");
					$('#BeforeCommentWhyInvent').children('textarea').text("이전 코멘트");
					$('#BeforeCommentProblem').children('textarea').text("이전 코멘트");
					$('#BeforeCommentSolution').children('textarea').text("이전 코멘트");
					$('#BeforeCommentEffect').children('textarea').text("이전 코멘트");
					$('#BeforeCommentCore_Element').children('textarea').text("이전 코멘트");
				}
				else
				{
					$('#BeforeCommentTypeOfInvent').children('textarea').text(beforeComment.re_typeOfInvent);
					$('#BeforeCommentTitle').children('textarea').text(beforeComment.re_title);
					$('#BeforeCommentSummary').children('textarea').text(beforeComment.re_summary);
					$('#BeforeCommentWhyInvent').children('textarea').text(beforeComment.re_whyInvent);
					$('#BeforeCommentProblem').children('textarea').text(beforeComment.re_problem);
					$('#BeforeCommentSolution').children('textarea').text(beforeComment.re_solution);
					$('#BeforeCommentEffect').children('textarea').text(beforeComment.re_effect);
					$('#BeforeCommentCore_Element').children('textarea').text(beforeComment.re_core_element);
				}
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
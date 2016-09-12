<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protection Center</title>
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>  
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">    
<script>
$(document).ready(function()
{
	//권한에 따라 보여주기
	if("${user}" == "pl")
	{
		var hideEl = document.getElementsByClassName('before_cmt')
		for(var i =0; i <hideEl.length ; i++)
			hideEl[i].style.display="none";
	}
	else if("${user}" == "inventor")
	{
		var hideEl = document.getElementsByClassName('box_comment1')
		for(var i =0; i <hideEl.length ; i++)
			hideEl[i].style.display="none";
	}
	else
	{
		location.href="/authError";
	}	
	
	//진행내역에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","tr",function()
	{
		var rid = $(this).children('input').attr('value');
		showClickedList(rid);	
	})

	//예시 
    $(".txt_box > button").click(function(){
        $(this).nextAll(".hiding_box").fadeIn();
    });
    $(".close_btn").click(function(){
        $(this).parents(".hiding_box").fadeOut();
    });

	//폼 버튼 이벤트 
	$('#tmpSave').on("click",function()
	{
		tmpSave();
	});
	$('#agree').on("click",function()
	{
		alert('저장 구현중');
	});
});

//임시 저장
var tmpSave = function()
{
	
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};

	data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;
    
    
	//발명가인 경우 
	if("${user}"=="inventor")
	{
		data['role'] = "inventor";
		data['rid'] = $('#currentPosition').val();
		data['typeOfInvent'] = $('#RegtypeOfInvent').children("input").val();
		data['title'] = $('#RegTitle').children("input").val();
		data['summary'] = $('#RegSummary').children("textarea").val();
		data['whyInvent'] = $('#RegWhyInvent').children("textarea").val();
		data['problem'] = $('#RegProblem').children("textarea").val();
		data['solution'] = $('#RegSolution').children("textarea").val();
		data['effect'] = $('#RegEffect').children("textarea").val();
		data['core_element'] = $("#RegCore_Element").children("textarea").val();
	}
	//변리사인 경우
	else if("${user}"=="pl")
	{
		data['role'] = "pl";
		data['rid'] = $('#currentPosition').val();
		data['re_typeOfInvent'] = $('#AfterCommentTypeOfInvent').children("input").val();
		data['re_title'] = $('#AfterCommentTitle').children("input").val();
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
	
	console.log(data);

    $.ajax({
		url : "/tmpSave",
		type:"POST",
		headers: headers,
 	    data : data,
 	    success:function(retVal)
 	    {
 			alert('임시 저장 완료')
 	    },
 	    error: function(request,status,error)
		{
 			alert('임시 저장에 실패하였습니다.')
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
 	
}


//진행내역에 따라 내용 바꿔주기
var showClickedList = function(rid)
{
	$.ajax({
		url : "/detailByRid/"+rid,
		type:"GET",
		success:function(retVal)
		{
			
			if(retVal != "")
			{
				var result = retVal.item;
				$('#currentPosition').val(result.rid);
				$('#RegTypeOfInvent').children('input').val(result.typeOfInvent);
				$('#RegTitle').children('textarea').text(result.title);
				$('#RegSummary').children('textarea').text(result.summary);
				$('#RegWhyInvent').children('textarea').text(result.whyInvent);
				$('#RegProblem').children('textarea').text(result.problem);
				$('#RegSolution').children('textarea').text(result.solution);
				$('#RegEffect').children('textarea').text(result.effect);
				$('#RegCore_Element').children('textarea').text(result.core_element);
			
				if(retVal.role == "inventor")
				{
					var comment = retVal.beforeComment;
					if(comment == null)
					{
						$('#BeforeCommentTypeOfInvent').children('input').val("이전 코멘트");
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
						$('#BeforeCommentTypeOfInvent').children('input').val(comment.re_typeOfInvent);
						$('#BeforeCommentTitle').children('textarea').text(comment.re_title);
						$('#BeforeCommentSummary').children('textarea').text(comment.re_summary);
						$('#BeforeCommentWhyInvent').children('textarea').text(comment.re_whyInvent);
						$('#BeforeCommentProblem').children('textarea').text(comment.re_problem);
						$('#BeforeCommentSolution').children('textarea').text(comment.re_solution);
						$('#BeforeCommentEffect').children('textarea').text(comment.re_effect);
						$('#BeforeCommentCore_Element').children('textarea').text(comment.re_core_element);
					}
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
</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">       
        <section>            
           <nav>
                <div id="profile">
                    <img src="#" alt="profile">
                    <h4>${sessionScope.currentUser.getName()} 회원님</h4>
                    <span>${sessionScope.currentUser.getId()}</span>
                </div>
                <div id="profile_menu">
                    <ul>
                        <li>아이디어 진행내역</li>
                        <li>회원정보수정</li>                                                
                    </ul>
                </div>
                <div id="nav_benner">
                    <ul>
                        <li>
                            <img src="/resources/image/index_patent_1.jpg" alt="benner1">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_2.jpg" alt="benner2">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_3.jpg" alt="benner3">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_4.jpg" alt="benner4">
                        </li>
                    </ul>
                </div>
            </nav>            
            <article class="sub_head">                    
                <h1><b>아이디어</b> 초안</h1>                
                <img src="/resources/image/cmt.png" alt="cmt" style="width:100%; float:left;">
            </article>                
            <article class="modify_log">                    
                <h1>아이디어수정내역</h1>   
                <table id="IdeaModifyList">
                    <c:forEach items="${processList}" var="list" varStatus="status">
						<tr>
							<input type="hidden" value="${list.getRid()}"/>
							<c:if test="${status.index == 0}">
								<td class="title_td">아이디어 등록(초안)</td>
							</c:if>
							<c:if test="${status.index > 0}">
								<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
	                        </c:if>
	                        <td class="date_td">${list.getRegistration_date()}</td>
	                    </tr>                    
					</c:forEach>
                </table>                             
            </article>  
            <article style="width: 75%;">
               <input id="currentPosition" type="hidden" value="${item.getRid()}"/>
               <div class="txt_box">
                    <h2>발명분야</h2>   
                    <button>작성 예시</button>
                    <div id="BeforeCommentTypeOfInvent" class="before_cmt">
                        <textarea name="BeforeCommentTypeOfInvent"  disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>             
                    <div id="RegtypeOfInvent" class="box_before1">                        
                        <input type="text" value="${item.getTypeOfInvent() }" />
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentTypeOfInvent" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name="AfterCommentTypeOfInvent" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                       <div class="hiding_box_header">
                           <h3>저작물 명칭</h3>
                           <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                       </div>  
                       <div class="hiding_box_content">
                           <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                       </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentTitle" class="before_cmt">
                        <textarea name="BeforeCommentTitle" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegTitle" class="box_before1">                        
                        <input type="text" name="RegTitle" value="${item.getTitle() }"/>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentTitle" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name="AfterCommentTitle" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>요약</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentSummary" class="before_cmt">
                        <textarea name="BeforeCommentSummary" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>                    
                    <div id="RegSummary" class="box_before1_b">   
	                    <textarea name="RegSummary">${item.getSummary()}</textarea>                     
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentSummary" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name="AfterCommentSummary" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="txt_box">
                    <h2>필요이유</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentWhyInvent" class="before_cmt">
                        <textarea name="BeforeCommentWhyInvent" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegWhyInvent" class="box_before1_b">                        
                         <textarea name="RegSummary">${item.getSummary()}</textarea>                     
                   </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentWhyInvent" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentProblem" class="before_cmt">
                    	<textarea name="BeforeCommentProblem" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegProblem" class="box_before1_b">                        
                         <textarea name="RegSummary">${item.getSummary()}</textarea>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentProblem" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name ="AfterCommentProblem" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>문제해결방법</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentSolution" class="before_cmt">
                    	<textarea name="BeforeCommentSolution" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegSolution" class="box_before1_b">                        
                    	<textarea name="RegSummary">${item.getSummary()}</textarea>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentSolution" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name="AfterCommentSolution" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>발명의 효과</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentEffect" class="before_cmt">
                   		<textarea name="BeforeCommentEffect" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegEffect" class="box_before1_b">                        
                    	<textarea name="RegSummary">${item.getSummary()}</textarea>
					</div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentEffect" class="comment1_txt">
                           <img src="/resources/image/arr.png">
                            <textarea name = "AfterCommentEffect" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>핵심구성요소</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentCore_Element" class="before_cmt">
                    	<textarea name="BeforeCommentCore_Element" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegCore_Element" class="box_before1_b">                        
                    	<textarea name="RegSummary">${item.getSummary()}</textarea>
					</div>
                    <div class="box_comment1">                    
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentCore_Element" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea name ="AfterCommentCore_Element" placeholder="Comment..."></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <form id="commentForm">             
	                <div class="txt_box">
	                    <h2 style="width:100%">도면첨부</h2>
	                    <button>작성 예시</button>
	                    <div id="BeforeCommentCore_Element" class="before_cmt">
	                    	<textarea name="BeforeCommentCore_Element" disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
	                    </div>
	                    <div id="demo_box">
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>                                            
	                    </div>
	                    <div class="box_comment1">
	                        <div class="img_comt">
	                            <img src="/resources/image/comment.png" alt="cmt_img">
	                        </div> 
	                        <div id="AfterCommentFiles" class="comment1_txt">
	                            <img src="/resources/image/arr.png">
	                            <textarea placeholder="Comment..."></textarea>
	                        </div>
	                    </div>
	                    <div class="hiding_box">
	                        <div class="hiding_box_header">
	                            <h3>저작물 명칭</h3>
	                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
	                        </div>  
	                        <div class="hiding_box_content">
	                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
	                        </div>                                                   
	                    </div>
	                </div>     
	                <div class="hr"></div>           
	                <div id="fin"> 
	                    <button type="button" id="tmpSave">임시저장</button>
	                    <button type="button" id="agree">코멘트작성</button>                    
	                </div>
	            </form>
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
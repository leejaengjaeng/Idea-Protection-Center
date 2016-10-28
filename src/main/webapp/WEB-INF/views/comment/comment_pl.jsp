<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protectection Center</title>
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>  
    <script src="/resources/common/js/comment.js"></script>  
    
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
	<style>
		.after_cmt>textarea{
		
			margin-top:0 !important;
		}
	</style>
<script>
$(document).ready(function()
{
	if("${isFirst}" == "true")
	{
		hideBeforeCmt();
	}

	if("${currentAnswer.getIscomplete()}" == 1)
		enableInput();
	else if ("${currentAnswer.getIscomplete()}" == 2){
		disableInputApply();
		alert("가출원상태에서는 수정을 할 수 없습니다.");
	}
	else if ("${currentAnswer.getIscomplete()}"==3){
		disableInputApply();
		alert("발명가 회원님이 최종 확인중입니다.");
	}
	else if ("${currentAnswer.getIscomplete()}"==4){
		disableInputApply();
		alert("발명가 회원님이 최종 확인중입니다.");
	}
	else 
	{
		disableInput();
		alert('고객이 작성을 완료하기를 기다려주세요');			
	}
	
	//폼 버튼 이벤트 
	$('#tmpSave').on("click",function()
	{
		tmpSave("${user}");
	});
	$('#agree').on("click",function()
	{
		ideaSave("${user}");
	});
	$('#gogogo').on("click",function(){                         
		var q=confirm("위의 내용을 최종 작성본으로 확인하시겠습니까?")       
		if(q==true){                                                      
			lastConfirm("${user}");                                 
		}                                                         
		else{                                                     
			return false;                                         
		}                                                         
		                                                          
	});                                                         
	//$('#gogogo').on("click",function(){
	//	var q=confirm("출원을 선택하면 수정할 수 없습니다. 출원을 선택하시겠습니까?")
    //	if(q==true){
    //		alert("확인을 누르시면 가출원 양식 서류가 다운받아집니다.");
    //		tempApply("${user}");
    //	}
    //	else{
    //		return false;
    //	}
	//	
	//});
	//클릭에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","tr",function()
	{
		//IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
		$(this).parent().find('.clickedIdea').removeClass('clickedIdea');
		var rid = $(this).children('input').attr('value');
		
		if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 1))
		{
			enableInput();
		}
		else
		{
			disableInput();
		}

		//현재 선택된 요소(tr)에 clickedIdea를 붙임
		$(this).addClass('clickedIdea');
		
		showClickedList(rid);	
	})

	//작성 예시 버튼 이벤트
    $(".txt_box > button").click(function(){
        $(this).nextAll(".hiding_box").fadeIn();
    });
    $(".close_btn").click(function(){
    	
        $(this).parents(".hiding_box").fadeOut();
    });

});

var i=0;
function addFile(){
	$('#inputFileDiv').append("<div style='float:left;text-align:center;margin:40px 5px 20px 5px; width:230px;'><img style='width:50px' src='/resources/image/plus.png' alt='img' id='"+i+"'><br><input type='file' id='imgInp"+i+"' name='addupimgs' onchange='readURL(this,"+i+")' name='profileImg' style='padding-top:5px; font-size:12px;'></div>");
	i++;
}

</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">       
        <section>            
           <nav>
                <div id="profile">
                    <img src="/resources/image/attonrney_profile.jpg" alt="profile">
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
                        <li onclick="loaction.href='/registration/addidea'">
                            <img src="/resources/image/sub_banner_1.jpg" alt="benner1">
                        </li>                       
                    </ul>
                </div>
            </nav>            
            <article class="sub_head">                    
                <h1><b>아이디어</b> 초안</h1>                
                <img src="/resources/image/cmt.jpg" alt="cmt" style="width:100%; float:left; margin-bottom:100px;">
            </article>                
            <article class="modify_log">                    
                <h1>아이디어수정내역</h1>   
                <table id="IdeaModifyList">
                	<c:forEach items="${processList}" var="list" varStatus="status">
						<c:choose>
						<%-- 목록이 하나인 경우 --%>
							<c:when test="${status.first and status.last }">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">아이디어 등록(초안)</td>
							       <td class="date_td">${list.getRegistration_date()}</td>
			                	</tr>
							</c:when>
						<%-- 목록이 하나가 아닌 경우 --%>
							<c:when test="${status.first}">
								<tr>
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">아이디어 등록(초안)</td>
							       <td class="date_td">${list.getRegistration_date()}</td>
			                	</tr>
							</c:when>
							<c:when test="${status.last}">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
			                        <td class="date_td">${list.getRegistration_date()}</td>
			                  	</tr>
							</c:when>
							<c:otherwise>	
								<tr>
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
			                        <td class="date_td">${list.getRegistration_date()}</td>
			                  	</tr>
			               	</c:otherwise>
			          	</c:choose>
					</c:forEach>		
				</table>                             
            </article>  
            <article style="width: 75%;">
               <input id="currentPosition" type="hidden" value="${currentAnswer.getRid()}"/>
               <div class="txt_box">
<!-- 1. 발명 분야 -->
                 	<h2>발명분야</h2> <button>작성 예시</button>
                    
                    <div id="BeforeCommentTypeOfInvent" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_typeOfInvent()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentTypeOfInvent" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getTypeOfInvent() }</textarea>
                    </div>             
           
                    <div id="AfterCommentTypeOfInvent" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_typeOfInvent() }</textarea>
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
<!-- 2. 제목 -->
                <div class="txt_box">
                    <h2>제목</h2> <button>작성 예시</button>
                   
                    <div id="BeforeCommentTitle" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_title()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentTitle" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getTitle()}</textarea>
                    </div>             
           
                    <div id="AfterCommentTitle" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_title()}</textarea>
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
<!-- 3. 요약 -->
			    <div class="txt_box">
                    <h2>요약</h2> <button>작성 예시</button>
        
                    <div id="BeforeCommentSummary" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_summary()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentSummary" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getSummary()}</textarea>
                    </div>             
           
                    <div id="AfterCommentSummary" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_summary()}</textarea>
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
<!-- 4. 필요 이유 -->
                <div class="txt_box">
                    <h2>필요이유</h2> <button>작성 예시</button>
                    
                    <div id="BeforeCommentWhyInvent" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_whyInvent()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentWhyInvent" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getWhyInvent()}</textarea>
                    </div>             
           
                    <div id="AfterCommentWhyInvent" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_whyInvent()}</textarea>
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
<!-- 5. 기존제품 설명 및 문제점 -->
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2> <button>작성 예시</button>
                    
       				<div id="BeforeCommentProblem" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_problem()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentProblem" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getProblem()}</textarea>
                    </div>             
           
                    <div id="AfterCommentProblem" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_problem()}</textarea>
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
<!-- 6. 문제 해결 방법 -->
                <div class="txt_box">
                    <h2>문제해결방법</h2> <button>작성 예시</button>
                  
                    <div id="BeforeCommentSolution" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_solution()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentSolution" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getSolution()}</textarea>
                    </div>             
           
                    <div id="AfterCommentSolution" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_solution()}</textarea>
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
<!-- 7. 발명의 효과 -->
                <div class="txt_box">
                    <h2>발명의 효과</h2> <button>작성 예시</button>
                  
                    <div id="BeforeCommentEffect" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_effect()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentEffect" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getEffect()}</textarea>
                    </div>             
           
                    <div id="AfterCommentEffect" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_effect()}</textarea>
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
<!-- 8. 핵심구성요소 -->
                <div class="txt_box">
                    <h2>핵심구성요소</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentCore_Element" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_core_element()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentCore_Element" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getCore_element()}</textarea>
                    </div>             
           
                    <div id="AfterCommentCore_Element" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_core_element()}</textarea>
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
<!-- 9. 권리를 보장받고자 하는 내용 -->
                <div class="txt_box">
                    <h2>권리를 보장받고자 하는 내용</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentHope_content" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_hope_content()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentHope_content" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getHope_content()}</textarea>
                    </div>             
           
                    <div id="AfterCommentHope_content" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_hope_content()}</textarea>
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
<!-- 10. 도면에 대한 설명 -->
                <div class="txt_box">
                    <h2>도면에 대한 설명</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentPicture_explain" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeComment.getRe_picture_explain()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
           			
           			<div id="CurrentPicture_explain" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${currentAnswer.getPicture_explain()}</textarea>
                    </div>             
           
                    <div id="AfterCommentPicture_explain" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getRe_picture_explain()}</textarea>
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
<!-- 11. 도면 첨부 -->
                <form id="commentForm">             
	                <div class="txt_box">
	                              						
	                    <div id="demo_box">
		                    <c:forEach items="${imgs}" var="list" varStatus="status">
			                    <div>
			                    	<a href="${list.getFile_path()}" id="id${list.getRfid()}" style="clear:both"><img src="${list.getFile_path()}" style="width:200px; height:200px; border:1px solid #ccc;  float:left; margin:20px;"></a>
		                        </div>		                        
		                    </c:forEach>
		                    
		                        <div id="inputFileDiv"></div>
		                        <!--  
		                        <div class="demo">
		                        	<input type="file">
		                        	<img src="/resources/image/plus.png" alt="plus">
		                        </div>
		                        -->                                           
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
	                    <button type="button" id="agree">저장</button>  
	                    <button type="button" id="gogogo">최종작성본</button>                    
	                </div>
	            </form>
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
	 
	
</script>
</body>
</html>
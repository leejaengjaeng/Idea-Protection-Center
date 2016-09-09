<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Idea Protection Center</title>
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>  
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
<script>
$(document).ready(function()
{
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
	
	$('#IdeaModifyList').on("click","tr",function()
	{
		var rid = $(this).children('input').attr('value');
		$.ajax({
			url : "/detailByRid/"+rid,
			type:"GET",
			success:function(retVal)
			{
				if(retVal != "")
				{
					var result = retVal.item;
					$('#RegTypeOfInvent').children().text(result.typeOfInvent);
					$('#RegTitle').children().text(result.title);
					$('#RegSummary').children().text(result.summary);
					$('#RegWhyInvent').children().text(result.whyInvent);
					$('#RegProblem').children().text(result.problem);
					$('#RegSolution').children().text(result.solution);
					$('#RegEffect').children().text(result.effect);
					$('#RegCore_Element').children().text(result.core_element);
				
					if(retVal.role == "inventor")
					{
						var comment = retVal.beforeComment;
						if(comment == null)
						{
							$('#BeforeCommentTypeOfInvent').children().text("이전 코멘트");
							$('#BeforeCommentTitle').children().text("이전 코멘트");
							$('#BeforeCommentSummary').children().text("이전 코멘트");
							$('#BeforeCommentWhyInvent').children().text("이전 코멘트");
							$('#BeforeCommentProblem').children().text("이전 코멘트");
							$('#BeforeCommentSolution').children().text("이전 코멘트");
							$('#BeforeCommentEffect').children().text("이전 코멘트");
							$('#BeforeCommentCore_Element').children().text("이전 코멘트");
						}
						else
						{
							$('#BeforeCommentTypeOfInvent').children().text(comment.re_typeOfInvent);
							$('#BeforeCommentTitle').children().text(comment.re_title);
							$('#BeforeCommentSummary').children().text(comment.re_summary);
							$('#BeforeCommentWhyInvent').children().text(comment.re_whyInvent);
							$('#BeforeCommentProblem').children().text(comment.re_problem);
							$('#BeforeCommentSolution').children().text(comment.re_solution);
							$('#BeforeCommentEffect').children().text(comment.re_effect);
							$('#BeforeCommentCore_Element').children().text(comment.re_core_element);
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
	})
});
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
                            <img src="#" alt="benner1">
                        </li>
                        <li>
                            <img src="#" alt="benner2">
                        </li>
                        <li>
                            <img src="#" alt="benner3">
                        </li>
                        <li>
                            <img src="#" alt="benner4">
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
            <article>
            <!--<form id="commentForm">-->
                <div class="txt_box">
                    <h2>발명분야</h2>   
                    <button>작성 예시</button>
                    <div id="BeforeCommentTypeOfInvent" class="before_cmt">
                        <textarea name="BeforeCommentTypeOfInvent"  disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
                    </div>             
                    <div id="RegtypeOfInvent" class="box_before1">                        
                        <input type="text" name="RegtypeOfInvent" value="${item.getTypeOfInvent() }" />
                  <!--  <span>${item.getTypeOfInvent() }</span> -->
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
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentTitle" class="before_cmt">
                        <textarea name="BeforeCommentTitle" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                        <textarea name="BeforeCommentSummary" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                        <textarea name="BeforeCommentWhyInvent" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                    	<textarea name="BeforeCommentProblem" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                    	<textarea name="BeforeCommentSolution" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                   		<textarea name="BeforeCommentEffect" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                    	<textarea name="BeforeCommentCore_Element" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                <div class="txt_box">
                    <h2 style="width:100%">도면첨부</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentCore_Element" class="before_cmt">
                    	<textarea name="BeforeCommentCore_Element" disabled="disabled" class="disabled"/> ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅁㄴㅇazscasdasdas</textarea>
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
                    <button id="tmpSave">임시저장</button>
                    <button id="agree">코멘트작성</button>                    
                </div>
            <!-- </form> -->
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
    $(".txt_box > button").click(function(){
        $(this).nextAll(".hiding_box").fadeIn();
    });
    $(".close_btn").click(function(){
        $(this).parents(".hiding_box").fadeOut();
    });
</script>
</body>
</html>
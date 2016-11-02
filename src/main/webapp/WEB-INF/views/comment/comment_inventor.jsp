<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protectection Center</title>
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>  
    <script src="/resources/common/js/comment.js"></script>  
    <script src="/resources/common/js/util.js" type="text/javascript"></script>
    
    <link href="/resources/common/css/cmt.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
<script>

$(document).ready(function()
{
	
	if("${isFirst}" == "true")
	{
		hideBeforeCmt();
		hideCurrentCmt();
		var optcnt = document.getElementById("selectBox").options.length;
		//alert("${beforeReg.getTypeOfInvent()}");
		for(i=0;i<optcnt;i++){
	  		if(document.getElementById("selectBox").options[i].value=="${currentAnswer.getTypeOfInvent()}"){
	  			document.getElementById("selectBox").options[i].selected=true;
	  		}
	  	}
	}
	else{
		var optcnt = document.getElementById("selectBox").options.length;
		//alert("${beforeReg.getTypeOfInvent()}");
		for(i=0;i<optcnt;i++){
	  		if(document.getElementById("selectBox").options[i].value=="${beforeReg.getTypeOfInvent()}"){
	  			document.getElementById("selectBox").options[i].selected=true;
	  		}
	  	}
	}
	/*
		//배치 변경
		var txtBoxList = $('.txt_box');
		for(var i=0; i<8; i++) //9개 항목, 마지막 항목은 current_Cmt가 없음
		{
			$(txtBoxList[i]).children('.before_cmt').children('textarea').css('float','right');
			$(txtBoxList[i]).children('.before_cmt').children('.img_comt').css('float','left');
			$(txtBoxList[i]).children('.current_cmt').children('.img_comt').css('cssText','float:right !important; margin:0 0 0 10px;');
			$(txtBoxList[i]).children('.after_cmt').children('.img_comt').css('float','left');				
			$(txtBoxList[i]).children('.after_cmt').children('textarea').css('cssText','float:right !important');				
		}
		$(txtBoxList[8]).children('.before_cmt').children('textarea').css('float','right !important');
		$(txtBoxList[8]).children('.before_cmt').children('.img_comt').css('float','left !important');
		$(txtBoxList[8]).children('.after_cmt').children('.img_comt').css('float','left !important');				
		
	*/
	//0 고객 작성중(변리사 작성 완료), 1 고객 작성 완료	
	if("${currentAnswer.getIscomplete()}" == 0)
	{		
		enableInput();	
	}
	else if("${currentAnswer.getIscomplete()}"==2){
		disableInput();
		btnHide();
		alert("가출원상태입니다.");
	}
	else if("${currentAnswer.getIscomplete()}"==3){
    	 disableInput();
    	 var q=confirm("변리사가 위의 내용으로 최종 확인하였습니다 출원 단계를 진행하시겠습니까?");
    	 if(q==true){                                                      
      	  gotoApply("${user}");                                 
     	}                                                         
     	else{
     		enableInput();
        	denyApply("${user}");
        	return false;                                         
  	 	  }
	}
	else if("${currentAnswer.getIscomplete()}"==4){
		   alert("aa");   
		   disableInput();
		                                                     
		         gotoApply("${user}");                                 
		                                                               
	   }     
	else
	{				
		disableInput();
		alert('변리사의 답변을 기다려주세요');
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
    
	//클릭에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","tr",function()
	{
		//IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
		$(this).parent().find('.clickedIdea').removeClass('clickedIdea');
		var rid = $(this).children('input').attr('value');
		
		if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 0))
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
});
</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
     <div class="wrap_comment">       
        <section>                      
            <article class="sub_head" style="margin-top:100px;">                    
                <h1>아이디어수정내역</h1>                
                <table id="IdeaModifyList">
                	<c:forEach items="${processList}" var="list" varStatus="status">
						<c:choose>
						
							<c:when test="${status.first and status.last }">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}"/>
								    <td class="title_td">아이디어 등록(초안)</td>
							        <td class="date_td">${list.getRegistration_date()}</td>
			                	</tr>
							</c:when>
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
            <article>
                <input id="currentPosition" type="hidden" value="${currentAnswer.getRid()}"/>           
                <div class="hiding_tab" style="position:relative;">
                    <select onChange=changeType(this.value); id="selectBox">
                   		<option>-</option>
                   		<c:forEach items="${typeList}" var="list" varStatus="status">
							<option>${list.getType()}</option>
						</c:forEach>                    		
                   	</select>        
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>제목</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentTitle">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                      
	                        </div>
	                        <input type="text" id="idea_title" name="title" required placeholder="45자 이내로 입력해주세요." class="disabled" disabled value="${beforeReg.getTitle()}">  
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentTitle">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_title()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentTitle">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getTitle()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>요약</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentSummary">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                      
	                        </div>
	                        <textarea name="summary" class="disabled" disabled>${beforeReg.getSummary()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentrCommentSummary">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_summary()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentSummary">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getSummary()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>필요이유</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentWhyInvent">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="whyInvent" class="disabled" disabled>${beforeReg.getWhyInvent()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentWhyInvent">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_whyInvent()}</textarea>
	                        </div>                            
	                    </div>       
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentWhyInvent">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getWhyInvent()}</textarea>
	                        </div>                            
	                    </div>             
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title" id="BeforeCommentProblem">
	                        <span>기존제품설명 및 문제점</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="problem" class="disabled" disabled>${beforeReg.getProblem()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentProblem">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_problem()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment" >
	                        <div class="tab_in" id="AfterCommentProblem">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getProblem()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>문제해결방법</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentSolution">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="solution" class="disabled" disabled>${beforeReg.getSolution()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentSolution">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_solution()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentSolution">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getSolution()}</textarea>
	                        </div>                            
	                    </div>
	                </div>    
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>        
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>발명의효과</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentEffect">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="effect" class="disabled" disabled>${beforeReg.getEffect()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentEffect">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_effect()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentEffect">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getEffect()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>핵심구성요소</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentCore_Element">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="core_element" class="disabled" disabled>${beforeReg.getCore_element()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentCore_Element">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_core_element()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in"id="AfterCommentCore_Element">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getCore_element()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>권리를 보장 받고자 하는 내용</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentHope_content">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="hope_content" class="disabled" disabled>${beforeReg.getHope_content()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentHope_content">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_hope_content()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in"id="AfterCommentHope_content">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getHope_content()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="full">
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>도면첨부</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt">                    
	                         <form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
	                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                            <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
	                            <input type="hidden" name="start_rid_file" value="${start_rid}">
	                        <div id="inputFileDiv">
	                                         
	                        </div>
	                        </form>
	                        <button type="button" onclick="addfile()">추가</button>
	                        <button type="button" onclick="delfile()">삭제</button>         
	                    </div>
	                    <div class="tab_imgs">
	                         <c:forEach items="${imgs}" var="list" varStatus="status">
	                           	<div  id="id${list.getRfid()}">
	                            	<img src="${list.getFile_path()}" onclick="location.href='${list.getFile_path()}'">
	                        		<button type="button" onclick="delImg('${list.getRfid()}')">삭제</button>
	                        	</div>
	                        </c:forEach>                  
	                    </div>     
	                </div>        
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>    
                </div>
                <div class="full">   
	                <div class="hiding_tab">
	                    <div class="tab_title">
	                        <span>도면에 대한 설명</span>
	                        <div class="arrow-up"></div>
	                    </div>
	                    <div class="tab_contents before_cmt" id="BeforeCommentPicture_explain">
	                        <div class="img_cover">                            
	                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
	                        </div>
	                        <textarea name="picture_explain" class="disabled" disabled>${beforeReg.getPicture_explain()}</textarea>
	                    </div>
	                    <div class="tab_comment current_cmt">
	                        <div class="tab_in" id="CurrentCommentPicture_explain">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/val1.png" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${beforeReg.getRe_picture_explain()}</textarea>
	                        </div>                            
	                    </div>
	                    <div class="tab_recomment">
	                        <div class="tab_in" id="AfterCommentPicture_explain">
	                            <div class="img_cover">                            
	                                <img src="/resources/image/inventor_profile.jpg" alt="123">
	                            </div>
	                            <textarea class="disabled" disabled>${currentAnswer.getPicture_explain()}</textarea>
	                        </div>                            
	                    </div>
	                </div>
	                <nav class="nav">
			            <button type="button">작성 예시</button>
			            <div class="modal">
			            	<p>
			            		발명의 내용을 용이하게 파악할 수<br> 
			            		있도록 다음 내용에 관한 사항을<br>
			            		기재합니다.
			            	</p>
			            </div>
		            </nav>
                </div>
                <div class="fin">
                    <button type ="button" id="tmpSave">임시저장</button>
                    <button type="button" id="agree">제출</button>
                </div>
                
            </article>
        </section>
    </div>       
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
var i=0;
function addfile()
{
	i++;
	$('#inputFileDiv').append("<div id='div"+i+"' style='float:left;text-align:center;margin:40px 5px 20px 5px; width:230px;'><img style='width:200px; height:200px; border:1px solid #ccc;' src='/resources/image/plus2.png' alt='img' id='"+i+"'><br><input type='file' style='padding-top:5px; font-size:12px;' id='imgInp"+i+"' name='imgs' onchange='readURL(this,"+i+");fileCheck(this)' name='profileImg' style='width:180px;'></div>");
	
}
function delfile(){
	$('#div'+i).remove();
	i--;
}
function readURL(input,imgId) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#'+imgId).attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}
function delImg(aa){
	alert(aa);
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	   var data = {};
	  
	   var headers = {};

	   data[csrfParameter] = csrfToken;
	    headers[csrfHeader] = csrfToken;

	    data['id'] = aa;
	    $.ajax({
	      url : "/deleteFile",
	      type:"POST",
	      headers: headers,
	        data : data,
	        success:function(retVal)
	        {
	        	$("#id"+aa).remove();
	             alert("삭제하였습니다.");
	        },
	        error: function(request,status,error)
	      {
	          alert('실패하였습니다.')
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	   });   
	    //location.href ="/mainPage";
}
$(function(){
   $("textarea").attr("placeholder", "Comment.."); 
});
$(".popup_close, #load_data").click(function(){
	$("body").css("overflow","auto");	
});
$(".tab_title").click(function(){
	if($(this).parent(".hiding_tab").hasClass("tab")){
    	$(this).removeClass("down"); 
	    $(this).parent(".hiding_tab").stop().animate({"max-height":"55px"}).removeClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(180deg)','border-bottom-color':'#036EB7'}).removeClass("tab");
    }else{            
    	$(this).addClass("down"); 
 	    $(this).parent(".hiding_tab").stop().animate({"max-height":"1000px"}).addClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(0deg)','border-bottom-color':'#036EB7'}).addClass("tab");
    }
});
$(".nav>button").click(function(){
	  $(this).next(".modal").css("display","block");
 });
 $(".modal").click(function(){
	  $(this).css("display","none"); 
 });
</script>
</body>
</html>
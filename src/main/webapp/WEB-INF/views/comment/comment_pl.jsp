<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Idea Protectection Center</title>
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/comment.js"></script>
<link href="/resources/common/css/cmt.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<link href="/resources/common/css/index.css" rel="stylesheet">
<style>
.after_cmt>textarea {
	margin-top: 0 !important;
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
     		alert("발명가 회원님이 서류 업로드 중입니다.");
     	}
     	else if ("${currentAnswer.getIscomplete()}"==5){
     		disableInputApply();
     		location.href="/downLoadPage";
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
            //var q=confirm("출원을 선택하면 수정할 수 없습니다. 출원을 선택하시겠습니까?")
            // if(q==true){
            //    alert("확인을 누르시면 가출원 양식 서류가 다운받아집니다.");
            //    tempApply("${user}");
            // }
            // else{
            //    return false;
            // }
            //
        	 var q=confirm("출원을 선택하면 수정할 수 없습니다. 출원을 선택하시겠습니까?");      
        	 if(q==true){                                            
        	    alert("확인을 누르시면 출원단계가 진행되어집니다.");               
        	    lastconfirm("${user}");                                
        	 }                                                       
        	 else{                                                   
        	    return false;                                        
        	 }                                                       
        	                                                         
         });
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
          var optcnt = document.getElementById("selectBox").options.length;
          for(i=0;i<optcnt;i++){
      		if(document.getElementById("selectBox").options[i].value=="${currentAnswer.getTypeOfInvent()}"){
      			document.getElementById("selectBox").options[i].selected=true;
      		}
      	}
      });
      
      </script>
<style>
	.tab_contents>textarea{
        float: right !important;
        width: 660px !important; 
        border-radius: 6px !important;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp" />
	<div class="wrap_comment">
		<section>
			<article class="modify_log"
				style="margin-top: 100px; padding-bottom: 65px;">
				<h1>아이디어수정내역</h1>
				<table id="IdeaModifyList">
					<c:forEach items="${processList}" var="list" varStatus="status">
						<c:choose>
							<%-- 목록이 하나인 경우 --%>
							<c:when test="${status.first and status.last }">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">아이디어 등록(초안)</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<%-- 목록이 하나가 아닌 경우 --%>
							<c:when test="${status.first}">
								<tr>
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">아이디어 등록(초안)</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<c:when test="${status.last}">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">${status.index}차전문가 검토 및 수정안</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">${status.index}차전문가 검토 및 수정안</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
			</article>
			<article>
				<input id="currentPosition" type="hidden"
					value="${currentAnswer.getRid()}" />
				<div class="hiding_tab" style="position: relative; margin-bottom:20px;">
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
							<input type="text" id="idea_title" name="title" required
								placeholder="45자 이내로 입력해주세요." class="disabled" disabled
								value="${beforeComment.getRe_title()}">
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentTitle">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getTitle()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentTitle">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_title()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
							<textarea name="summary" class="disabled" disabled>${beforeComment.getRe_summary()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentrCommentSummary">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getSummary()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentSummary">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_summary()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
							<textarea name="whyInvent" class="disabled" disabled>${beforeComment.getRe_whyInvent()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentWhyInvent">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getWhyInvent()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentWhyInvent">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_whyInvent()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
							<textarea name="problem" class="disabled" disabled>${beforeComment.getRe_problem()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentProblem">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getProblem()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentProblem">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_problem()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
							<textarea name="solution" class="disabled" disabled>${beforeComment.getRe_solution()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentSolution">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getSolution()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentSolution">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_solution()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
							<textarea name="effect" class="disabled" disabled>${beforeComment.getRe_effect()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentEffect">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getEffect()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentEffect">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_effect()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
						<div class="tab_contents before_cmt"
							id="BeforeCommentCore_element">
							<div class="img_cover">
								<img src="/resources/image/inventor_profile.jpg" alt="123">
							</div>
							<textarea name="core_element" class="disabled" disabled>${beforeComment.getRe_core_element()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentCore_element">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getCore_element()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">

							<div class="tab_in" id="AfterCommentCore_Element">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_core_element()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
						<div class="tab_contents before_cmt"
							id="BeforeCommentHope_content">
							<div class="img_cover">
								<img src="/resources/image/inventor_profile.jpg" alt="123">
							</div>
							<textarea name="hope_content" class="disabled" disabled>${beforeComment.getRe_hope_content()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentHope_content">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getHope_content()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentHope_content">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_hope_content()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
								
							</form>
						</div>
						<div class="tab_imgs">
							<c:forEach items="${imgs}" var="list" varStatus="status">
								<div onclick="location.href='${list.getFile_path()}'"
									id="id${list.getRfid()}">
									<img src="${list.getFile_path()}">
								</div>
							</c:forEach>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
						<div class="tab_contents before_cmt"
							id="BeforeCommentPicture_explain">
							<div class="img_cover">
								<img src="/resources/image/inventor_profile.jpg" alt="123">
							</div>
							<textarea name="picture_explain" class="disabled" disabled>${beforeComment.getRe_picture_explain()}</textarea>
						</div>
						<div class="tab_comment current_cmt">
							<div class="tab_in" id="CurrentCommentPicture_explain">
								<div class="img_cover">
									<img src="/resources/image/val1.png" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getPicture_explain()}</textarea>
							</div>
						</div>
						<div class="tab_recomment">
							<div class="tab_in" id="AfterCommentPicture_explain">
								<div class="img_cover">
									<img src="/resources/image/inventor_profile.jpg" alt="123">
								</div>
								<textarea class="disabled" disabled>${currentAnswer.getRe_picture_explain()}</textarea>
							</div>
						</div>
					</div>
					<nav class="nav">
						<button type="button">작성 예시</button>
						<div class="modal">
							<p>
								발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
							</p>
						</div>
					</nav>
				</div>
				<div class="fin">
					<button type="button" id="tmpSave">임시저장</button>
					<button type="button" id="agree">제출</button>
					<button type="button" id="gogogo">출원하기</button>
				</div>
				
			</article>
		</section>
	</div>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
    
var i=1;
function addfile(){
    i++;
    $('#upimgdiv').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:10px;'>");
    //var targetdiv=document.getElementById("uploaddiv");
    //targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";
}
$(function(){
   $("textarea").attr("placeholder", "Comment.."); 
   $("textarea , input , button").attr("tabindex","-1");
});
$(".popup_close, #load_data").click(function(){
   $("body").css("overflow","auto");   
});
$(".tab_title").click(function(){
	if($(this).parent(".hiding_tab").hasClass("tab")){                                       
    	$(this).removeClass("down"); 
	    $(this).parent(".hiding_tab").stop().animate({"max-height":"47px"}).removeClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(180deg)','border-bottom-color':'#fff'}).removeClass("tab");
    }else{            
    	$(this).addClass("down"); 
 	    $(this).parent(".hiding_tab").stop().animate({"max-height":"2000px"}).addClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(0deg)','border-bottom-color':'#0fa4d4'}).addClass("tab");
    }
});
</script>
</body>
</html>
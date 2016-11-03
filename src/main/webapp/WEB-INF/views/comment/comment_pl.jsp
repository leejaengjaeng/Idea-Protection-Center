<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="/resources/common/css/cmt.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<link href="/resources/common/css/index.css" rel="stylesheet">
<style>
.after_cmt>textarea {
	margin-top: 0 !important;
}
</style>
<script>
/*$(document).ready(function()
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
     	else if ("${currentAnswer.getIscomplete()}"==6){
     		disableInputApply();
     		alert("출원이 완료된 사항입니다.");
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
      */
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
			<article class="nt" style="display:block;">
		<div class="full">
			<div class="hiding_tab" style="position: relative; width: 100%;">
				<div class="arrow-up ee"></div>
				<form name="regisForm" action="/registration/inputidea" method="POST"
				enctype="multipart/form-data"
				onsubmit="return formSubmit(document.regisForm.imgs);">
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" >				
				<select onChange=changeType(this.value);>
					<option>해당 산업에 맞는 카테고리를 선택해 주세요</option>
				</select> 
				<input type="hidden" value="-" name="typeOfInvent" id="idea_kind">
			</div>
		</div>
		<div class="tab_box">
			<div class="b0" style="background-color: #004a80; color: white;">
				<span>제목</span>
			</div>
			<div class="b1">
				<span>요약</span>
			</div>
			<div class="b2">
				<span>필요이유</span>
			</div>
			<div class="b3">
				<span>기존제품설명<br>및 문제점
				</span>
			</div>
			<div class="b4">
				<span>문제해결방법</span>
			</div>
			<div class="b5">
				<span>발명의 효과</span>
			</div>
			<div class="b6">
				<span>핵심구성요소</span>
			</div>
			<div class="b7">
				<span>권리를 보장받고자<br>하는 내용
				</span>
			</div>
			<div class="b8">
				<span>도면첨부</span>
			</div>
			<div class="b9">
				<span>도면에 대한 설명</span>
			</div>
		</div>
		<div class="area_box a0" style="display: block;">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a1">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a2">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a3">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a4">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a5">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a6">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a7">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a8">
			<div>
				<div class="plc">
					
				</div>
			</div>
		</div>
		<div class="area_box a9">
			<div class="plc">
				<textarea id="idea_title" name="title" class="half disabled inventor" placeholder="발명가" disabled>${beforeReg.getTitle()}</textarea>
				<textarea id="idea_title" name="title" class="half disabled pl" placeholder="변리사" disabled>${beforeReg.getRe_title()}</textarea>
				<textarea id="idea_title" name="title" class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button">임시저장</button>
			<input type="submit">
		</div>
		</form>
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

$(".tab_box div").click(function(){       
    $(this).addClass("sel").siblings().removeClass("sel");
    $(this).eq(0).css({backgroundColor:"#004a80",color:"#fff"}).siblings(0).css({backgroundColor:"#fff",color:"#464646"});                        
});    
$(".b0").click(function(){
    $(".a0").css("display","block");
    $(".a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b1").click(function(){
    $(".a1").css("display","block");
    $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b2").click(function(){
    $(".a2").css("display","block");
    $(".a0,.a1,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b3").click(function(){
    $(".a3").css("display","block");
    $(".a0,.a2,.a1,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b4").click(function(){
    $(".a4").css("display","block");
    $(".a0,.a2,.a3,.a1,.a5,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b5").click(function(){
    $(".a5").css("display","block");
    $(".a0,.a2,.a3,.a4,.a1,.a6,.a7,.a8,.a9").css("display","none");
});
$(".b6").click(function(){
    $(".a6").css("display","block");
    $(".a0,.a2,.a3,.a4,.a5,.a1,.a7,.a8,.a9").css("display","none");
});
$(".b7").click(function(){
    $(".a7").css("display","block");
    $(".a0,.a2,.a3,.a4,.a5,.a6,.a1,.a8,.a9").css("display","none");
});
$(".b8").click(function(){
    $(".a8").css("display","block");
    $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a1,.a9").css("display","none");
});
$(".b9").click(function(){
    $(".a9").css("display","block");
    $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a1").css("display","none");
});


</script>
</body>
</html>
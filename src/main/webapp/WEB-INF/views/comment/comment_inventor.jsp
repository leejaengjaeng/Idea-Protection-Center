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
<style>
	.tab_contents textarea{
        float: right !important;
        width: 660px !important; 
        border-radius: 6px !important;
    }
</style>
<script>
$(document).ready(function()
{
	/*
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
	*/
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
	
	
	if("${currentAnswer.getIscomplete()}" == 0)	enableInput();	
	else
	{
		disableInput();
		if("${currentAnswer.getIscomplete()}"==2) {	btnHide(); alert("가출원상태입니다."); }
		else if("${currentAnswer.getIscomplete()}"==4) gotoApply("${user}");
		else if("${currentAnswer.getIscomplete()}"==3)
		{
			var q=confirm("변리사가 위의 내용으로 최종 확인하였습니다 출원 단계를 진행하시겠습니까?");
	    	if(q==true)	gotoApply("${user}");                                 
	     	else
	     	{
	     		enableInput();
	        	denyApply("${user}");
	        	return false;                                         
	  	 	}
		}
		else alert('변리사의 답변을 기다려주세요');
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
		
		if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 0)) enableInput();
		else disableInput();
	
		//현재 선택된 요소(tr)에 clickedIdea를 붙임
		$(this).addClass('clickedIdea');
		showClickedList(rid);	
	})
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
    <c:import url="/WEB-INF/views/import/header.jsp"/>
     <div class="wrap_comment">       
        <section>                      
            <article class="sub_head" style="margin-top:100px;">                    
                <h1 style="width:300px; margin-bottom:20px;">아이디어수정내역</h1>                
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
            <article class="nt" style="display:block;">
		<div class="full">

		<div class="hiding_tab" style="position: relative; width: 100%;">
		<div class="arrow-up ee"></div>
			<input type="hidden" name="${_csrf.parameterName}" 	value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}">
			<select onChange=changeType(this.value);>
				<option>${currentAnswer.getTypeOfInvent()}</option>
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
				<span>기존제품설명<br>및 문제점</span>
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
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentTitle">${beforeReg.getTitle()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentTitle">${beforeReg.getRe_title()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentTitle">${currentAnswer.getTitle()}</textarea>
			</div>
		</div>
		<div class="area_box a1">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSummary" name="summary">${beforeReg.getSummary()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentSummary">${beforeReg.getRe_summary()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSummary">${currentAnswer.getSummary()}</textarea>
			</div>
		</div>
		<div class="area_box a2">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentWhyInvent" name="whyInvent">${beforeReg.getWhyInvent()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentWhyInvent">${beforeReg.getRe_whyInvent()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentWhyInvent">${currentAnswer.getWhyInvent()}</textarea>
			</div>
		</div>
		<div class="area_box a3">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentProblem">${beforeReg.getProblem()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentProblem">${beforeReg.getRe_problem()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentProblem">${currentAnswer.getProblem()}</textarea>
			</div>
		</div>
		<div class="area_box a4">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSolution">${beforeReg.getSolution()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentSolution">${beforeReg.getRe_solution()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSolution">${currentAnswer.getSolution()}</textarea>
			</div>
		</div>
		<div class="area_box a5">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentEffect">${beforeReg.getEffect()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentEffect">${beforeReg.getRe_effect()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentEffect">${currentAnswer.getEffect()}</textarea>
			</div>
		</div>
		<div class="area_box a6">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentCore_Element">${beforeReg.getCore_element()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentCore_Element">${beforeReg.getRe_core_element()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentCore_Element">${currentAnswer.getCore_element()}</textarea>
			</div>
		</div>
		<div class="area_box a7">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentHope_content()">${beforeReg.getHope_content()}</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentHope_content()">${beforeReg.getRe_hope_content()}</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentHope_content">${currentAnswer.getHope_content()}</textarea>
			</div>
		</div>
		<div class="area_box a8">
			<div>
				<div class="plc">
					<form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                       <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
                       <input type="hidden" name="start_rid_file" value="${start_rid}">
                   	   <div id="inputFileDiv"></div>
                   </form>
                   <button type="button" onclick="addfile()">추가</button>
                   <button type="button" onclick="delfile()">삭제</button>
                    <c:forEach items="${imgs}" var="list" varStatus="status">
                    <div id="id ${list.getRfid()}">
                    	<img src="${list.getFile_path()}" onclick="location.href='${list.getFile_path()}'">
                  		<button type="button" onclick="delImg('${list.getRfid()}')">삭제</button>
                  	</div>
                    </c:forEach>     
				</div>
			</div>
		</div>
		<div class="area_box a9">
			<div class="plc">
				<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentPicture_explain">
					${beforeReg.getPicture_explain()}
				</textarea>
				<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentPicture_explain">
					${beforeReg.getRe_picture_explain()}
				</textarea>
				<textarea class="disabled current " placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentPicture_explain">
					${currentAnswer.getPicture_explain()}
				</textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button" id="tmpSave">임시저장</button>
			<input type="submit" id="agree">
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
$(".nav>button").click(function(){
	  $(this).next(".modal").css("display","block");
 });
 $(".modal").click(function(){
	  $(this).css("display","none"); 
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
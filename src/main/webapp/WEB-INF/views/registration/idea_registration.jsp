<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- <link rel="stylesheet"
   href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css"> -->
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/util.js" type="text/javascript"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/cmt.css">
<title>Idea Protection Center</title>
<script>
var i=1;
function delfile(){
   $('#upimg'+i+'').detach();
   i--;
}
function checkTemp(){  
    if(${isTemp}=="1"){
      document.getElementById("bw").style.visibility="visible";
      document.getElementById("pp").style.visibility="visible";
     }
     else{
                      
     }
}
function loadTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   var optcnt;
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
   headers[csrfHeader] = csrfToken;
      $.ajax({
       url : "/registration/loadTempIdea",
       dataType : "json",
       type : "POST",
       headers: headers,
       data : data,
       success: function(data) {
    	   	optcnt = document.getElementById("selectBox").options.length;
    	   	
    	   	for(i =0 ; i < optcnt; i++){
	    	     if(document.getElementById("selectBox").options[i].value == data.typeOfInvent) {
	    	          document.getElementById("selectBox").options[i].selected = true;
	    	          break;
	    	    }
	    	}
         	document.getElementById("idea_kind").value=data.typeOfInvent;
            document.getElementById("idea_title").value=data.title;
            document.getElementById("small_cont").value=data.summary;
            document.getElementById("why_cont").value=data.whyInvent;
            document.getElementById("col_cont").value=data.problem;
            document.getElementById("wel_cont").value=data.solution;
            document.getElementById("bal_cont").value=data.effect;
            document.getElementById("imp_cont").value=data.core_element;
            document.getElementById("hope_content").value=data.hope_content;
            document.getElementById("picture_explain").value=data.picture_explain;
            document.getElementById("bw").style.visibility="hidden";
           	document.getElementById("pp").style.visibility="hidden";
       },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   }); 
   
}
 
function removeTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
    headers[csrfHeader] = csrfToken;
    $.ajax({
        url : "/registration/removeTempIdea",
        dataType : "json",
        type : "POST",
        headers: headers,
        data : data,
        success: function(data) {
           document.getElementById("bw").style.visibility="hidden";
          document.getElementById("pp").style.visibility="hidden";
          location.href="/registration/addidea";
        },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   });
}
function tempsave(){
   var typeOfInvent=document.getElementById("idea_kind").value;
   var title=document.getElementById("idea_title").value;
   var summary=document.getElementById("small_cont").value;
   var whyInvent=document.getElementById("why_cont").value;
   var problem=document.getElementById("col_cont").value;
   var solution=document.getElementById("wel_cont").value;
   var effect=document.getElementById("bal_cont").value;
   var core_element=document.getElementById("imp_cont").value;
   var uid=document.getElementById("uid").value;
   var hope_content=document.getElementById("hope_content").value;
   var picture_explain=document.getElementById("picture_explain").value
   
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["typeOfInvent"] = typeOfInvent;
   data["title"] = title;
   data["summary"] = summary;
   data["whyInvent"] = whyInvent;
   data["problem"] = problem;
   data["solution"] = solution;
   data["effect"] = effect;
   data["core_element"] = core_element;
   data["uid"]=uid;
   data["hope_content"]=hope_content;
   data["picture_explain"]=picture_explain;
   headers[csrfHeader] = csrfToken;
   $.ajax({
      url : "/registration/tempsave",
      dataType : "json",
      type : "POST",
      headers: headers,
      data : data,
      success: function(data) {
         alert("임시저장이 완료되었습니다");
      },
      error:function(request,status,error){
          alert("code:"+request.status+"\n"+"error:"+error);
      }
   
   }); 
}
 
 
 
function closeload(){
   document.getElementById("bw").style.visibility="hidden";
   document.getElementById("pp").style.visibility="hidden";  
   
}
function formSubmit(file){
   //alert($("input[name=imgs]").length);
    var maxSize  = 5 * 1024 * 1024    
    var fileSize = 0;
 
   // 브라우저 확인
   var browser=navigator.appName;
 
   // 익스플로러일 경우
   if (browser=="Microsoft Internet Explorer")
   {
      alert("ie");
      var oas = new ActiveXObject("Scripting.FileSystemObject");
      fileSize = oas.getFile( file.value ).size;
   }
      // 익스플로러가 아닐경우
   else
   {
      fileSize+= file.files[i].size;
      alert(fileSize);
   }
   
   
   alert("파일사이즈 : "+ fileSize +", 최대파일사이즈 : 5MB");
   
   if(fileSize > maxSize)
   {
       alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.    ");
       return false;
   }
   
   if(document.getElementById("typeOfInvent").value=="-"){
      alert("발명분야를 선택해주세요");
      return false;
   }
}
function changeType(value){
   document.getElementById("idea_kind").value=value;
}
</script>
</head>
<body onload='checkTemp();'>

	<div class="black_wall" id="bw" style="visibility: hidden"></div>
	<div class="popup" id="pp" style="visibility: hidden">
		<div class="pop_header">
			<h2 style="color: #f9f9f9">아이디어 보호센터</h2>
			<img src="/resources/image/close.png" alt="close" class="popup_close"
				onclick="closeload()" id="close">
		</div>
		<div class="pop_cont">
			<span>임시저장된 아이디어가 있습니다.</span>
			<table style="width: 100%;">
				<c:forEach items="${tempList}" var="list" varStatus="status">
					<tr>
						<td style="width: 30px;">${status.count }</td>
						<td>${list.getTitle()}</td>
						<td>${list.getRegistration_date() }</td>
						<td style="width: 100px;"><button
								style="background: #45d4fe;"
								onclick="loadTempIdea(${list.getRid()})" id="load_data">불러오기</button></td>
						<td style="width: 100px;"><button
								style="background: #e9e9e9; color: #333;"
								onclick="removeTempIdea(${list.getRid()})">삭제하기</button></td>

					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<c:import url="/WEB-INF/views/import/header.jsp" />
	<div class="wrap_comment">
		<section> 
		<article class="sub_head"
			style="margin-top:100px;">
		<h1>
			<b>특허</b>출원
		</h1>
		<span>아이디어 보호센터에서 손쉽게 특허를 등록하세요.</span>
		<div id="chgbtn">
			<button id="ot">1</button>
			<button id="nt">2</button>
		</div>
		 </article> 
		 <article style="margin-left:0;" class="ot">
		<form name="regisForm" action="/registration/inputidea" method="POST"
			enctype="multipart/form-data"
			onsubmit="return formSubmit(document.regisForm.imgs);">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="text" name="uid" id="uid"
				value="${sessionScope.currentUser.getUid()}" hidden>
			<div class="full">
				<div class="hiding_tab" style="position: relative;">
					<div class="arrow-up ee"></div>
					<select onChange=changeType(this.value); id="selectBox">
						<option>해당 산업에 맞는 카테고리를 선택해 주세요</option>
						<c:forEach items="${typeList}" var="list" varStatus="status">
							<option>${list.getType()}</option>
						</c:forEach>
					</select> <input type="hidden" value="-" name="typeOfInvent" id="idea_kind">
				</div>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>제목</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="idea_title" name="title"></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성예시</button>
				<div class="modal">
					<p></p>
				</div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>요약</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="small_cont" name="summary" tabindex="-1"></textarea>
					</div>
				</div>
				<nav class="nav">
				<button type="button">작성 예시</button>
				<div class="modal">
					<p>
						발명의 내용을 용이하게 파악할 수<br>  있도록 다음 내용에 관한 사항을<br> 기재합니다.
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
					<div class="tab_contents">
						<textarea id="why_cont" name="whyInvent"></textarea>
					</div>
				</div>
				<nav class="nav">
				<button type="button">작성 예시</button>
				<div class="modal">
					<p>발명이 속하는 기술분야 및 그 분야의 이전기술과 발명이 이루고자하는 목적을 기재함.</p>
				</div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>기존제품설명 및 문제점</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="col_cont" name="problem"></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>문제해결방법</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="wel_cont" name="solution"></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>발명의효과</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="bal_cont" name="effect"></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal">
					<p>효과는 발명의 목적달성을 확인 할 수 있는 효과, 종래기술과 비교하여 유리한 효과가 발생된다는 것을
						보여줄 수 있게 기재</p>
				</div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>핵심구성요소</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="imp_cont" name="core_element"></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>권리를 보장 받고자 하는 내용</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="hope_content" name="hope_content" required></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>도면첨부</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<div id="upimgdiv">
							<input type="file" id="upimg1" name="imgs"
								accept="image/gif, image/jpeg, image/png"
								onchange="fileCheck(this)">
						</div>
						<button type="button" onclick="addfile()">추가</button>
						<button type="button" onclick="delfile()">삭제</button>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="full">
				<div class="hiding_tab">
					<div class="tab_title">
						<span>도면에 대한 설명</span>
						<div class="arrow-up"></div>
					</div>
					<div class="tab_contents">
						<textarea id="picture_explain" name="picture_explain" required></textarea>
					</div>
				</div>
				<nav class="nav" style="margin-top:0;">
				<button type="button">작성 예시</button>
				<div class="modal"></div>
				</nav>
			</div>
			<div class="fin">
				<button type="button" onclick="tempsave();">임시저장</button>
				<input type="submit" value="제출" id="agree">
			</div>
		</form>
		</article> 
		<article class="nt">
		<div class="full">
			<div class="hiding_tab" style="position: relative; width: 100%;">
				<div class="arrow-up ee"></div>
				<form name="regisForm" action="/registration/inputidea" method="POST"
				enctype="multipart/form-data"
				onsubmit="return formSubmit(document.regisForm.imgs);">
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="text" name="uid" id="uid"
				value="${sessionScope.currentUser.getUid()}" hidden>				
				<select onChange=changeType(this.value);>
					<option>해당 산업에 맞는 카테고리를 선택해 주세요</option>
				</select> <input type="hidden" value="-" name="typeOfInvent" id="idea_kind">
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
			<div>
				<textarea id="idea_title" name="title"></textarea>
			</div>
		</div>
		<div class="area_box a1">
			<div>
				<textarea id="small_cont" name="summary"></textarea>
			</div>
		</div>
		<div class="area_box a2">
			<div>
				<textarea id="why_cont" name="whyInvent"></textarea>
			</div>
		</div>
		<div class="area_box a3">
			<div>
				<textarea id="col_cont" name="problem"></textarea>
			</div>
		</div>
		<div class="area_box a4">
			<div>
				<textarea id="wel_cont" name="solution"></textarea>
			</div>
		</div>
		<div class="area_box a5">
			<div>
				<textarea id="bal_cont" name="effect"></textarea>
			</div>
		</div>
		<div class="area_box a6">
			<div>
				<textarea id="imp_cont" name="core_element"></textarea>
			</div>
		</div>
		<div class="area_box a7">
			<div>
				<textarea id="hope_content" name="hope_content"></textarea>
			</div>
		</div>
		<div class="area_box a8">
			<div>
				<div id="plc">
					<div id="upimgdiv2">
						<input type="file" id="upimg1" name="imgs"
						accept="image/gif, image/jpeg, image/png"
						onchange="fileCheck(this)" style="margin-left:5px; margin-top:5px; float:left;">
					</div>
					<button type="button" onclick="addfile2()">추가</button>
					<button type="button" onclick="delfile()">삭제</button>
				</div>
			</div>
		</div>
		<div class="area_box a9">
			<div>
				<textarea id="picture_explain" name="picture_explain"></textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button" onclick='tempsave()'>임시저장</button>
			<input type="submit">
		</div>
		</form>
		</article> 
	</section>	
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
    var i=1;
function addfile(){
    i++;
    $('#upimgdiv').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:10px;' onchange='fileCheck(this)'>");
    //var targetdiv=document.getElementById("uploaddiv");
    //targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";
 
}
function addfile2(){
    i++;
    $('#upimgdiv2').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:5px; margin-left:5px; margin-top:5px; float:left;' onchange='fileCheck(this)'>");
}
$(function(){
   $("textarea,input,button").attr({"tabindex":"-1"});
   $("textarea").attr({"placeholder":"Comment.."});
   $(".tab_title:odd").css("background","#464646");
});
$(".popup_close, #load_data").click(function(){
   $("body").css("overflow","auto");   
});

$('#idea_title').keyup(function(){
    if ($(this).val().length > 45) {
        alert('제한길이 초과');
        $(this).val($(this).val().substr(0, 45));
    }
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
   $("textarea").attr("placeholder","Comment");
   $("#nt").click(function(){
	   $(".nt").css("display","block");
	   $(".ot").css("display","none");
   });
   $("#ot").click(function(){
	   $(".nt").css("display","none");
	   $(".ot").css("display","block");
   });
   
</script>
</body>
</html>
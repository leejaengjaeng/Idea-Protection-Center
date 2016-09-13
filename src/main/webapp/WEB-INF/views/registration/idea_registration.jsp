<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet"
	href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css">
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>Insert title here</title>
<style>
body{
    height: 100% !important;        
}
.black_wall{
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.7);
    position:fixed;    
    z-index:98;
}    
    .popup{
        width: 400px;
        height: 200px;
        background:#fff;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        -moz-transform: translate(-50%,-50%);
        -webkit-transform: translate(-50%,-50%);
        box-shadow: 0 0 10px 0 #000;                
        position: fixed;        
        z-index: 99;
    }
    .pop_header{
        width: 100%;
        float: left;
        background: #696969;
        color: white;
        padding: 10px;    
        box-shadow:0 0 5px 0 #000;
    }
    .pop_header>h2{
        display: block;
        float: left;
        font-size: 1rem;
        margin: 5px;
    }
    .pop_header>img{
        width: 25px;
        float: right;
    }
    .pop_cont{
        width: 100%;
        float: left;
        text-align: center;
        padding: 20px;
        padding-top: 30px;
    }
    .pop_cont>span{
        color: #595959;
        font-size: 0.9;
        display: inline-block;
        width: 100%;
    }
    .pop_cont button{
        width: 100px; 
        height: 35px;    
        margin:25px 5px 0 5px;
        background: none;
        border: none;
        box-shadow: inset 0 -4px rgba(0, 0, 0, .1);
        color: white;        
    }
    .popup_close{
        cursor: pointer;
    }
 
</style>
<script>
var i=1;
function addfile(){
	i++;
	$('#upimgdiv').append("<input type='file' id='upimg"+i+"' name='imgs' onchange='addfile()' accept='image/gif, image/jpeg, image/png'>");
    //var targetdiv=document.getElementById("uploaddiv");
    //targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";
    
    }
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
function loadTempIdea(){
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};

	data[csrfParameter] = csrfToken;
 	data["uid"]=${sessionScope.currentUser.getUid()};
 	headers[csrfHeader] = csrfToken;
     $.ajax({
 	    url : "/registration/loadTempIdea",
 	    dataType : "json",
 	    type : "POST",
 	    headers: headers,
 	    data : data,
 	    success: function(data) {
 	    	document.getElementById("idea_kind").value=data.typeOfInvent;
        	document.getElementById("idea_title").value=data.title;
        	document.getElementById("small_cont").value=data.summary;
        	document.getElementById("why_cont").value=data.whyInvent;
        	document.getElementById("col_cont").value=data.problem;
        	document.getElementById("wel_cont").value=data.solution;
        	document.getElementById("bal_cont").value=data.effect;
        	document.getElementById("imp_cont").value=data.core_element;
        	document.getElementById("bw").style.visibility="hidden";
    		document.getElementById("pp").style.visibility="hidden";
 	    },
 	    error:function(request,status,error){
 	        alert("code:"+request.status+"\n"+"error:"+error);
 	    }
 	}); 
}

function removeTempIdea(){
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};
	
	data[csrfParameter] = csrfToken;
	data["uid"]=${sessionScope.currentUser.getUid()};
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
   headers[csrfHeader] = csrfToken;
   $.ajax({
	   url : "/registration/tempsave",
	   dataType : "json",
	   type : "POST",
	   headers: headers,
	   data : data,
	   success: function(data) {

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

</script>
</head>
<body onload='checkTemp();'>

<div class="black_wall" id="bw" style="visibility:hidden"></div>
<div class="popup" id="pp" style="visibility:hidden">
   	  <div class="pop_header">            
       	<h2 style="color:#f9f9f9">아이디어 보호센터</h2>
       	<img src="/resources/image/close.png" alt="close" class="popup_close" onclick="closeload()" id="close">
    </div>
    <div class="pop_cont">            
       	<span>임시저장된 아이디어가 있습니다.</span>
       	<button style="background:#45d4fe;" onclick="loadTempIdea()">불러오기</button>
       	<button style="background:#e9e9e9; color:#333;" onclick="removeTempIdea()">삭제하기</button>
    </div>
</div>
 
<c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">
        <section>            
            <article class="sub_head">                    
                <h1><b>특허</b>등록</h1>                
            </article>                
            <article>

            <form action="/registration/inputidea" method="POST" enctype="multipart/form-data">
               	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="text" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" hidden> 

                <div class="txt_box">
                    <h2>발명분야</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_kind" name="typeOfInvent" required>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_title"  name="title" required>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>                    
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>요약</h2>
                    <button>작성예시 보기</button>
                    <textarea id="small_cont"  name="summary" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>                
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>필요이유</h2>
                    <button>작성예시 보기</button>
                    <textarea id="why_cont"  name="whyInvent" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2>
                    <button>작성예시 보기</button>
                    <textarea id="col_cont"  name="problem" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>문제해결방법</h2>
                    <button>작성예시 보기</button>
                    <textarea id="wel_cont"  name="solution" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>발명의 효과</h2>
                    <button>작성예시 보기</button>
                    <textarea id="bal_cont"  name="effect" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>핵심구성요소</h2>
                    <button>작성예시 보기</button>
                    <textarea id="imp_cont"  name="core_element" required></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div id="upimgdiv" class="txt_box">
                    <h2 style="width:100%">도면첨부</h2><button type="button" style="margin-top:5px;" onclick="addfile()">추가</button>
                    <button type="button" style="margin-top:5px;" onclick="delfile()">삭제</button>
                    <input type="file" id="upimg1" name="imgs" accept="image/gif, image/jpeg, image/png" style="padding-top:5px;">
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>                    
                </div>
                
                <div id="fin"> 
                    <button type ="button" onclick="tempsave();">임시저장</button>
                    <input type="submit" value="제출" id="agree" style="width:140px; height:40px; border:none; box-shadow:inset 0 -4px rgba(0,0,0,.1); color:white; margin-left:10px;">
                </div>
            </article>
        </section>
    </div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
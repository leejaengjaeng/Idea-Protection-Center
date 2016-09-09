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
</head>
<body onload='return checkTemp();'>
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
                    <input type="text" id="idea_kind">
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
                    <input type="text" id="idea_title">
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
                    <textarea id="small_cont"></textarea>
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
                    <textarea id="why_cont"></textarea>
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
                    <textarea id="col_cont"></textarea>
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
                    <textarea id="wel_cont"></textarea>
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
                    <textarea id="bal_cont"></textarea>
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
                    <textarea id="imp_cont"></textarea>
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
                    <h2 style="width:100%">도면첨부</h2>
                    <li><input type="file" id="upimg" name="imgs" onchange="addfile()" accept="image/gif, image/jpeg, image/png"><button type="button">제거</button></li>
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
                <script>
                function addfile(){
                	$('#upimgdiv').append("<input type='file' name='imgs' onchange='addfile()' accept='image/gif, image/jpeg, image/png'>");
                	//var targetdiv=document.getElementById("uploaddiv");
                	//targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";
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
                	        alert("성공:"+data.aa);
                	        
                	    },
                	    error:function(request,status,error){
                	        alert("code:"+request.status+"\n"+"error:"+error);
                	    }
                	 
                	}); 
                }
                function checkTemp(){
                	if(${isTemp}=="1"){
                		var q=confirm("임시저장된 아이디어가 있습니다. 불러올까요?");
                		if(q==true){
                			loadTempIdea(${sessionScope.currentUser.getUid()});
                		}
                	}
                	else{
                		
                	}
                }
                function loadTempIdea(uid){
                	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
                	var csrfToken = $("meta[name='_csrf']").attr("content"); 
                	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
                	var data = {};
                	var headers = {};
                	
                	data[csrfParameter] = csrfToken;
                	 data["uid"]=uid;
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
                        	document.getElementById("small_cont").value=data.whyInvent;
                        	document.getElementById("why_cont").value=data.solution;
                        	document.getElementById("col_cont").value=data.effect;
                        	document.getElementById("wel_cont").value=data.summary;
                        	document.getElementById("bal_cont").value=data.problem;
                        	document.getElementById("imp_cont").value=data.core_element;
                 	    },
                 	    error:function(request,status,error){
                 	        alert("code:"+request.status+"\n"+"error:"+error);
                 	    }
                 	}); 
                }
                </script>
                <div id="fin"> 
                    <button type ="button" onclick="tempsave();">임시저장</button>
                    <input type="submit" value="제출">
                </div>
            </article>
        </section>
    </div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
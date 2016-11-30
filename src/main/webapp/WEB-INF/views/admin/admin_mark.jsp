<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IPC_AdminPage</title>
    <link href="/resources/common/css/admin.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link rel="icon" href="/resources/image/pavicon.png">
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>
 
    <script>
    var markId;
    var buttonId;
    var pId;
    function giveLawyer(mid,btnid,pid){
    	//alert("aa");
    	markId=mid;
    	buttonId=btnid;
    	pId=pid;
    	document.getElementById("bw").style.visibility="visible";
		document.getElementById("pp").style.visibility="visible";
    }
    function assign(uid){
    	alert(uid+","+markId);

    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["uid"] = uid;
        data["mid"]=markId;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/IPC_admin/assignMark",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	//alert(pId);
    	    	var element = document.getElementById(buttonId);
    	    	element.parentNode.removeChild(element);
    	    	var inDiv=document.getElementById(pId);
    	    	inDiv.innerHTML="<p>"+data.lawyerName+"</p>";
    	        document.getElementById("bw").style.visibility="hidden";
        		document.getElementById("pp").style.visibility="hidden";
        		
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
    function viewLawyer(uid){
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["uid"] = uid;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/IPC_admin/viewLawyer",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	alert("이름 : "+data.name+"\n"+
    	    			"아이디 : "+data.ID+"\n"+
    	    			"전문분야 : "+data.major+"\n"+
    	    			"소개 : "+data.introduce+"\n"+
    	    			"이메일 : "+data.email);
    	    	
    	    },
    	    error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"error:"+error);
    	    }
    	 
    	}); 
    }
    </script>
</head>
<body>
<div class="black_wall" id="bw" style="visibility:hidden"></div>
<div class="popup" id="pp" style="visibility:hidden">
   	<div class="pop_header">            
       	<h2 style="color:#f9f9f9">아이디어 보호센터</h2>
       	<img src="/resources/image/close.png" alt="close" class="popup_close" onclick="closeload()" id="close">
    </div>
    <div class="pop_cont">            
       	<span>변리사를 지정하세요</span>
       	<table>
       	<tr>
       		<td>아이디</td>
       		<td>이름</td>
       		<td>이메일</td>
       		<td>지정</td>
       	</tr>
       	<c:forEach items="${lawyerList}" var="lawlist" varStatus="status">
       		<tr>
       			<td>${lawlist.getId()}</td>
       			<td onclick="viewLawyer('${lawlist.getUid()}')">${lawlist.getName()}</td>
       			<td>${lawlist.getEmail()}</td>
       			<td><button onclick="assign('${lawlist.getUid()}')">지정</button><td>
       		</tr>
       	</c:forEach>
       	</table>
    </div>
</div>
    <c:import url="/WEB-INF/views/import/admin_header.jsp" />
        <article>
            <div id="table_header">
                <h1>상표권 관리</h1>
                <!-- 
                <div id="select_management">
                    <select>
                        <option>전체분류</option>
                    </select>
                    <select>
                        <option>전체상태</option>
                    </select>
                    <input type="text">
                    <button>검색</button>
                </div>z
                 -->
            </div>
            <table class="manage_table" style="margin-bottom:20px; ">
                <tr>
                    <th>사용자</th>
                    <th style="width:100px;">이름</th>
                    <th style="width:130px;">지정변리사</th>
                    <th>이메일</th>                    
                    <th style="width:280px;">제목</th>
                    <th>진행상태</th>
                   <!--   <th style="width:120px;">수정</th> -->
                </tr>
                <c:forEach items="${markAdminKist}" var="list" varStatus="status">
	                <tr>
	                	<input type="hidden" value="${list.getMid() }"/>
	                    <td>${list.getId()}</td>
	                    <td >${list.getName()}</td>
						
	                    <!-- pName 없으면 선택하게 버튼나오도록 -->
	                    <c:choose>
	                    	<c:when test="${list.getLawyer_name()==null}">
	                    		<td><div id="p${status.count}"></div><button id="btn${status.count}" onclick="giveLawyer('${list.getMid()}','btn${status.count}','p${status.count}')">지정</button></td>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<td>${list.getLawyer_name()}</td>
	                    	</c:otherwise>
	                    </c:choose>	                   
	                    <td>${list.getEmail()}</td>
	                    <td>${list.getTitle1()}</td>
	                    <c:choose>
	                    	<c:when test="${list.getIscomplete() eq 0}">
	                    		<td>변리사수정중</td>	
	                    	</c:when>
	                    	<c:when test="${list.getIscomplete() eq 1}">
	                    		<td>발명가수정중</td>	
	                    	</c:when>
	                    	<c:when test="${list.getIscomplete() eq 2}">
	                    		<td>결제대기중</td>	
	                    	</c:when>
	                    </c:choose>
	                    
	                   <!--<td><button>정보수정</button></td> -->
	                </tr>		               
	            </c:forEach>
            </table>     
            
		</article>
	</div>       
 <c:import url="/WEB-INF/views/import/admin_footer.jsp" />
<script>
    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
</script>
</body>
</html>

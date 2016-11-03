<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>

<link href="/resources/common/css/admin.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">


<title>IPC_AdminPage</title>
<style>

</style>
</head>

<body>
    <header>        
        <img src="/resources/image/ideapc_logo.jpg" alt="logo" onclick="location.href='/IPC_admin/'" style="cursor: pointer;">
        <div id="header_info">
            <span><b>${currentUser.getName() }</b>님</span>
            <button onclick="location.href='/logoutProcess.do'">로그아웃</button>
        </div>        
    </header>
    <div id="admin_cont">
        <nav>
            <ul>
                <li onclick="location.href='/IPC_admin/userList'">회원관리</li>
                <li onclick="location.href='/IPC_admin/'">아이디어 관리</li>
                <li>문의사항 관리</li>
                <li onclick="location.href='/IPC_admin/admin_notice'">공지사항 관리</li>
               	<li onclick="location.href='/qna/regularQnaAdd'">자주 묻는 질문 등록</li>
            
            </ul>  
        </nav>
        <article>
            <div id="table_header">
                <h1>특허 분류 관리</h1>                
            </div>
            <table class="manage_table">
                <tr>
                    <th>No</th>
                    <th>TYPE</th>
                    <th>-</th>
                </tr>
               	<c:forEach items="${vo}" var="type" varStatus="status">
               		<div>
			   			<tr id="${type.getTid()}">
				   			<td>${status.count}</td>
				   			<td>${type.getType()}</td>
				   			<td><button onclick="removetype('${type.getTid()}')">삭제</button></td>
				   		</tr>
				   	</div>
				</c:forEach>
				<div id="addtypeDiv"></div>
            </table>
            <h3>타입 추가</h3>
            <input type="text" id="addTypeBox"><button onclick="addType()">추가</button>
        </article>
    </div>
<footer>
    <div id="admin_footer">
        <span>COPYRIGHT 2016 @ IDEAPROTECTIONCENTER ALL RIGHTS RESERVED</span>
    </div>
</footer>     
<script>

    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
    function removetype(id){
    	//alert(id);
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["tid"] = id;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/IPC_admin/rmtype",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	//alert(data);
    	    	$("#"+data).remove();
    	    },
    	    error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"error:"+error);
    	    }
    	 
    	}); 
    }
    function addType(){
    	var type=document.getElementById('addTypeBox').value;
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["type"] = type;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/IPC_admin/addtype",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	
    	    	location.reload();
    	    },
    	    error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"error:"+error);
    	    }
    	 
    	}); 
    }
</script>
</body>
</html>
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
<link rel="icon" href="/resources/image/pavicon.png">

<title>IPC_AdminPage</title>
<style>
	#addTypeBox{width:200px; height:35px; margin-top:50px; padding-left:10px;}
	#addtype{width:50px;height:35px;margin-left:10px; background-color:#333; color:white; border:none;}
</style>
</head>

<body>
     <c:import url="/WEB-INF/views/import/admin_header.jsp" />
        <article>
            <div id="table_header">
                <h1>특허 분류 관리</h1>                
            </div>
            <table class="manage_table">
                <tr>
                    <th style="width:100px;">No</th>
                    <th>TYPE</th>
                    <th style="width:150px;">-</th>
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
            <input type="text" id="addTypeBox" placeholder="타입 추가" /><button onclick="addType()" id="addtype">추가</button>
        </article>
    <c:import url="/WEB-INF/views/import/admin_footer.jsp" />     
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>downLoad Document</title>
<script>
function downDoc(kindOfDocument){
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};

	data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['kind']=kindOfDocument;
    $.ajax({
		url : "/downDoc",
		type:"POST",
		headers: headers,
 	    data : data,
 	    success:function(retVal)
 	    {
	 	   	alert("다운로드가 실행됩니다. 오류가 있을 시 한번 더 누르거나 문의하여 주십시오");
	 	   	location.href="/executeDownLoad/"+retVal;
 	    },
 	    error: function(request,status,error)
		{
 			alert('실패하였습니다.')
 			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
${first} <button onclick="downDoc('resident')">다운로드</button><br>
사업자등록증 <button onclick="downDoc('business')">다운로드</button><br>
인감증명서(포괄위임용) <button onclick="downDoc('certificate')">다운로드</button><br>
<c:choose>
<c:when test="${smallexist==1}">
중소기업감면서류 <button onclick="downDoc('small')">다운로드</button><br>
</c:when>
</c:choose>

<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
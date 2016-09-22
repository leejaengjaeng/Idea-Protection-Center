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
<script>
function checkAdmin(){
	//alert("${role}");

	if("${role}"=='notAdmin'){
		document.getElementById("btn_notice_regis").style.display='none';
	}
}
</script>
<title>Insert title here</title>
</head>
<body onload="checkAdmin()">
<div>
<table>
<tr>
<th>번호</th>
<th>제목</th>
<th>날짜</th>
</tr>
	<c:forEach items="${noticeList}" var="list" varStatus="status">
    	<tr onclick="location.href='/noticeList/${list.getNid()}'">
    		<td>${status.count}</td>
    		<td>${list.getTitle()}</td>
    		<td>${list.getDate()}</td>
    	</tr>
	</c:forEach>
</table>
</div>
<button id="btn_notice_regis" onclick="location.href='/admin_notice_registration'">등록</button>

</body>
</html>
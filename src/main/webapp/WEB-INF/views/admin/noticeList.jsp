<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<link href="/resources/common/css/style.css" rel="stylesheet">
<link href="/resources/common/css/index.css" rel="stylesheet">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>IPC_AdminPage</title>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="wrap_form">
	<h1>공지사항</h1>
	<table id="notice_table">
		<tr>
			<th style="width:100px;">
				no
			</th>
			<th>
				제목
			</th>
			<th style="width:250px;">
				시간
			</th>
		</tr>
		<c:forEach items="${noticeList}" var="list" varStatus="status">
			<tr onclick="location.href='/noticeList/${list.getNid()}'">
    			<td>${list.getTitle()}</td>
    			<td>${list.getDate()}</td>
    			<td>관리자</td>
    		</tr>
		</c:forEach>
	</table>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>

</body>
</html>

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
<link href="/resources/common/css/admin.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<link rel="icon" href="/resources/image/pavicon.png">
<title>IPC_AdminPage</title>
</head>
<body style="background:#f9f9f9;">
<div class="notice_form">
	<span>공지사항</span>
	<form action="/notice/noticeRegistration" name="noticeform" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
		<input type="text" name="title" id="title" placeholder="제목"><br/>
		<textarea id="content" name="content" placeholder="내용"></textarea>
		<input type="submit" id="submit">
	</form>
</div>
</body>
</html>
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
<title>IPC_AdminPage</title>
</head>
<body style="background:#f9f9f9;">
<c:import url="/WEB-INF/views/import/header.jsp"/>

<!-- <div class="notice_form"> -->
	<span>질문하기</span>
	<form action="/qna/regisOneQna" name="noticeform" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
		<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}">
		<input type="text" name="title" id="title" placeholder="제목"><br/>
		<textarea id="content" name="content" placeholder="내용"></textarea>
		<input type="submit" id="submit">
	</form>
<!-- </div> -->
<c:import url="/WEB-INF/views/import/footer.jsp"/>

</body>
</html>
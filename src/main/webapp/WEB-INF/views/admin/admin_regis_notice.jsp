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
<title>Insert title here</title>
</head>
<body>
<div>
<form action="/noticeRegistration" name="noticeform" method="POST">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

제목<input type="text" name="title" id="title"><br/>
내용<textarea id="content" name="content"></textarea>
<input type="submit">
</form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="hasAnyRole('INVENTOR','PATIENTENTLAWYER')">
	<meta http-equiv="refresh" content="0; url=/"></meta>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IdeaProtect</title>
    <link href="/resources/common/css/index.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp"/>	
	<c:import url="/WEB-INF/views/forms/loginForm.jsp"/>
	<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<script>
		console.log(${processList});
	</script>
	<h1>${currentUser.getId() }</h1>
	<c:forEach var="process" items="${processList }">
		${process.getTitle()}
		${process.getRegistration_date() }
		${process.getR_condition() }
		${process.getStart_rid() }
		${process.getTypeOfInvent() }		
	</c:forEach>

</body>
</html>
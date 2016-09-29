<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Idea Protectection Center</title>
<link rel="stylesheet" href="/resources/common/css/style.css"> 
<link rel="stylesheet" href="/resources/common/css/index.css"> 
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
	<div id="wrap_form">
        <div style="width:100%;float:left;">
            <img src="/resources/image/error.png" alt="error" style="width:200px; margin-top:100px;">
            <h1 style="margin-top:10px; color:#3e3e3e; font-size:40px; display:block;">권한이 없습니다.</h1>
            <h3 style="display:block; margin-bottom:100px;">Sorry No Access</h3>
        </div>
    </div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- <link rel="stylesheet"
	href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css"> -->
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">

<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="wrap_form">
	<h1 style="margin-top:100px;">질문하기</h1>
	<table id="notice_table">
		<tr>
			<th style="width:100px;">
				no
			</th>
			<th>
				제목
			</th>
			<th>
				작성자
			</th>
			<th style="width:200px;">
				날짜
			</th>
		</tr>
		<c:forEach items="${qnaList}" var="list" varStatus="status">
			<tr onclick="location.href='/qna/detail/${list.getQid()}'">
    			<td>${status.count }</td>
    			<td>${list.getTitle()}</td>
    			<td>${list.getId()}</td>
    			<td>${list.getDate()}</td>
    		</tr>
		</c:forEach>
	</table>
	<button onclick="location.href='/qna/addOneQna'" id="btn_add_notice" style="margin-bottom:100px;">등록</button>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
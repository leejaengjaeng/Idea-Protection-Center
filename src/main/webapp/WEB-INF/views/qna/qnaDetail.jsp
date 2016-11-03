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
<title>Idea Protection Center</title>
<script type="text/javascript">
function ddddd(){
	//alert(sessionScope.currentUser.getRole());
	//alert("${sessionScope.currentUser.getRole()}");
	if("${sessionScope.currentUser.getRole()}"=="ROLE_ADMIN"){
		document.getElementById("replyDiv").style.display='block';
	}
}
</script>
</head>
<body onload='ddddd();'>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="wrap_form" >
	<h1>질문하기</h1>
	<div id="notice_detail">
		<div class="title_detail">
			<p>${qna.getTitle()}</p>
		</div>
		<div class="date_detail">
			<p>${qna.getDate()}</p>
		</div>
		<div class="cont_detail">
			<p>${qna.getContent()}</p>
		</div>
	</div>
	<div id="wrap_form">
	<table id="notice_table">
		
		<c:forEach items="${replyList}" var="list" varStatus="status">
			<tr style="border-top:1px solid #ccc;">
    			<td>
    				<div style="width:60px; height:60px; padding:5px; border:1px solid #ccc; margin:10px; background:#e8e8e8;">
    					<img src="/resources/image/inventor.png">
    				</div>
    			</td>
    			<td>관리자</td>
    			<td>${list.getContent()}</td>
    		</tr>
		</c:forEach>
	</table>
	</div>
	<div id="replyDiv" style="display:none;">
		<form action="/qna/regisreply" method="POST" name="replyform" style="margin-bottom:50px;">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<input type="hidden" value="${qna.getQid()}" name="qid" style="width:88%; height:25px; padding-left:5px; float:left;">	
			<textarea name="content" id="content" placeholder="답글달기" style="width:88%; height:50px; padding-left:5px; padding-top:5px; height:80px; float:left; resize: none;"></textarea>
			<input type="submit" style="width:10%;height:80px;background:none; border:2px solid #ccc;">

		</form>
	</div>	
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>

</body>
</html>
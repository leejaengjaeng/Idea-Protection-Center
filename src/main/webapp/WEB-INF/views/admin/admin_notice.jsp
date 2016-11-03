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
<script>
function checkAdmin(){
	//alert("${role}");

	if("${role}"=='notAdmin'){
		document.getElementById("btn_notice_regis").style.display='none';
	}
}
</script>
<title>IPC_AdminPage</title>
<style>

</style>
</head>

<body onload="checkAdmin()">
    <header>        
        <img src="/resources/image/ideapc_logo.jpg" alt="logo" onclick="location.href='/IPC_admin/'" style="cursor: pointer;">
        <div id="header_info">
            <span><b>${currentUser.getName() }</b>님</span>
            <button onclick="location.href='/logoutProcess.do'">로그아웃</button>
        </div>        
    </header>
    <div id="admin_cont">
        <nav>
            <ul>
                <li onclick="location.href='/IPC_admin/userList'">회원관리</li>
                <li onclick="location.href='/IPC_admin/'">아이디어 관리</li>
                <li>문의사항 관리</li>
                <li onclick="location.href='/IPC_admin/admin_notice'">공지사항 관리</li>
            	<li onclick="location.href='/qna/regularQnaAdd'">자주 묻는 질문 등록</li>
            
            </ul>  
        </nav>
        <article>
            <div id="table_header">
                <h1>공지사항</h1>                
            </div>
            <table class="manage_table">
                <tr>
                    <th style="width:100px;">No</th>
                    <th>제목</th>
                    <th style="width:150px;">작성자</th>
                    <th style="width:280px;">날짜</th>
                </tr>
               	<c:forEach items="${noticeList}" var="list" varStatus="status">
			   		<tr onclick="location.href='/noticeList/${list.getNid()}'">
				   		<td>${status.count}</td>
				   		<td>${list.getTitle()}</td>
				   		<td>관리자</td>
				   		<td>${list.getDate()}</td>
				   	</tr>
				</c:forEach>
				<a href="/IPC_admin/admin_notice/${leftArrow}"> < </a>
				<c:forEach items="${pages}" var="page">
					<c:choose>
						<c:when test="${page eq currentPage }">
							<a href="/notice/noticePage/${page}"><b style="font-size:20px;">${page}</b><a>
						</c:when>
						<c:otherwise>
							<a href="/notice/noticePage/${page}">${page}<a>
						</c:otherwise>
					</c:choose>
			  	</c:forEach>
				<a href="/IPC_admin/admin_notice/${rightArrow}"> > </a>
            </table>
            <button onclick="location.href='/admin_notice_registration'" id="btn_add_notice">등록</button>            
        </article>
    </div>
<footer>
    <div id="admin_footer">
        <span>COPYRIGHT 2016 @ IDEAPROTECTIONCENTER ALL RIGHTS RESERVED</span>
    </div>
</footer>     
<script>
    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
</script>
</body>
</html>
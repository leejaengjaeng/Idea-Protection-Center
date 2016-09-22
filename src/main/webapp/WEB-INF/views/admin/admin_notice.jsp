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
<title>Insert title here</title>
<style>

</style>
</head>
<body>
    <header>        
        <img src="/resources/image/ideapc_logo.jpg" alt="logo" onclick="location.href='/IPC_adminPage'" style="cursor: pointer;">
        <div id="header_info">
            <span><b>${currentUser.getName() }</b>님</span>
            <button onclick="location.href='/logoutProcess.do'">로그아웃</button>
        </div>        
    </header>
    <div id="admin_cont">
        <nav>
            <ul>
                <li>회원관리</li>
                <li>아이디어 관리</li>
                <li>문의사항 관리</li>
                <li>게시판 관리</li>
                <a href="/admin_notice"><li>공지사항 관리</li></a>
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
                    <th style="width:150px;">날짜</th>
                </tr>
               	<c:forEach items="${noticeList}" var="list" varStatus="status">
			   		<tr onclick="location.href='/noticeList/${list.getNid()}'">
				   		<td>${status.count}</td>
				   		<td>${list.getTitle()}</td>
				   		<td>${list.getDate()}</td>
				   	</tr>
				</c:forEach>
            </table>            
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
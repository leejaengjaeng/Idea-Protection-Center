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
<style>

</style>
</head>

<body>
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
                    <th>No</th>
                    <th>ID</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>이메일</th>
                    <th>역할</th>       
                </tr>
               	<c:forEach items="${userList}" var="user" varStatus="status">
			   		<tr>
				   		<td>${status.count}</td>
				   		<td>${user.getId()}</td>
				   		<td>${user.getName()}</td>
				   		<td>${user.getPhone()}</td>
				   		<td>
				   			${user.getAddr3()} <br>
				   			${user.getAddr1()} &nbsp; ${user.getAddr2()}
				   		</td>
						<td>${user.getEmail()}</td>
				   		<c:choose>
				   			<c:when test="${user.getRole() == 'ROLE_INVENTOR' }">
				   				<td> 발명가 </td>
				   			</c:when>
				   			<c:when test="${user.getRole() == 'ROLE_ADMIN' }">
				   				<td> 관리자 </td>
				   			</c:when>
				   			<c:when test="${user.getRole() == 'ROLE_PATIENTENTLAWYER' }">
				   				<td> 변리사 </td>
				   			</c:when>
				   			<c:otherwise>
				   				<td style="color:red"> 비 정상 사용자 </td>
				   			</c:otherwise>
				   		</c:choose>
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
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
    <c:import url="/WEB-INF/views/import/admin_header.jsp" />
        <article>
            <div id="table_header">
                <h1>회원관리</h1>                
            </div>
            <table class="manage_table">
                <tr>
                    <th>No</th>
                    <th>ID</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>역할</th>       
                </tr>
               	<c:forEach items="${userList}" var="user" varStatus="status">
			   		<tr>
				   		<td>${status.count}</td>
				   		<td>${user.getId()}</td>
				   		<td>${user.getName()}</td>				   		
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
    <c:import url="/WEB-INF/views/import/admin_footer.jsp" />
<script>
    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
</script>
</body>
</html>
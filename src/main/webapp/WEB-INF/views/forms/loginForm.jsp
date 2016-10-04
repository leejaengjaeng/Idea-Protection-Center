<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<div id="log_form">
	<div id="log_form_wrap">
		<h1>로그인</h1>
		<form action="/login.do" method="post">	
		<table>
			<tr>
				<td colspan="2"><input type="text" name="id" class="log_inp" placeholder="ID"></td>				
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pw" class="log_inp" placeholder="Pass Word"></td>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>				
			</tr>
			<tr>
				<td>
					<button class="log_btn" style="cursor:pointer;background:#45d4fe">로그인</button>
	       		</td>
	       		<td>
					<button type="button" class="lost_password" style="background:#585858">ID/PW 찾기 (준비중)</button>
	       		</td>					
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="join_btn" onclick="location.href='/signup/signupPage'">아직 회원이 아니시라면</button>
				</td>
			</tr>
		</form>			
		</table>
	</div>
</div>
	
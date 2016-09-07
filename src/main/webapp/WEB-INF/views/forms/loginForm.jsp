<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div id="log_form">
<form action="/login.do" method="post">	
	<table>
		<tr>
			<td><input type="text" name="id" class="log_inp" placeholder="ID"></td>				
		</tr>
		<tr>
			<td><input type="password" name="pw" class="log_inp" placeholder="Pass Word"></td>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>				
		</tr>
		<tr>
			<td><button class="log_btn" style="background: #FF9800;
       color: #fff;">Login</button></td>				
		</tr>
	</form>
		<tr>
			<td>
			<button class="log_btn" style="background: #282828; color: #fff;">Join</button>
       		</td>				
		</tr>
	</table>
</div>
	
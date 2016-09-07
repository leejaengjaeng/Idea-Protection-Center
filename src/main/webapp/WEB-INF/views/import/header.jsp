<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<header>

	<div class="header_wrap">
		<ol>
			<!-- 로그인 하지 않은 유저 -->
			<sec:authorize access="isAnonymous()">
				<li>
					<button onclick="location.href='signup/signupPage'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #ccc;">
						회원가입</button>
				</li>
				<li>
					<button onclick="location.href='login'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #45d4fe;">
						로그인</button>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li>
					<button onclick="location.href='#'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #ccc;">
						<c:out value="${sessionScope.currentUser.getId() }" />
					</button>
				</li>
				<li>
					<button onclick="location.href='/logoutProcess.do'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #45d4fe;">
						로그아웃</button>
				</li>
			</sec:authorize>
		</ol>
		<div class="header_menu">
			<img src="#" alt="Logo">
			<ul>
				<li>아이디어 권리확보 시스템</li>
				<li>이용안내</li>
				<li>1:1질문하기</li>
				<li>자주하는 질문모음</li>
			</ul>
		</div>
	</div>
</header>
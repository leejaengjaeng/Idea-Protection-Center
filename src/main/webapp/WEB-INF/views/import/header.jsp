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
					<button onclick="location.href='/signup/signupPage'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #ccc;">
						회원가입</button>
				</li>
				<li>
					<button onclick="location.href='/login'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #45d4fe;">
						로그인</button>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li>
					
					<span style="display:inline-block; margin-top:8px;">
						<b style="color:#45d4fe;" onclick="location.href='/mainPage'">
							<c:out value="${sessionScope.currentUser.getName() }" />
						</b>
						<!--권한별 이름변경-->
						<c:choose>
							<c:when test="${sessionScope.currentUser.getRole()=='ROLE_INVENTOR'}">
								발명가님 환영합니다.
							</c:when>
							<c:when test="${sessionScope.currentUser.getRole()=='ROLE_PATIENTENTLAWYER'}">
								변리사님 환영합니다.
							</c:when>
							<c:otherwise>
								관리자님 환영합니다.
							</c:otherwise>
						</c:choose>
						
					</span>
					
				</li>
				<li>
					<button onclick="location.href='/logoutProcess.do'"
						style="box-shadow: inset 0 -4px rgba(0, 0, 0, .1); background: #45d4fe;">
						로그아웃</button>
				</li>
			</sec:authorize>
		</ol>
		<div class="header_menu">
			<img src="/resources/image/ideapc_logo.jpg" alt="Logo" onclick="location.href='/'" style="cursor: pointer;" draggable="false">
			<ul>
			<!-- 
				<li>아이디어 권리확보 시스템</li>
				<li>이용안내</li>
			 -->
			 	<li onclick="location.href='/comeOn'">상담 예약</li>
			 	<li onclick="location.href='/registration/addidea'">특허 출원하기</li>
			 	<li onclick="location.href='/qna/qnaBoard'">1:1질문하기</li>
				<li onclick="location.href='/qna/regularQna'">자주하는 질문모음</li>
			</ul>
		</div>		
	</div>
	<div id="header_benner">
		<img src="/resources/image/patent_apply_banner.jpg" alt="banner">
	</div>
</header>
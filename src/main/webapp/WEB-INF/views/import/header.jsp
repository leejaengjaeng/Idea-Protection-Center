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
						<b style="color:#45d4fe; font-size:14PX;" onclick="location.href='/mainPage'">
							<c:out value="${sessionScope.currentUser.getName() }" />
						</b>
						<!--권한별 이름변경-->
						<c:choose>
							<c:when test="${sessionScope.currentUser.getRole()=='ROLE_INVENTOR'}">
								<span style="font-size:14px;">발명가님 환영합니다.</span>
							</c:when>
							<c:when test="${sessionScope.currentUser.getRole()=='ROLE_PATIENTENTLAWYER'}">
								<span style="font-size:14px;">변리사님 환영합니다.</span>
							</c:when>
							<c:otherwise>
								<span style="font-size:14px;">관리자님 환영합니다.</span>
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
			<img src="/resources/image/logo.png" alt="Logo" onclick="location.href='/'" style="cursor: pointer;" draggable="false">
			<ul class="menu">
			<!-- 
				<li>아이디어 권리확보 시스템</li>
				<li>이용안내</li>
			 -->
			 	<li onclick="location.href='/comeOn'">
			 		아이디어 보호센터는
			 		<ul>
			 			<li>
			 				서비스 소개
			 			</li>
			 			<li>
			 				왜 아이디어 보호센터 인가
			 			</li>
			 		</ul>
			 	</li>
			 	<li onclick="location.href='/'">
			 		이용방법안내
			 		<ul>
			 			<li>
			 				사이트 이용안내
			 			</li>
			 			<li>
			 				비용안내
			 			</li>
			 		</ul>
			 	</li>
			 	<li onclick="location.href='/qna/qnaBoard'">
			 		고객센터
			 		<ul>
			 			<li>
			 				공지사항
			 			</li>
			 			<li>
			 				1:1문의
			 			</li>
			 			<li>
			 				자주하는 질문
			 			</li>
			 			<li>
			 				오시는길
			 			</li>
			 			<li>
			 				상담예약
			 			</li>
			 		</ul>
			 	</li>				
			</ul>
		</div>		
	</div>
	<div id="header_benner">
		<img src="/resources/image/patent_apply_banner.jpg" alt="banner">
	</div>
</header>
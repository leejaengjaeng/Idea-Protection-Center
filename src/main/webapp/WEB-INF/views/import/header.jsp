<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<header>
    <div class="header_wrap">
        <ol>
            <li>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#ccc;" onclick="location.href='/signup/signupPage'">
                    회원가입
                </button>
            </li>
            <li>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;" onclick="location.href='/login'">
                    로그인
                </button>
            </li>
        </ol>
        <div class="header_menu">
            <img src="/resources/image/ideapc_logo.jpg" alt="Logo" onclick="location.href='/'"style='cursor:pointer;'>
            <ul>
                <li>
                    아이디어 권리확보 시스템
                </li>
                <li>
                    이용안내
                </li>
                <li>
                    1:1질문하기
                </li>
                <li>
                    자주하는 질문모음
                </li>
            </ul>
        </div>
    </div>
    <div id="header_benner"></div>
</header>
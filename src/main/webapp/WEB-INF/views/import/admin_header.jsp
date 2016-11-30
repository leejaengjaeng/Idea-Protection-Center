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
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>

<link href="/resources/common/css/admin.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<link rel="icon" href="/resources/image/pavicon.png">

<title>IPC_AdminPage</title>
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
                <li onclick="location.href='/IPC_admin/design'">디자인 관리</li>  
                <li onclick="location.href='/IPC_admin/mark'">상표권 관리</li>                                
                <li onclick="location.href='/IPC_admin/admin_notice'">공지사항 관리</li>
               	<li onclick="location.href='/qna/regularQnaAdd'">자주 묻는 질문 등록</li>     
               	<li onclick="location.href='/IPC_admin/manageType'">특허 분류 관리</li>            
            </ul>  
        </nav>
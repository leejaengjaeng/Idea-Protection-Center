<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>SiteMap</title>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="wrap_form">
    <div style="width:100%; float:left; text-align:left; margin-bottom:100px;">
        <h1>오시는 길</h1>
    </div>
    <div style="width:100%; float:left;">
        <nav style="width:200px; float:left; text-align:right; padding-right:20px; font-size:20px; padding-top:20px;">
            <span class="road">아이디어콘서트<br>사무실</span>
        </nav>
        <div style="width:800px; float:left; text-align:left;">
            <img src="/resources/image/come1.jpg" alt="come1" style="border:1px solid #ccc; width:100%;">
            <span style="font-size:14px;">버스 : 강남역 5번출구에서 100미터 6800직행버스 ▶ 금토천교정류장하차 ▶ <b style="color:#45d4fe;">경기창조혁신센터 5층 (주)아이디어콘서트</b></span><br>
            <span style="font-size:14px; display:inline-block; margin-top:5px;">지하철 : 신분당선 판교역 4번이나 1번출구에서 안랩4거리 ▶ 좌회전 ▶ 300미터 ▶ <b style="color:#45d4fe;">경기창조혁신센터 5층 (주)아이디어콘서트</b></span>
        </div>
    </div>
    <div style="width:100%; float:left; margin-top:200px; margin-bottom:200px;">
        <nav style="width:200px; float:left; text-align:right; padding-right:20px; font-size:20px; padding-top:20px;">
            <span class="road">아이디어콘서트<br>부설연구소</span>
        </nav>
        <div style="width:800px; float:left; text-align:left;">
            <img src="/resources/image/come2.jpg" alt="come2" style="border:1px solid #ccc; width:100%;">     
            <span style="font-size:14px; display:inline-block; margin-top:5px;">
                양재시민의 숲역 5번출구 ▶ K호텔사거리 ▶ 우회전 500미터 직진 ▶ 좌회전 ▶
                <b style="color:#45d4fe;">KT연구센터 4층 에코노베이션 내 (주)아이디어콘서트</b><br>
                <span style="color:#ccc; display:inline-block; margin-top:5px;">※차를 가지고 오실 경우 1일 전에 연락을 주셔야 합니다.</span>
            </span>
        </div>
    </div>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
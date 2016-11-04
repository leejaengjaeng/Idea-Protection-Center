<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/util.js" type="text/javascript"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="icon" href="/resources/image/pavicon.png">
<title>Idea Protection Center</title>
<style>
    p{
    	line-height:1.8em;
    }
    input[type=file]{
    	padding-top:7px;
    }
    #patentsClientCode{
    	margin-top:10px; width:300px; height:35px; padding-left:5px;
    }
    table img{
    	width:50px;
    	margin-left:10px;
    }
</style>
<script>
	function changePersonal1(){
		document.getElementById("personal").textContent="주민등록 등본*";
		document.getElementById("smallCompany").style="display:none";
	}
	function changePersonal0(){
		document.getElementById("personal").textContent="법인등기부 등본*";
		document.getElementById("smallCompany").style="display:table-row";
	}
	function changeCode1(){
		document.getElementById("patentsClientCode").style="display:inline-block";
	}
	function changeCode0(){
		document.getElementById("patentsClientCode").style="display:none";
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>

<div id="wrap_form">
	<div style="width:100%; float:left;">
		<h2 style="font-size:40px; margin-top:100px; display: block; font-weight:400; margin-bottom:30px;">특허 준비하기</h2>
		<p>${regis.getTitle()} 을(를) 출원하기 위한 과정을 안내해 드립니다.</p>
		<p>미리 업로드하여 주시면 더욱 빠른 출원이 가능합니다.</p>
		<h3 style="float:left; margin:50px 0 0 0;">Step1. 필요서류 업로드</h3>
		<form action="/upload/inputFile" method="POST" enctype="multipart/form-data" style="margin-bottom:100px;">
		<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<span style="font-size:20px; display: inline-block; margin-right: 10px;"><input type="radio" name="is_personal" value="1" checked onclick='changePersonal1()'> 개인</span>
			<span style="font-size:20px;"><input type="radio" name="is_personal" value="0" onclick='changePersonal0()'> 법인</span>
			<input type="hidden" value="${regis.getRid()}" name="rid">
			<table>
				<tr>
					<td><span id="personal">주민등록등본*</span>
					<c:choose>
						<c:when test="${isExist>=1}">
							<td>이미 업로드 하였음.</td>
						</c:when>
						<c:otherwise>
							<td><input type="file" name="resident_registration" accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td><span>인감증면서(포괄위임용)*</span>
					<c:choose>
						<c:when test="${isExist>=1}">
							<td>이미 업로드 하였음.</td>
						</c:when>
						<c:otherwise>
							<td><input type="file" name="certificate" accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td><span>사업자등록증 <br>개인사업자이신 분은 업로드 하여 주세요</span>
					<c:choose>
						<c:when test="${isExist>=1}">
							<td>이미 업로드 하였음.</td>
						</c:when>
						<c:otherwise>
							<td><input type="file" name="business_license" accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr id="smallCompany" style="display:none">
					<td>중소기업 감면서류</td>
					<c:choose>
						<c:when test="${isExist>=1}">
							<td>이미 업로드 하였음.</td>
						</c:when>
						<c:otherwise>
							<td><input type="file" name="smallsale" accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"></td>
						</c:otherwise>
					</c:choose>
					
				</tr>
				<tr>
					<td>포괄위임장(인감날인)*</td>
					
					<td style="font-size:14px;"><img src="/resources/image/hwp.png" onclick="location.href='/downContents/attorney'">양식 다운로드     <img src="/resources/image/hwp.png" onclick="location.href='/downContents/envelope'">우편봉투 서식</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
						<span style="line-height:1.8em;">포괄 위임장 양식을 다운로드 받으신 후, 내용을 기입하여 인감을 날인하시어 우편으로 발송하여 주세요 <br>우편봉투 서식에 주소를 기재하시고 출력하여 이용하시면 편리합니다.</span>
					</td>
				</tr>
				
			</table>		
			<h3 style="text-align:left; margin-top:100px;">Step2. 특허고객번호 입력</h3>
			<span style="display: inline-block; margin:10px; margin-bottom:20px;">기존의 "출원인 코드"를 의미합니다</span><br>
			<input type="radio" name="patentsName" value="1" checked onclick="changeCode1()">있음 (직접입력)
			<input type="radio" name="patentsName" value="0" onclick="changeCode0()">없음 (변리사 님께 맡김)<br>
			<c:choose>
						<c:when test="${isExist>=1}">
							<td>이미 업로드 하였음.</td>
						</c:when>
						<c:otherwise>
							<input type="text" name="patentsClientCode" id="patentsClientCode">	
							<input type="submit" value="제출" style="width:60px; height:35px; background: none; border: 2px solid #555; margin-top:10px;">
									
						</c:otherwise>
			</c:choose>
		</form>
	</div>
</div>

<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
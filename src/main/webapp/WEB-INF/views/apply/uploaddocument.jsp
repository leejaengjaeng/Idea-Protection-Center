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
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>Insert title here</title>
<style>
    
</style>
<script>
	function changePersonal1(){
		document.getElementById("personal").textContent="주민등록 등본*";
		document.getElementById("smallCompany").style="display:none";
	}
	function changePersonal0(){
		document.getElementById("personal").textContent="법인등기부 등본*";
		document.getElementById("smallCompany").style="display:block";
	}
	function changeCode1(){
		document.getElementById("patentsClientCode").style="display:block";
	}
	function changeCode0(){
		document.getElementById("patentsClientCode").style="display:none";
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<h2>특허 준비하기</h2>
<p>제목 을(를) 출원하기 위한 과정을 안내해 드립니다.</p>
<h3>Step1. 필요서류 업로드</h3>
<p>미리 업로드하여 주시면 더욱 빠른 출원이 가능합니다.</p>
<form action="/upload/inputFile" method="POST" enctype="multipart/form-data">
	<input type="radio" name="is_personal" value="1" checked onclick='changePersonal1()'>개인
	<input type="radio" name="is_personal" value="0" onclick='changePersonal0()'>법인
	<table>
		<tr>
			<td><span id="personal">주민등록등본*</span>
			<td><input type="file" name="resident_registration" accept="image/gif, image/jpeg, image/png"></td>
		</tr>
		<tr>
			<td><span>인감증면서(포괄위임용)*</span>
			<td><input type="file" name="cerificate" accept="image/gif, image/jpeg, image/png"></td>
		</tr>
		<tr>
			<td><span>사업자등록증 <br>개인사업자이신 분은 업로드 하여 주세요</span>
			<td><input type="file" name="business_license" accept="image/gif, image/jpeg, image/png"></td>
		</tr>
		<tr>
			<td>포괄위임장(인감날인)*</td>
			<td></td>
		</tr>
		<tr>
			<td>
				<span>포괄 위임장 양식을 다운로드 받으신 후, 내용을 기입하여 인감을 날인하시어 우편으로 발송하여 주세요 <br>우편봉투 서식에 주소를 기재하시고 출력하여 이용하시면 편리합니다.</span>
			</td>
		</tr>
		<tr id="smallCompany" style="display:none">
			<td>중소기업 감면서류</td>
			<td><input type="file" name="smallsale" accept="image/gif, image/jpeg, image/png"></td>
		</tr>
	</table>
	
	<h3>Step2. 특허고객번호 입력</h3>
	<p>기존의 "출원인 코드"를 의미합니다</p>
	<input type="radio" name="patentsName" value="1" checked onclick="changeCode1()">있음 (직접입력)
	<input type="radio" name="patentsName" value="0" onclick="changeCode0()">없음 (변리사 님께 맡김)<br>
	<input type="text" name="patentsClientCode" id="patentsClientCode">
	
	<input type="submit" value="제출">
</form>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
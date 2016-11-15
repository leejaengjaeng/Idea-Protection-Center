<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/util.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resources/common/css/style.css"> 
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="icon" href="/resources/image/pavicon.png">
<title>Insert title here</title>
<script>


function checkpwd(){
	var pwd=document.getElementById("pw").value;
	var repwd=document.getElementById("repw").value;
	if(pwd==repwd){
		document.getElementById("checkpassword").innerHTML="<b>비밀번호가 일치합니다</b>"
	}
	else{
		document.getElementById("checkpassword").innerHTML="<b>비밀번호가 일치하지않습니다</b>"
	}
}
function changerole(inputvalue){
	document.getElementById("role").value=inputvalue;
	//alert(document.getElementById("role").value);
	
}
function editExecute(){
	var pwd=document.getElementById("password");
	var repwd=document.getElementById("repassword");
	var id=document.getElementById("id");
	var email=document.getElementById("email1");
	if(pwd.value!=repwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		pwd.value="";
		repwd.value="";
		pwd.focus();
		return false;
	}
	if(id.readOnly==false){
		alert("아이디 중복확인을 해주세요");
		return false;
	}
	if(id.value==""){
		alert("아이디를 입력하세요");
		return false;
	}
	return true;
}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp"/>
	<div id="wrap_form">
		<h1>회원정보수정</h1>

		<form action="/signup/editinput" method="POST" name="editform" onsubmit="return editExecute();" enctype="multipart/form-data" novalidate>
			<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
			<input type="text" id="role" name="role" value="${role}" hidden>		
			<table>
				<tr>
					<td colspan="2" style="text-align:center; padding-left: 0;" class="join_img_td">						
						<div>
							<img src="${uv.getProfileimg()}" alt="img" id="blah"><br>
							<input type="file" id="imgInp" name="profileImg" style="cursor:pointer;" onchange="fileCheck(this);">
							<span>대표사진을 설정 해주세요</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" id="id" value="${uv.getId()}" readOnly style="background:#f1f1f1;"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" id="pw"><div id="checkpassword" required></div></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="repw" onKeyUp='checkpwd()' required></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input name="name" id="name" required value="${uv.getName()}" readOnly style="background:#f1f1f1;"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input type="text" name="email1" id="email1" pattern="[A-Za-z0-9_]+" required style="float:left;" value="${email1}">
						<select name="emailMiddle" onChange="changeEmail2(this.value);" id="email_chg" style="float:left;">
							<option value=" " selected>${email2}</option>
							<option value="@naver.com">@ naver.com</option>
							<option value="@hanmail.com">@ hanmail.com</option>
							<option value="@daum.net">@ daum.net</option>
							<option value="@nate.com">@ nate.com</option>
							<option value="@gmail.com">@ gmail.com</option>
							<option value="@hotmail.com">@ hotmail.com</option>
							<option value="@dreamwiz.com">@ dreamwiz.com</option>
							<option value="@korea.com">@ korea.com</option>
							<option value="1">직접입력</option>							
						</select>
						<input type="text" name="email3" value="${email2}" id="email3" style="display:none; float:left;" required>
						<div style="width:100%; float:left; font-size:12px;margin-top:5px;"><span style="display:inline-block; float:left;">이메일은 회원가입 인증을 위한 정보입니다. 정확히 기재해 주세요.</span></div>
					</td>
				</tr>
				<c:choose>
					<c:when test="${role=='lawyer'}">
						<tr>
							<td>변리사 번호</td>
							<td><input type="text" name="license_number" id="license_number" value="${liNum}" readOnly style="background:#f1f1f1;"></td>
						</tr>		
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>				
								
			</table>
			<!-- <input type="submit" value="가입" id="submit"> -->
			<input type="submit" value="정보 수정" id="submit">
		</form>
	</div>
	<c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>

$(".hill").click(function(){	
	$(this).addClass("on");
	$(this).siblings().removeClass("on");
	
	
	if($(this).data('no') == 1){		
		$("#hide").css("display","table-row");
	}else{		
		$("#hide").css("display","none");
	}
	
});
$("#repw").keyup(function(){
	if($(this).val() == ""){
		$("#checkpassword").css("display","none");
	}else{
		$("#checkpassword").css("display","block");
	}
});
$("#email_chg").change(function(){
	if($(this).val()==1){
		$("#email2").css("display","block");
	}else{
		$("#email2").css("display","none");
	}
});

$(function() {
    $("#imgInp").on('change', function(){
        readURL(this);
    });
});

function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#blah').attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}
function changeEmail2(emailvalue){
	if(emailvalue=="1"){
		document.getElementById("email3").style.display="block";
		document.editform.email3.value="";
	}
	else{
		document.getElementById("email3").style.display="none";
		document.editform.email3.value=emailvalue;
	}
}
</script>
</body>
</html>
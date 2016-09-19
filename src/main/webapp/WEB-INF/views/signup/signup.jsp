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
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/style.css"> 
<link rel="stylesheet" href="/resources/common/css/index.css">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>Insert title here</title>
<script>
function changeEmail(emailvalue){
	if(emailvalue=="1"){
		document.getElementById("email2").style.display="block";
		document.signupform.email2.value="";
	}
	else{
		document.getElementById("email2").style.display="none";
		document.signupform.email2.value=emailvalue;
	}
}
function checkid(){
	
	//var id = document.getElementById("id").value;
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    var id = document.getElementById("id").value; 
    var data = {};
	var headers = {};
    data[csrfParameter] = csrfToken;
    data["id"] = id;
    headers[csrfHeader] = csrfToken; 
	$.ajax({
	    url : "/signup/checkid",
	    dataType : "json",
	    type : "POST",
	    headers: headers,
	    data : data,
	    success: function(data) {
	        alert("성공:"+data.KEY);
	        if (data.KEY=="YES"){
	        	//document.signupform.id.readOnly=true;
	        	var q=confirm(id+"는 사용할 수 있는 아이디 입니다. 사용하시겠습니까?")
	        	if(q==true){
	        		document.signupform.id.readOnly=true;
	        	}
	        	else{
	        		document.getElementById("id").value="";
	        	}
	        }
	        else{
	        	document.getElementById("id").value="";
	        	alert("중복된 아이디 입니다.");
	        }
	        
	    },
	    error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"error:"+error);
	    }
	 
	}); 
}
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
function execute(){
	var pwd=document.getElementById("password");
	var repwd=document.getElementById("repassword");
	var id=document.getElementById("id");
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
		<h1>회원가입</h1>

		<form action="/signup/inputsignup" method="POST" name="signupform" onsubmit="return execute();" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
			<button type="button" class="hill on" data-no="0" onclick='changerole("1")'>발명자 회원</button>
			<button type="button" class="hill" data-no="1" onclick='changerole("2")'>변리사</button>			
			<input type="text" id="role" name="role" value="1" hidden>		
			<table>
				<tr>
					<td colspan="2" style="text-align:center; padding-left: 0;" class="join_img_td">						
						<div>
<<<<<<< HEAD
							<img src="/resources/image/inventor_profile.jpg" alt="img" id="blah"><br>
							<input type="file" id="imgInp">
							<span>��ǥ������ �������ּ���</span>
=======
							<img src="#" alt="img" id="blah"><br>
							<input type="file" id="imgInp" name="profileImg">
							<span>대표사진을 설정해주세요</span>
>>>>>>> baba8eb44d068751ccd063619d19ce66fca124f5
						</div>
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" id="id"><button type="button" onclick="checkid()">중복확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" id="pw"><div id="checkpassword"></div></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="repw" onKeyUp='checkpwd()'></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input name="name" id="name"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input type="text" name="email1" id="email1">
						<select name="emailMiddle" onChange=changeEmail(this.value); id="email_chg">
							<option value="" selected>이메일선택</option>
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
						<input type="text" name="email2" id="email2" style="display:none;">
					</td>
				</tr>				
				<tr id="hide">
					<td>변리사 번호</td>
					<td><input type="text" name="license_number" id="license_number"></td>
				</tr>				
			</table>
			<input type="submit" value="가입" id="submit">
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
</script>
</body>
</html>
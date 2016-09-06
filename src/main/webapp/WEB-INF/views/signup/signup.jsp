<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css">
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
function changeEmail(emailvalue){
	if(emailvalue=="1"){
		document.getElementById("email2").style.visibility="visible";
		document.signupform.email2.value="";
	}
	else{
		document.getElementById("email2").style.visibility="hidden";
		document.signupform.email2.value=emailvalue;
	}
}
function checkid(){
	
	//var id = document.getElementById("id").value;
	//var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	//var csrfToken = $("meta[name='_csrf']").attr("content"); 
	//var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    var id = document.getElementById("id").value; 
    var data = {};
	//var headers = {};
    //data[csrfParameter] = csrfToken;
    data["id"] = id;
    //headers[csrfHeader] = csrfToken; 
	$.ajax({
	    url : "/signup/checkid",
	    dataType : "json",
	    type : "POST",
	    //headers: headers,
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
	return true;
}
</script>
</head>
<body>
	<form action="/signup/inputsignup" method="POST" name="signupform" onsubmit="return execute();">
		회원구분<br/>
		<button type="button" onclick="changerole('1');">발명자 회원</button><button type="button" onclick="changerole('2');">변리사</button><br/>
		<input type="text" name="role" id="role" hidden>
		아이디<input type="text" name="id" id="id"><button type="button" onclick="checkid()">중복확인</button><br/>
		비밀번호<input type="password" name="pw" id="pw"><br/>
		비밀번호 확인 <input type="password" id="repw" onKeyUp=checkpwd()><br/>
		<div id="checkpassword" ></div>
		이름<input name="name" id="name"><br/>
		이메일<input type="text" name="email1" id="email1">
		<select name="emailMiddle" onChange=changeEmail(this.value);>
			<option value="" selected>이메일선택</option>
			<option value="naver.com">@ naver.com</option>
			<option value="hanmail.com">@ hanmail.com</option>
			<option value="daum.net">@ daum.net</option>
			<option value="nate.com">@ nate.com</option>
			<option value="gmail.com">@ gmail.com</option>
			<option value="hotmail.com">@ hotmail.com</option>
			<option value="dreamwiz.com">@ dreamwiz.com</option>
			<option value="korea.com">@ korea.com</option>
			<option value="1">직접입력</option>
		</select>
		<input type="text" name="email2" id="email2" style="visibility:hidden"><br/>
		<input type="submit" value="가입">
	</form>
</body>
</html>
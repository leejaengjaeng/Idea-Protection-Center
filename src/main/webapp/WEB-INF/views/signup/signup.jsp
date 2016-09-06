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
	if(value=="1"){
		document.getElementById("email2").style.visibility="visible";
		document.getElementById("email2").value="";
	}
	else{
		document.getElementById("email2").style.visibility="hidden";
		document.getElementById("email2").value=emailvalue;
	}
}
function checkid(){
	
	var id = document.getElementById("id").value;
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
</script>
</head>
<body>
	<form action="/signup/inputsignup" method="POST">
		아이디<input type="text" name="id" id="id"><button type="button" onclick="checkid()"></button><br/>
		비밀번호<input type="text" name="pw" id="pw"><br/>
		비밀번호 확인 <input type="text" id="repw"><br/>
		이름<input name="name" id="name">
		이메일<input type="text" name="email1" id="email1">@					
		<select onChange=changeEmail(this.value)>
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
		<input type="text" name="email2" id="email2" hidden>
		<input type="submit" value="가입신청">
	</form>
</body>
</html>
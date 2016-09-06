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
	        alert("����:"+data.KEY);
	        if (data.KEY=="YES"){
	        	//document.signupform.id.readOnly=true;
	        	var q=confirm(id+"�� ����� �� �ִ� ���̵� �Դϴ�. ����Ͻðڽ��ϱ�?")
	        	if(q==true){
	        		document.signupform.id.readOnly=true;
	        	}
	        	else{
	        		document.getElementById("id").value="";
	        	}
	        }
	        else{
	        	document.getElementById("id").value="";
	        	alert("�ߺ��� ���̵� �Դϴ�.");
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
		���̵�<input type="text" name="id" id="id"><button type="button" onclick="checkid()"></button><br/>
		��й�ȣ<input type="text" name="pw" id="pw"><br/>
		��й�ȣ Ȯ�� <input type="text" id="repw"><br/>
		�̸�<input name="name" id="name">
		�̸���<input type="text" name="email1" id="email1">@					
		<select onChange=changeEmail(this.value)>
			<option value="" selected>�̸��ϼ���</option>
			<option value="naver.com">@ naver.com</option>
			<option value="hanmail.com">@ hanmail.com</option>
			<option value="daum.net">@ daum.net</option>
			<option value="nate.com">@ nate.com</option>
			<option value="gmail.com">@ gmail.com</option>
			<option value="hotmail.com">@ hotmail.com</option>
			<option value="dreamwiz.com">@ dreamwiz.com</option>
			<option value="korea.com">@ korea.com</option>
			<option value="1">�����Է�</option>
		</select>
		<input type="text" name="email2" id="email2" hidden>
		<input type="submit" value="���Խ�û">
	</form>
</body>
</html>
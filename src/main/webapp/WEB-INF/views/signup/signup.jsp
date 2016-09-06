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
function checkpwd(){
	var pwd=document.getElementById("pw").value;
	var repwd=document.getElementById("repw").value;
	if(pwd==repwd){
		document.getElementById("checkpassword").innerHTML="<b>��й�ȣ�� ��ġ�մϴ�</b>"
	}
	else{
		document.getElementById("checkpassword").innerHTML="<b>��й�ȣ�� ��ġ�����ʽ��ϴ�</b>"
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
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		pwd.value="";
		repwd.value="";
		pwd.focus();
		return false;
	}
	if(id.readOnly==false){
		alert("���̵� �ߺ�Ȯ���� ���ּ���");
		return false;
	}
	return true;
}
</script>
</head>
<body>
	<form action="/signup/inputsignup" method="POST" name="signupform" onsubmit="return execute();">
		ȸ������<br/>
		<button type="button" onclick="changerole('1');">�߸��� ȸ��</button><button type="button" onclick="changerole('2');">������</button><br/>
		<input type="text" name="role" id="role" hidden>
		���̵�<input type="text" name="id" id="id"><button type="button" onclick="checkid()">�ߺ�Ȯ��</button><br/>
		��й�ȣ<input type="password" name="pw" id="pw"><br/>
		��й�ȣ Ȯ�� <input type="password" id="repw" onKeyUp=checkpwd()><br/>
		<div id="checkpassword" ></div>
		�̸�<input name="name" id="name"><br/>
		�̸���<input type="text" name="email1" id="email1">
		<select name="emailMiddle" onChange=changeEmail(this.value);>
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
		<input type="text" name="email2" id="email2" style="visibility:hidden"><br/>
		<input type="submit" value="����">
	</form>
</body>
</html>
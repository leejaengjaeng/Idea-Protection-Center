<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/util.js" type="javascript/text"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>downLoad Document</title>
<script>
function downDoc(kindOfDocument){
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	var data = {};
	var headers = {};

	data[csrfParameter] = csrfToken;
    headers[csrfHeader] = csrfToken;

    data['kind']=kindOfDocument;
    $.ajax({
		url : "/downDoc",
		type:"POST",
		headers: headers,
 	    data : data,
 	    success:function(retVal)
 	    {
	 	   	alert("다운로드가 실행됩니다. 오류가 있을 시 한번 더 누르거나 문의하여 주십시오");
	 	   	alert(retVal);
	 	   	location.href="/executeDownLoad/"+retVal;
 	    },
 	    error: function(request,status,error)
		{
 			alert('실패하였습니다.')
 			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
특허 출원서 <button onclick="downDoc('apply')">다운로드</button><br>
<c:choose>
	<c:when test="${docVo.getResident_registration()!=null}">
		<c:choose>
			<c:when test="${docVo.getIs_personal()==1}">
				주민등록등본 <button onclick="downDoc('resident')">다운로드</button><br>
			</c:when>
			<c:otherwise>
				법인등기부등본 <button onclick="downDoc('resident')">다운로드</button><br>
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${docVo.getBusiness_license()!=null}">
		사업자등록증 <button onclick="downDoc('business')">다운로드</button><br>
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${docVo.getCertificate()!=null}">
		인감증명서 <button onclick="downDoc('certificate')">다운로드</button><br>
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${docVo.getSmallsale()!=null}">
		중소기업감면서류 <button onclick="downDoc('small')">다운로드</button><br>
	</c:when>
</c:choose>



<form action="/upload/uploadfinalApplyDoc" enctype="multipart/form-data" method="post" >
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

출원서 업로드<input type="file" name="finalApplyDoc" accept="image/gif, image/jpeg, image/png">

<input type="submit" value="제출">
</form>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
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
	 	   	//alert(retVal);
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
<style>
	table tr{
		height: 65px;
		border: 1px solid #ccc;
		border-left:none;
		border-right:none;
	}
	table{
		margin-top:100px;
		font-size:14px;
	}
	table button{
		width:100px;
		height:35px;
		border:none;
		background:#1e97d0;
		color:white;
	}
	table input[type=submit]{
		width:100px;
		height:35px;
		border:none;
		background:#1e97d0;
		color:white;
	}
	table input[type=text]{
		width:120px;
	}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="wrap_form">
	<div style="width:100%; float:left; padding-top:50px; padding-bottom:100px;">	
	<table style="width:80%;">		
	<c:choose>
		<c:when test="${docVo.getResident_registration()!=null}">
			<c:choose>
				<c:when test="${docVo.getIs_personal()==1}">
				<tr>
					<td>주민등록등본</td>
					<td style="width:70%;"> <button onclick="downDoc('resident')">다운로드</button></td>					
				</tr>
				</c:when>
		
		
				<c:otherwise>
				<tr>
					<td>법인등기부등본</td>
					<td><button onclick="downDoc('resident')">다운로드</button></td>
				</tr>
				</c:otherwise>
			</c:choose>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${docVo.getBusiness_license()!=null}">
			<tr>
				<td>사업자등록증</td>
				<td><button onclick="downDoc('business')">다운로드</button></td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${docVo.getCertificate()!=null}">
			<tr>
				<td>인감증명서</td> 
				<td><button onclick="downDoc('certificate')">다운로드</button></td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${docVo.getSmallsale()!=null}">
			<tr>
				<td>중소기업감면서류</td>
				<td><button onclick="downDoc('small')">다운로드</button></td>
			</tr>
		</c:when>
	</c:choose>
	
	<tr>
		<td>특허고객번호 (출원인 코드) :</td>	
	<c:choose>		
		<c:when test="${docVo.getPatentscode()!=null}">
		<td>
			${docVo.getPatentscode()}<br>
		</td>
		</c:when>
		<c:otherwise>
		<td>
			없음..
		</td>
		</c:otherwise>
	</c:choose>
	</tr> 
	<form action="/upload/uploadfinalApplyDoc" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
	
	<c:choose>
		<c:when test="${docVo.getFinalApplyDoc()!=null}">
			<tr>
				<td colspan="2">출원서를 이미 업로드 하였습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<td>
					출원서 업로드
				</td>
				<td>
					<input type="file" name="finalApplyDoc" accept="image/gif, image/jpeg, image/png">
				</td>
			</tr>
			<tr>
				<td>
					출원일
				</td>
				<td>
					<input type="text" name="year">년  <input type="text" name="month">월 <input type="text" name="day">일
					<input type="submit" value="제출">	
				</td>
			</tr>			
		</c:otherwise>
	</c:choose>
	</form>
	</table>
	<span style="display:inline-block; margin-top:30px;">특허 출원서 </span><button onclick="downDoc('apply')" style="border: none;background:#1e97d0; width:80px; height:35px; color:white; margin-left:10px;">다운로드</button><br>
	</div>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- <link rel="stylesheet"
   href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css"> -->
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/util.js" type="text/javascript"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/cmt.css">
<link rel="icon" href="/resources/image/pavicon.png">
<title>Idea Protection Center</title>
<script src="/resources/common/js/registration.js"></script>
</head>
<body onload='checkTemp();'>

	<div class="black_wall" id="bw" style="visibility: hidden"></div>
	<div class="popup" id="pp" style="visibility: hidden">
		<div class="pop_header">
			<h2 style="color: #f9f9f9">아이디어 보호센터</h2>
			<img src="/resources/image/close.png" alt="close" class="popup_close"
				onclick="closeload()" id="close">
		</div>
		<div class="pop_cont">
			<span>임시저장된 아이디어가 있습니다.</span>
			<table style="width: 100%;">
				<c:forEach items="${tempList}" var="list" varStatus="status">
					<tr>
						<td style="width: 30px;">${status.count }</td>
						<td>${list.getTitle()}</td>
						<td>${list.getRegistration_date() }</td>
						<td style="width: 100px;"><button
								style="background: #45d4fe;"
								onclick="loadTempIdea(${list.getRid()})" id="load_data">불러오기</button></td>
						<td style="width: 100px;"><button
								style="background: #e9e9e9; color: #333;"
								onclick="removeTempIdea(${list.getRid()})">삭제하기</button></td>

					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<c:import url="/WEB-INF/views/import/header.jsp" />
	<div class="wrap_comment">
		<section> 
		<article class="sub_head"
			style="margin-top:100px;">
		<h1>
			<b>특허</b>출원
		</h1>
		<span>아이디어 보호센터에서 손쉽게 특허를 등록하세요.</span>		
		 </article> 
		<article class="nt">
		<div class="full">
			<div class="hiding_tab" style="position: relative; width: 100%;">
				<div class="arrow-up ee"></div>
				<form name="regisForm" action="/registration/inputidea" method="POST" enctype="multipart/form-data" onsubmit="return formSubmit(document.regisForm.imgs);">
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="text" name="uid" id="uid"
				value="${sessionScope.currentUser.getUid()}" hidden>				
				<select onChange="changeType(this.value);" id="selectBox">
					<option>해당 산업에 맞는 카테고리를 선택해 주세요</option>
				</select> <input type="hidden" value="-" name="typeOfInvent" id="idea_kind">
			</div>
		</div>
		<div class="tab_box">
			<div class="b0" style="background-color: #004a80; color: white;">
				<span>제목</span>
			</div>
			<div class="b1">
				<span>요약</span>
			</div>
			<div class="b2">
				<span>필요이유</span>
			</div>
			<div class="b3">
				<span>기존제품설명<br>및 문제점
				</span>
			</div>
			<div class="b4">
				<span>문제해결방법</span>
			</div>
			<div class="b5">
				<span>발명의 효과</span>
			</div>
			<div class="b6">
				<span>핵심구성요소</span>
			</div>
			<div class="b7">
				<span>권리를 보장받고자<br>하는 내용
				</span>
			</div>
			<div class="b8">
				<span>도면첨부</span>
			</div>
			<div class="b9">
				<span>도면에 대한 설명</span>
			</div>
		</div>
		<div class="area_box a0" style="display: block;">
			<div>
				<textarea id="idea_title" name="title"></textarea>
			</div>
		</div>
		<div class="area_box a1">
			<div>
				<textarea id="small_cont" name="summary"></textarea>
			</div>
		</div>
		<div class="area_box a2">
			<div>
				<textarea id="why_cont" name="whyInvent"></textarea>
			</div>
		</div>
		<div class="area_box a3">
			<div>
				<textarea id="col_cont" name="problem"></textarea>
			</div>
		</div>
		<div class="area_box a4">
			<div>
				<textarea id="wel_cont" name="solution"></textarea>
			</div>
		</div>
		<div class="area_box a5">
			<div>
				<textarea id="bal_cont" name="effect"></textarea>
			</div>
		</div>
		<div class="area_box a6">
			<div>
				<textarea id="imp_cont" name="core_element"></textarea>
			</div>
		</div>
		<div class="area_box a7">
			<div>
				<textarea id="hope_content" name="hope_content"></textarea>
			</div>
		</div>
		<div class="area_box a8">
			<div style="width:96%; margin-left:2%;">
				<div id="plc">
					<div id="upimgdiv2">
						<input type="file" id="upimg1" name="imgs"
						accept="image/gif, image/jpeg, image/png"
						onchange="fileCheck(this)" style="margin-left:5px; margin-top:5px; float:left;">
					</div>
					<button type="button" onclick="addfile2()" class="addbtns">추가</button>
					<button type="button" onclick="delfile()" class="addbtns">삭제</button>
				</div>
			</div>
		</div>
		<div class="area_box a9">
			<div>
				<textarea id="picture_explain" name="picture_explain"></textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button" onclick='tempsave()'>임시저장</button>
			<input type="submit">
		</div>
		</form>
		</article> 
	</section>	
	</div>
<c:import url="/WEB-INF/views/import/footer.jsp" />
<script src="/resources/common/js/cmts.js"></script>
</body>
</html>
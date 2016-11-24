<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:import url="/WEB-INF/views/import/header.jsp" />
<link href="/resources/common/css/copyRight.css" rel="stylesheet">
<script type="text/javascript"	src="/resources/common/js/util.js"></script>

<script>

var submitFunc = function()
{
	var title 	= $('#idea_kind').val()
	var field 	= $('#field_selected option:selected').val()
	var type	= $('#kind').val()
	var meaning = $('#meaning').val()
	alert(title+'\n'+field+'\n'+type+'\n'+meaning)
	
}
</script>

</head>
<body>
	<div class="wrap_comment">
		<section> <article class="sub_head">
		<h1>
			<b style="color: #45d7c2">저작권</b>출원
		</h1>
		</article> 
		<article>
		<form action="/copyRight/regCopyright" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" />				
<!-- 명칭 -->
			<div class="txt_box">
				<h2>저작물 명칭</h2>
				<button>작성예시 보기</button>
				<input type="text" id="idea_kind" name="idea_kind"
					placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품">
				<div class="hiding_box">
					<div class="hiding_box_header">
						<h3>저작물 명칭</h3>
						<img src="image/close.png" alt="close" class="close_btn">
					</div>
					<div class="hiding_box_content">
						<span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
					</div>
				</div>
			</div>
<!-- 분야 -->
			<div class="txt_box">
				<h2>저작물 분야</h2>
				<button>작성예시 보기</button>
				<br>
				<div class="field">
					<span>분야</span> 
					<select id="field_selected" name="field_selected">
					<!-- 	<option>-선택-</option> -->
						<c:forEach items="${typeList}" var="type">
						<option>${type.getType()}</option>
						</c:forEach>
					</select>
<!-- 종류 -->
					<span style="display: inline-block; margin-left: 140px;">종류</span>
					<input type="text" id="kind" name="kind">
				</div>
				<span
					style="font-size: 0.8rem; color: #45d7c2; display: inline-block; float: left; margin-top: 10px;">
					본인이 창작한 저작물의 분야를 선택해주세요. </span>
				<div class="hiding_box">
					<div class="hiding_box_header">
						<h3>저작물 명칭</h3>
						<img src="image/close.png" alt="close" class="close_btn">
					</div>
					<div class="hiding_box_content">
						<span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
					</div>
				</div>
			</div>
<!-- 의미 -->
			<div class="txt_box" style="margin-top: 100px;">
				<h2>저작물의 의미</h2>
				<button>작성예시 보기</button>
				<textarea id="meaning" name="meaning"></textarea>
				<span style="font-size: 0.8rem; color: #45d7c2;">본인이 창작한 저작의
					의미를 적어 주시기 바랍니다.</span>
				<div class="hiding_box">
					<div class="hiding_box_header">
						<h3>저작물 명칭</h3>
						<img src="image/close.png" alt="close" class="close_btn">
					</div>
					<div class="hiding_box_content">
						<span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
					</div>
				</div>
			</div>
<!-- 첨부 -->
			<div class="txt_box">
				<h2>저작물 첨부</h2>
				<button>작성예시 보기</button>
				<input type="file" style="float: left; margin: 10px; opacity: 1; padding-top: 5px;">
				<span style="font-size: 0.8rem; color: #45d7c2; display: inline-block; float: left;">만드신
					저작물의 첨부파일을 넣어 주세요 10mb이상의 파일은 이후 지정된 전문가의 메일로 제출하여 주세요.</span>
				<div id="add_btn" onclick="addfile2()">추가하기</div>
				<div class="hiding_box">
					<div class="hiding_box_header">
						<h3>저작물 명칭</h3>
						<img src="image/close.png" alt="close" class="close_btn">
					</div>
					<div class="hiding_box_content">
						<span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
					</div>
				</div>
			</div>
			<div class="txt_box">
				<img src="#" alt="등록된 디자인 시안이 없습니다.">
			</div>
			<div id="fin">
				<!-- <button>임시저장</button>	 -->
				<button id="agree" onclick="submitFunc()">등록하기</button>
			</div>
		</form>
		</article>
		</section>
	</div>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
</body>
</html>
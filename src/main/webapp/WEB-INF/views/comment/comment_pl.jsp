<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Idea Protectection Center</title>
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/comment.js"></script>
<link href="/resources/common/css/cmt.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<link href="/resources/common/css/index.css" rel="stylesheet">
<link rel="icon" href="/resources/image/pavicon.png">
<style>
.after_cmt>textarea {
	margin-top: 0 !important;
}
</style>

<script src="/resources/common/js/cmt_pl.js"></script>
<style>
	.tab_contents>textarea{
        float: right !important;
        width: 660px !important; 
        border-radius: 6px !important;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp" />
	<div class="wrap_comment">
		<section>
			<article class="modify_log"
				style="margin-top: 100px; padding-bottom: 65px;">
				<h1>아이디어수정내역</h1>
				<table id="IdeaModifyList">
					<c:forEach items="${processList}" var="list" varStatus="status">
						<c:choose>
							<%-- 목록이 하나인 경우 --%>
							<c:when test="${status.first and status.last }">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">아이디어 등록(초안)</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<%-- 목록이 하나가 아닌 경우 --%>
							<c:when test="${status.first}">
								<tr>
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">아이디어 등록(초안)</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<c:when test="${status.last}">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">${status.index}차전문가 검토 및 수정안</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<input type="hidden" value="${list.getRid()}" />
									<td class="title_td">${status.index}차전문가 검토 및 수정안</td>
									<td class="date_td">${list.getRegistration_date()}</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
			</article>
			<article class="nt" style="display:block;">
		<div class="full">
			<div class="hiding_tab" style="position: relative; width: 100%;">
				<div class="arrow-up ee"></div>
				<form name="regisForm" action="/registration/inputidea" method="POST"
				enctype="multipart/form-data"
				onsubmit="return formSubmit(document.regisForm.imgs);">
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" >				
				<select onChange=changeType(this.value);>
					<option>해당 산업에 맞는 카테고리를 선택해 주세요</option>
				</select> 
				<input type="hidden" value="-" name="typeOfInvent" id="idea_kind">
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
		<!-- 제목 -->
		<div class="area_box a0" style="display: block;">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentTitle">${beforeComment.getRe_title()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentTitle">${currentAnswer.getTitle()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled style="border-top:1px solid #fff;" id="AfterCommentTitle">${currentAnswer.getRe_title()}</textarea>				
			</div>
		</div>
		<!-- 요약 -->
		<div class="area_box a1">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSummary" name="summary">${beforeComment.getRe_summary()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentSummary">${currentAnswer.getSummary()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSummary">${currentAnswer.getRe_summary()}</textarea>
			</div>
		</div>
		<!-- 필요이유 -->
		<div class="area_box a2">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentWhyInvent" name="whyInvent">${beforeComment.getRe_whyInvent()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentWhyInvent">${currentAnswer.getWhyInvent()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentWhyInvent">${currentAnswer.getRe_whyInvent()}</textarea>
			</div>
		</div>
		<!-- 기존제품 설명 및 문제점 -->
		<div class="area_box a3">
			<div class="plc">
				<div class="halfframe">			
					<h1>이전 작성 내용</h1>	
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentProblem" name="problem">${beforeComment.getRe_problem()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentProblem">${currentAnswer.getProblem()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentProblem">${currentAnswer.getRe_problem()}</textarea>
			</div>
		</div>
		<!-- 문제 해결 방법 -->
		<div class="area_box a4">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea  class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSolution" name="solution">${beforeComment.getRe_solution()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea  class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentSolution">${currentAnswer.getSolution()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea  class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSolution">${currentAnswer.getRe_solution()}</textarea>
			</div>
		</div>
		<!-- 발명의 효과 -->
		<div class="area_box a5">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea  class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentEffect" name="effect">${beforeComment.getRe_effect()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea  class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentEffect">${currentAnswer.getEffect()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea  class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentEffect">${currentAnswer.getRe_effect()}</textarea>				
			</div>
		</div>
		<!-- 핵심 구성 요소 -->
		<div class="area_box a6">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentCore_Element" name="core_element">${beforeComment.getRe_core_element()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentCore_Element">${currentAnswer.getCore_element()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentCore_Element">${currentAnswer.getRe_core_element()}</textarea>					
			</div>
		</div>
		<!-- 권리를 보장 받고자 하는 내용 -->
		<div class="area_box a7">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentHope_content()" name="hope_content">${beforeComment.getRe_hope_content()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentHope_content()">${currentAnswer.getHope_content()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentHope_content">${currentAnswer.getRe_hope_content()}</textarea>
			</div>
		</div>
		<!-- 도면 첨부 -->
		<div class="area_box a8">
			<div>
				<div class="plc">
					<form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                        <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
                        <input type="hidden" name="start_rid_file" value="${start_rid}">                    
                  	</form>
                  	<div class="tab_imgs">
	                	<c:forEach items="${imgs}" var="list" varStatus="status">
	                    	<div onclick="location.href='${list.getFile_path()}'" id="id${list.getRfid()}">
	                           <img src="${list.getFile_path()}">
	                        </div>
	                    </c:forEach>
                  </div>
				</div>
			</div>
		</div>
		<!-- 도면 설명 -->
		<div class="area_box a9">
			<div class="plc">
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentPicture_explain" name="picture_explain">${beforeComment.getRe_picture_explain()}</textarea>
				</div>
				<div class="halfframe">
					<h1>발명가의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="변리사" disabled id="CurrentCommentPicture_explain">${currentAnswer.getPicture_explain()}</textarea>
				</div>
				<div class="titframe">
					<h1>Comment를 작성 해 주세요</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentPicture_explain">${currentAnswer.getRe_picture_explain()}</textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button" id="tmpSave">임시저장</button>
			<input type="submit" id="agree">
		</div>
		</form>
		</article>
		</section>
	</div>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
<script src="/resources/common/js/cmts.js"></script>
</body>
</html>

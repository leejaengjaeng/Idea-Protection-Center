<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protectection Center</title>
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>  
    <script src="/resources/common/js/comment.js"></script>  
    <script src="/resources/common/js/util.js" type="text/javascript"></script>
        
    <link href="/resources/common/css/title_cmt.css" rel="stylesheet">
    <link href="/resources/common/css/cmt.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
    <link rel="icon" href="/resources/image/pavicon.png">
<style>
	.tab_contents textarea{
        float: right !important;
        width: 660px !important; 
        border-radius: 6px !important;
    }
    #header_benner{
		display: none;
	}
	
</style>
<script>
$(document).ready(function()
{
	if("${isFirst}" == "true")	hideBeforeCmt();
	
	if("${currentAnswer.getIscomplete()}" == 0)	enableInput();	
	else
	{
		disableInput();
		if("${currentAnswer.getIscomplete()}"==2) {	btnHide(); alert("가출원상태입니다."); }
		//else if("${currentAnswer.getIscomplete()}"==4) gotoApply("${user}");
		else if("${currentAnswer.getIscomplete()}"==3)
		{
			btnHide();
			disableInput();
			alert("변리사가 위의 내용으로 최종확인하였습니다. \n출원 단계를 원하시면 하단의 출원 버튼을 눌러주세요");
			
		}
		else if("${currentAnswer.getIscomplete()}"==5){
			alert("변리사님이 발명가님의 서류를 검토하는 동안 기다려 주세요");
		}
		else if("${currentAnswer.getIscomplete()}"==6){
			alert("변리사님이 출원을 완료하였습니다.");
			$('#gotoApply').hide();
		}
		else alert('변리사의 답변을 기다려주세요');
	}
	
	//폼 버튼 이벤트 
	$('#tmpSave').on("click",function()
	{
		tmpSave("${user}");
	});
	$('#agree').on("click",function()
	{
		ideaSave("${user}");
	});
	$('#gotoApply').on("click",function()
	{
		gotoApply("${user}");
	});
	//클릭에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","li",function()
	{
		//IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
		
		$('#IdeaModifyList').find('.clickedIdea').removeClass('clickedIdea');
		var rid = $(this).children('input').attr('value');
		
		if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 0)) enableInput();
		else disableInput();
	
		//현재 선택된 요소(tr)에 clickedIdea를 붙임
		$(this).addClass('clickedIdea');
		showClickedList(rid);	
		
		$('#drop_sp').text($(this).text());
	})	
	$('#drop_sp').text($('#IdeaModifyList').find('.clickedIdea').text());
});

</script>
<style>
	.tab_contents>textarea{
        float: right !important;
        width: 660px !important; 
        border-radius: 6px !important;
    }
</style>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
     <div class="wrap_comment">       
        <section>                      
            <article class="sub_head" style="margin-top:100px;">                    
                <h1 style="width:300px; margin-bottom:20px;">아이디어수정내역</h1>                
				<div class="dropdown">
					<span id="drop_sp">아이디어 등록 (초안)</span>
					<div class="arrow-up ee"></div>					
					<ul id="IdeaModifyList">
						<c:forEach items="${processList}" var="list" varStatus="status">
							<c:choose>
								<c:when test="${status.first and status.last }">
									<li class ="clickedIdea" data-val="아이디어 등록 (초안) ${list.getRegistration_date()}">
										<input type="hidden" value="${list.getRid()}"/>
										아이디어 등록 (초안)
										${list.getRegistration_date()}
									</li>
								</c:when>
								<c:when test="${status.first }">
									<li data-val="아이디어 등록 (초안) ${list.getRegistration_date()}">
										<input type="hidden" value="${list.getRid()}"/>
										아이디어 등록 (초안)
										${list.getRegistration_date()}
									</li>
								</c:when>
								<c:when test="${status.last }">
									<li class="clickedIdea" data-val="${status.index}차 전문가 검토 및 수정안 ${list.getRegistration_date()}">
										<input type="hidden" value="${list.getRid()}"/>
										${status.index}차 전문가 검토 및 수정안
										${list.getRegistration_date()}
									</li>
								</c:when>
								<c:otherwise>
									<li data-val="${status.index}차 전문가 검토 및 수정안 ${list.getRegistration_date()}">
										<input type="hidden" value="${list.getRid()}"/>
										${status.index}차 전문가 검토 및 수정안
										${list.getRegistration_date()}
									</li>
								</c:otherwise>
				          	</c:choose>
						</c:forEach>
					</ul>					
				</div> 
			</article>                
            <article class="nt" style="display:block;">
		<div class="full">

		<div class="hiding_tab" style="position: relative; width: 100%;">
		<div class="arrow-up ee"></div>
			<input type="hidden" name="${_csrf.parameterName}" 	value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}">
			<select onChange=changeType(this.value);>
				<c:choose>
					<c:when test="${isFirst eq 'true'}">
						<option>${currentAnswer.getTypeOfInvent()}</option>
					</c:when>
					<c:otherwise>
						<option>${beforeReg.getTypeOfInvent()}</option>
					</c:otherwise>
				</c:choose>
			</select> 
			
			<input type="hidden" value="${beforeReg.getTypeOfInvent()}" name="typeOfInvent" id="AfterCommentTypeOfInvent">
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
				<span>기존제품설명<br>및 문제점</span>
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
			<div class="plc">
				<div class="title_cmt">
					<h3>제목</h3>
					<span>여러분의 아이디어의 이름을 적어 주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>제목</h3>
						</div>
						<p>
							제목은 아이디어를 구체적으로 표현할 수 있는 단어들을 <br>조합하면 됩니다.<br><br>
							분야+기술의 명사형+해결하는 방식 명사형<br><br>
							예시) 전자상거래에서의 매매보호 방법
						</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentTitle">${beforeReg.getTitle()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentTitle">${beforeReg.getRe_title()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled style="border-top:1px solid #fff;" id="AfterCommentTitle">${currentAnswer.getTitle()}</textarea>				
			</div>
		</div>
		<!-- 요약 -->
		<div class="area_box a1">
			<div class="plc">
				<div class="title_cmt">	
					<h3>요약</h3>		
					<span>아이디어에 대한 요약을 설명해 주세요</span>	
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>요약</h3>
						</div>
						<p>
							요약은 본인이 만들고자 하는 아이디어의 제목을 기본으로 하여 <br>
							기존의 방법을 통해서 이루어진 방법을 기술하고<br>
							 이때 기존기술의 불편한 요소를 기술하면 됩니다.<br>
							해당 불편요소를 해결하는 핵심적인 기술과 그 기술로<br> 
							이루어지는 혜택을 서술하시면 됩니다.
						</p>
					</div>		
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSummary" name="summary">${beforeReg.getSummary()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentSummary">${beforeReg.getRe_summary()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSummary">${currentAnswer.getSummary()}</textarea>
			</div>
		</div>
		<!-- 필요이유 -->
		<div class="area_box a2">
			<div class="plc">
				<div class="title_cmt">
					<h3>필요이유</h3>		
					<span>이 아이디어가 왜 필요한지 알려 주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>필요이유</h3>
						</div>
						<p>
							제해당부분의 지식을 가진자가 용이하도록 만들 수 있도록<br> 
							발명의 목적와 구성 그리고 효과를 기재하시면 됩니다.
						</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentWhyInvent" name="whyInvent">${beforeReg.getWhyInvent()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentWhyInvent">${beforeReg.getRe_whyInvent()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentWhyInvent">${currentAnswer.getWhyInvent()}</textarea>
			</div>
		</div>
		<!-- 기존제품 설명 및 문제점 -->
		<div class="area_box a3">
			<div class="plc">
				<div class="title_cmt">
					<h3>기존제품설명 및 문제점</h3>		
					<span>기존제품의 간단한 설명 및 문제점을 알려 주세요</span>
					<button class="exbtn">작성예시</button>s
					<div class="example">
						<div class="extitle">
							<h3>기존제품설명 및 문제점</h3>
						</div>
						<p>
							본인의 아이디어가 속하는 분야를 기재하면 됩니다.(1번)<Br>
							그 분야의 종래기술은 구체적으로 지금 그리고 <br>
							이전의 기술에 대한 내용을 정리하시면 됩니다.
						</p>
					</div>
				</div>
				<div class="halfframe">			
					<h1>이전 작성 내용</h1>	
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentProblem" name="problem">${beforeReg.getProblem()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentProblem">${beforeReg.getRe_problem()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentProblem">${currentAnswer.getProblem()}</textarea>

			</div>
		</div>
		<!-- 문제 해결 방법 -->
		<div class="area_box a4">
			<div class="plc">
				<div class="title_cmt">
					<h3>문제해결방법</h3>		
					<span>기존제품의 문제점을 어떻게 해결했는지를 알려주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>문제해결방법</h3>
						</div>
						<p>
							현재 및 이전기술의 문제점을 분석하여<br> 
							그 문제점으로부터 발명이 해결하고자 하는 과제를<br> 
							현재및 이전기술과 비교하여 기술적으로 좋은<br>
							 내용을 작성해 주세요.
						</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea  class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentSolution" name="solution">${beforeReg.getSolution()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea  class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentSolution">${beforeReg.getRe_solution()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea  class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentSolution">${currentAnswer.getSolution()}</textarea>
			</div>
		</div>
		<!-- 발명의 효과 -->
		<div class="area_box a5">
			<div class="plc">
				<div class="title_cmt">
					<h3>발명의 효과</h3>		
					<span>아이디어로 얻을 수 있는 혜택이나 효과를 알려주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>발명의 효과</h3>
						</div>
						<p>이전기술보다 본 발명의 특별한 효과를 <br>
						비교하여 구체적으로 기재(경제적,기술적,시간적, 등등)</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea  class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentEffect" name="effect">${beforeReg.getEffect()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea  class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentEffect">${beforeReg.getRe_effect()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea  class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentEffect">${currentAnswer.getEffect()}</textarea>				
			</div>
		</div>
		<!-- 핵심 구성 요소 -->
		<div class="area_box a6">
			<div class="plc">
				<div class="title_cmt">
					<h3>핵심구성요소</h3>		
					<span>아이디어를 구성하는 기술 및 기능적 구성요소와 작동순서를 알려주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>핵심구성요소</h3>
						</div>
						<p>
						발명의 구성은 발명의 기술적인 부분을 나열하고<br> 
						해당 기술의 연관관계와 해당 기술의 동작 및 기능을 <br>
						프로세스로 기술합니다.
</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentCore_Element" name="core_element">${beforeReg.getCore_element()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentCore_Element">${beforeReg.getRe_core_element()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentCore_Element">${currentAnswer.getCore_element()}</textarea>					

			</div>
		</div>
		<!-- 권리를 보장 받고자 하는 내용 -->
		<div class="area_box a7">
			<div class="plc">
				<div class="title_cmt">
					<h3>권리를 보장받고자 하는 내용</h3>		
					<span>아이디어를 보호받고자 하는 내용을 적어 주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>권리를 보장받고자 하는 내용</h3>
						</div>
						<p>
							특허청구범위는 중요하여 변리사가 직접 작성을 합니다.<br>
							본 란은 본인이 받을 수 있는 <br>
							아이디어에 대한 권리를 적어 주시면 됩니다.
						</p>
					</div>				
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentHope_content()" name="hope_content">${beforeReg.getHope_content()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentHope_content()">${beforeReg.getRe_hope_content()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentHope_content">${currentAnswer.getHope_content()}</textarea>

			</div>
		</div>
		<!-- 도면 첨부 -->
		<div class="area_box a8">
			<div>
				<div class="plc">
				<div class="title_cmt">
					<h3>도면첨부</h3>		
					<span>아이디어에 대한 밑그림이나 도면을 업로드 해주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>도면첨부</h3>
						</div>
						<p>모든 방법 및 비교 그리고 응용에 대한 부분은 도식화 하여 그림을 그려 놓습니다.</p>
					</div>
				</div>
					<form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                        <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
                        <input type="hidden" name="start_rid_file" value="${start_rid}">
                        <div id="inputFileDiv"></div>                    
                  	</form>
                  	<button onclick="addfile()">추가</button>
                  	<div class="tab_imgs">
	                	<c:forEach items="${imgs}" var="list" varStatus="status">
	                    	<div onclick="window.open('${list.getFile_path()}')" id="id${list.getRfid()}">
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
				<div class="title_cmt">
					<h3>도면에 대한 설명</h3>		
					<span>도면에 대한 설명을 작성해 주세요</span>
					<button class="exbtn">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>도면에 대한 설명</h3>
						</div>
						<p>
							올려주신 도면 하나 하나에 대한 모든 설명을 적어주세요.<br>
							예) 도면1-설명글, 도면2-설명글
						</p>
					</div>
				</div>
				<div class="halfframe">
					<h1>이전 작성 내용</h1>
					<textarea class="half disabled inventor before_cmt" placeholder="발명가" disabled id="BeforeCommentPicture_explain" name="picture_explain">${beforeReg.getPicture_explain()}</textarea>
				</div>
				<div class="halfframe">
					<h1>변리사 의견</h1>
					<textarea class="half disabled pl before_cmt" placeholder="이전에 작성한 의견이 없습니다." disabled id="CurrentCommentPicture_explain">${beforeReg.getRe_picture_explain()}</textarea>
				</div>
				<div class="titframe">
					<h1>변리사 의견을 참고하여 내용을 작성해 주세요.</h1>
				</div>
				<textarea class="disabled current" placeholder="Comment" disabled="disabled" style="border-top:1px solid #fff;" id="AfterCommentPicture_explain">${currentAnswer.getPicture_explain()}</textarea>
			</div>
		</div>
		
		<div class="fin">
			<button type="button" id="tmpSave">임시저장</button>
			<button type="button" id="agree">제출</button>
			<c:choose>
				<c:when test="${currentAnswer.getIscomplete()>=3}">
					<button type="button" id="gotoApply">출원</button>
				</c:when>				
			</c:choose>			
		</div>
		</article>             
    </section>
</div>       
<c:import url="/WEB-INF/views/import/footer.jsp"/>
<script src="/resources/common/js/comment_inventor.js"></script>
</body>
</html>
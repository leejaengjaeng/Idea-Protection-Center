<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script type="text/javascript"	src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript"	src="/resources/common/js/util.js"></script>
<script type="text/javascript"	src="/resources/common/js/registration.js" ></script>

<link rel="stylesheet" href="/resources/common/css/title_cmt.css" >
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/cmt.css">
<link rel="icon" 	   href="/resources/image/pavicon.png">
<title>Idea Protection Center</title>
</head>
<body onload='checkTemp("${isTemp}");'>
	
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
		<article class="nt" style="display:block;">
		<form name="regisForm" action="/registration/inputidea" method="POST" enctype="multipart/form-data" onsubmit="return formSubmit(document.regisForm.imgs);">
		
		<div class="full">
			<div class="hiding_tab" style="position: relative; width: 100%;">
				<div class="arrow-up ee"></div>
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="text" name="uid" id="uid"
				value="${sessionScope.currentUser.getUid()}" hidden>				
				<select onChange="changeType(this.value);" id="selectBox">
					<option>특허분야</option>
					<c:forEach items="${typeList}" var="type">
					<option>${type.getType()}</option>
					</c:forEach>
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
			<div class="title_cmt">
				<h3>제목</h3>
				<span>여러분의 아이디어의 이름을 적어 주세요</span>
				<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="idea_title" name="title"></textarea>
			</div>
		</div>
		<div class="area_box a1">
			<div class="title_cmt">	
					<h3>요약</h3>		
					<span>아이디어에 대한 요약을 설명해 주세요</span>	
					<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="small_cont" name="summary"></textarea>
			</div>
		</div>
		<div class="area_box a2">
			<div class="title_cmt">
					<h3>필요이유</h3>		
					<span>이 아이디어가 왜 필요한지 알려 주세요</span>
					<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="why_cont" name="whyInvent"></textarea>
			</div>
		</div>
		<div class="area_box a3">
			<div class="title_cmt">
					<h3>기존제품설명 및 문제점</h3>		
					<span>기존제품의 간단한 설명 및 문제점을 알려 주세요</span>
					<button class="exbtn" type="button">작성예시</button>s
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
			<div>
				<textarea id="col_cont" name="problem"></textarea>
			</div>
		</div>
		<div class="area_box a4">
			<div class="title_cmt">
				<h3>문제해결방법</h3>		
				<span>기존제품의 문제점을 어떻게 해결했는지를 알려주세요</span>
				<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="wel_cont" name="solution"></textarea>
			</div>
		</div>
		<div class="area_box a5">
			<div class="title_cmt">
					<h3>발명의 효과</h3>		
					<span>아이디어로 얻을 수 있는 혜택이나 효과를 알려주세요</span>
					<button class="exbtn" type="button">작성예시</button>
					<div class="example">
						<div class="extitle">
							<h3>발명의 효과</h3>
						</div>
						<p>이전기술보다 본 발명의 특별한 효과를 <br>
						비교하여 구체적으로 기재(경제적,기술적,시간적, 등등)</p>
					</div>
				</div>
			<div>
				<textarea id="bal_cont" name="effect"></textarea>
			</div>
		</div>
		<div class="area_box a6">
			<div class="title_cmt">
				<h3>핵심구성요소</h3>		
				<span>아이디어를 구성하는 기술 및 기능적 구성요소와 작동순서를 알려주세요</span>
				<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="imp_cont" name="core_element"></textarea>
			</div>
		</div>
		<div class="area_box a7">
			<div class="title_cmt">
				<h3>권리를 보장받고자 하는 내용</h3>		
				<span>아이디어를 보호받고자 하는 내용을 적어 주세요</span>
				<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="hope_content" name="hope_content"></textarea>
			</div>
		</div>
		<div class="area_box a8">
			<div class="title_cmt">
				<h3>도면첨부</h3>		
				<span>아이디어에 대한 밑그림이나 도면을 업로드 해주세요</span>
				<button class="exbtn" type="button">작성예시</button>
				<div class="example">
					<div class="extitle">
						<h3>도면첨부</h3>
					</div>
					<p>모든 방법 및 비교 그리고 응용에 대한 부분은 도식화 하여 그림을 그려 놓습니다.</p>
				</div>
			</div>
			<div style="width:96%; margin-left:2%;">
				<div id="plc">
					<div id="upimgdiv2">
						<input type="file" id="upimg1" name="imgs" accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)" style="margin-left:5px; margin-top:5px; float:left;">
					</div>
					<button type="button" onclick="addfile2()" class="addbtns">추가</button>
					<button type="button" onclick="delfile()" class="addbtns">삭제</button>
				</div>
			</div>
		</div>
		<div class="area_box a9">
			<div class="title_cmt">
				<h3>도면에 대한 설명</h3>		
				<span>도면에 대한 설명을 작성해 주세요</span>
				<button class="exbtn" type="button">작성예시</button>
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
			<div>
				<textarea id="picture_explain" name="picture_explain"></textarea>
			</div>
		</div>
		<div class="fin">
			<button type="button" onclick='tempsave()'>임시저장</button>
			<input type="submit" value="제출하기" id="submit">
		</div>
		</form>
		</article> 
	</section>	
	</div>
<c:import url="/WEB-INF/views/import/footer.jsp" />
<script src="/resources/common/js/cmts.js"></script>
</body>
</html>
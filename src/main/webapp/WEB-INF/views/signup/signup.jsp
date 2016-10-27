<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/js/jquery-3.1.0.min.js" type="text/javascript" ></script>

<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/index.css">
<title>Insert title here</title>
<script>
function changeBank(value){
	document.getElementById("bank_name").value=value;
}
	function changeEmail(emailvalue) {
		if (emailvalue == "1") {
			document.getElementById("email2").style.display = "block";
			document.signupform.email2.value = "";
		} else {
			document.getElementById("email2").style.display = "none";
			document.signupform.email2.value = emailvalue;
		}
	}
	function checkid() {

		//var id = document.getElementById("id").value;
		var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
		var csrfToken = $("meta[name='_csrf']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content"); // THIS WAS ADDED
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
			headers : headers,
			data : data,
			success : function(data) {
				//alert("성공:"+data.KEY);
				if (data.KEY == "YES") {
					//document.signupform.id.readOnly=true;
					var q = confirm(id + "는 사용할 수 있는 아이디 입니다. 사용하시겠습니까?")
					if (q == true) {
						document.signupform.id.readOnly = true;
					} else {
						document.getElementById("id").value = "";
					}
				} else {
					document.getElementById("id").value = "";
					alert("중복된 아이디 입니다.");
				}

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}

		});
	}
	function checkpwd() {
		var pwd = document.getElementById("pw").value;
		var repwd = document.getElementById("repw").value;
		if (pwd == repwd) {
			document.getElementById("checkpassword").innerHTML = "<b>비밀번호가 일치합니다</b>"
		} else {
			document.getElementById("checkpassword").innerHTML = "<b>비밀번호가 일치하지않습니다</b>"
		}
	}
	function changerole(inputvalue) {
		document.getElementById("role").value = inputvalue;
		//alert(document.getElementById("role").value);

	}
	function execute() {
		var pwd = document.getElementById("password");
		var repwd = document.getElementById("repassword");
		var id = document.getElementById("id");
		var email = document.getElementById("email1");
		if (pwd.value != repwd.value) {
			alert("비밀번호가 일치하지 않습니다.");
			pwd.value = "";
			repwd.value = "";
			pwd.focus();
			return false;
		}
		if (id.readOnly == false) {
			alert("아이디 중복확인을 해주세요");
			return false;
		}
		if (id.value == "") {
			alert("아이디를 입력하세요");
			return false;
		}
		return true;
	}
</script>
<style>
body {
	height: 100% !important;
}

.black_wall {
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	position: fixed;
	z-index: 98;
}

.popup {
	width: 1000px;
	min-height: 200px;
	background: #fff;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	-moz-transform: translate(-50%, -50%);
	-webkit-transform: translate(-50%, -50%);
	box-shadow: 0 0 30px #000;
	position: fixed;
	z-index: 99;
	border-radius: 4px;
	background: #f9f9f9;
}

.pop_header {
	width: 100%;
	float: left;
	background: #696969;
	color: white;
	padding: 10px;
	box-shadow: 0 0 5px 0 #000;
}

.pop_header>h2 {
	display: block;
	float: left;
	font-size: 1rem;
	margin: 5px;
}

.pop_header>img {
	width: 25px;
	float: right;
}

.pop_cont {
	width: 100%;
	float: left;
	text-align: left;
	padding: 25px;
	padding-top: 30px;
}

.pop_cont>span {
	color: #595959;
	font-size: 0.9;
	display: inline-block;
	width: 100%;
}

.pop_cont button {
	width: 80px;
	height: 30px;
	background: #888;
	border: none;
	box-shadow: inset 0 -4px rgba(0, 0, 0, .1);
	color: white;
}

.popup_close {
	cursor: pointer;
}

.pop_cont table {
	margin-top: 20px;
	font-size: 14px;
	border-top: 1px solid #ccc;
}

.pop_cont table td {
	height: 50px;
	border-bottom: 1px solid #ccc;
	border-collapse: collapse;
	border-top: none;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp" />
	<div id="wrap_form">		
		<div class="service_role">
			<span class="role_title" style="margin-top:50px;">이용 약관 </span>
			<div id="ContentsWrap">
				<ul class="list-unstyled">
					<li id="provision1"><h2>제 1 장 : 총 칙</h2>
						<ul>
							<li><h3>제 1조 (목적)</h3>
								<p>이 약관은 아이디어보호센터(이하 "회사"라 한다)가 홈페이지(ideapc.org)에서 제공하는 모든
									서비스(이하 "서비스"라 한다)의 이용조건 및 절차에 관한 사항을 규정함을 목적으로 합니다.</p></li>
							<li><h3>제 2조 (정의)</h3>
								<p>이 약관에서 사용하는 용어의 정의는 다음 각 호와 같습니다.</p>
								<ul>
									<li>이용자 - 본 약관에 따라 회사가 제공하는 서비스를 받는 자</li>
									<li>이용계약 - 서비스 이용과 관련하여 회사와 이용자간에 체결하는 계약</li>
									<li>가입 - 회사가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스
										이용계약을 완료시키는 행위</li>
									<li>회원 - 당 사이트에 회원가입에 필요한 개인정보를 제공하여 회원 등록을 한 자</li>
									<li>이용자번호(ID)- 회원 식별과 회원의 서비스 이용을 위하여 이용자가 선정하고 회사가 승인하는
										영문자와 숫자의 조합</li>
									<li>패스워드(PASSWORD) - 회원의 정보 보호를 위해 이용자 자신이 설정한 영문자와 숫자,
										특수문자의 조합</li>
									<li>이용해지 - 회사 또는 회원이 서비스 이용이후 그 이용계약을 종료시키는 의사표시										
									</li>
								</ul></li>
							<li><h3>제3조(약관의 효력과 변경)</h3>
								<p>
									회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터
									7일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로
									간주됩니다.<br> 이 약관의 서비스 화면에 게시하거나 공지사항 게시판 또는 기타의 방법으로 공지함으로써
									효력이 발생됩니다.<br> 회사는 필요하다고 인정되는 경우 이 약관의 내용을 변경할 수 있으며, 변경된
									약관은 서비스 화면에 공지하며, 공지후 7일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우
									약관의 변경 사항에 동의한 것으로 간주됩니다.<br> 이용자가 변경된 약관에 동의하지 않는 경우 서비스
									이용을 중단하고 본인의 회원등록을 취소할 수 있으며, 계속 사용하시는 경우에는 약관 변경에 동의한 것으로 간주되며
									변경된 약관은 전항과 같은 방법으로 효력이 발생합니다.
								</p></li>
							<li><h3>제4조(준용규정)</h3>
								<p>이 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법 및 기타 관련법령의 규정에 따릅니다</p></li>
						</ul></li>
					<li id="provision2"><h2>제2장 서비스 이용계약</h2>
						<ul>
							<li><h3>제5조(이용계약의 성립)</h3>
								<p>이용계약은 이용자의 이용신청에 대한 회사의 승낙과 이용자의 약관 내용에 대한 동의로 성립됩니다.</p></li>
							<li><h3>제6조(이용신청)</h3>
								<p>이용신청은 서비스의 회원정보 화면에서 이용자가 회사에서 요구하는 가입신청서 양식에 개인의 신상정보를
									기록하여 신청할 수 있습니다.</p></li>
							<li><h3>제7조(이용신청의 승낙)</h3>
								<ul>
									<li>회원이 신청서의 모든 사항을 정확히 기재하여 이용신청을 하였을 경우에 특별한 사정이 없는 한
										서비스 이용신청을 승낙합니다.</li>
									<li>다음 각 호에 해당하는 경우에는 이용 승낙을 하지 않을 수 있습니다.
										<ul>
											<li>본인의 실명으로 신청하지 않았을 때</li>
											<li>타인의 명의를 사용하여 신청하였을 때</li>
											<li>이용신청의 내용을 허위로 기재한 경우</li>
											<li>사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때</li>
											<li>기타 회사가 정한 이용신청 요건에 미비 되었을 때</li>
										</ul>
									</li>
								</ul></li>
							<li><h3>제8조(계약사항의 변경)</h3>
								<p>회원은 이용신청시 기재한 사항이 변경되었을 경우에는 수정하여야 하며, 수정하지 아니하여 발생하는 문제의
									책임은 회원에게 있습니다.</p></li>
						</ul></li>
					<li id="provision3"><h2>제3장 계약당사자의 의무</h2>
						<ul>
							<li><h3>제9조(회사의 의무)</h3>
								<p>회사는 서비스 제공과 관련해서 알고 있는 회원의 신상 정보를 본인의 승낙 없이 제3자에게 누설하거나
									배포하지 않습니다. 단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의
									목적이 있거나 또는 기타 관계법령에서 정한 절차에 의한 요청이 있을 경우에는 그러하지 아니합니다.</p></li>
							<li><h3>제10조(회원의 의무)</h3>
								<ol>
									<li>회원은 서비스를 이용할 때 다음 각 호의 행위를 하지 않아야 합니다.
										<ol>
											<li>다른 회원의 ID를 부정하게 사용하는 행위</li>
											<li>서비스에서 얻은 정보를 복제, 출판 또는 제3자에게 제공하는 행위</li>
											<li>회사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 행위</li>
											<li>공공질서 및 미풍양속에 위반되는 내용을 유포하는 행위</li>
											<li>범죄와 결부된다고 객관적으로 판단되는 행위</li>
											<li>기타 관계법령에 위반되는 행위</li>
										</ol>
									</li>
									<li>회원은 서비스를 이용하여 영업활동을 할 수 없으며, 영업활동에 이용하여 발생한 결과에 대하여
										회사는 책임을 지지 않습니다.</li>
									<li>회원은 서비스의 이용권한, 기타 이용계약상 지위를 타인에게 양도하거나 증여할 수 없으며, 이를
										담보로도 제공할 수 없습니다.</li>
								</ol></li>
						</ul></li>
					<li id="provision4"><h2>제4장 서비스 이용</h2>
						<ul>
							<li><h3>제11조(회원의 의무)</h3>
								<ol>
									<li>회원은 필요에 따라 자신의 메일, 게시판, 등록자료 등 유지보수에 대한 관리책임을 갖습니다.</li>
									<li>회원은 회사에서 제공하는 자료를 임의로 삭제, 변경할 수 없습니다.</li>
									<li>회원은 회사의 홈페이지에 공공질서 및 미풍양속에 위반되는 내용물이나 제3자의 저작권 등 기타권리를
										침해하는 내용물을 등록하는 행위를 하지 않아야 합니다. 만약 이와 같은 내용물을 게재하였을 때 발생하는 결과에
										대한 모든 책임은 회원에게 있습니다.</li>
								</ol></li>
							<li><h3>제12조(게시물 관리 및 삭제)</h3>
								<p>효율적인 서비스 운영을 위하여 회원의 메모리 공간, 메시지크기, 보관일수 등을 제한할 수 있으며
									등록하는 내용이 다음 각 호에 해당하는 경우에는 사전 통지없이 삭제할 수 있습니다.</p>
								<ol>
									<li>다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우</li>
									<li>공공질서 및 미풍양속에 위반되는 내용인 경우</li>
									<li>범죄적 행위에 결부된다고 인정되는 내용인 경우</li>
									<li>회사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
									<li>회원이 회사의 홈페이지와 게시판에 음란물을 게재하거나 음란 사이트를 링크하는 경우</li>
									<li>기타 관계법령에 위반된다고 판단되는 경우</li>
								</ol></li>
							<li><h3>제13조(게시물의 저작권)</h3>
								<p>게시물의 저작권은 게시자 본인에게 있으며 회원은 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등
									서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.</p></li>
							<li><h3>제14조(서비스 이용시간)</h3>
								<p>서비스의 이용은 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다.
									다만 정기 점검 등의 사유 발생시는 그러하지 않습니다.</p></li>
							<li><h3>제15조(서비스 이용 책임)</h3>
								<p>서비스를 이용하여 해킹, 음란사이트 링크, 상용S/W 불법배포 등의 행위를 하여서는 아니되며, 이를
									위반으로 인해 발생한 영업활동의 결과 및 손실, 관계기관에 의한 법적 조치 등에 관하여는 회사는 책임을 지지
									않습니다.</p></li>
							<li><h3>제16조(서비스 제공의 중지)</h3>
								<p>다음 각 호에 해당하는 경우에는 서비스 제공을 중지할 수 있습니다.</p>
								<ol>
									<li>서비스용 설비의 보수 등 공사로 인한 부득이한 경우</li>
									<li>전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우</li>
									<li>시스템 점검이 필요한 경우</li>
									<li>기타 불가항력적 사유가 있는 경우</li>
								</ol></li>
						</ul></li>
					<li id="provision5"><h2>제5장 계약해지 및 이용제한</h2>
						<ul>
							<li><h3>제17조(계약해지 및 이용제한)</h3>
								<ol>
									<li>회원이 이용계약을 해지하고자 하는 때에는 회원 본인이 인터넷을 통하여 해지신청을 하여야 하며,
										회사에서는 본인 여부를 확인 후 조치합니다.</li>
									<li>회사는 회원이 다음 각 호에 해당하는 행위를 하였을 경우 해지조치 30일전까지 그 뜻을
										이용고객에게 통지하여 의견진술할 기회를 주어야 합니다.
										<ol>
											<li>타인의 이용자ID 및 패스워드를 도용한 경우</li>
											<li>서비스 운영을 고의로 방해한 경우</li>
											<li>허위로 가입 신청을 한 경우</li>
											<li>같은 사용자가 다른 ID로 이중 등록을 한 경우</li>
											<li>공공질서 및 미풍양속에 저해되는 내용을 유포시킨 경우</li>
											<li>타인의 명예를 손상시키거나 불이익을 주는 행위를 한 경우</li>
											<li>서비스의 안정적 운영을 방해할 목적으로 다량의 정보를 전송하거나 광고성 정보를 전송하는 경우</li>
											<li>정보통신설비의 오작동이나 정보 등의 파괴를 유발시키는 컴퓨터바이러스 프로그램 등을 유포하는
												경우</li>
											<li>회사 또는 다른 회원이나 제3자의 지적재산권을 침해하는 경우</li>
											<li>타인의 개인정보, 이용자ID 및 패스워드를 부정하게 사용하는 경우</li>
											<li>회원이 자신의 홈페이지나 게시판 등에 음란물을 게재하거나 음란 사이트를 링크하는 경우</li>
											<li>기타 관련법령에 위반된다고 판단되는 경우</li>
										</ol>
									</li>
								</ol></li>
						</ul></li>
					<li id="provision6"><h2>제6장 기 타</h2>
						<ul>
							<li><h3>제18조(양도금지)</h3>
								<p>회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로
									제공할 수 없습니다.</p></li>
							<li><h3>제19조(손해배상)</h3>
								<p>회사는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동 손해가 회사의 고의
									또는 중대한 과실로 인한 손해를 제외하고 이에 대하여 책임을 부담하지 아니합니다.</p></li>
							<li><h3>제20조(면책 조항)</h3>
								<ol>
									<li>회사는 천재지변, 전쟁 또는 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는
										경우에는 서비스 제공에 관한 책임이 면제됩니다.</li>
									<li>회사는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한
										책임이 면제됩니다.</li>
									<li>회사는 회원의 귀책사유로 인한 서비스이용의 장애에 대하여 책임을 지지 않습니다.</li>
									<li>회사는 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통하여 얻는 자료로 인한 손해에 관하여
										책임을 지지 않습니다.</li>
									<li>회사는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을
										지지 않습니다.</li>
								</ol></li>
							<li><h3>제21조(관할법원)</h3>
								<p>서비스 이용으로 발생한 분쟁에 대해 소송이 제기 될 경우 회사의 소재지를 관할하는 법원을 전속
									관할법원으로 합니다.</p></li>
						</ul></li>
					<li id="provision7"><h2>부칙</h2>
						<p>(시행일) 이 약관은 2014년 3월 15일부터 시행합니다.</p></li>
				</ul>
			</div>
			<span style="float: left; margin-top: 20px;" class="role_title">개인정보
				보호방침</span>
			<div id="ContentsWrap" style="clear:both;">
				<p>
					'<strong>아이디어보호센터</strong>' 회사(이하 회사 이라 함)은 귀하의 개인정보보호를 매우 중요시하며,
					『개인정보보호법』을 준수하고 있습니다.<br>회사은 개인정보처리방침을 통하여 귀하께서 제공하시는 개인정보가
					어떠한 용도와 방식으로 이용되고 있으며, <br>개인정보보호를 위해 떠한 조치가 취해지고 있는지 알려드립니다.
				</p>
				<br>
				<p>이 개인정보처리방침의 순서는 다음과 같습니다.</p>
				<ol>
					<li id="private1"><h2>수집하는 개인정보의 항목</h2>
						<p>회원가입 시 필수항목과 선택항목이 있으며, 메일수신여부 등과 같은 선택항목은 동의하지 않으시더라도, 서비스
							이용에는 제한이 없습니다.</p>
						<h4>[홈페이지 개인정보 수집항목]</h4>
						<dl class="dl-horizontal">
							<dt>필수 항목</dt>
							<dt></dt>
							<dd>로그인 아이디, 이메일, 비밀번호</dd>
							<dt>선택 항목</dt>
							<dt></dt>
							<dd>이름, 닉네임, 연락처(유선전화번호 또는 휴대폰 번호)</dd>
							<dd>메일링서비스 수신여부, SMS 서비스 수신여부</dd>
							<dd>서비스 이용 과정이나 서비스 제공 업무 처리 과정에서 다음 정보들이 자동으로 생성되어 수집될 수
								있습니다.</dd>
							<dd></dd>
							<dd>서비스 이용기록, 접속 로그, 쿠키, 접속 IP정보</dd>
						</dl>
						<h4>[개인정보 수집방법]</h4>
						<ol>
							<dd>다음과 같은 방법으로 개인정보를 수집합니다.: 홈페이지 회원가입, 홈페이지 게시판</dd>
						</ol></li>
					<li id="private2"><h2>개인정보의 수집 및 이용목적</h2>
						<p>
							회사은 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br> 이용자가 제공한 모든 정보는 하기 목적에
							필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 사전 동의를 구할 것입니다.
						</p>
						<dl class="dl-horizontal">
							<dt rel="tooltip" title=""
								data-original-title="이름 연락처, 이메일, 로그인 아이디ㆍ비밀번호">이름 연락처,
								이메일, 로그인 아이디ㆍ비밀번호</dt>
							<dd>서비스 이용에 따른 회원가입 및 본인 식별에 이용, 게시판 내 게시글 등록 및 확인(수정,삭제),
								예약&amp;예약조회 및 회원제 서비스 제공</dd>
							<dt rel="tooltip" title=""
								data-original-title="이메일(메일링), SMS 서비스 수신 여부">이메일(메일링), SMS
								서비스 수신 여부</dt>
							<dd>소식 및 고지사항 전달, 불만처리 등을 위한 원활한 의사소통 경로의 확보, 상담 답변 및 예약
								확인(취소) 안내, 의학정보 및 이벤트 정보 등의 안내, 정기 소식지 발송</dd>
						</dl></li>
					<li id="private3"><h2>개인정보의 보유 및 이용기간</h2>
						<p>회사은 개인정보의 수집목적 또는 제공받은 목적이 달성된 때에는 귀하의 개인정보를 지체 없이 파기합니다.</p>
						<p>다만, 수집목적 또는 제공받은 목적이 달성된 경우에도 상법 등 법령의 규정에 의하여 보존할 필요성이 있는
							경우에는 귀한의 개인정보를 보유할 수 있습니다.</p>
						<dl class="dl-horizontal">
							<dt rel="tooltip" title=""
								data-original-title="소비자의 불만 또는 분쟁처리에 관한 기록">소비자의 불만 또는
								분쟁처리에 관한 기록</dt>
							<dd>3년 (전자상거래 등에서의 소비자보호에 관한 법률)</dd>
							<dt rel="tooltip" title=""
								data-original-title="신용정보의 수집/처리 및 이용 등에 관한 기록">신용정보의 수집/처리
								및 이용 등에 관한 기록</dt>
							<dd>3년 (신용정보의 이용 및 보호에 관한 법률)</dd>
							<dt>본인 확인에 관한 기록</dt>
							<dd>6개월 (정보통신망 이용촉진 및 정보보호 등에 관한 법률)</dd>
							<dt>방문에 관한 기록</dt>
							<dd>3개월 (통신비밀보호법)</dd>
						</dl></li>
					<li id="private4"><h2>개인정보의 파기 절차 및 방법</h2>
						<p>회사은 『개인정보의 수집 및 이용목적』이 달성된 후에는 개인 정보를 즉시 파기합니다. 파기절차 및 방법은
							다음과 같습니다.</p>
						<dl class="dl-horizontal">
							<dt>파기절차</dt>
							<dd>이용자가 회원가입 등을 위해 입력한 정보는 목적이 달성된 후 파기방법에 의하여 즉시 파기합니다.</dd>
							<dt>파기방법</dt>
							<dd>전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</dd>
							<dd>종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.</dd>
						</dl></li>
					<li id="private5"><h2>개인정보 제3제공 및 공유</h2>
						<p>
							회사은 귀하의 동의가 있거나 관련법령의 규정에 의한 경우를 제외하고는 어떠한 경우에도 『개인정보의 수집 및
							용목적』에서 고지한 범위를 넘어 귀하의 개인정보를 이용하거나, 타인 또는 타기업ㆍ기관에 제공하지 않습니다.<br>
							다만, 고객의 동의가 있거나 다음과 같은 사례에 해당하는 경우에는 예외로 합니다.
						</p>
						<ul>
							<li>통계작성ㆍ학술연구를 위하여 필요한 경우 특정 개인을 알아볼 수 없는 형태로 가공하여 제공</li>
							<li>법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우 제공</li>
						</ul></li>
					<li id="private6"><h2>수집한 개인정보의 취급위탁</h2>
						<p>회사은 서비스 이행을 위해 아래와 같이 개인정보를 위탁하고 있으며, 관계 법령에 따라 위탁계약 시
							개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.</p>
						<p>회사의 개인정보 위탁처리 기관 및 위탁업무 내용은 아래와 같습니다.</p>
						<dl class="dl-horizontal">
							<dt>수탁기관</dt>
							<dt></dt>
							<dd>
								<a href="javascript:void(0);"
									onclick="window.open('http://thelupe.co.kr/', '_blank');">(주)The
									Lupe</a>
							</dd>
							<dt>위탁업무 내용</dt>
							<dd>회원관리, 수집된 개인정보 관리 및 본인 확인, 불만처리 등 민원처리, 고지사항 전달, 마케팅 신규
								서비스(제품) 개발 및 특화, 이벤트 등 광고성 정보 전달, 기타 AS 센터, 웹사이트 제작,운영 및 시스템 관리,
								소식지(의학정보 제공) 정기 발송</dd>
							<dt>위탁 개인정보 항목</dt>
							<dd>이름, 생년월일, 성별, 로그인 아이디, 비밀번호, 연락처(유선전화번호 또는 휴대폰 번호), 이메일,
								주소</dd>
							<dd>위탁 대상자는 상업적인 목적이 아닌 국민건강 증진을 위해 발송하는 소식지를 회원에게 이메일을 통해
								발송할 수 있습니다. 물론 이 경우에도 회원가입 시 동의 절차를 거치게 되며, 회원님께서 동의하지 않는 경우에는
								발송하지 않습니다.</dd>
							<dt rel="tooltip" title="" data-original-title="개인정보 보유 및 이용기간">개인정보
								보유 및 이용기간</dt>
							<dd>위탁 계약 종료시까지</dd>
							<p></p>
						</dl></li>
					<li id="private7"><h2>동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익
							내용</h2>
						<p>
							귀하는 홈페이지에서 개인정보 수집에 대한 동의를 거부할 권리가 있습니다.<br> 그러나 동의를 거부할 경우
							회원가입이 진행되지 않으며, 특정 게시판(또는 특정 페이지)에 접근 제한이 있을 수 있습니다. 이는 특정 게시판(또는
							특정 페이지)으로의 접근에만 제한이 있을 뿐이며 홈페이지 이용에는 제한이 없습니다
						</p></li>
					<li id="private8"><h2>회원탈퇴 방법</h2>
						<p>귀하는 회원가입 시 개인정보의 수집ㆍ이용 및 제공에 대해 동의하신 내용을 언제든지 철회하실 수 있습니다.
							회원탈퇴는 회사 홈페이지에서 로그인하신 후, member info 페이지에서 『회원탈퇴』를 클릭하여 본인 확인 절차를
							거치신 후 직접 회원탈퇴를 하시거나, 개인정보보호책임자에게 서면, 전화 또는 이메일 등으로 연락하시면 지체 없이
							귀하의 개인정보를 파기하는 등 필요한 조치를 하겠습니다.</p></li>
					<li id="private9"><h2>개인정보 자동 수집 장치의 설치/운영 및 그 거부에 관한 사항</h2>
						<p>회사은 귀하의 정보를 수시로 저장하고 찾아내는 '쿠키(cookie)'를 운용합니다. 쿠키란 회사의
							웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에
							저장됩니다. 회사은 다음과 같은 목적을 위해 쿠키를 사용합니다.</p>
						<p class="text-info">귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹
							브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의
							저장을 거부할 수도 있습니다.</p> <strong class="text-danger">회원님께서 쿠키
							설치를 거부하셨을 경우 일부 서비스 제공에 어려움이 있습니다.</strong></li>
					<li id="private10"><h2>개인정보보호책임자</h2>
						<p>귀하의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 회사은 아래와 같이 개인정보보호책임자를
							두고 있습니다.</p>
						<p></p>
						<h3>[개인정보보호 책임자]</h3>
						<dl class="dl-horizontal">
							<dt>이름</dt>
							<dd>&nbsp;한걸음</dd>
							<dt>소속</dt>
							<dd>&nbsp;두걸음</dd>
							<dt>전화번호</dt>
							<dd>&nbsp;</dd>
							<dt>이메일</dt>
							<dd>&nbsp;</dd>
						</dl>
						<p>귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보보호책임자로 신고하실
							수 있습니다. 회사은 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다. 기타 개인정보침해에 대한
							신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.</p>
						<ol>
							<li>개인분쟁조정위원회 (<a href="javascript:void(0);"
								onclick="window.open('http://www.1336.or.kr', '_blank');">http://www.1336.or.kr</a>
								/ <a href="tel:1336">1336</a>)
							</li>
							<li>개인정보침해신고센터 (<a href="javascript:void(0);"
								onclick="window.open('http://118.or.kr', '_blank');">http://118.or.kr</a>
								/ <a href="tel:118">118</a>)
							</li>
							<li>정보보호마크인증위원회 (<a href="javascript:void(0);"
								onclick="window.open('http://eprivacy.or.kr', '_blank');">http://eprivacy.or.kr</a>
								/ <a href="tel:02-580-0533">02-580-0533</a>~4)
							</li>
							<li>대검찰청 사이버범죄수사단 (<a href="javascript:void(0);"
								onclick="window.open('http://spo.go.kr', '_blank');">http://spo.go.kr</a>
								/ <a href="tel:02-3480-2000">02-3480-2000</a>)
							</li>
							<li>경찰청 사이버테러대응센터 (<a href="javascript:void(0);"
								onclick="window.open('http://ctrc.go.kr', '_blank');">http://ctrc.go.kr</a>
								/ <a href="02-392-0330">02-392-0330</a>)
							</li>
						</ol></li>
					<li id="private11"><h2>개인정보의 안전성 확보조치</h2>
						<p>회사은 회원님의 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 개인정보 보호를 위하여 다음과
							같은 기술적, 관리적 대책을 강구하고 있습니다.</p>
						<ul>
							<li>기술적 대책
								<ul>
									<li>개인정보는 비밀번호에 의해 보호됩니다.</li>
									<li class="hidden">네트워크상에서 개인정보를 안전하게 전송할 수 있도록 SSL 등
										암호알고리즘을 이용한 보안조치를 마련하고 있으며, 회원가입 시 수집하는 주민등록번호는 암호화하여 보호되고
										있습니다.</li>
									<li class="hidden">백신프로그램을 이용하여 서버 바이러스에 의한 피해를 사전에 방지하고
										있습니다. 백신프로그램은 주기적으로 업데이트되며, 바이러스에 걸린 경우 백신이 나오는 즉시 이를 치료함으로써
										개인정보가 침해되는 것을 방지하고 있습니다.</li>
									<li class="hidden">웹방화벽(국가정보원 CC인증 (EAL4 등급),
										한국정보통신기술협회(TTA) GS 인증, 국가정보원 검증필 암호모듈 탑재)을 구축하여 해킹 등에 의해 귀하의
										개인정보가 유출되는 것을 방지하고, 외부로부터의 침입을 차단하며, 24시간 침입을 감시하고 있습니다.</li>
									<li><a href="javascript:void(0);"
										onclick="window.open('http://help.cafe24.com/cs/cs_faq_view.php?idx=1181&amp;page=2&amp;mode=&amp;s_key=&amp;s_period=&amp;s_value=&amp;faq_list=35&amp;categoryIdx=0&amp;select_os=&amp;contentNum=1', '_blank');"><strong>안전한
												홈페이지 운영을 위한 PC보안 관리 캠페인</strong></a></li>
								</ul>
							</li>
							<li>관리적 대책
								<ul>
									<li>개인정보의 위탁 관리
										<p>개인정보를 누설 또는 권한없이 처리하거나 제 3자에게 제공하는 등 부당한 목적을 위하여 사용하지
											않도록 위탁 대상자(㈜엠서클)에 대한 감독과 관리를 실시하고 있습니다.</p>
									</li>
									<li>회사은 회원의 개인정보를 취급할 수 있는 자를 최소한으로 제한하고 접근 권한을 관리하며, 교육을
										통하여 법규 및 정책을 준수합니다. 회원 개인정보를 취급하는 자는 다음과 같습니다.
										<p>회원을 직.간접적으로 상대하여 업무를 처리하는 자</p>
									</li>
								</ul>
							</li>
						</ul></li>
					<li id="private12"><h2>정책 변경에 따른 공지의무</h2>
						<p>이 개인정보취급방침은 2014년 3월 15일에 제정되었으며 법령ㆍ정책 또는 보안기술의 변경에 따라 내용의
							추가ㆍ삭제 및 수정이 있을 시에는 변경되는 개인정보취급방침을 시행하기 전에 회사 홈페이지를 통해 변경이유 및 내용
							등을 공지하도록 하겠습니다.</p></li>
				</ol>
			</div>
			<span class="role_title" style="float:left; margin-top:20px;">이메일 수집거부</span>
			<div id="ContentsWrap">
				<p>본 사이트에 게시된 이메일 주소가 전자우편 수집 프로그램이나 그밖의 기술적 장치를 이용하여 무단으로 수집되는<br>
					것을 거부하며, 이를 위반시 정보통신망법에 의해 형사처벌됨을 유념하시기 바립니다.</p>
					<br>
					<br>
				<ol>
					<li>정보통신망법 제 40조 2 (전자우편주소의 무단 수집행위 등 금지)
						<ol>
							<li>누구든지 전자우편 주소의 수집을 거부하는 의사가 명시된 인터넷 홈페이지에서 자동으로 전자우편주소를
								수집하는 프로그램 그밖의 기술적 장치를 이용하여 전자우편 주소를 수집하여서는 아니된다.</li>
							<li>누구든지 제1항의 규정을 위반하여 수집된 전자우편주소를 판매 유통하여서는 아니된다.</li>
							<li>누구든지 제1항 및 제2항의 규정에 의하여 수집 판매 및 유통이 금지된 전자우편 주소임을 알고 이를
								정보전송에 이용하여서는 아니된다.</li>
						</ol>
					</li>
				</ol>
			</div>
		</div>
		<div class="check_box">
			<div>
				<span><b style="color:#f00;">[필수]</b> 이용약관에 동의합니다.</span>
				<input type="checkbox" style="float:right;" name="box">
			</div>
			<div>
				<span><b style="color:#f00;">[필수]</b>  개인정보 수집 및 이용에 대한 안내에 동의합니다.</span>
				<input type="checkbox" style="float:right;" name="box">
			</div>
			<div>
				<span><b style="color:#f00;">[필수]</b>  이메일 수집 거부에 대한 안내에 동의합니다.</span>
				<input type="checkbox" style="float:right;" name="box">
			</div>
			<div style="border-top:1px solid #ccc; padding-top:10px; margin-top:30px;">
				<span>위 모든 내용에 동의합니다.</span>
				<input type="checkbox" style="float:right;" id="all_check">
			</div>
		</div>
		<h1>회원가입</h1>

		<form action="/signup/inputsignup" method="POST" name="signupform"
			onsubmit="return execute();" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<button type="button" class="hill on" data-no="0"
				onclick='changerole("1")'>발명자 회원</button>
			<button type="button" class="hill" data-no="1"
				onclick='changerole("2")'>변리사</button>
			<input type="text" id="role" name="role" value="1" hidden>
			<table>
				<tr>
					<td colspan="2" style="text-align: center; padding-left: 0;"
						class="join_img_td">
						<div>
							<img src="/resources/image/inventor_profile.jpg" alt="img"
								id="blah"><br> <input type="file" id="imgInp"
								name="profileImg" style="cursor: pointer;"> <span>대표사진을
								설정 해주세요</span>
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:30%;">아이디</td>
					<td style="width:70%;"><input type="text" name="id" id="id">
						<button type="button" onclick="checkid()" required>중복확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" id="pw">
						<div id="checkpassword" required></div></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="repw" onKeyUp='checkpwd()'
						required></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input name="name" id="name" required></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email1" id="email1"
						pattern="[A-Za-z0-9_]+" required style="float: left;"> <select
						name="emailMiddle" onChange=changeEmail(this.value);
						id="email_chg" style="float: left;">
							<option value="" selected>이메일선택</option>
							<option value="@naver.com">@ naver.com</option>
							<option value="@hanmail.com">@ hanmail.com</option>
							<option value="@daum.net">@ daum.net</option>
							<option value="@nate.com">@ nate.com</option>
							<option value="@gmail.com">@ gmail.com</option>
							<option value="@hotmail.com">@ hotmail.com</option>
							<option value="@dreamwiz.com">@ dreamwiz.com</option>
							<option value="@korea.com">@ korea.com</option>
							<option value="1">직접입력</option>
					</select> <input type="text" name="email2" id="email2"
						style="display: none; float: left;" required>
						<div
							style="width: 100%; float: left; font-size: 12px; margin-top: 5px;">
							<span style="display: inline-block; float: left;">이메일은
								회원가입 인증을 위한 정보입니다.</span>
						</div></td>
				</tr>
				<tr class="hide">
					<td>변리사 번호</td>
					<td><input type="text" name="license_number"
						id="license_number"></td>
				</tr>
				<tr class="hide">
					<td>전문분야</td>
					<td>
						<ul>
							<c:forEach items="${typeList}" var="list" varStatus="status">
								<li><input type="checkbox" name="major" value="${list.getType()}">${list.getType()}</li>
							</c:forEach>
							<!-- 
							<li><input type="checkbox" name="major" value="전자상거래">전자상거래</li>
							<li><input type="checkbox" name="major" value="플랫폼서비스">플랫폼서비스</li>
							<li><input type="checkbox" name="major" value="헬스케어">헬스케어</li>
							<li><input type="checkbox" name="major" value="iot(사물인터넷)">iot(사물인터넷)</li>
							<li><input type="checkbox" name="major" value="전자/전기">전자/전기</li>
							<li><input type="checkbox" name="major" value="생명공학/의료">생명공학/의료</li>
							<li><input type="checkbox" name="major" value="정보통신">정보통신</li>
							<li><input type="checkbox" name="major" value="기계/금속">기계/금속</li>
							<li><input type="checkbox" name="major" value="화학/바이오">화학/바이오</li>
							<li><input type="checkbox" name="major" value="디자인(제품)">디자인(제품)</li>
							<li><input type="checkbox" name="major" value="아이디어상품">아이디어상품  </li>							
							 -->
						</ul>
					</td>
				</tr>
				<tr class="hide">
					<td>변리사 등록증 사본</td>
					<td><input type="file" name="license_scan_img"
						id="license_scan_img"></td>
				</tr>
				<tr class="hide">
					<td>경력기술(간단한 소개)</td>
					<td><textarea name="introduce"
						id="introduce"></textarea></td>
				</tr>
				<tr class="hide">
					<td>계좌번호</td>
					<c:forEach items="${qnaList}" var="list" varStatus="status">
						<tr onclick="location.href='/qna/detail/${list.getQid()}'">
    						<td>${status.count }</td>
    						<td>${list.getTitle()}</td>
    						<td>${list.getId()}</td>
    						<td>${list.getDate()}</td>
    					</tr>
					</c:forEach>
					<td>
					<select name="bank" id="bank" onChange=changeBank(this.value); style="float: left;">
						<option value="" selected>은행 선택 </option>
						<option value="국민은행">국민은행</option>
						<option value="우리은행">우리은행</option>
						<option value="신한은행">신한은행</option>
						<option value="하나은행">하나은행</option>
						<option value="외환은행">외환은행</option>
						<option value="SC제일은행">SC제일은행</option>
						<option value="한국씨티은행">한국씨티은행</option>
						<option value="부산은행">부산은행</option>
						<option value="대구은행">대구은행</option>
						<option value="경남은행">경남은행</option>
						<option value="광주은행">광주은행</option>
						<option value="전북은행">전북은행</option>
						<option value="제주은행">제주은행</option>
						<option value="농협은행">농협은행</option>
						<option value="기업은행">기업은행</option>
						<option value="산업은행">산업은행</option>
						<option value="수출입은행">수출입은행</option>
						<option value="수협은행">수협은행</option>
					</select>
					<input type="hidden" name="bank_name" id="bank_name">
					<input type="text" name="account_number" id="account_number" placeholder="계좌번호"></td>
				</tr>
				
			</table>
			<!-- <input type="submit" value="가입" id="submit"> -->
			<input type="submit" value="가입" id="submit">
		</form>
	</div>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
		$(".hill").click(function() {
			$(this).addClass("on");
			$(this).siblings().removeClass("on");

			if ($(this).data('no') == 1) {
				$(".hide").css("display", "table-row");
			} else {
				$(".hide").css("display", "none");
			}

		});
		$("#repw").keyup(function() {
			if ($(this).val() == "") {
				$("#checkpassword").css("display", "none");
			} else {
				$("#checkpassword").css("display", "block");
			}
		});
		$("#email_chg").change(function() {
			if ($(this).val() == 1) {
				$("#email2").css("display", "block");
			} else {
				$("#email2").css("display", "none");
			}
		});

		$(function() {
			$(".hide").hide();
			$("#imgInp").on('change', function() {
				readURL(this);
			});
		});

		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}
		$(".popup_close").click(function() {
			$(".black_wall").css("display", "none");
			$(".popup").css("display", "none");
			$("body").css("overflow", "auto");
		});
		$("#all_check").click(function(){
			if($('#all_check:checked').length <= 0){
				$("input[name=box]:checkbox").each(function(){				
					$(this).attr("checked",false)
				});
			}else{
				$("input[name=box]:checkbox").each(function(){					
					$(this).attr("checked",true)
				});	
			}
		});
	</script>
</body>
</html>
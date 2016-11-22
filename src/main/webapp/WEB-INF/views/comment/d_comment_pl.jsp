<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<script src="/resources/common/js/design_comment.js"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/design.css">
<link rel="icon" href="/resources/image/pavicon.png">
<title>디자인권 수정내역</title>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp" />
	<form action="/registration/designInput" method="POST"
		enctype="multipart/form-data" onsubmit="return checkDesign();">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<input type="hidden" name="uid" value="nowDv.getUid()"><input type="hidden" name="luid" value="nowDv.getLuid()">
		<div class="wrap_comment">
			<section> <article class="sub_head">
			<h1>
				<b style="color: rgba(1, 102, 156, 1);">디자인권</b>수정
			</h1>
			</article> <article>
			<div class="txt_box">
				<h2>디자인 명칭*</h2>
				<button>작성예시 보기</button>
				<input type="text" id="title" name="title"
					value="${nowDv.getTitle()}"
					class="disabled"
					disabled
					placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품">		
				<textarea class="cmt_de" name="re_title"></textarea>
			</div>
			<div class="txt_box">
				<h2>디자인이 적용된 곳*</h2>
				<button>작성예시 보기</button>
				<input type="text" id="whereapply" name="whereapply"
					value="${nowDv.getWhereapply()}"
					class="disabled"
					disabled
					placeholder="본인이 창작한 디자인이 사용되는 품목을 넣어 주시면 됩니다. 예)모니터받침, 모니터 보드">
				<textarea class="cmt_de" name="re_whereapply"></textarea>
			</div>
			<div class="txt_box" style="margin-top: 100px;">
				<h2>디자인의 의미*</h2>
				<button>작성예시 보기</button>
				<textarea id="mean" class="disabled" name="re_mean" disabled>${nowDv.getMean()}</textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 102, 203, 1);">본인이 창작한 디자인의
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
				<textarea class="cmt_de" name="mean" ></textarea>
			</div>
			<div class="txt_box">
				<h2>디자인 시안 첨부*</h2>
				<ol>
					<li id="ex1">사시도</li>
					<li id="ex2">정면도</li>
					<li id="ex3">배면도</li>
					<li id="ex4">좌측면도</li>
					<li id="ex5">우측면도</li>
					<li id="ex6">평면도</li>
					<li id="ex7">저면도</li>
				</ol>
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
			<div class="tot">
				<div class="txt_box" id="exe1">
					<span>사시도</span>
					<div class="eximg" style="padding: 10px;">
						<div
							style="background-image: url(${nowDv.getSasi()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah1"> -->
					<textarea class="cmt_img" name="re_sasi"> </textarea>
				</div>
				<div class="txt_box" id="exe2">
					<span>정면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getFront()});"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah2"> -->
					<textarea class="cmt_img" name="re_front"> </textarea>
				</div>
				<div class="txt_box" id="exe3">
					<span>배면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getBae()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah3"> -->
					<textarea class="cmt_img" name="re_bae"> </textarea>
				</div>
				<div class="txt_box" id="exe4">
					<span>좌측면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getLeft_side()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah4"> -->
					<textarea class="cmt_img" name="re_leftside"> </textarea>
				</div>
				<div class="txt_box" id="exe5">
					<span>우측면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getRight_side()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah5"> -->
					<textarea class="cmt_img" name="re_rightside"> </textarea>
				</div>
				<div class="txt_box" id="exe6">
					<span>평면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getPlane()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah6"> -->
					<textarea class="cmt_img" name="re_plane"> </textarea>
				</div>
				<div class="txt_box" id="exe7">
					<span>저면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getInside()}); "></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah7"> -->
					<textarea class="cmt_img" name="re_inside"> </textarea>
				</div>
			</div>
			<!-- <div class="txt_box">
				<table>
					<tr>
						<td>사시도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="sasi" id="sasi"></td>
						<td style="padding-left: 10px;"><label for="sasi">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="1" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>정면도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="front" id="front"></td>
						<td style="padding-left: 10px;"><label for="front">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="2" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>배면도*</td>
						<td style="padding-left: 15px;"><input type="file" name="bae"
							id="bae"></td>
						<td style="padding-left: 10px;"><label for="bae">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="3" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>좌측면도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="left_side" id="left_side"></td>
						<td style="padding-left: 10px;"><label for="left_side">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="4" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>우측면도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="right_side" id="right_side"></td>
						<td style="padding-left: 10px;"><label for="right_side">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="5" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>평면도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="plane" id="plane"></td>
						<td style="padding-left: 10px;"><label for="plane">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="6" type="button">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td>저면도*</td>
						<td style="padding-left: 15px;"><input type="file"
							name="inside" id="inside"></td>
						<td style="padding-left: 10px;"><label for="inside">첨부하기</label>
						</td>
						<td>
							<button class="btn_del" data-no="7" type="button">삭제하기</button>
						</td>
					</tr>
				</table>
			</div> -->
			<div id="fin">
				<button>임시저장</button>
				<input type="submit" value="등록하기" class="add_design">
			</div>
			</article> </section>
		</div>
	</form>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
		$("#ex1").click(function() {
			$("#exe1").css("display", "block");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "none");
		});
		$("#ex2").click(function() {
			$("#exe1").css("display", "none");
			$("#exe2").css("display", "block");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "none");
		});
		$("#ex3").click(function() {
			$("#exe1").css("display", "none");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "block");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "none");
		});
		$("#ex4").click(function() {

			$("#exe1").css("display", "none");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "block");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "none");

		});
		$("#ex5").click(function() {

			$("#exe1").css("display", "none");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "block");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "none");

		});
		$("#ex6").click(function() {

			$("#exe1").css("display", "none");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "block");
			$("#exe7").css("display", "none");

		});
		$("#ex7").click(function() {

			$("#exe1").css("display", "none");
			$("#exe2").css("display", "none");
			$("#exe3").css("display", "none");
			$("#exe4").css("display", "none");
			$("#exe5").css("display", "none");
			$("#exe6").css("display", "none");
			$("#exe7").css("display", "block");

		});
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah1').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#sasi").on('change', function() {
				readURL(this);
			});
		});

		function readURL2(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah2').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#front").on('change', function() {
				readURL2(this);
			});
		});

		function readURL3(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah3').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#bae").on('change', function() {
				readURL3(this);
			});
		});

		function readURL4(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah4').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#left_side").on('change', function() {
				readURL4(this);
			});
		});

		function readURL5(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah5').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#right_side").on('change', function() {
				readURL5(this);
			});
		});

		function readURL6(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah6').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#plane").on('change', function() {
				readURL6(this);
			});
		});

		function readURL7(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah7').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(function() {
			$("#inside").on('change', function() {
				readURL7(this);
			});
		});
		$(".btn_del").click(function() {
			if ($(this).data("no") == 1) {
				$("#sasi").val('');
				$("#blah1").attr('src', '/resources/image/check.png');
			} else if ($(this).data("no") == 2) {
				$("#front").val('');
				$("#blah2").attr('src', '/resources/image/check.png');

			} else if ($(this).data("no") == 3) {
				$("#bae").val('');
				$("#blah3").attr('src', '/resources/image/check.png');

			} else if ($(this).data("no") == 4) {
				$("#left_side").val('');
				$("#blah4").attr('src', '/resources/image/check.png');

			} else if ($(this).data("no") == 5) {
				$("#right_side").val('');
				$("#blah5").attr('src', '/resources/image/check.png');

			} else if ($(this).data("no") == 6) {
				$("#plane").val('');
				$("#blah6").attr('src', '/resources/image/check.png');

			} else if ($(this).data("no") == 7) {
				$("#inside").val('');
				$("#blah7").attr('src', '/resources/image/check.png');

			}
		});
		function checkDesign() {
			var title = document.getElementById("title");
			var whereapply = document.getElementById("whereapply");
			var mean = document.getElementById("mean");
			var sasi = document.getElementById("sasi");
			var front = document.getElementById("front");
			var bae = document.getElementById("bae");
			var left_side = document.getElementById("left_side");
			var right_side = document.getElementById("right_side");
			var plane = document.getElementById("plane");
			var inside = document.getElementById("inside");

			if (title.value == "") {
				alert("제목을 입력하세요");
				title.focus();
				return false;
			} else if (whereapply.value == "") {
				alert("디자인이 적용된 곳을 입력하세요");
				whereapply.focus();
				return false;
			} else if (mean.value == "") {
				alert("디자인이 적용된 곳을 입력하세요");
				mean.focus();
				return false;
			} else if (sasi.value == "") {
				alert("사시도를 첨부해 주세요");
				sasi.focus();
				return false;
			} else if (front.value == "") {
				alert("정면도를 첨부해 주세요");
				front.focus();
				return false;
			} else if (bae.value == "") {
				alert("배면도를 첨부해 주세요");
				bae.focus();
				return false;
			} else if (left_side.value == "") {
				alert("좌측면도를 첨부해 주세요");
				left_side.focus();
				return false;
			} else if (right_side.value == "") {
				alert("우측면도를 첨부해 주세요");
				right_side.focus();
				return false;
			} else if (plane.value == "") {
				alert("평면도를 첨부해 주세요");
				plane.focus();
				return false;
			} else if (inside.value == "") {
				alert("저면도를 첨부해 주세요");
				inside.focus();
				return false;
			}
		}
	</script>
</body>
</html>
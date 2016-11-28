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
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/design_comment.js"></script>

<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/design.css">
<link rel="icon" href="/resources/image/pavicon.png">
<title>디자인권 출원</title>
</head>
<body>
	<c:import url="/WEB-INF/views/import/header.jsp" />
	<c:forEach var="j" begin="1" end="${count}" step="1">
		<button class="loadBtn" data-num="${j}">${j}차 수정안</button><br/>
	</c:forEach>
	<form action="/design/inputEditDesign" method="POST"
		enctype="multipart/form-data" onsubmit="return checkDesign();">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<input type="hidden" name="uid" value="${nowDv.getUid()}"><input type="hidden" name="luid" id="luid" value="${nowDv.getLuid()}"><input type="hidden" id="deid" name="deid" value="${nowDv.getDeid()}">
		
		<div class="wrap_comment">
			<section> <article class="sub_head">
			<h1>
				<b style="color: rgba(1, 102, 156, 1);">디자인권</b>출원
			</h1>
			</article> <article>
			<div class="txt_box">
				<h2>디자인 명칭*</h2>
				<button>작성예시 보기</button>
				<input type="text" id="before_title" name="before_title"
					value="${nowDv.getTitle()}" class="disabled" disabled
					placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품">
				<textarea class="cmt_de disabled" id="before_re_title" disabled>${nowDv.getRe_title()}</textarea>
				<input type="text" id="title" name="title" class="disabled" disabled>
			</div>
			<div class="txt_box">
				<h2>디자인이 적용된 곳*</h2>
				<button>작성예시 보기</button>
				<input type="text" id="before_whereapply" name="before_whereapply"
					value="${nowDv.getWhereapply()}" class="disabled" disabled
					placeholder="본인이 창작한 디자인이 사용되는 품목을 넣어 주시면 됩니다. 예)모니터받침, 모니터 보드">
				<textarea class="cmt_de disabled" id="before_re_whereapply" disabled>${nowDv.getRe_whereapply()}</textarea>
				<input type="text" id="whereapply" name="whereapply" class="disabled" disabled>
			</div>
			<div class="txt_box" style="margin-top: 100px;">
				<h2>디자인의 의미*</h2>
				<button>작성예시 보기</button>
				
				<textarea name="before_mean" id="before_mean" disabled class="disabled">${nowDv.getMean()}</textarea>
				<textarea class="cmt_de disabled"  id="before_re_mean"  disabled>${nowDv.getRe_mean()}</textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 102, 203, 1)">본인이
					창작한 디자인의 의미를 적어 주시기 바랍니다.</span>
				<textarea class="cmt_de disabled" disabled id="mean" name="mean"></textarea>
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
					<div class="eximg">
						<div style="background-image: url(${nowDv.getSasi()});"  id="before_sasi"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah1"> -->
					<textarea class="cmt_img disabled" disabled id="before_re_sasi">${nowDv.getRe_sasi()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_sasi"></div>
					</div>
				</div>
				<div class="txt_box" id="exe2">
					<span>정면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getFront()}); "  id="before_front" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah2"> -->
					<textarea class="cmt_img disabled"disabled id="before_re_front">${nowDv.getRe_front()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_front"></div>
					</div>
				</div>
				<div class="txt_box" id="exe3">
					<span>배면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getBae()}); "  id="before_bae" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah3"> -->
					<textarea class="cmt_img disabled"disabled  id="before_re_bae">${nowDv.getRe_bae() }</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_bae"></div>
					</div>
				</div>
				<div class="txt_box" id="exe4">
					<span>좌측면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getLeft_side()}); " id="before_leftside" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah4"> -->
					<textarea class="cmt_img disabled"disabled  id="before_re_leftside">${nowDv.getRe_leftside()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_left_side"></div>
					</div>
				</div>
				<div class="txt_box" id="exe5">
					<span>우측면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getRight_side()}); " id="before_rightside" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah5"> -->
					<textarea class="cmt_img disabled" disabled  id="before_re_rightside">${nowDv.getRe_rightside()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_right_side"></div>
					</div>
				</div>
				<div class="txt_box" id="exe6">
					<span>평면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getPlane()}); " id="before_plane" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah6"> -->
					<textarea class="cmt_img disabled" disabled id="before_re_plane">${nowDv.getRe_plane()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_plane"></div>
					</div>
				</div>
				<div class="txt_box" id="exe7">
					<span>저면도</span>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getInside()}); " id="before_inside" ></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah7"> -->
					<textarea class="cmt_img disabled" disabled id="before_re_inside">${nowDv.getRe_inside()}</textarea>
					<div class="eximg curimg">
						<div style="background-image: url('');"  id="cur_inside"></div>
					</div>
				</div>
			</div>
			<div class="txt_box" id="addPicture">
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
			</div>
			<div id="fin">
				
				<input type="submit" value="등록하기" class="add_design" id="submit_btn">
				<button type="button" id="gotoUpLoad" style="display:none">서류 업로드</button>
			</div>
			</article> </section>
		</div>
	</form>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
	$(document).ready(function()
	{
		if("${count}"=="1"&&"${nowDv.getIscomplete()}"=="0"){
			$("#before_title").css("display","none");
			$("#before_whereapply").css("display","none");
			$("#before_mean").css("display","none");
			$("#before_sasi").css("display","none");
			$("#before_front").css("display","none");
			$("#before_bae").css("display","none");
			$("#before_plane").css("display","none");
			$("#before_inside").css("display","none");
			$("#before_leftside").css("display","none");
			$("#before_rightside").css("display","none");
		}
		
		if("${nowDv.getIscomplete()}"=="1"){
			$("#title").removeClass("disabled");
			$("#title").attr("disabled",false);
			$("#whereapply").removeClass("disabled");
			$("#whereapply").attr("disabled",false);
			$("#mean").removeClass("disabled");
			$("#mean").attr("disabled",false);
			
		}
		else if ("${nowDv.getIscomplete()}"=="0"){
			alert("변리사 수정중입니다.");
			$("#submit_btn").css("display","none");
		}
		else if("${nowDv.getIscomplete()}">"3"){
			$("#submit_btn").css("display","none");
			$("#gotoUpLoad").css("display","inline");
			alert("변리사님이 최종 확인을 하였습니다. 하단의 서류 업로드 버튼을 눌러 서류업로드를 해주세요");
		}
 		$(".curimg").css("display","none");
		
 		$("#gotoUpLoad").click(function(){
 			alert("서류 업로드 화면으로 이동합니다.");
 			location.href="/design/gotoUpLoad"
 		})
	});
	$(".loadBtn").click(function(){
		var num=$(this).data("num");
		var deid=$("#deid").val();
		var csrfToken = $("meta[name='_csrf']").attr("content"); 
		var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
		var data = {};
		
		var headers = {};

		data[csrfParameter] = csrfToken;
		headers[csrfHeader] = csrfToken;

		 data['num'] = num;
		 data['deid'] = deid;
		 data['count']="${count}";
		 $.ajax({
		   url : "/design/changeDesign",
		   type:"POST",
		   headers: headers,
		     data : data,
		     success:function(retVal)
		     {
		    	 
		     	if(num!="${count}"){
		     		var cur=retVal.cuVo;
		     		var be = retVal.beVo;
		     		
		     		
		     		$(".curimg").css("display","inline");
		     		$("#title").attr("disabled",true);
		     		$("#whereapply").attr("disabled",true);
		     		$("#mean").attr("disabled",true);
		     		$("#title").addClass("disabled");
		     		$("#whereapply").addClass("disabled");
		     		$("#mean").addClass("disabled");

		     		$("#before_title").val(be.title);
		     		$("#before_whereapply").val(be.whereapply);
		     		$("#before_mean").val(be.mean);
		     		$("#before_re_title").val(be.re_title);
		     		$("#before_re_whereapply").val(be.re_whereapply);
		     		$("#before_re_mean").val(be.re_mean);
		     		$("#before_re_sasi").val(be.re_sasi);
		     		$("#before_re_front").val(be.re_front);
		     		$("#before_re_bae").val(be.re_bae);
		     		$("#before_re_leftside").val(be.re_leftside);
		     		$("#before_re_rightside").val(be.re_rightside);
		     		$("#before_re_plane").val(be.re_plane);
		     		$("#before_re_inside").val(be.re_inside);
		     		
		     		$("#title").val(cur.title);
		     		$("#whereapply").val(cur.whereapply);
		     		$("#mean").val(cur.mean);
		     		//$("#before_re_sasi").css("background-imgae","");
		     		$("#before_sasi").css("background-image","url("+be.sasi+")");
		     		$("#before_front").css("background-image","url("+be.front+")");
		     		$("#before_bae").css("background-image","url("+be.bae+")");
		     		$("#before_left_side").css("background-image","url("+be.left_side+")");
		     		$("#before_right_side").css("background-image","url("+be.right_side+")");
		     		$("#before_plane").css("background-image","url("+be.plane+")");
		     		$("#before_inside").css("background-image","url("+be.inside+")");
		     		
		     		$("#cur_sasi").css("background-image","url("+cur.sasi+")");
		     		$("#cur_front").css("background-image","url("+cur.front+")");
		     		$("#cur_bae").css("background-image","url("+cur.bae+")");
		     		$("#cur_left_side").css("background-image","url("+cur.left_side+")");
		     		$("#cur_right_side").css("background-image","url("+cur.right_side+")");
		     		$("#cur_plane").css("background-image","url("+cur.plane+")");
		     		$("#cur_inside").css("background-image","url("+cur.inside+")");
		     		
		     		$("#addPicture").css("display","none");
		     		
		     		$("#submit_btn").css("display","none");
		     	}
		     	else{
		     		
		     		var be = retVal.beVo;
					
		     		$("#before_title").val(be.title);
		     		$("#before_whereapply").val(be.whereapply);
		     		$("#before_mean").val(be.mean);
		     		$("#before_re_title").val(be.re_title);
		     		$("#before_re_whereapply").val(be.re_whereapply);
		     		$("#before_re_mean").val(be.re_mean);
		     		$("#title").val("");
		     		$("#whereapply").val("");
		     		$("#mean").val("");
		     		$("#title").attr("disabled",false);
		     		$("#whereapply").attr("disabled",false);
		     		$("#mean").attr("disabled",false);
		     		$("#title").removeClass("disabled");
		     		$("#whereapply").removeClass("disabled");
		     		$("#mean").removeClass("disabled");
		     		$("#addPicture").css("display","inline");
		     		$("#before_sasi").css("background-image","url("+be.sasi+")");
		     		$("#before_front").css("background-image","url("+be.front+")");
		     		$("#before_bae").css("background-image","url("+be.bae+")");
		     		$("#before_leftside").css("background-image","url("+be.left_side+")");
		     		$("#before_rightside").css("background-image","url("+be.right_side+")");
		     		$("#before_plane").css("background-image","url("+be.plane+")");
		     		$("#before_inside").css("background-image","url("+be.inside+")");
		     		
		     		
		     		
		     		$(".curimg").css("display","none");
		     		
		     		$("#submit_btn").css("display","inline");
		     		
					if("${nowDv.getIscomplete()}"!="1"){
			     		$("#submit_btn").css("display","none");
			     		$("#title").attr("disabled",true);
			     		$("#whereapply").attr("disabled",true);
			     		$("#mean").attr("disabled",true);
			     		$("#title").addClass("disabled");
			     		$("#whereapply").addClass("disabled");
			     		$("#mean").addClass("disabled");
			     		$("#addPicture").css("display","none");
		     		}
		     	}
		     },
		     error: function(request,status,error)
		   {
		       alert('실패하였습니다.')
		       console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		   }
		});   
		 //location.href ="/mainPage";
	});
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
		$(function(){
			$(".txt_box>button").attr("type","button");
		});
	</script>
</body>
</html>
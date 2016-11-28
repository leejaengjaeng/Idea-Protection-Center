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
	<c:forEach var="j" begin="1" end="${count}" step="1">
		<button class="loadBtn" data-num="${j}">${j}차 수정안</button><br/>
	</c:forEach>
	<form action="/design/inputCommentDesign" method="POST"
		enctype="multipart/form-data" onsubmit="return checkDesign();">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<input type="hidden" name="uid" value="${nowDv.getUid()}"><input type="hidden" name="luid" value="${nowDv.getLuid()}"><input type="hidden" id="deid" name="deid" value="${nowDv.getDeid()}">
		<div class="wrap_comment">
			<section> <article class="sub_head">
			<h1>
				<b style="color: rgba(1, 102, 156, 1);">디자인권</b>수정
			</h1>
			</article> <article>
			<div class="txt_box">
				<h2>디자인 명칭*</h2>
				<button>작성예시 보기</button>
				<textarea class="cmt_de disabled first" id="before_re_title" disabled>${prevDv.getRe_title()}</textarea>
				<input type="text" id="title" name="title"
					value="${nowDv.getTitle()}"
					class="disabled second"
					disabled
					placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품">		
				<textarea class="cmt_de disabled third" name="re_title" id="re_title" disabled>${nowDv.getRe_title()}</textarea>
			</div>
			<div class="txt_box">
				<h2>디자인이 적용된 곳*</h2>
				<button>작성예시 보기</button>
				<textarea class="cmt_de disabled first" id="before_re_whereapply" disabled>${prevDv.getRe_whereapply()}</textarea>
				
				<input type="text" id="whereapply" name="whereapply"
					value="${nowDv.getWhereapply()}"
					class="disabled second"
					disabled
					placeholder="본인이 창작한 디자인이 사용되는 품목을 넣어 주시면 됩니다. 예)모니터받침, 모니터 보드">
				<textarea class="cmt_de disabled third" name="re_whereapply" id="re_whereapply" disabled>${nowDv.getRe_whereapply()}</textarea>
			</div>
			<div class="txt_box" style="margin-top: 100px;">
				<h2>디자인의 의미*</h2>
				<button>작성예시 보기</button>
				<textarea class="cmt_de disabled first" id="before_re_mean" disabled>${prevDv.getRe_mean()}</textarea>
				
				<textarea id="mean" class="disabled second" disabled>${nowDv.getMean()}</textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 102, 203, 1);">본인이 창작한 디자인의

					의미를 적어 주시기 바랍니다.</span>				
				<textarea class="cmt_de disabled third" name="re_mean" id="re_mean" disabled>${nowDv.getRe_mean()}</textarea>
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
					<textarea class="cmt_img disabled first" id="before_re_sasi" disabled>${prevDv.getRe_sasi()}</textarea>
					<div class="eximg" style="padding: 10px">
						<div style="background-image: url(${nowDv.getSasi()}); " id="sasi"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah1"> -->
					<textarea class="cmt_img disabled third" name="re_sasi" id="re_sasi" disabled>${nowDv.getRe_sasi()}</textarea>
				</div>
				<div class="txt_box" id="exe2">
					<span>정면도</span>
					<textarea class="cmt_img disabled first" id="before_re_front" disabled>${prevDv.getRe_front()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getFront()});" id="front"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah2"> -->
					<textarea class="cmt_img disabled third" name="re_front" id="re_front" disabled>${nowDv.getRe_front()}</textarea>
				</div>
				<div class="txt_box" id="exe3">
					<span>배면도</span>
					<textarea class="cmt_img disabled first" id="before_re_bae" disabled>${prevDv.getRe_bae()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getBae()}); " id="bae"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah3"> -->
					<textarea class="cmt_img disabled third" name="re_bae" id="re_bae" disabled>${nowDv.getRe_bae()}</textarea>
				</div>
				<div class="txt_box" id="exe4">
					<span>좌측면도</span>
					<textarea class="cmt_img disabled first" id="before_re_leftside" disabled>${prevDv.getRe_leftside()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getLeft_side()}); " id="left_side"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah4"> -->
					<textarea class="cmt_img disabled third" name="re_leftside" id="re_leftside" disabled>${nowDv.getRe_leftside()}</textarea>
				</div>
				<div class="txt_box" id="exe5">
					<span>우측면도</span>
					<textarea class="cmt_img disabled first" id="before_re_rightside" disabled>${prevDv.getRe_rightside()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getRight_side()}); " id="right_side"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah5"> -->
					<textarea class="cmt_img disabled third" name="re_rightside" id="re_rightside" disabled>${nowDv.getRe_rightside()}</textarea>
				</div>
				<div class="txt_box" id="exe6">
					<span>평면도</span>
					<textarea class="cmt_img disabled first" id="before_re_plane" disabled>${prevDv.getRe_plane()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getPlane()}); " id="plane"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah6"> -->
					<textarea class="cmt_img disabled third" name="re_plane" id="re_plane" disabled>${nowDv.getRe_plane()}</textarea>
				</div>
				<div class="txt_box" id="exe7">
					<span>저면도</span>
					<textarea class="cmt_img disabled first" id="before_re_inside" disabled>${prevDv.getRe_inside()}</textarea>
					<div class="eximg">
						<div style="background-image: url(${nowDv.getInside()}); " id="inside"></div>
					</div>
					<!-- <img src="/resources/image/check.png" alt="등록된 디자인 시안이 없습니다." id="blah7"> -->
					<textarea class="cmt_img disabled third" name="re_inside" id="re_inside" disabled>${nowDv.getRe_inside()}</textarea>
				</div>
			</div>
			
			<div id="fin">
				
				<input type="submit" id="submit_btn" value="등록하기" class="add_design">
				<button type="button" id="gotoApply">출원하기</button>
			</div>
			<button type="button" id="gotoDownLoad" style="display:none">다운받기</button>
			
			</article> </section>
		</div>
	</form>
	<c:import url="/WEB-INF/views/import/footer.jsp" />
	<script>
	$(document).ready(function()
	{
		if("${count}"=="1"){
			$("#before_re_title").css("display","none");
			$("#before_re_whereapply").css("display","none");
			$("#before_re_mean").css("display","none");
			$("#before_re_sasi").css("display","none");
			$("#before_re_front").css("display","none");
			$("#before_re_bae").css("display","none");
			$("#before_re_plane").css("display","none");
			$("#before_re_inside").css("display","none");
			$("#before_re_leftside").css("display","none");
			$("#before_re_rightside").css("display","none");
		}
		
		if("${nowDv.getIscomplete()}"=="0"){
			$("#re_title").removeClass("disabled");
			$("#re_title").attr("disabled",false);
			$("#re_whereapply").removeClass("disabled");
			$("#re_whereapply").attr("disabled",false);
			$("#re_mean").removeClass("disabled");
			$("#re_mean").attr("disabled",false);
			$("#re_sasi").removeClass("disabled");
			$("#re_sasi").attr("disabled",false);
			$("#re_front").removeClass("disabled");
			$("#re_front").attr("disabled",false);
			$("#re_bae").removeClass("disabled");
			$("#re_bae").attr("disabled",false);
			$("#re_leftside").removeClass("disabled");
			$("#re_leftside").attr("disabled",false);
			$("#re_rightside").removeClass("disabled");
			$("#re_rightside").attr("disabled",false);
			$("#re_plane").removeClass("disabled");
			$("#re_plane").attr("disabled",false);
			$("#re_inside").removeClass("disabled");
			$("#re_inside").attr("disabled",false);
		}
		else if("${nowDv.getIscomplete()}"=="1"){
			alert("발명가 수정중입니다.");
			$("#fin").css("display","none");
		}
		else if("${nowDv.getIscomplete()}"=="3"){
			alert("발명가 회원이 서류 업로드 중입니다.");
			$("#fin").css("display","none");
		}
		else if("${nowDv.getIscomplete()}"=="4")
		{
			alert("발명가 회원이 서류 업로드를 완료하였습니다. 하단의 다운받기 버튼을 클릭해주세요.");
			$("#fin").css("display","none");
			$("#gotoDownLoad").css("display","inline");
			
		}
		$("#gotoDownLoad").click(function(){
			location.href="/downLoadDoc/Design";
		});
		$("#gotoApply").click(function(){
			                                          
	        	 alert("확인을 누르시면 출원단계가 진행되어집니다.");               
	        	var deid= $("#deid").val();
	        	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	 			var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	 			var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	 			var data = {};
	 			
	 			var headers = {};

	 			data[csrfParameter] = csrfToken;
	 			headers[csrfHeader] = csrfToken;

	 			 
	 			 data['deid'] = deid;
	 			 
	 			 $.ajax({
	 			   url : "/design/gotoApply",
	 			   type:"POST",
	 			   headers: headers,
	 			   data : data,
	 			   success:function(retVal)
	 			   {
	 					alert("발명가 회원이 최종확인 후, 서류를 업로드 시키면 나머지 출원 단계가 진행됩니다.");
	 					location.href="/mainPage";
	 			   },
	 			   error: function(request,status,error)
	 			   {
	 			       alert('실패하였습니다.')
	 			       console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	 			   }
	 			});   
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
			   url : "/design/changeDesignPL",
			   type:"POST",
			   headers: headers,
			     data : data,
			     success:function(retVal)
			     {
						
			    	if(num==1){
			    		$(".first").css("display","none");
			    		var cu=retVal.cuVo;
			     		$("#title").val(cu.title);
			     		$("#whereapply").val(cu.whereapply);
			     		$("#mean").val(cu.mean);
			     		$("#sasi").css("background-image","url("+cu.sasi+")");
			     		$("#front").css("background-image","url("+cu.front+")");
			     		$("#bae").css("background-image","url("+cu.bae+")");
			     		$("#left_side").css("background-image","url("+cu.left_side+")");
			     		$("#right_side").css("background-image","url("+cu.right_side+")");
			     		$("#plane").css("background-image","url("+cu.plane+")");
			     		$("#inside").css("background-image","url("+cu.inside+")");
			     		
			     		$("#re_title").val(cu.re_title);
			     		$("#re_whereapply").val(cu.re_whereapply);
			     		$("#re_mean").val(cu.re_mean);
			     		$("#re_sasi").val(cu.re_sasi);
			     		$("#re_front").val(cu.re_front);
			     		$("#re_bae").val(cu.re_bae);
			     		$("#re_leftside").val(cu.re_leftside);
			     		$("#re_rightside").val(cu.re_rightside);
			     		$("#re_plane").val(cu.re_plane);
			     		$("#re_inside").val(cu.re_inside);
			     		
			     		$(".third").addClass("disabled");
			     		$(".third").attr("disabled",true);
			     		$("#submit_btn").css("display","none");
			    	}
			    	else if(num<"${count}"){
			    		$(".first").css("display","inline");
			     		var cur=retVal.cuVo;
			     		var be = retVal.beVo;
						
			     		
			     		$("#title").val(cur.title);
			     		$("#whereapply").val(cur.whereapply);
			     		$("#mean").val(cur.mean);
			     		$("#sasi").css("background-image","url("+cur.sasi+")");
			     		$("#front").css("background-image","url("+cur.front+")");
			     		$("#bae").css("background-image","url("+cur.bae+")");
			     		$("#left_side").css("background-image","url("+cur.left_side+")");
			     		$("#right_side").css("background-image","url("+cur.right_side+")");
			     		$("#plane").css("background-image","url("+cur.plane+")");
			     		$("#inside").css("background-image","url("+cur.inside+")");
			     		
			     		$("#re_title").val(cur.re_title);
			     		$("#re_whereapply").val(cur.re_whereapply);
			     		$("#re_mean").val(cur.re_mean);
			     		$("#re_sasi").val(cur.re_sasi);
			     		$("#re_front").val(cur.re_front);
			     		$("#re_bae").val(cur.re_bae);
			     		$("#re_leftside").val(cur.re_leftside);
			     		$("#re_rightside").val(cur.re_rightside);
			     		$("#re_plane").val(cur.re_plane);
			     		$("#re_inside").val(cur.re_inside);
			     		
			     		$("#before_re_title").val(be.re_title);
			     		$("#before_re_whereapply").val(be.re_whereapply);
			     		$("#before_re_mean").val(be.re_mean);
			     		$("#before_re_sasi").val(be.re_sasi);
			     		$("#before_re_front").val(be.re_front);
			     		$("#before_re_bae").val(be.re_bae);
			     		$("#before_re_left_side").val(be.re_leftside);
			     		$("#before_re_right_side").val(be.re_rightside);
			     		$("#before_re_plane").val(be.re_plane);
			     		$("#before_re_inside").val(be.re_inside);
			     		
			     		$(".third").addClass("disabled");
			     		$(".third").attr("disabled",true);
			     		
			     		$(".second").addClass("disabled");
			     		$(".second").attr("disabled",true);
			     		
			     		$("#submit_btn").css("display","none");
			     	}
			     	else{
			     		var be = retVal.beVo;
			     		var cur=retVal.cuVo;
			    		$(".first").css("display","inline");

			     		$("#re_title").val(cur.re_title);
			     		$("#re_whereapply").val(cur.re_whereapply);
			     		$("#re_mean").val(cur.re_mean);
			     		$("#re_sasi").val(cur.re_sasi);
			     		$("#re_front").val(cur.re_front);
			     		$("#re_bae").val(cur.re_bae);
			     		$("#re_leftside").val(cur.re_leftside);
			     		$("#re_rightside").val(cur.re_rightside);
			     		$("#re_plane").val(cur.re_plane);
			     		$("#re_inside").val(cur.re_inside);
			     		
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
			     		$("#sasi").css("background-image","url("+cur.sasi+")");
			     		$("#front").css("background-image","url("+cur.front+")");
			     		$("#bae").css("background-image","url("+cur.bae+")");
			     		$("#left_side").css("background-image","url("+cur.left_side+")");
			     		$("#right_side").css("background-image","url("+cur.right_side+")");
			     		$("#plane").css("background-image","url("+cur.plane+")");
			     		$("#inside").css("background-image","url("+cur.inside+")");
			     		
			     		
			     		
			     		
			     		$(".third").removeClass("disabled");
			     		$(".third").attr("disabled",false);
			     		
			     		$(".second").addClass("disabled");
			     		$(".second").attr("disabled",true);
			     		
			     		
			     		
			     		$("#submit_btn").css("display","inline");
			     		
			     		if("${nowDv.getIscomplete()}"=="1"){
			     			$(".third").addClass("disabled");
				     		$(".third").attr("disabled",true);
				     		$("#submit_btn").css("display","none");
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
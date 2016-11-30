<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:import url="/WEB-INF/views/import/header.jsp" />
<link href="/resources/common/css/mark.css" rel="stylesheet">
<script type="text/javascript"	src="/resources/common/js/util.js"></script>
</head>
<body>
	<div class="wrap_comment">
		<section> <article class="sub_head">
		<h1>
			<b style="color:rgba(0, 204, 254, 1);">상표</b>출원
		</h1>
		</article> 
		<article>
			<div class="dropdown">
				<span id="drop_sp">상표권 등록 (초안)</span>
				<div class="arrow-up ee"></div>					
				<ul id="IdeaModifyList">
					<c:forEach var="j" begin="1" end="${count}" step="1">
						<li class="loadBtn" data-num="${j}">${j}차 수정안</li>
					</c:forEach>
				</ul>					
			</div>
		<form action="/copyRight/regCopyright" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" />				
<!-- 명칭 -->
			<div class="txt_box">
				<h2>사용할 상표(명칭)</h2>
				<button>작성예시 보기</button>
				<div class="mark_form">
					<input type="text" class="name_mark" placeholder="1안">
					<input type="text" class="name_mark" placeholder="2안">
					<input type="text" class="name_mark" placeholder="3안">
				</div>	
				<textarea class="disabled" disabled="disabled"></textarea>
				<textarea></textarea>			
			</div>
<!-- 사용처 -->
			<div class="txt_box">
				<h2>상표 사용처</h2>
				<button>작성예시 보기</button>
				<br>		
				<input type="text">		
				<span
					style="font-size: 0.8rem; color: rgba(0, 204, 254, 1); display: inline-block; float: left;">
					본인이 창작한 저작물의 분야를 선택해주세요. </span>
				<textarea class="disabled" disabled="disabled"></textarea>	
				<textarea></textarea>			
			</div>
<!-- 의미 -->
			<div class="txt_box" style="margin-top: 100px;">
				<h2>상표 의미</h2>
				<button>작성예시 보기</button>
				<textarea id="meaning" name="meaning"></textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 204, 254, 1);">본인이 창작한 저작의
					의미를 적어 주시기 바랍니다.</span>
				<textarea class="disabled" disabled="disabled">이전내용</textarea>
				<textarea></textarea>
			</div>
<!-- 첨부 -->
			<div class="txt_box">
				<h2>로고 첨부</h2>
				<button>작성예시 보기</button>											
			</div>
			<div class="txt_box" style="margin-top:10px;">							
				<div class="add_imgs">
					<img src="/resources/image/noimg_sum.png" id="imgkkk">
					<input type="file" id="plan_img" name="plan_img">
				</div>	
				<textarea class="logo_cmt disabled" disabled="disabled">이전내용</textarea>
				<textarea></textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 204, 254, 1); display: inline-block; float: left;">
				만드신 저작물의 첨부파일을 넣어 주세요 10mb이상의 파일은 이후 지정된 전문가의 메일로 제출하여 주세요.
				</span>			
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
<script>
	var i = 1;
	function addfile2(){
		i++;
		$(".inp_add").append("<input type='file' style='float: left; margin: 10px 0 10px 0; opacity: 1; padding-top: 5px;' id='copy_file"+i+"'>");		
	}

    $(document).ready(function(){
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                reader.onload = function (e) {
                //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                    $('#imgkkk').attr('src', e.target.result);
                    //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                    //(아래 코드에서 읽어들인 dataURL형식)
                }                   
                reader.readAsDataURL(input.files[0]);
                //File내용을 읽어 dataURL형식의 문자열로 저장
            }
        }//readURL()--

        //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
        $("#plan_img").change(function(){
            //alert(this.value); //선택한 이미지 경로 표시
            readURL(this);
        });
     });
    $(function(){
		$(".txt_box>button").attr("type","button");
	});
    $(".dropdown").click(function(){		
		  
		if($(this).height() < 100){
		    $(this).css('max-height', '500px'); //set max height
		}else{
		    $(this).css('max-height', '50px'); //delete attribute
		}
	});

	$("#IdeaModifyList_top li").click(function(){
		$("#drop_sp").text($(this).data("val"));
	});
</script>	
</body>
</html>
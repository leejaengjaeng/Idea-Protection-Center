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
		<form action="/mark/regMarkIn" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" />				
<!-- 명칭 -->
			<div class="txt_box">
				<h2>사용할 상표(명칭)</h2>
				<button>작성예시 보기</button>
				<div class="mark_form">
					<input type="text" class="name_mark"  id="before_title1"  class="disabled" disabled="disabled" placeholder="1안" value="${mv.getTitle1()}">
					<input type="text" class="name_mark"  id="before_title2"  class="disabled" disabled="disabled" placeholder="2안" value="${mv.getTitle2()}">
					<input type="text" class="name_mark"  id="before_title3"  class="disabled" disabled="disabled" placeholder="3안" value="${mv.getTitle3()}">
				</div>	
				<textarea class="disabled" disabled="disabled" id="before_re_title1">${mv.getRe_title1()}</textarea>
				<div class="mark_form">
					<input type="text" name="title1" id="title1" class="name_mark disabled now" placeholder="1안" disabled>
					<input type="text" name="title2" id="title2" class="name_mark disabled now" placeholder="2안" disabled>
					<input type="text" name="title3" id="title3" class="name_mark disabled now" placeholder="3안" disabled>
				</div>				
			</div>
<!-- 사용처 -->
			<div class="txt_box">
				<h2>상표 사용처</h2>
				<button>작성예시 보기</button>
				<br>		
				<input type="text" id="before_whereuse" class="disabled" disabled="disabled" value="${mv.getWhereuse()}">		
				<span
					style="font-size: 0.8rem; color: rgba(0, 204, 254, 1); display: inline-block; float: left;">
					본인이 창작한 저작물의 분야를 선택해주세요. </span>
				<textarea class="disabled" id="before_re_whereuse" disabled="disabled">${mv.getRe_whereuse()}</textarea>	
				<input type="text" name="whereuse" id="whereuse" class="disabled now" disabled>
			</div>
<!-- 의미 -->
			<div class="txt_box" style="margin-top: 100px;">
				<h2>상표 의미</h2>
				<button>작성예시 보기</button>
				<textarea id="before_mean" class="disabled" disabled="disabled" >${mv.getMean()}</textarea>
				<span style="font-size: 0.8rem; color: rgba(0, 204, 254, 1);">본인이 창작한 저작의
					의미를 적어 주시기 바랍니다.</span>
				<textarea class="disabled" id="before_re_mean" disabled="disabled">${mv.getRe_mean()}</textarea>
				<textarea name="mean" id="mean" class="disabled now" disabled></textarea>
			</div>
<!-- 첨부 -->
			<div class="txt_box">
				<h2>로고 첨부</h2>
				<button>작성예시 보기</button>											
			</div>
			<div class="txt_box" style="margin-top:10px;">							
				<div class="add_imgs">
					<img src="${mv.getLogo()}" id="before_logo">
				</div>	
				<textarea class="logo_cmt disabled" disabled="disabled" id="before_re_logo">${mv.getRe_logo()}</textarea>
				<div class="add_imgs" id="logo">
					
							<img src="/resources/image/noimg_sum.png" id="imgkkk">	
					<input type="file" id="plan_img" name="logo" class="disabled now" disabled>
				</div>	
				<span style="font-size: 0.8rem; color: rgba(0, 204, 254, 1); display: inline-block; float: left;">
				만드신 저작물의 첨부파일을 넣어 주세요 10mb이상의 파일은 이후 지정된 전문가의 메일로 제출하여 주세요.
				</span>			
			</div>
			<div id="fin">
				<!-- <button>임시저장</button>	 -->
				<input type="submit" value="등록하기" id="subbtn" style="display:none">
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
    	
		
    	if("${mv.getIscomplete()}"=='0'){
    		alert("변리사님이 수정중입니다.");
    		if("${countMark}"==1){
    			$('#before_re_title1').css("display","none");
    			$('#before_re_mean').css("display","none");
    			$('#before_re_whereuse').css("display","none");
    			$('#before_re_logo').css("display","none");
    			
    			$('#title1').css("display","none");
    			$('#title2').css("display","none");
    			$('#title3').css("display","none");
    			$('#whereuse').css("display","none");
    			$('#mean').css("display","none");
    			$('#logo').css("display","none");
    			$('#logoimg').css("display","none");
    			$('#subbtn').css("display","none");
    			
    		}
    	}
    	else if("${countMark}"=='1'){
			$('#subbtn').css("display","inline");
			$('.now').removeClass("disabled");
			$('.now').attr("disabled",false);
    	}
    	
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
</script>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:import url="/WEB-INF/views/import/header.jsp" />
<link href="/resources/common/css/mark.css" rel="stylesheet">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
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
		<c:forEach var="j" begin="1" end="${countMark}" step="1">
			<button class="loadBtn" data-num="${j}">${j}차 수정안</button>
		</c:forEach>
		<form action="/mark/regMarkPl" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" />
			<input type="hidden" name="mid" id="mid" value="${mv.getMid()}" />				

<!-- 명칭 -->
			<div class="txt_box">
				<h2>사용할 상표(명칭)</h2>
				<button>작성예시 보기</button>
				<textarea class="disabled first" disabled="disabled" id="before_re_title1">${prev_mv.getRe_title1()}</textarea>
				<div class="mark_form">
					<input type="text" class="name_mark disabled" placeholder="1안" disabled="disabled" id="title1" value="${mv.getTitle1()}">
					<input type="text" class="name_mark disabled" placeholder="2안" disabled="disabled" id="title2" value="${mv.getTitle2()}">
					<input type="text" class="name_mark disabled" placeholder="3안" disabled="disabled" id="title3" value="${mv.getTitle3()}">
				</div>	
				
				<textarea class="now disabled" name="re_title1" id="re_title1" disabled>${mv.getRe_title1()}</textarea>			
			</div>
<!-- 사용처 -->
			<div class="txt_box">
				<h2>상표 사용처</h2>
				<button>작성예시 보기</button>
				<br>		
					
				<textarea class="disabled first" disabled="disabled" id="before_re_whereuse">${prev_mv.getRe_whereuse()}</textarea><br>
				<input type="text" class="disabled" disabled="disabled" value="${mv.getWhereuse()}" id="whereuse">	
				<textarea class="now disabled" name="re_whereuse" id="re_whereuse" disabled>${mv.getRe_whereuse()}</textarea>			
			</div>
<!-- 의미 -->
			<div class="txt_box" style="margin-top: 100px;">
				<h2>상표 의미</h2>
				<button>작성예시 보기</button>
				<textarea class="disabled first" disabled="disabled" id="before_re_mean">${prev_mv.getRe_mean()}</textarea>
				<textarea class="disabled" disabled="disabled" id="mean">${mv.getMean()}</textarea>
				<textarea name="re_mean" class="now disabled" disabled id="re_mean">${mv.getRe_mean()}</textarea>
			</div>
<!-- 첨부 -->
			<div class="txt_box">
				<h2>로고 첨부</h2>
				<button>작성예시 보기</button>											
			</div>
			<div class="txt_box" style="margin-top:10px;">							
				<textarea class="logo_cmt disabled first" disabled="disabled" id="before_re_logo">${prev_mv.getRe_logo()}</textarea>
				<div class="add_imgs">
					<img src="${mv.getLogo()}" id="imgkkk">
				</div>	
				<textarea class="now disabled" disabled name="re_logo" id="re_logo">${mv.getRe_logo()}</textarea>				
			</div>
			<div id="fin">
				<!-- <button>임시저장</button>	 -->
				<input id="subbtn" value="등록하기" type="submit" style="display:none">
				<button type="button" id="gotoApply">출원하기</button>
				<button type="button" id="gotoDownLoad" style="display:none">서류다운받기</button>
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
    	$("#gotoDownLoad").click(function(){
			location.href="/downLoadDoc/Mark";
		});
    
    	if("${countMark}"=='1'){
			$('#before_re_title1').css("display","none");
			$('#before_re_mean').css("display","none");
			$('#before_re_whereuse').css("display","none");
			$('#before_re_logo').css("display","none");
		}
    	if("${mv.getIscomplete()}"=='1'){
    		alert("발명가님이 수정중입니다.");
    	}
    	else if("${mv.getIscomplete()}"=='0'){
			$('#subbtn').css("display","inline");
			$('.now').removeClass("disabled");
			$('.now').attr("disabled",false);
    	}
    	else if("${mv.getIscomplete()}"=='3'){
    		alert("서류업로드중");
    		$('#subbtn').css("display","none");
    		$('#gotoApply').css("display","none");
			$('.now').addClass("disabled");
			$('.now').attr("disabled",true);
    	}
    	else if("${mv.getIscomplete()}"=='4'){
    		alert("아래의 서류받기 버튼을 눌러서 서류를 다운받아주세요");
    		$('#gotoDownLoad').css("display","inline");
    		$('#gotoApply').css("display","none");

    	}
    	else if("${mv.getIscomplete()}"=='5'){
    		alert("출원이 완료된 사항입니다.");
    		$('#gotoDownLoad').css("display","inline");
    		$('#gotoApply').css("display","none");

    	}
		$(".loadBtn").click(function(){
    		
    		var num=$(this).data("num");
    		var mid=$("#mid").val();
    		var csrfToken = $("meta[name='_csrf']").attr("content"); 
    		var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    		var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    		var data = {};
    		
    		var headers = {};

    		data[csrfParameter] = csrfToken;
    		headers[csrfHeader] = csrfToken;

    		 data['num'] = num;
    		 data['mid'] = mid;
    		 data['count']="${countMark}";
    		 $.ajax({
    		   url : "/mark/changeMarkPl",
    		   type:"POST",
    		   headers: headers,
    		     data : data,
    		     success:function(retVal)
    		     {
    		    	if(num=='1'){
    		    		var cur=retVal.cuVo;
    		     		var be = retVal.beVo;
    		    		
    		    		$(".first").css("display","none");
    		    		$("#title1").val(cur.title1);
    		    		$("#title2").val(cur.title2);
    		    		$("#title3").val(cur.title3);
    		    		$("#whereuse").val(cur.whereuse);
    		    		$("#mean").val(cur.mean);
    		    		$("#imgkkk").attr("src",cur.logo);
    		    		$("#re_title1").val(cur.re_title1);
    		    		$("#re_whereuse").val(cur.re_whereuse);
    		    		$("#re_mean").val(cur.re_mean);
    		    		$("#re_logo").val(cur.re_logo);
    		    		
    		    		
    		    		$(".now").addClass("disabled");
    		    		$(".now").attr("disabled",true);
    					$('#subbtn').css("display","none");

    		    	} 
    		     	else if(num!="${countMark}"){
    		     		var cur=retVal.cuVo;
    		     		var be = retVal.beVo;
    		     		
    		    		$(".first").css("display","inline");

    		     		$("#before_re_title1").val(be.re_title1);
    		     		$("#before_re_whereuse").val(be.re_whereuse);
    		     		$("#before_re_mean").val(be.re_mean);
    		     		$("#before_re_logo").val(be.re_logo);
    		     		$("#title1").val(cur.title1);
    		     		$("#title2").val(cur.title2);
    		     		$("#title3").val(cur.title3);
    		     		$("#whereuse").val(cur.whereuse);
    		     		$("#mean").val(cur.mean);
    		     		$("#imgkkk").attr("src",cur.logo);
    		     		$("#re_title1").val(cur.re_title1);
    		     		$("#re_whereuse").val(cur.re_whereuse);
    		     		$("#re_mean").val(cur.re_mean);
    		     		$("#re_logo").val(cur.re_logo);
    		     		
    		     		$('.now').addClass("disabled");
    					$('.now').attr("disabled",true);
    					$('#subbtn').css("display","none");

    		     	}
    		     	else{
    		     		var be = retVal.beVo;
    		     		var cur=retVal.cuVo;

    		     		$("#title1").val(cur.title1);
    		     		$("#title2").val(cur.title2);
    		     		$("#title3").val(cur.title3);
    		     		$("#whereuse").val(cur.whereuse);
    		     		$("#mean").val(cur.mean);
    		     		$("#imgkkk").attr("src",cur.logo);
    		     		$("#before_re_title1").val(be.re_title1);
    		     		$("#before_re_whereuse").val(be.re_whereuse);
    		     		$("#before_re_mean").val(be.re_mean);
    		     		$("#before_re_logo").val(be.re_logo);
    		     		$("#re_title1").val("");
    		     		$("#re_whereuse").val("");
    		     		$("#re_mean").val("");
    		     		$("#re_logo").val("");
    		     		$('#subbtn').css("display","none");

    		     		if("${mv.getIscomplete()}"=='0'){
    		     			$('.now').removeClass("disabled");
    						$('.now').attr("disabled",false);
    						$('#subbtn').css("display","inline");

    		     		}
    		     	}
    		     },
    		     error: function(request,status,error)
    		   {
    		       alert('실패하였습니다.')
    		       console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		   }
    		});
    		$('#gotoApply').click(function(){
    			alert("발명가 회원님이 서류를 업로드하면 나머지 과정이 진행됩니다.");
    			location.href="/mark/gotoApply"
    		});
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
});
</script>	
</body>
</html>
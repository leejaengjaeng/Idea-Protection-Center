<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- <link rel="stylesheet"
   href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css"> -->
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>Insert title here</title>
<style>

 
</style>
<script>
var i=1;
function delfile(){
   $('#upimg'+i+'').detach();
   i--;
}
function checkTemp(){  
    if(${isTemp}=="1"){
      document.getElementById("bw").style.visibility="visible";
      document.getElementById("pp").style.visibility="visible";
     }
     else{
                      
     }
}
function loadTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
   headers[csrfHeader] = csrfToken;
      $.ajax({
       url : "/registration/loadTempIdea",
       dataType : "json",
       type : "POST",
       headers: headers,
       data : data,
       success: function(data) {
          document.getElementById("idea_kind").value=data.typeOfInvent;
            document.getElementById("idea_title").value=data.title;
            document.getElementById("small_cont").value=data.summary;
            document.getElementById("why_cont").value=data.whyInvent;
            document.getElementById("col_cont").value=data.problem;
            document.getElementById("wel_cont").value=data.solution;
            document.getElementById("bal_cont").value=data.effect;
            document.getElementById("imp_cont").value=data.core_element;
            document.getElementById("bw").style.visibility="hidden";
           document.getElementById("pp").style.visibility="hidden";
       },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   }); 
   
}

function removeTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
    headers[csrfHeader] = csrfToken;
    $.ajax({
        url : "/registration/removeTempIdea",
        dataType : "json",
        type : "POST",
        headers: headers,
        data : data,
        success: function(data) {
           document.getElementById("bw").style.visibility="hidden";
          document.getElementById("pp").style.visibility="hidden";
          location.href="/registration/addidea";
        },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   });
}
function tempsave(){
   var typeOfInvent=document.getElementById("idea_kind").value;
   var title=document.getElementById("idea_title").value;
   var summary=document.getElementById("small_cont").value;
   var whyInvent=document.getElementById("why_cont").value;
   var problem=document.getElementById("col_cont").value;
   var solution=document.getElementById("wel_cont").value;
   var effect=document.getElementById("bal_cont").value;
   var core_element=document.getElementById("imp_cont").value;
   var uid=document.getElementById("uid").value;
   
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["typeOfInvent"] = typeOfInvent;
   data["title"] = title;
   data["summary"] = summary;
   data["whyInvent"] = whyInvent;
   data["problem"] = problem;
   data["solution"] = solution;
   data["effect"] = effect;
   data["core_element"] = core_element;
   data["uid"]=uid;
   headers[csrfHeader] = csrfToken;
   $.ajax({
      url : "/registration/tempsave",
      dataType : "json",
      type : "POST",
      headers: headers,
      data : data,
      success: function(data) {
         alert("임시저장이 완료되었습니다");
      },
      error:function(request,status,error){
          alert("code:"+request.status+"\n"+"error:"+error);
      }
   
   }); 
}



function closeload(){
   document.getElementById("bw").style.visibility="hidden";
   document.getElementById("pp").style.visibility="hidden";  
   
}
function formSubmit(file){
   //alert($("input[name=imgs]").length);
    var maxSize  = 5 * 1024 * 1024    
    var fileSize = 0;

   // 브라우저 확인
   var browser=navigator.appName;

   // 익스플로러일 경우
   if (browser=="Microsoft Internet Explorer")
   {
      alert("ie");
      var oas = new ActiveXObject("Scripting.FileSystemObject");
      fileSize = oas.getFile( file.value ).size;
   }
      // 익스플로러가 아닐경우
   else
   {
      fileSize+= file.files[i].size;
      alert(fileSize);
   }
   
   
   alert("파일사이즈 : "+ fileSize +", 최대파일사이즈 : 5MB");
   
   if(fileSize > maxSize)
   {
       alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.    ");
       return false;
   }
   
   if(document.getElementById("typeOfInvent").value=="-"){
      alert("발명분야를 선택해주세요");
      return false;
   }
}
function changeType(value){
   document.getElementById("typeOfInvent").value=value;
}
</script>
</head>
<body onload='checkTemp();'>

<div class="black_wall" id="bw" style="visibility:hidden"></div>
<div class="popup" id="pp" style="visibility:hidden">
        <div class="pop_header">            
          <h2 style="color:#f9f9f9">아이디어 보호센터</h2>
          <img src="/resources/image/close.png" alt="close" class="popup_close" onclick="closeload()" id="close">
    </div>
    <div class="pop_cont">            
          <span>임시저장된 아이디어가 있습니다.</span>
          <table style="width:100%;">
             <c:forEach items="${tempList}" var="list" varStatus="status">
            <tr>
                <td style="width:30px;">${status.count }</td>
                <td>${list.getTitle()}</td>
                <td>${list.getRegistration_date() }</td> 
                <td style="width:100px;"><button style="background:#45d4fe;" onclick="loadTempIdea(${list.getRid()})" id="load_data">불러오기</button></td>
                <td style="width:100px;"><button style="background:#e9e9e9; color:#333;" onclick="removeTempIdea(${list.getRid()})">삭제하기</button></td>

             </tr>
         </c:forEach>
      </table>
    </div>
</div>
 
<c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">
        <section>            
            <article class="sub_head" style="margin-top:100px;">                    
                <h1><b>특허</b>등록</h1>                
            </article>                
            <article>
                <form name = "regisForm" action="/registration/inputidea" method="POST" enctype="multipart/form-data" onsubmit="return formSubmit(document.regisForm.imgs);">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="hiding_tab" style="position:relative;">
                    <select onChange=changeType(this.value);>
                         <option>-</option>
                         <c:forEach items="${typeList}" var="list" varStatus="status">
                     <option>${list.getType()}</option>
                  </c:forEach>                          
                      </select>        
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>제목</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <input type="text" id="idea_title" name="title" required placeholder="45자 이내로 입력해주세요."> 
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>요약</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="summary"></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>필요이유</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="whyInvent"></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>기존제품설명 및 문제점</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="problem"></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>문제해결방법</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="solution"></textarea>
                    </div>
                </div>            
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>발명의효과</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="effect"></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>핵심구성요소</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="core_element"></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>권리르 보장 받고자 하는 내용</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea></textarea>
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>도면첨부</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">                    
                        <div id="upimgdiv">
                            <input type="file" id="upimg1" name="imgs" accept="image/gif, image/jpeg, image/png">               
                        </div>
                        <button type="button" onclick="addfile()">추가</button>
                        <button type="button" onclick="delfile()">삭제</button>         
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>도면에 대한 설명</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea></textarea>
                    </div>
                </div>
                <div class="fin">
                    <button type ="button" onclick="tempsave();">임시저장</button>
                    <input type="submit" value="제출" id="agree">
                </div>
                </form>
            </article>
        </section>
    </div>    
<c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
    var i=1;
function addfile(){
    i++;
    $('#upimgdiv').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:10px;'>");
    //var targetdiv=document.getElementById("uploaddiv");
    //targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";

}
$(function(){
   $("textarea").attr("placeholder", "Comment.."); 
});
$(".popup_close, #load_data").click(function(){
   $("body").css("overflow","auto");   
});
    $(".arrow-up").click(function(){
       if($(this).parent().parent(".hiding_tab").hasClass("tab")){                                       
            $(this).parent().parent(".hiding_tab").stop().animate({"max-height":"70px"}).removeClass("tab");           
            $(this).stop().css({'transform' : 'rotate(180deg)','border-bottom-color':'#036EB7'}).addClass("tab");
        }else{            
            $(this).parent().parent(".hiding_tab").stop().animate({"max-height":"1000px"}).addClass("tab");            
            $(this).stop().css({'transform' : 'rotate(0deg)','border-bottom-color':'#ccc'}).addClass("tab");
        }
    });
    
</script>
</body>
</html>
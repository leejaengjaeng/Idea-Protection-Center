<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <meta name="_csrf" content="${_csrf.token}" />
<<<<<<< HEAD
   <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protectection Center</title>
=======
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protection Center</title>
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>  
    <script src="/resources/common/js/comment.js"></script>  
    <link href="/resources/common/css/cmt.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">

<style>
      .before_cmt>.img_comt{
         float: left !important;
      }
      .before_cmt>textarea{
         float:right !important;
      }
      .current_cmt>.img_comt{
         float:right !important;      
      }
      .current_cmt>textarea{
         float:left !important;
      }
      .after_cmt>.img_comt{
         float:left !important;         
      }
      .after_cmt>textarea{
         float:right !important;
         margin-top:0 !important;
      }
   
</style>

<script>
$(document).ready(function()
{
   
   if("${isFirst}" == "true")
   {
      hideBeforeCmt();
      hideCurrentCmt();
   }
   
   /*
      //배치 변경
      var txtBoxList = $('.txt_box');
      for(var i=0; i<8; i++) //9개 항목, 마지막 항목은 current_Cmt가 없음

      {
         $(txtBoxList[i]).children('.before_cmt').children('textarea').css('float','right');
         $(txtBoxList[i]).children('.before_cmt').children('.img_comt').css('float','left');
         $(txtBoxList[i]).children('.current_cmt').children('.img_comt').css('cssText','float:right !important; margin:0 0 0 10px;');
         $(txtBoxList[i]).children('.after_cmt').children('.img_comt').css('float','left');            
         $(txtBoxList[i]).children('.after_cmt').children('textarea').css('cssText','float:right !important');            
      }
      $(txtBoxList[8]).children('.before_cmt').children('textarea').css('float','right !important');
      $(txtBoxList[8]).children('.before_cmt').children('.img_comt').css('float','left !important');
      $(txtBoxList[8]).children('.after_cmt').children('.img_comt').css('float','left !important');            
      
   */
   //0 고객 작성중(변리사 작성 완료), 1 고객 작성 완료
   alert("${currentAnswer.getIscomplete()}");
   if("${currentAnswer.getIscomplete()}" == 0)
   {
	 
      enableInput();   
   }
   else if("${currentAnswer.getIscomplete()}"==2){
      disableInput();
      btnHide();
      alert("가출원상태입니다.");
   }
   else if("${currentAnswer.getIscomplete()}"==3){
      disableInput();
      var q=confirm("변리사가 위의 내용으로 최종 확인하였습니다 출원 단계를 진행하시겠습니까?");
      if(q==true){                                                      
         gotoApply("${user}");                                 
      }                                                         
      else{
         enableInput();
         denyApply("${user}");
         return false;                                         
      }  
   }
   else if("${currentAnswer.getIscomplete()}"==4){
	   alert("aa");   
	   disableInput();
	                                                     
	         gotoApply("${user}");                                 
	                                                               
   }      
   else
   {
      disableInput();
      alert('변리사의 답변을 기다려주세요');
   }
   
   //폼 버튼 이벤트 
   $('#tmpSave').on("click",function()
   {
      tmpSave("${user}");
   });
   $('#agree').on("click",function()
   {
      document.getElementById("commentForm").submit();
      ideaSave("${user}");
      

<<<<<<< HEAD
   });

   //클릭에 따라 내용 바꿔주기
   $('#IdeaModifyList').on("click","tr",function()
   {
      //IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
      $(this).parent().find('.clickedIdea').removeClass('clickedIdea');
      var rid = $(this).children('input').attr('value');
      
      if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 0))
      {
         enableInput();
      }
      else
      {
         disableInput();
      }

      //현재 선택된 요소(tr)에 clickedIdea를 붙임
      $(this).addClass('clickedIdea');
      
      showClickedList(rid);   
   })
=======
		{
			$(txtBoxList[i]).children('.before_cmt').children('textarea').css('float','right');
			$(txtBoxList[i]).children('.before_cmt').children('.img_comt').css('float','left');
			$(txtBoxList[i]).children('.current_cmt').children('.img_comt').css('cssText','float:right !important; margin:0 0 0 10px;');
			$(txtBoxList[i]).children('.after_cmt').children('.img_comt').css('float','left');				
			$(txtBoxList[i]).children('.after_cmt').children('textarea').css('cssText','float:right !important');				
		}
		$(txtBoxList[8]).children('.before_cmt').children('textarea').css('float','right !important');
		$(txtBoxList[8]).children('.before_cmt').children('.img_comt').css('float','left !important');
		$(txtBoxList[8]).children('.after_cmt').children('.img_comt').css('float','left !important');				
		
	*/
	
	//0 고객 작성중(변리사 작성 완료), 1 고객 작성 완료	
	if("${currentAnswer.getIscomplete()}" == 0)
	{		
		enableInput();	
	}
	else if("${currentAnswer.getIscomplete()}"==2){
		disableInput();
		btnHide();
		alert("가출원상태입니다.");
	}
	else if("${currentAnswer.getIscomplete()}"==3){
    	 disableInput();
    	 var q=confirm("변리사가 위의 내용으로 최종 확인하였습니다 출원 단계를 진행하시겠습니까?");
    	 if(q==true){                                                      
      	  gotoApply("${user}");                                 
     	}                                                         
     	else{
     		enableInput();
        	denyApply("${user}");
        	return false;                                         
  	 	  }
	}
	else
	{				
		disableInput();
		alert('변리사의 답변을 기다려주세요');
	}
	
	//폼 버튼 이벤트 
	$('#tmpAgree').on("click",function()
	{
		tmpSave("${user}");
	});
	$('#agree').on("click",function()
	{
		ideaSave("${user}");
	});

	//클릭에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","tr",function()
	{
		//IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
		$(this).parent().find('.clickedIdea').removeClass('clickedIdea');
		var rid = $(this).children('input').attr('value');
		
		if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 0))
		{
			enableInput();
		}
		else
		{
			disableInput();
		}
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c

   //작성 예시 버튼 이벤트
    $(".txt_box > button").click(function(){
        $(this).nextAll(".hiding_box").fadeIn();
    });
    $(".close_btn").click(function(){
       
        $(this).parents(".hiding_box").fadeOut();
    });

});

var i=0;
function addFile()
{
   $('#inputFileDiv').append("<div style='float:left;text-align:center;margin:40px 5px 20px 5px; width:230px;'><img style='width:200px; height:200px; border:1px solid #ccc;' src='/resources/image/plus2.png' alt='img' id='"+i+"'><br><input type='file' style='padding-top:5px; font-size:12px;' id='imgInp"+i+"' name='imgs' onchange='readURL(this,"+i+")' name='profileImg' style='width:180px;'></div>");
   i++;
}
function readURL(input,imgId) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#'+imgId).attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}

</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">       
        <section>            
           <nav>
                <div id="profile">
                    <img src="/resources/image/attonrney_profile.jpg" alt="profile">
                    <h4>${sessionScope.currentUser.getName()} 회원님</h4>
                    <span>${sessionScope.currentUser.getId()}</span>
                </div>
                <div id="profile_menu">
                    <ul>
                        <li>아이디어 진행내역</li>
                        <li>회원정보수정</li>                                                
                    </ul>
                </div>
                <div id="nav_benner">
                    <ul>
                        <li onclick="loaction.href='/registration/addidea'">
                            <img src="/resources/image/index_patent_1.jpg" alt="benner1">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_2.jpg" alt="benner2">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_3.jpg" alt="benner3">
                        </li>
                        <li>
                            <img src="/resources/image/index_patent_4.jpg" alt="benner4">
                        </li>
                    </ul>
                </div>
            </nav>                                      
            <article class="modify_log" style="margin-top:100px; border-top:2px solid #777; padding-top:50px;">                    
                <h1>아이디어수정내역</h1>   
                <table id="IdeaModifyList">
<<<<<<< HEAD
                   <c:forEach items="${processList}" var="list" varStatus="status">
                  <c:choose>
                  <%-- 목록이 하나인 경우 --%>
                     <c:when test="${status.first and status.last }">
                        <tr class="clickedIdea">
                           <input type="hidden" value="${list.getRid()}"/>
                           <td class="title_td">아이디어 등록(초안)</td>
                            <td class="date_td">${list.getRegistration_date()}</td>
                            </tr>
                     </c:when>
                  <%-- 목록이 하나가 아닌 경우 --%>
                     <c:when test="${status.first}">
                        <tr>
                           <input type="hidden" value="${list.getRid()}"/>
                           <td class="title_td">아이디어 등록(초안)</td>
                            <td class="date_td">${list.getRegistration_date()}</td>
                            </tr>
                     </c:when>
                     <c:when test="${status.last}">
                        <tr class="clickedIdea">
                           <input type="hidden" value="${list.getRid()}"/>
                           <td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
                                 <td class="date_td">${list.getRegistration_date()}</td>
                              </tr>
                     </c:when>
                     <c:otherwise>   
                        <tr>
                           <input type="hidden" value="${list.getRid()}"/>
                           <td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
                                 <td class="date_td">${list.getRegistration_date()}</td>
                              </tr>
                           </c:otherwise>
                      </c:choose>
               </c:forEach>      
            </table>                             
            </article>  
            <article style="width: 75%;">
               <input id="currentPosition" type="hidden" value="${currentAnswer.getRid()}"/>
               <div class="txt_box">
<!-- 1. 발명 분야 -->
                    <h2>발명분야</h2> <button>작성 예시</button>
                    
                    <div id="BeforeCommentTypeOfInvent" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getTypeOfInvent()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentTypeOfInvent" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_typeOfInvent() }</textarea>
                    </div>             
           
                    <div id="AfterCommentTypeOfInvent" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getTypeOfInvent() }</textarea>
                    </div>
                    
                    <div class="hiding_box">
                       <div class="hiding_box_header">
                           <h3>저작물 명칭</h3>
                           <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                       </div>  
                       <div class="hiding_box_content">
                           <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                       </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 2. 제목 -->
                <div class="txt_box">
                    <h2>제목</h2> <button>작성 예시</button>
                   
                    <div id="BeforeCommentTitle" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getTitle()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentTitle" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_title()}</textarea>
                    </div>             
           
                    <div id="AfterCommentTitle" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea disabled="disabled" class="disabled">${currentAnswer.getTitle()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 3. 요약 -->
             <div class="txt_box">
                    <h2>요약</h2> <button>작성 예시</button>
        
                    <div id="BeforeCommentSummary" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getSummary()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentSummary" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_summary()}</textarea>
                    </div>             
           
                    <div id="AfterCommentSummary" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getSummary()}</textarea>
                    </div>
                   
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 4. 필요 이유 -->
                <div class="txt_box">
                    <h2>필요이유</h2> <button>작성 예시</button>
                    
                    <div id="BeforeCommentWhyInvent" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getWhyInvent()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentWhyInvent" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_whyInvent()}</textarea>
                    </div>             
           
                    <div id="AfterCommentWhyInvent" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getWhyInvent()}</textarea>
                    </div>
                   
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 5. 기존제품 설명 및 문제점 -->
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2> <button>작성 예시</button>
                    
                   <div id="BeforeCommentProblem" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getProblem()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentProblem" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_problem()}</textarea>
                    </div>             
           
                    <div id="AfterCommentProblem" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getProblem()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 6. 문제 해결 방법 -->
                <div class="txt_box">
                    <h2>문제해결방법</h2> <button>작성 예시</button>
                  
                    <div id="BeforeCommentSolution" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getSolution()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentSolution" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_solution()}</textarea>
                    </div>             
           
                    <div id="AfterCommentSolution" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getSolution()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
<!-- 7. 발명의 효과 -->
                <div class="txt_box">
                    <h2>발명의 효과</h2> <button>작성 예시</button>
                  
                    <div id="BeforeCommentEffect" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getEffect()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentEffect" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
=======
                	<c:forEach items="${processList}" var="list" varStatus="status">
						<c:choose>
						
							<c:when test="${status.first and status.last }">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}"/>
								    <td class="title_td">아이디어 등록(초안)</td>
							        <td class="date_td">${list.getRegistration_date()}</td>
			                	</tr>
							</c:when>
							<c:when test="${status.first}">
								<tr>
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">아이디어 등록(초안)</td>
							       <td class="date_td">${list.getRegistration_date()}</td>
			                	</tr>
							</c:when>
							<c:when test="${status.last}">
								<tr class="clickedIdea">
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
			                        <td class="date_td">${list.getRegistration_date()}</td>
			                  	</tr>
							</c:when>
							<c:otherwise>	
								<tr>
									<input type="hidden" value="${list.getRid()}"/>
									<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
			                        <td class="date_td">${list.getRegistration_date()}</td>
			                  	</tr>
			               	</c:otherwise>
			          	</c:choose>
					</c:forEach>		
				</table>
            </article>                
            <article>
                <input id="currentPosition" type="hidden" value="${currentAnswer.getRid()}"/>           
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
                    <div class="tab_contents before_cmt" id="BeforeCommentTitle">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                      
                        </div>
                        <input type="text" id="idea_title" name="title" required placeholder="45자 이내로 입력해주세요." class="disabled" disabled value="${beforeReg.getTitle()}">  
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentTitle">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_title()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in" id="AfterCommentTitle">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getTitle()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>요약</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentSummary">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                      
                        </div>
                        <textarea name="summary" class="disabled" disabled>${beforeReg.getSummary()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentrCommentSummary">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_summary()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in" id="AfterCommentSummary">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getSummary()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>필요이유</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentWhyInvent">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="whyInvent" class="disabled" disabled>${beforeReg.getWhyInvent()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentWhyInvent">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_whyInvent()}</textarea>
                        </div>                            
                    </div>       
                    <div class="tab_recomment">
                        <div class="tab_in" id="AfterCommentWhyInvent">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getWhyInvent()}</textarea>
                        </div>                            
                    </div>             
                </div>
                <div class="hiding_tab">
                    <div class="tab_title" id="BeforeCommentProblem">
                        <span>기존제품설명 및 문제점</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="problem" class="disabled" disabled>${beforeReg.getProblem()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentProblem">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_problem()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment" >
                        <div class="tab_in" id="AfterCommentProblem">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getProblem()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>문제해결방법</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentSolution">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="solution" class="disabled" disabled>${beforeReg.getSolution()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentSolution">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_solution()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in" id="AfterCommentSolution">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getSolution()}</textarea>
                        </div>                            
                    </div>
                </div>            
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>발명의효과</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentEffect">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="effect" class="disabled" disabled>${beforeReg.getEffect()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentEffect">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_effect()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in" id="AfterCommentEffect">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getEffect()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>핵심구성요소</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentCore_Element">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="core_element" class="disabled" disabled>${beforeReg.getCore_element()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentCore_Element">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_core_element()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in"id="AfterCommentCore_Element">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getCore_element()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>권리를 보장 받고자 하는 내용</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentHope_content">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
                        </div>
                        <textarea name="hope_content" class="disabled" disabled>${beforeReg.getHope_content()}</textarea>
                    </div>
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentHope_content">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_hope_content()}</textarea>
                        </div>                            
                    </div>
                    <div class="tab_recomment">
                        <div class="tab_in"id="AfterCommentHope_content">
                            <div class="img_cover">                            
                                <img src="/resources/image/inventor_profile.jpg" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${currentAnswer.getHope_content()}</textarea>
                        </div>                            
                    </div>
                </div>
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>도면첨부</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt">                    
                         <form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
                            <input type="hidden" name="start_rid_file" value="${start_rid}">
                        <div id="upimgdiv">
                            <input type="file" id="upimg1" name="imgs" accept="image/gif, image/jpeg, image/png">               
                        </div>
                        <button type="button" onclick="addfile()">추가</button>
                        <button type="button" onclick="delfile()">삭제</button>         
                    </div>
                    <div class="tab_imgs">
                         <c:forEach items="${imgs}" var="list" varStatus="status">
                           <div onclick="location.href='${list.getFile_path()}'" id="id${list.getRfid()}">
                            <img src="${list.getFile_path()}">
                        </div>     
                        </c:forEach>                  
                    </div>     
                </div>               
                <div class="hiding_tab">
                    <div class="tab_title">
                        <span>도면에 대한 설명</span>
                        <div class="arrow-up"></div>
                    </div>
                    <div class="tab_contents before_cmt" id="BeforeCommentPicture_explain">
                        <div class="img_cover">                            
                            <img src="/resources/image/inventor_profile.jpg" alt="123">                       
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_effect()}</textarea>
                    </div>             
           
                    <div id="AfterCommentEffect" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getEffect()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
<<<<<<< HEAD
                </div>
                <div class="hr"></div>
<!-- 8. 핵심구성요소 -->
                <div class="txt_box">
                    <h2>핵심구성요소</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentCore_Element" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getCore_element()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentCore_Element" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_core_element()}</textarea>
                    </div>             
           
                    <div id="AfterCommentCore_Element" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getCore_element()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
=======
                    <div class="tab_comment current_cmt">
                        <div class="tab_in" id="CurrentCommentPicture_explain">
                            <div class="img_cover">                            
                                <img src="/resources/image/val1.png" alt="123">
                            </div>
                            <textarea class="disabled" disabled>${beforeReg.getRe_picture_explain()}</textarea>
                        </div>                            
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c
                    </div>
                </div>
                <div class="hr"></div>
<!-- 9.보호받고자 하는 내용 -->
                <div class="txt_box">
                    <h2>권리를 보장받고자 하는 내용</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentHope_content" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getHope_content()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentHope_content" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_hope_content()}</textarea>
                    </div>             
           
                    <div id="AfterCommentHope_content" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getHope_content()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
<<<<<<< HEAD
                <div class="hr"></div>
<!-- 10.도면에 대한 설명 -->
                <div class="txt_box">
                    <h2>도면에 대한 설명</h2> <button>작성 예시</button>
                 
                    <div id="BeforeCommentPicture_explain" class="cmt_field before_cmt">
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getPicture_explain()}</textarea>
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="prev_userImg">
                        </div>
                    </div>             
                    
                    <div id="CurrentPicture_explain" class="cmt_field current_cmt">                        
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="current_userImg">
                        </div>
                        <textarea disabled="disabled" class="disabled"/>${beforeReg.getRe_picture_explain()}</textarea>
                    </div>             
           
                    <div id="AfterCommentPicture_explain" class="cmt_field after_cmt">
                        <div class="img_comt">
                            <img src="/resources/image/inventor3.png" alt="after_userImg">
                        </div> 
                        <textarea  disabled="disabled" class="disabled">${currentAnswer.getPicture_explain()}</textarea>
                    </div>
                    
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
=======
                <div class="fin">
                    <button type ="button" id="tmpAgree">임시저장</button>
                    <button type="button" id="agree">제출</button>
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c
                </div>
                <div class="hr"></div>
<!-- 11. 도면 첨부 -->
                <form id="commentForm" name="commentForm" action="/commentFileSave" method="post" enctype="multipart/form-data">
                                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                
                <input type="hidden" name="userID_file" value="${sessionScope.currentUser.getId()}">
                <input type="hidden" name="start_rid_file" value="${start_rid}">
                   <div class="txt_box">
                            
                  <button class="removeBtn" style="clear:both; margin-top:15px;" type="button" onclick="addFile()">추가</button>
                       <div id="demo_box">
                          <div style="width:100%; float: left;  border-bottom:1px solid #ccc; padding-bottom:50px;">
                          <c:forEach items="${imgs}" var="list" varStatus="status">
                             <div style="width:200px; float:left; margin:20px;">
                                <a href="${list.getFile_path()}" id="id${list.getRfid()}" style="clear:both"><img src="${list.getFile_path()}" style="width:200px; height:200px;"></a>
                                <button class="removeBtn" style="float:left" type="button" id='btn${list.getRfid()}' onclick="delImg('${list.getFile_path()}','id${list.getRfid()}','btn${list.getRfid()}')">삭제</button>
                              </div>                              
                          </c:forEach>
                          </div>                          
                              <div id="inputFileDiv"></div>
                              <!--  
                              <div class="demo">
                                 <input type="file">
                                 <img src="/resources/image/plus.png" alt="plus">
                              </div>
                              -->                                           
                      </div>
                      
                      
                       
                      <div class="hiding_box">
                           <div class="hiding_box_header">
                               <h3>저작물 명칭</h3>
                               <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                           </div>  
                           <div class="hiding_box_content">
                               <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                           </div>                                                   
                       </div>
                   </div>     
                   <div class="hr"></div>           
                   <div id="fin"> 
                      
                       <button type="button" id="tmpSave">임시저장</button>
                       <button type="button" id="agree" >저장</button>                    
                   </div>
               </form>
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
<<<<<<< HEAD
=======
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
$(".tab_title").click(function(){
	if($(this).parent(".hiding_tab").hasClass("tab")){
    	$(this).removeClass("down"); 
	    $(this).parent(".hiding_tab").stop().animate({"max-height":"55px"}).removeClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(180deg)','border-bottom-color':'#036EB7'}).removeClass("tab");
    }else{            
    	$(this).addClass("down"); 
 	    $(this).parent(".hiding_tab").stop().animate({"max-height":"1000px"}).addClass("tab");           
        $(this).children(".arrow-up").stop().css({'transform' : 'rotate(0deg)','border-bottom-color':'#036EB7'}).addClass("tab");
    }
});
>>>>>>> 4e39d813840da8955831149a7868a00d49deca0c
    
</script>
</body>
</html>
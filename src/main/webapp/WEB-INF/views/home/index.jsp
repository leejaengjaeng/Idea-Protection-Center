<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>Idea Protectection Center</title>
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="icon" href="/resources/image/pavicon.png">
<style>
	#header_benner{display:none;}
</style>
</head>
<body>
   <c:import url="/WEB-INF/views/import/header.jsp" />
   <div class="ani">
      <div class="imgs" id="fir_slide"></div>
      <div class="imgs" id="sec_slide"></div>
      <div class="imgs" id="tth_slide"></div>
      <div class="imgs" id="fth_slide"></div>
      <div class="ani_wrap">
         <span style="right: 0;" onclick="btn('right')">&gt;</span> <span
            onclick="btn('left');" id="left_ani">&lt;</span>
         <div id="remote_box">
            <div class="remote" onclick="pro(0)"></div>
            <div class="remote" onclick="pro(1)"></div>
            <div class="remote" onclick="pro(2)"></div>
            <div class="remote" onclick="pro(3)"></div>
         </div>
      </div>
   </div>
   <article style="border-top: 1px solid #ccc;">
      <section>         
         <div id="cont_block1">
            <div class="cont_title">
               <h1>IDEA<br>출원하기</h1>
               <span>
                  아이디어 보호센터에서<br>
                  손쉽고 강력하게<br>
                  아이디어를 보호하세요.
               </span>
            </div>
            <div class="cont_1">
               <div class="regist" onclick="location.href='/registration/addidea'">
                  <div>
                     <p>
                        <b>특허</b><br>
                        출원<br>                        
                     </p>
                     <span>298,000원</span>
                     <button>출원하러가기▶</button>
                  </div>
                  <img src="/resources/image/patent_apply_banner.jpg">
               </div>
               <div class="design" onclick="notready();">
                  <div>
                     <span><b>디자인권</b> 출원</span><br>
                     <span style="font-size:1.5em;">99,000원</span>
                     <button>출원하러가기▶</button>
                  </div>
                  <img src="/resources/image/index_patent_2.jpg">
               </div>
               <div class="brand" onclick="notready();">                  
                  <div class="abb">
                     <span style="font-size:26px; display:inline-block; margin-top:10px;">
                        <b>상표</b> 출원<br>                        
                     </span>
                     <span style="display:inline-block; margin-top:5px; font-size:20px;">
                        55,000원
                     </span><br>
                     <button>출원하러가기▶</button>
                  </div>               
                  <div>
                     <img src="/resources/image/index_patent_3.jpg">
                  </div>
               </div>
               <div class="copyright" onclick="notready();">
                  <div class="abb">
                     <span style="font-size:26px; display:inline-block; margin-top:10px;">
                        <b>저작권</b> 출원<br>                        
                     </span>
                     <span style="display:inline-block; margin-top:5px; font-size:20px;">
                        49,000원
                     </span><br>
                     <button>출원하러가기▶</button>
                  </div>
                  <div>
                     <img src="/resources/image/index_patent_4.jpg">
                  </div>
               </div>
            </div>
         </div>      
      </section>
      <section>         
         <div class="banner">
            <img src="/resources/image/banner.jpg" alt="alt">
            <div class="img_txt">
               <span>
                  <b>아이디어 보호센터</b>에서<br>
                  <b>아이디어</b>를 <b>보호</b>하는 방법!
               </span><br>
               <span id="sp_s">아이디어 보호센터 권리확보 시스템</span><br>
               <button onclick="location.href='/intro_service'">내용보러가기▶</button>
            </div>
         </div>
         <div class="hr"></div>
         <div id="table_notice">
            <h1>공지사항</h1>
            <span>
               아이디어 보호센터의 공지사항과<br>
               정부지원사업에 대한 정보를 확인하세요
            </span>
            <table>
               <tr>
                  <th>No</th>
                  <th style="width:60%;">제목</th>
                  <th>글쓴이</th>
                  <th>작성일</th>
               </tr>
               <c:forEach items="${noticeList}" var="list" varStatus="status">                  
                  <tr onclick="location.href='/notice/noticeList/${list.getNid()}'">
                     <td> ${status.count}</td>
                     <td>${list.getTitle()}</td>
                     <td>관리자</td>
                     <td>${list.getDate()}</td>
                  </tr>                  
               </c:forEach>
               
            </table>
            <button onclick="location.href='/notice/noticePage'">공지사항 확인하러 가기 ▶</button>
         </div>
         <div id="onair">
            <span id="onair_title">실시간 의뢰정보</span><br> <span
               style="line-height: 1.4rem;">아이디어 보호센터는 발명가님들의 여러 아이디어가<br>
               출원될 수 있도록 하는 강력한 파트너입니다.
            </span><br>
            <!-- 
            <button>더보기 ▶</button>                                           
             -->
         </div>
      </section>
   </article>
   <div class="bar">
      <span>${totalUser}명의 발명가님의 ${totalIdea}가지 아이디어와 함께 하고 있습니다</span>
   </div>
   <!-- TODO: 이거 height 어떻게 해야댕..?, height 안주면 너무 넓음 아래  -->
   <div class="val" style="height:250px;">
      <c:forEach items="${current}" var="list" varStatus="status">      
         <div>
            <div class="cover">
               <span>
                  	${list.getName()}님<br>
                  	${list.getType()}
               </span>
            </div>
            <img src="/resources/image/kind1.png" alt="123">
         </div>
      </c:forEach>      
   </div>
   <c:import url="/WEB-INF/views/import/footer.jsp" />
<script src="/resources/common/js/index.js"></script>
</body>
</html>
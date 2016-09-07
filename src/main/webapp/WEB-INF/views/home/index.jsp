<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IdeaProtect</title>
    <link href="/resources/common/css/index.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
</head>
<body>
    <header>
        <div class="header_wrap">
            <ol>
           	<!-- 로그인 하지 않은 유저 -->
           	<sec:authorize access="isAnonymous()">
                <li>
                    <button onclick="location.href='signup/signupPage'" style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#ccc;">
                    	회원가입
                    </button>
                </li>
                <li>
                    <button onclick="location.href='login'" style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                    	로그인
                    </button>
                </li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <li>
                    <button onclick="location.href='#'" style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#ccc;">
                    	<c:out value="${sessionScope.currentUser.getId() }"/>
                    </button>
                </li>
                <li>
                    <button onclick="location.href='/logoutProcess.do'" style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                    	로그아웃
                    </button>
                </li>
            </sec:authorize>
            </ol>
            <div class="header_menu">
                <img src="#" alt="Logo">
                <ul>
                    <li>
                        아이디어 권리확보 시스템
                    </li>
                    <li>
                        이용안내
                    </li>
                    <li>
                        1:1질문하기
                    </li>
                    <li>
                        자주하는 질문모음
                    </li>
                </ul>
            </div>
        </div>
    </header>
    <div class="ani">
        <div class="imgs" id="fir_slide"></div>
        <div class="imgs" id="sec_slide"></div>
        <div class="imgs" id="tth_slide"></div>
        <div class="imgs" id="fth_slide"></div>
        <div class="ani_wrap">
            <span style="right:0;" onclick="btn('right')">&gt;</span>
            <span onclick="btn('left');">&lt;</span>
            <div id="remote_box">
                <div class="remote" onclick="pro(0)"></div>
                <div class="remote" onclick="pro(1)"></div>
                <div class="remote" onclick="pro(2)"></div>
                <div class="remote" onclick="pro(3)"></div>
            </div>
        </div>
    </div>
    <article>
        <section>
            <div id="benner_1">
                <img src="#" alt="benner">
            </div>
            <div id="cont_title1">
                <span id="t_span">아이디어 출원하기</span><br>
                <span>아이디어 보호센터에서 손쉽고 강력하게 아이디어를 보호하세요</span>
            </div>
            <div id="cont_block1">
                <div class="block">
                   <div class="block_inside">
                       <img src="#" alt="img1">
                       <h1><b>특허</b> 출원</h1>      
                       <span>198,000원 우선 출원</span>                          
                   </div>
                   <button class="btn_go">출원하러 가기 &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="#" alt="img2">
                        <h1><b style="color:#72d1f3;">디자인권</b> 출원</h1>      
                        <span>100,000원 우선 출원</span>                          
                    </div>
                    <button class="btn_go">출원하러 가기 &gt;</button>   
                </div>  
                <div class="block">
                   <div class="block_inside">
                       <img src="#" alt="img3">
                       <h1><b style="color:#0066cc;">상표</b> 출원</h1>      
                       <span>150,000원 우선 출원</span>                          
                   </div>
                   <button class="btn_go">출원하러 가기 &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="#" alt="img4">
                        <h1><b style="color:#45d7c2;">저작권</b> 출원</h1>      
                        <span>50,000원 등록 보장</span>                          
                    </div>
                    <button class="btn_go">출원하러 가기 &gt;</button>   
                </div>                
            </div>
            <div id="cont_title2">
                <span id="notice">공지사항</span><br>
                <span>아이디어 보호센터의 공지사항과 정부지원사업에 대한 정보를 확인하세요</span>
            </div>                        
            <div id="table_notice">
               <table>
                    <tr>
                        <td style="text-align:left;">
                            아이디어 보호센터에서 아이디어를 보호하는 방법안내
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>                    
                    <tr>
                        <td style="text-align:left;">
                            아이디어 보호센터에서 아이디어를 보호하는 방법안내
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                    <tr>
                        <td style="text-align:left;">
                            아이디어 보호센터에서 아이디어를 보호하는 방법안내
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>                    
                    <tr>
                        <td style="text-align:left;">
                            아이디어 보호센터에서 아이디어를 보호하는 방법안내
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                    <tr>
                        <td style="text-align:left;">
                            아이디어 보호센터에서 아이디어를 보호하는 방법안내
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                </table>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                        더보기
                </button>
            </div>
            <div id="cont_title3">
                <span id="onair_title">실시간 의뢰정보</span><br>
                <span>아이디어 보호센터는 발명가님들의 여러 아이디어가 출원될 수 있도록 하는 강력한 파트너입니다.</span>
            </div>
            <div id="onair">
                <div id="onair_who">
                    <table>
                        <tr>                            
                            <td style="text-align:left;">걸어다니는 코딩기계</td>
                            <td>2016.09.06</td>
                            <td>김**님</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">걸어다니는 코딩기계</td>
                            <td>2016.09.06</td>
                            <td>김**님</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">걸어다니는 코딩기계</td>
                            <td>2016.09.06</td>
                            <td>김**님</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">걸어다니는 코딩기계</td>
                            <td>2016.09.06</td>
                            <td>김**님</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">걸어다니는 코딩기계</td>
                            <td>2016.09.06</td>
                            <td>김**님</td>
                        </tr>
                    </table>
                </div>
                <div id="onair_count">
                    <div id="center_box">
                        <span>00명의 발명가님의</span><br>
                        <span>00가지 아이디어와</span><br>
                        <span>함께 하고 있습니다</span><br>
                    </div>
                </div>
            </div>
        </section>
    </article> 
    <footer>
        <div id="footer_benner">
            <div id="footer_benner_wrap">
                <img src="#" alt="benner1">
                <img src="#" alt="benner2">
                <img src="#" alt="benner3">
                <img src="#" alt="benner4">
                <img src="#" alt="benner5">
                <img src="#" alt="benner6">
            </div>            
        </div>
        <div id="footer_fill">
            <div id="footer_wrap">
                <div id="footer_left">
                    <ul>                        
                       <li><a href="#">이용안내</a> &nbsp;| </li> 
                       <li><a href="#">오시는 길</a> &nbsp;| </li> 
                       <li><a href="#">상담예약</a> &nbsp;| </li> 
                       <li><a href="#">워크샵 안내</a></li> 
                    </ul><br>
                    <ul id="small_ul">                        
                       <li><a href="#">이용약관</a> &nbsp;| </li> 
                       <li><a href="#">개인정보 보호방침</a> &nbsp;| </li> 
                       <li><a href="#">이메일 수집거부</a></li> 
                    </ul><br>
                    <span>
                        COPYRIGHT 2016 @ IDEAPROTECTIONCENTER ALL RIGHTS RESERVED
                    </span>                   
                </div>
                <div id = "footer_center">
                    <img src="#" alt="Logo">
                </div>
                <div id = "footer_right">
                    <span>
                        경기창조경제혁신센터 5층<br>
                        경기도 성남시 분당구 대왕판교로 635번길 12<br>
                        Tel : 010-3302-7000<br>
                        mail : ideaconcert@naver.com
                    </span>
                </div>
            </div>            
        </div>
    </footer>   
<script>
    var now=0;
        
		//현재첫번째 이미지의 나머지를 숨김
<<<<<<< HEAD:src/main/webapp/WEB-INF/views/home/index.jsp
=======

>>>>>>> 410ee18e5e9485043c05a67fca66b4bb5c21617c:src/main/webapp/WEB-INF/views/index.jsp
		$(".imgs").eq(now).siblings(".imgs").hide();
		start();
		$(".remote").eq(now).css("background-color","#ccc");
		
		function start(){
			time = setInterval(function(){
			$(".imgs").eq(now).fadeOut(1000);
			$(".imgs").eq(now=now==3?0:now+1).fadeIn(1000);
			$(".remote").eq(now).css("background-color","#ccc");
			$(".remote").eq(now).siblings(".remote").css("background-color","#fff");
			},8000);
		}
		
		function end(){
			clearInterval(time)	
		}
		
		//버튼
		function btn(type){
			if($(".imgs").is(":animated")){return}else{
			end();
			switch(type){
				case"right":
					$(".imgs").eq(now).fadeOut(1000);
					$(".imgs").eq(now=now==3?0:now+1).fadeIn(1000);
					$(".remote").eq(now).css("background-color","#ccc");
					$(".remote").eq(now).siblings(".remote").css("background-color","#fff");
				break;
				case"left":
					$(".imgs").eq(now).fadeOut(2000);
					$(".imgs").eq(now=now==0?3:now-1).fadeIn(1000);
					$(".remote").eq(now).css("background-color","#ccc");
					$(".remote").eq(now).siblings(".remote").css("background-color","#fff");
				break;
			}
			start();
			}
		}
		//밑에 상태버튼
		function pro(divno){
            if($(".imgs").is(":animated")){return}else{
                end();
                $(".imgs").eq(now).fadeOut(1000);
                $(".imgs").eq(now=divno).fadeIn(1000);
                $(".remote").eq(now).css("background-color","#ccc");
                $(".remote").eq(now).siblings(".remote").css("background-color","#fff");
                start();
            }
		}
</script>    
</body>
</html>

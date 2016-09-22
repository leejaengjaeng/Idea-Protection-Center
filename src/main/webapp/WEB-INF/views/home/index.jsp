<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
    <title>IdeaProtect</title>
    <script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="/resources/common/css/index.css">
    <link rel="stylesheet" href="/resources/common/css/style.css">
    <style>
    	#header_benner{
    		display: none;
    	}
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
       
    <div class="ani">
        <div class="imgs" id="fir_slide"></div>
        <div class="imgs" id="sec_slide"></div>
        <div class="imgs" id="tth_slide"></div>
        <div class="imgs" id="fth_slide"></div>
        <div class="ani_wrap">
            <span style="right:0;" onclick="btn('right')">&gt;</span>
            <span onclick="btn('left');" id="left_ani">&lt;</span>
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
                <img src="/resources/image/main_banner.jpg" alt="benner">
                <button>내용 보러가기</button>
            </div>
            <div id="cont_title1">
                <span id="t_span">아이디어 출원하기</span><br>
                <span>아이디어 보호센터에서 손쉽고 강력하게 아이디어를 보호하세요</span>
            </div>
            <div id="cont_block1">
                <div class="block">
                   <div class="block_inside">
                       <img src="/resources/image/index_patent_1.jpg" alt="img1">
                       <h1><b>특허</b> 출원</h1>      
                       <span>198,000원 출원</span>                          
                   </div>
                   <button class="btn_go" onclick='location.href="/registration/addidea"'>출원하러 가기 &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="/resources/image/index_patent_3.jpg" alt="img2">
                        <h1><b style="color:#72d1f3;">디자인권</b> 출원</h1>      
                        <span>100,000원 출원</span>                          
                    </div>
                    <button class="btn_go">출원하러 가기 &gt;</button>   
                </div>  
                <div class="block">
                   <div class="block_inside">
                       <img src="/resources/image/index_patent_2.jpg" alt="img3">
                       <h1><b style="color:#0066cc;">상표</b> 출원</h1>      
                       <span>150,000원 출원</span>                          
                   </div>
                   <button class="btn_go">출원하러 가기 &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="/resources/image/index_patent_4.jpg" alt="img4">
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
                    <c:forEach items="${noticeList}" var="list" varStatus="status">
    					<tr onclick="location.href='/noticeList/${list.getNid()}'">
			    		
			    			<td>${list.getTitle()}</td>
			    			<td>${list.getDate()}</td>
			    			<td>관리자</td>
			    		</tr>
					</c:forEach>          
                    
                </table>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                        더보기
                </button>
            </div>
            <div id="cont_title3">
                <span id="onair_title">실시간 의뢰정보</span><br>
                <span style="line-height:1.4rem;">아이디어 보호센터는 발명가님들의 여러 아이디어가<br> 출원될 수 있도록 하는 강력한 파트너입니다.</span>
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
    <c:import url="/WEB-INF/views/import/footer.jsp"/>       
<script>
    var now=0;
        
		//현재첫번째 이미지의 나머지를 숨김
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
					$(".imgs").eq(now).fadeOut(1000);
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
            if($(".imgs").is(":animated") || now == divno){return}else{
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

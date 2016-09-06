<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IdeaProtect</title>
    <link href="/resources/common/css/index.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
</head>
<body>
    <header>
        <div class="header_wrap">
            <ol>
                <li>
                    <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#ccc;">
                        íìê°ì
                    </button>
                </li>
                <li>
                    <button onclick="location.href='/signup/signupPage'" style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                        ë¡ê·¸ì¸
                    </button>
                </li>
            </ol>
            <div class="header_menu">
                <img src="#" alt="Logo">
                <ul>
                    <li>
                        ìì´ëì´ ê¶ë¦¬íë³´ ìì¤í
                    </li>
                    <li>
                        ì´ì©ìë´
                    </li>
                    <li>
                        1:1ì§ë¬¸íê¸°
                    </li>
                    <li>
                        ìì£¼íë ì§ë¬¸ëª¨ì
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
                <span id="t_span">ìì´ëì´ ì¶ìíê¸°</span><br>
                <span>ìì´ëì´ ë³´í¸ì¼í°ìì ìì½ê³  ê°ë ¥íê² ìì´ëì´ë¥¼ ë³´í¸íì¸ì</span>
            </div>
            <div id="cont_block1">
                <div class="block">
                   <div class="block_inside">
                       <img src="#" alt="img1">
                       <h1><b>í¹í</b> ì¶ì</h1>      
                       <span>198,000ì ì°ì  ì¶ì</span>                          
                   </div>
                   <button class="btn_go">ì¶ìíë¬ ê°ê¸° &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="#" alt="img2">
                        <h1><b style="color:#72d1f3;">ëìì¸ê¶</b> ì¶ì</h1>      
                        <span>100,000ì ì°ì  ì¶ì</span>                          
                    </div>
                    <button class="btn_go">ì¶ìíë¬ ê°ê¸° &gt;</button>   
                </div>  
                <div class="block">
                   <div class="block_inside">
                       <img src="#" alt="img3">
                       <h1><b style="color:#0066cc;">ìí</b> ì¶ì</h1>      
                       <span>150,000ì ì°ì  ì¶ì</span>                          
                   </div>
                   <button class="btn_go">ì¶ìíë¬ ê°ê¸° &gt;</button>           
                </div>
                <div class="block" style="margin-left:20px;">                    
                    <div class="block_inside">
                        <img src="#" alt="img4">
                        <h1><b style="color:#45d7c2;">ì ìê¶</b> ì¶ì</h1>      
                        <span>50,000ì ë±ë¡ ë³´ì¥</span>                          
                    </div>
                    <button class="btn_go">ì¶ìíë¬ ê°ê¸° &gt;</button>   
                </div>                
            </div>
            <div id="cont_title2">
                <span id="notice">ê³µì§ì¬í­</span><br>
                <span>ìì´ëì´ ë³´í¸ì¼í°ì ê³µì§ì¬í­ê³¼ ì ë¶ì§ìì¬ìì ëí ì ë³´ë¥¼ íì¸íì¸ì</span>
            </div>                        
            <div id="table_notice">
               <table>
                    <tr>
                        <td style="text-align:left;">
                            ìì´ëì´ ë³´í¸ì¼í°ìì ìì´ëì´ë¥¼ ë³´í¸íë ë°©ë²ìë´
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>                    
                    <tr>
                        <td style="text-align:left;">
                            ìì´ëì´ ë³´í¸ì¼í°ìì ìì´ëì´ë¥¼ ë³´í¸íë ë°©ë²ìë´
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                    <tr>
                        <td style="text-align:left;">
                            ìì´ëì´ ë³´í¸ì¼í°ìì ìì´ëì´ë¥¼ ë³´í¸íë ë°©ë²ìë´
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>                    
                    <tr>
                        <td style="text-align:left;">
                            ìì´ëì´ ë³´í¸ì¼í°ìì ìì´ëì´ë¥¼ ë³´í¸íë ë°©ë²ìë´
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                    <tr>
                        <td style="text-align:left;">
                            ìì´ëì´ ë³´í¸ì¼í°ìì ìì´ëì´ë¥¼ ë³´í¸íë ë°©ë²ìë´
                        </td>
                        <td>2016.09.06</td>
                        <td>Admin</td>                                               
                    </tr>
                </table>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;">
                        ëë³´ê¸°
                </button>
            </div>
            <div id="cont_title3">
                <span id="onair_title">ì¤ìê° ìë¢°ì ë³´</span><br>
                <span>ìì´ëì´ ë³´í¸ì¼í°ë ë°ëªê°ëë¤ì ì¬ë¬ ìì´ëì´ê° ì¶ìë  ì ìëë¡ íë ê°ë ¥í íí¸ëìëë¤.</span>
            </div>
            <div id="onair">
                <div id="onair_who">
                    <table>
                        <tr>                            
                            <td style="text-align:left;">ê±¸ì´ë¤ëë ì½ë©ê¸°ê³</td>
                            <td>2016.09.06</td>
                            <td>ê¹**ë</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">ê±¸ì´ë¤ëë ì½ë©ê¸°ê³</td>
                            <td>2016.09.06</td>
                            <td>ê¹**ë</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">ê±¸ì´ë¤ëë ì½ë©ê¸°ê³</td>
                            <td>2016.09.06</td>
                            <td>ê¹**ë</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">ê±¸ì´ë¤ëë ì½ë©ê¸°ê³</td>
                            <td>2016.09.06</td>
                            <td>ê¹**ë</td>
                        </tr>
                        <tr>                            
                            <td style="text-align:left;">ê±¸ì´ë¤ëë ì½ë©ê¸°ê³</td>
                            <td>2016.09.06</td>
                            <td>ê¹**ë</td>
                        </tr>
                    </table>
                </div>
                <div id="onair_count">
                    <div id="center_box">
                        <span>00ëªì ë°ëªê°ëì</span><br>
                        <span>00ê°ì§ ìì´ëì´ì</span><br>
                        <span>í¨ê» íê³  ììµëë¤</span><br>
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
                       <li><a href="#">ì´ì©ìë´</a> &nbsp;| </li> 
                       <li><a href="#">ì¤ìë ê¸¸</a> &nbsp;| </li> 
                       <li><a href="#">ìë´ìì½</a> &nbsp;| </li> 
                       <li><a href="#">ìí¬ìµ ìë´</a></li> 
                    </ul><br>
                    <ul id="small_ul">                        
                       <li><a href="#">ì´ì©ì½ê´</a> &nbsp;| </li> 
                       <li><a href="#">ê°ì¸ì ë³´ ë³´í¸ë°©ì¹¨</a> &nbsp;| </li> 
                       <li><a href="#">ì´ë©ì¼ ìì§ê±°ë¶</a></li> 
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
                        ê²½ê¸°ì°½ì¡°ê²½ì íì ì¼í° 5ì¸µ<br>
                        ê²½ê¸°ë ì±ë¨ì ë¶ë¹êµ¬ ëìíêµë¡ 635ë²ê¸¸ 12<br>
                        Tel : 010-3302-7000<br>
                        mail : ideaconcert@naver.com
                    </span>
                </div>
            </div>            
        </div>
    </footer>   
<script>
    var now=0;
        
		//íì¬ì²«ë²ì§¸ ì´ë¯¸ì§ì ëë¨¸ì§ë¥¼ ì¨ê¹

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
		
		//ë²í¼
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
		//ë°ì ìíë²í¼
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
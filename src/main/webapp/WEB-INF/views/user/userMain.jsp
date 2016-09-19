<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/inventor.css">

<script>
//js파일 밖으로 빼기 
$(document).ready(function()
{
	$('.ideaList').on("click",(function()
	{
		var r = $(this).children('input').attr('value');
		location.href="/detail/"+r;
	}));
});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="hide_menu">
	<img src="/resources/image/hide_menu.png" alt="ham">	
</div>
<div id="hide_nav">
	<div id="hide_nav_cont">
	    <div id="profile">
	        <img src="#" alt="profile">
	        <h4>${currentUser.getName() }</h4>
	        <span>ideaconcert</span>
	    </div>
	    <div id="profile_menu">
	        <ul style="padding-left:0;">
	            <li>회원정보수정</li>
	            <li>1:1질문하기</li>
	            <li>아이디어 진행내역</li>
	            <li>임시저장함</li>
	            <li>결제대기</li>
	            <li>결제내역</li>
	        </ul>
	    </div>	    
	</div>
</div>
<div id="inven">
    <div id="inven_wrap">
        <nav>
            <div id="profile">
                <img src="/resources/image/attonrney_profile.jpg" alt="profile">
                <h4>${currentUser.getName() }</h4>
                <span>ideaconcert</span>
            </div>
            <div id="profile_menu">
                <ul style="padding-left:0;">
                    <li>회원정보수정</li>
                    <li>1:1질문하기</li>
                    <li>아이디어 진행내역</li>
                    <li>임시저장함</li>
                    <li>결제대기</li>
                    <li>결제내역</li>
                </ul>
            </div>
            <div id="nav_benner">
                <ul style="padding-left:0;">
                    <li>
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
        <article>
            <section id="msg_section">
                <div id="now_count">
                    <h2>
			                    현재까지 진행중인<br>
			                    아이디어 00건,<br>
			                    완료 00건이 있습니다.
                    </h2>
                </div>
                <div id="now_msg">
                    <table>
                        <tr>
                            <td>
                                "아이디어 손잡이"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="/resources/image/message.png" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="/resources/image/message new.png" alt="msg">     
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                            	<img src="/resources/image/message.png" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="/resources/image/message.png" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="/resources/image/message.png" alt="msg">                                
                            </td>      
                        </tr>
                    </table>
                </div>
            </section>
            <div id="cont_header">
                <h2>아이디어 진행내역</h2>
            </div>
            <div id="cont_table">
                <ol>
                    <li style="font-size:1.3rem; font-weight:bold;">분류</li>
                    <li>                        
                        <select>
                            <option>전체</option>                            
                            <option>특허</option>   
                            <option>디자인권</option>   
                            <option>상표</option>                            
                            <option>저작권</option>                            
                        </select>
                    </li>
                    <li style="font-size:1.3rem; font-weight:bold;">상태</li>
                    <li>                        
                        <select>
                            <option>전체</option>                            
                            <option>전문가 지정</option>   
                            <option>컨설팅</option>   
                            <option>변리사 검토</option>                            
                            <option>가출원중</option>                            
                            <option>가출원완료</option>                            
                        </select>
                    </li>
                </ol>
                <table>
                    <tr>
                        <th>번호</th>
                        <th>등록날짜</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>상태</th>
                        <th>가출원일</th>
                        <th>출원일</th>
                        <th>비고</th>
                    </tr>
                   	<c:forEach var="process" items="${processList }">
						<tr class="ideaList">
							<input type="hidden" value="${process.getRid()}"/>
							<td style="background:#f1f1f1;">0</td>
	                        <td>${process.getRegistration_date() }</td>
	                        <td>${process.getTypeOfInvent() }</td>
	                        <td>${process.getTitle()}</td>
	                        <td>${process.getR_condition() }</td>
	                        <td>${process.getPre_apply_date() }</td>
	                        <td>${process.getApply_date() }</td>
	                        <td>-</td>
						</tr>
					</c:forEach>
                </table>
                <div id="paging_btn">
                    <span>
                       <
                    </span>
                    <span>
                       1 2 3 4 
                    </span>
                    <span>
                       >
                    </span>
                </div>
                <div id="notice_title">
                    <h2>공지사항</h2>
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
            </div>
        </article>
    </div>    
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
	$("#hide_menu").click(function(){
		$("#hide_nav").animate({width:"200px"});		
	});
	$(document).click(function(e){
		if($('#hide_nav').css('width') == '200px'){
			if($("#hide_nav").has(e.target).length == 0){
				$('#hide_nav').animate({width:"0"});
			}
		}
	});
</script>
</body>
</html>
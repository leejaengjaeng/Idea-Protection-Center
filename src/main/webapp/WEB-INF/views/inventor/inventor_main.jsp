<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/inventor.css">
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="inven">
    <div id="inven_wrap">
        <nav>
            <div id="profile">
                <img src="#" alt="profile">
                <h4>OOO 회원님</h4>
                <span>ideaconcert</span>
            </div>
            <div id="profile_menu">
                <ul>
                    <li>회원정보수정</li>
                    <li>1:1질문하기</li>
                    <li>아이디어 진행내역</li>
                    <li>임시저장함</li>
                    <li>결제대기</li>
                    <li>결제내역</li>
                </ul>
            </div>
            <div id="nav_benner">
                <ul>
                    <li>
                        <img src="#" alt="benner1">
                    </li>
                    <li>
                        <img src="#" alt="benner2">
                    </li>
                    <li>
                        <img src="#" alt="benner3">
                    </li>
                    <li>
                        <img src="#" alt="benner4">
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
                                <img src="#" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="#" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="#" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="#" alt="msg">                                
                            </td>      
                        </tr>
                        <tr>
                            <td>
                                "제목"<br>
                                에 대해 컨설턴트,변리사가 지정되었습니다.
                            </td>                  
                            <td>
                                <img src="#" alt="msg">                                
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
                    <tr>
                        <td style="background:#f1f1f1;">10</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">09</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">08</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">07</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">06</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">05</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">04</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">03</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">02</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td style="background:#f1f1f1;">01</td>
                        <td>16.09.07</td>
                        <td>저작권</td>
                        <td>발명가의 권리를 위한 아이디어 보호센터의...</td>
                        <td>변리사 검토</td>
                        <td>16.05.30</td>
                        <td>D-100</td>
                        <td>-</td>
                    </tr>
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
</body>
</html>
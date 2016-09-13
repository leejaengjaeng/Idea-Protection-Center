<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>management</title>
    <link href="/resources/common/css/admin.css" rel="stylesheet">
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>
</head>
<body>
    <header>        
        <img src="image/ideapc_logo.jpg" alt="logo">
        <div id="header_info">
            <span><b>Admin</b>님</span>
            <button>로그아웃</button>
        </div>        
    </header>
    <div id="admin_cont">
        <nav>
            <ul>
                <li>회원관리</li>
                <li>아이디어 관리</li>
                <li>문의사항 관리</li>
                <li>게시판 관리</li>
            </ul>  
        </nav>
        <article>
            <div id="table_header">
                <h1>아이디어 관리</h1>
                <div id="select_management">
                    <select>
                        <option>전체분류</option>
                    </select>
                    <select>
                        <option>전체상태</option>
                    </select>
                    <input type="text">
                    <button>검색</button>
                </div>
            </div>
            <table class="manage_table">
                <tr>
                    <th style="width:50px;">No</th>
                    <th>사용자</th>
                    <th style="width:100px;">이름</th>
                    <th style="width:100px;">지정변리사</th>
                    <th>이메일</th>                    
                    <th>연락처</th>
                    <th>분류</th>
                    <th style="width:280px;">제목</th>
                    <th>진행상태</th>
                   <!--   <th style="width:120px;">수정</th> -->
                </tr>
                <c:forEach items="${ideaList }" var="list" varStatus="status">
	                <tr>
	                	<input type="hidden" value="${list.getRid() }"/>
	                    <td>${status.count}</td>
	                    <td>${list.getiId()}</td>
	                    <td>${list.getiName()}</td>

	                    <!-- pName 없으면 선택하게 버튼나오도록 -->
	                    <td>${list.getpName()}</td>

	                    <td>${list.getEmail()}</td>
	                    <td>${list.getPhone()}</td>
	                    <td>${list.getTypeofinvent()}</td>
	                    <td>${list.getTitle()}</td>
	                    <td>${list.getR_condition()}</td>
	                   <!--   <td><button>정보수정</button></td> -->
	                </tr>	
	            </c:forEach>
            </table>
            <span>< 1 2 3 4 ></1></span>
        </article>
    </div>
<footer>
    <div id="admin_footer">
        <span>COPYRIGHT 2016 @ IDEAPROTECTIONCENTER ALL RIGHTS RESERVED</span>
    </div>
</footer>     
<script>
    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
</script>
</body>
</html>

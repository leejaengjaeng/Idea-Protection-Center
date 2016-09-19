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
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <script src="/resources/common/js/jquery-3.1.0.min.js"></script>
    <style>
body{
    height: 100% !important;        
}
.black_wall{
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.7);
    position:fixed;    
    z-index:98;
}    
    .popup{
        width: 400px;
        height: 200px;
        background:#fff;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        -moz-transform: translate(-50%,-50%);
        -webkit-transform: translate(-50%,-50%);
        box-shadow: 0 0 10px 0 #000;                
        position: fixed;        
        z-index: 99;
    }
    .pop_header{
        width: 100%;
        float: left;
        background: #696969;
        color: white;
        padding: 10px;    
        box-shadow:0 0 5px 0 #000;
    }
    .pop_header>h2{
        display: block;
        float: left;
        font-size: 1rem;
        margin: 5px;
    }
    .pop_header>img{
        width: 25px;
        float: right;
    }
    .pop_cont{
        width: 100%;
        float: left;
        text-align: center;
        padding: 20px;
        padding-top: 30px;
    }
    .pop_cont>span{
        color: #595959;
        font-size: 0.9;
        display: inline-block;
        width: 100%;
    }
    .pop_cont button{
        width: 100px; 
        height: 35px;    
        margin:25px 5px 0 5px;
        background: none;
        border: none;
        box-shadow: inset 0 -4px rgba(0, 0, 0, .1);
        color: white;        
    }
    .popup_close{
        cursor: pointer;
    }
 
</style>
    <script>
    var RegisId;
    var buttonId;
    var pId;
    function giveLawyer(rid,btnid,pid){
    	//alert("aa");
    	RegisId=rid;
    	buttonId=btnid;
    	pId=pid;
    	document.getElementById("bw").style.visibility="visible";
		document.getElementById("pp").style.visibility="visible";
    }
    function assign(uid){
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["uid"] = uid;
        data["rid"]=RegisId;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/assign",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	alert(pId);
    	    	var element = document.getElementById(buttonId);
    	    	element.parentNode.removeChild(element);
    	    	var inDiv=document.getElementById(pId);
    	    	inDiv.innerHTML="<p>"+data.lawyerName+"</p>";
    	        document.getElementById("bw").style.visibility="hidden";
        		document.getElementById("pp").style.visibility="hidden";
        		
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
    </script>
</head>
<body>
<div class="black_wall" id="bw" style="visibility:hidden"></div>
<div class="popup" id="pp" style="visibility:hidden">
   	<div class="pop_header">            
       	<h2 style="color:#f9f9f9">아이디어 보호센터</h2>
       	<img src="/resources/image/close.png" alt="close" class="popup_close" onclick="closeload()" id="close">
    </div>
    <div class="pop_cont">            
       	<span>변리사를 지정하세요</span>
       	<table>
       	<tr>
       		<td>아이디</td>
       		<td>이름</td>
       		<td>이메일</td>
       	</tr>
       	<c:forEach items="${lawyerList}" var="lawlist" varStatus="status">
       		<tr>
       			<td>${lawlist.getId()}</td>
       			<td>${lawlist.getName()}</td>
       			<td>${lawlist.getEmail()}</td>
       			<td><button onclick="assign('${lawlist.getUid()}')">지정</button><td>
       		</tr>
       	</c:forEach>
       	</table>
    </div>
</div>
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
	                    <c:choose>
	                    	<c:when test="${list.getpName()==null}">
	                    		<td><div id="p${status.count}"></div><button id="btn${status.count}" onclick="giveLawyer('${list.getRid()}','btn${status.count}','p${status.count}')">지정</button></td>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<td>${list.getpName()}</td>
	                    	</c:otherwise>
	                    </c:choose>
	                    
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

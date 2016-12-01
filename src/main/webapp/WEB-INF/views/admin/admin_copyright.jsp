<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script>
    var copyrightId;
    var buttonId;
    var pId;
    
    function giveLawyer(cid,btnid,pid)
    {
    	copyrightId=cid;
    	buttonId=btnid;
    	pId=pid;
    	document.getElementById("bw").style.visibility="visible";
		document.getElementById("pp").style.visibility="visible";
    }
    
    function assign(plId)
    {
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["plId"] = plId;
        data["cid"]  = copyrightId;
        headers[csrfHeader] = csrfToken;

        $.ajax({
    	    url : "/IPC_admin/assignCopyright",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	
    	    	var element = document.getElementById(buttonId);
    	    	element.parentNode.removeChild(element);
    	    	var inDiv=document.getElementById(pId);
    	    	inDiv.innerHTML="<p>"+data.plName+"</p>";
    	    	document.getElementById("bw").style.visibility="hidden";
        		document.getElementById("pp").style.visibility="hidden";
        		
        		$('#admin_copyright_condition').text(data.condition);
    	    },
    	    error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"error:"+error);
    	    }
    	 
    	}); 
    }
    function closeload()
    {
    	document.getElementById("bw").style.visibility="hidden";
		document.getElementById("pp").style.visibility="hidden";
    }
    /*
    function viewLawyer(uid){
    	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
    	var csrfToken = $("meta[name='_csrf']").attr("content"); 
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
    	var data = {};
    	var headers = {};
    	data[csrfParameter] = csrfToken;
        data["uid"] = uid;
        headers[csrfHeader] = csrfToken;
        $.ajax({
    	    url : "/IPC_admin/viewLawyer",
    	    dataType : "json",
    	    type : "POST",
    	    headers: headers,
    	    data : data,
    	    success: function(data) {
    	    	alert("이름 : "+data.name+"\n"+
    	    			"아이디 : "+data.ID+"\n"+
    	    			"전문분야 : "+data.major+"\n"+
    	    			"소개 : "+data.introduce+"\n"+
    	    			"이메일 : "+data.email);
    	    },
    	    error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"error:"+error);
    	    }
    	 
    	}); 
    }
    */
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
	       		<td>지정</td>
	       	</tr>
	       	<c:forEach items="${lawyerList}" var="lawlist" varStatus="status">
	       		<tr>
	       			<td>${lawlist.getId()}</td>
	       			<!-- <td onclick="viewLawyer('${lawlist.getUid()}')">${lawlist.getName()}</td> -->
	       			<td>${lawlist.getName()}</td>
	       			<td>${lawlist.getEmail()}</td>
	       			<td><button onclick="assign('${lawlist.getUid()}')">지정</button><td>
	       		</tr>
	       	</c:forEach>
	       	</table>
	    </div>
	</div>
    <c:import url="/WEB-INF/views/import/admin_header.jsp" />
        <article>
            <div id="table_header">
                <h1>저작권 관리</h1>
            </div>
            <table class="manage_table" style="margin-bottom:20px; ">
                <tr>
                    <th>사용자</th>
                    <th style="width:100px;">이름</th>
                    <th style="width:130px;">지정변리사</th>
                    <th>이메일</th>                    
                    <th style="width:280px;">제목</th>
                    <th>진행상태</th>
                </tr>
                <c:forEach items="${copyrightList }" var="copy" varStatus="status">
	                <tr>
	                	<input type="hidden" value="${copy.getCid() }"/>
	                    <td>${copy.getId()}</td>
	                    <td >${copy.getInventor_name()}</td>
						
	                    <!-- pName 없으면 선택하게 버튼나오도록 -->
	                    <c:choose>
	                    	<c:when test="${copy.getPl_name()==null}">
	                    		<td><div id="p${status.count}"></div><button id="btn${status.count}" onclick="giveLawyer('${copy.getCid()}','btn${status.count}','p${status.count}')">지정</button></td>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<td>${copy.getPl_name()}</td>
	                    	</c:otherwise>
	                    </c:choose>	                   
	                    <td>${copy.getEmail()}</td>
	                    <td>${copy.getTitle()}</td>
	                    <td id="admin_copyright_condition">${copy.getReg_condition()}</td>
	                </tr>		               
	            </c:forEach>
            </table>     
            
		</article>
	</div>       
 <c:import url="/WEB-INF/views/import/admin_footer.jsp" />
<script>
    $(document).ready(function(){
      $('.manage_table tr:even').css("backgroundColor","#fff");     // odd 홀수
      $('.manage_table tr:odd').css("backgroundColor","#f5f5fc");   // even 짝수
    }); 
</script>
</body>
</html>

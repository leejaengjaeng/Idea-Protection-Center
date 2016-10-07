<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>

<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/index.css">
<title>Insert title here</title>
<style>
body{
    height: 100% !important;  
    overflow:auto;
}
.black_wall{
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.7);
    position:fixed;    
    z-index:98;
    display: none;
}    
    .popup{
        width: 600px;
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
        display: none;
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
        background: #333;
        border: none;
        box-shadow: inset 0 -4px rgba(0, 0, 0, .1);
        color: white;        
    }
    .popup_close{
        cursor: pointer;
    }
    .pop_cont table{
    	margin-top:30px;
    	width:100%;
    }
    .pop_cont table tr td{
    	height:50px;
    }
    .pop_cont table tr td button{
    	margin:0;
    }
    .pop_cont table tr:nth-child(1){
		border-top:1px solid #ccc;
		border-bottom:1px solid #ccc;    
    }
 
</style>
</head>
<body>
<div class="black_wall" id="bw"></div>
<div class="popup" id="pp">
   	<div class="pop_header">            
       	<h2 style="color:#f9f9f9">아이디어 보호센터</h2>
       	<img src="/resources/image/close.png" alt="close" class="popup_close" onclick="closeload()" id="close">
    </div>
    <div class="pop_cont">            
       	
    </div>
</div>
<c:import url="/WEB-INF/views/import/header.jsp" />
<div id="wrap_form">
    <DIV style="width:100%; float:left; margin-top:100px; margin-bottom:100px;">
        <h1>아이디 & 비밀번호 찾기</h1>
        <div style="width:100%; float:left; margin-top:50px;">            
            <div class="half">
                <div>
                    <h3 style="margin-top:50px; color:#555;">아이디 찾기 </h3>
                    <form>
                        <input name="nameLostId"  placeholder="이름">
                        <input name="emailLostId" placeholder="이메일">
                        <button>아이디찾기</button>
                    </form>
                    
                </div>
            </div>
            <div class="half">
                <div>                                        
                    <h3 style="margin-top:50px; color:#555;">비밀번호 찾기 </h3>
                    <form>
                        <input name="nameLostPw"  placeholder="아이디">
                        <input name="emailLostPw" placeholder="이메일">
                        <button>비밀번호찾기</button>
                    </form>
                </div>
            </div>
        </div>
    </DIV>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp" />
<script>
	$(".popup_close").click(function(){
		$(".black_wall , .popup").css("display","none");
		$("body").css("overflow","auto");	

	});
	$(".half button").click(function(){
		$(".black_wall , .popup").css("display","block");
		$("body").css("overflow","hidden");	
	});
</script>
</body>
</html>
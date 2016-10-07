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
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp" />
<div id="wrap_form">
    <DIV style="width:100%; float:left; margin-top:100px; margin-bottom:100px;">
        <h1>아이디 & 비밀번호 찾기</h1>
        <div style="width:100%; float:left; margin-top:50px;">            
            <div class="half">
                <div>
                    <h3 style="margin-top:50px; color:#555;">아이디 찾기 </h3>
                    <form>
                        <input placeholder="이름">
                        <input placeholder="이메일">
                        <button>아이디찾기</button>
                    </form>
                    
                </div>
            </div>
            <div class="half">
                <div>                                        
                    <h3 style="margin-top:50px; color:#555;">비밀번호 찾기 </h3>
                    <form>
                        <input placeholder="아이디">
                        <input placeholder="이메일">
                        <button>비밀번호찾기</button>
                    </form>
                </div>
            </div>
        </div>
    </DIV>
</div>
<c:import url="/WEB-INF/views/import/footer.jsp" />
</body>
</html>
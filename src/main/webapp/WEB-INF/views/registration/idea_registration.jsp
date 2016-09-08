<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet"
	href="/webjars/bootstrap/3.3.7/dist/css/bootstrap.min.css">
<script src="/webjars/jquery/3.1.0/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">
        <section>            
            <article class="sub_head">                    
                <h1><b>특허</b>등록</h1>                
            </article>                
            <article>
                <div class="txt_box">
                    <h2>발명분야</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_kind">
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_title">
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>                    
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>요약</h2>
                    <button>작성예시 보기</button>
                    <textarea id="small_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>                
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>필요이유</h2>
                    <button>작성예시 보기</button>
                    <textarea id="why_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2>
                    <button>작성예시 보기</button>
                    <textarea id="col_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>문제해결방법</h2>
                    <button>작성예시 보기</button>
                    <textarea id="wel_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>발명의 효과</h2>
                    <button>작성예시 보기</button>
                    <textarea id="bal_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>핵심구성요소</h2>
                    <button>작성예시 보기</button>
                    <textarea id="imp_cont"></textarea>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2 style="width:100%">도면첨부</h2>
                    <button>작성예시 보기</button>
                    <div id="demo_box">
                        <div class="demo" id="fir"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>발명분야</h3>
                            <img src="/resources/image/ideapc_logo.jpg" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>            
                <div id="fin"> 
                    <button>임시저장</button>
                    <button id="agree">등록하기</button>
                </div>
            </article>
        </section>
    </div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>
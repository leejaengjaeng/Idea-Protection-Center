<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<title>Insert title here</title>
<style>
    .txt_box>input{
        border: 1px solid #ccc !important;
    }
    .txt_box>button{
        background:#1c4098 !important;
    }
    .hiding_box_header{
        background: #ccc !important;
    }
    textarea{
        border: 1px solid #ccc !important;
    }
    #add_btn{
        width: 110px;
        height: 33px;
        position: absolute;
        right: 0;
        top: 0;
        background: #999;
        color: #f9f9f9;
        text-align: center;
        font-size: 0.8rem;
        font-weight: bold;
        padding-top: 8px;
        border-radius: 4px;        
    }
    
    .txt_box>img{
        width: 240px;
        float: left;
        height: 240px;
        border: 2px solid #ccc;
    }
     .txt_box>img{
        width: 300px;
        float: left;
        height: 300px;
        border: 1px solid #ccc;
        margin-left: 40px;
    }
    .eximg{
        width: 300px;
        height: 300px;
        float: left;
        background:url(image/example.png);
        background-position: center;
        border: 2px solid rgba(1,102,156,1);
        
    }
    select{
        padding-left: 5px;
    }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div class="wrap_comment">
        <section>            
            <article class="sub_head">                    
                <h1><b style="color:rgba(1,102,156,1);">디자인권</b>출원</h1>                
            </article>                
            <article>
                <div class="txt_box">
                    <h2>디자인 명칭</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_kind" placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품">
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>                                
                 <div class="txt_box">
                    <h2>디자인 명칭</h2>
                    <button>작성예시 보기</button>
                    <input type="text" id="idea_kind" placeholder="본인이 창작한 디자인이 사용되는 품목을 넣어 주시면 됩니다. 예)모니터받침, 모니터 보드">
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>                
                <div class="txt_box" style="margin-top:100px;">
                    <h2>디자인의 의미</h2>
                    <button>작성예시 보기</button>
                    <textarea></textarea>
                    <span style="font-size:0.8rem; color:#45d7c2;">본인이 창작한 디자인의 의미를 적어 주시기 바랍니다.</span>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="txt_box">
                    <h2>디자인 시안 첨부</h2>                    
                    <ol>
                        <li>사시도</li>
                        <li>정면도</li>
                        <li>배면도</li>
                        <li>좌측면도</li>
                        <li>우측면도</li>
                        <li>평면도</li>
                        <li>저면도</li>
                    </ol>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="txt_box">
                    <span style="display:inline-block; float:left; width:100%; color:rgba(1,102,156,1); font-weight:bold;">작성예시</span>
                    <div class="eximg"></div>
                    <img src="#" alt="등록된 디자인 시안이 없습니다.">
                </div>
                <div class="txt_box">
                    <table>
                        <tr>
                            <td>
                                사시도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="sasi" id="sasi" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="sasi">첨부하기</label>
                            </td>
                            <td>
                                <button class="btn_del" data-no="1">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                정면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="front" id="front" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="front">첨부하기</label>
                            </td>
                            <td>
                                <button class="btn_del" data-no="2">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                배면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="bae" id="bae" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="bae">첨부하기</label>
                            </td>
                            <td>
                                <button class="btn_del" data-no="3">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                좌측면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="left_side" id="left_side" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="left_side">첨부하기</label>
                            </td>
                            <td>
                               <button class="btn_del" data-no="4">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                우측면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="right_side" id="right_side" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="right_side">첨부하기</label>
                            </td>
                            <td>
                                <button class="btn_del" data-no="5">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                평면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="plane" id="plane">                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="plane">첨부하기</label>
                            </td>
                            <td>
                               <button class="btn_del" data-no="6">삭제하기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                저면도
                            </td>
                            <td style="padding-left:15px;">
                                <input type="file"name="inside" id="inside" >                                
                            </td>
                            <td style="padding-left:10px;">
                                <label for="inside">첨부하기</label>
                            </td>
                            <td>
                               <button class="btn_del" data-no="7">삭제하기</button>
                            </td>
                        </tr>
                    </table>
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
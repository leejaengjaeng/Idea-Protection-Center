<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="icon" href="/resources/image/pavicon.png">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
출원완료일 : ${vo.getPre_apply_date()}<br>
최종출원 완성일 : ${vo.getApply_date()}<br>
${vo.getTitle()}에 대한 출원서
<button onclick="location.href='/getDoc'">다운로드</button>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
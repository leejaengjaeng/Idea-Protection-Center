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
����Ϸ��� : ${vo.getPre_apply_date()}<br>
������� �ϼ��� : ${vo.getApply_date()}<br>
${vo.getTitle()}�� ���� �����
<button onclick="location.href='/getDoc'">�ٿ�ε�</button>
<c:import url="/WEB-INF/views/import/footer.jsp"/>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));

	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>statistics</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="nav">
		<a href="/cashbook/statistics/totalStatsByKind.jsp">
			전체 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/yearStatsByKind.jsp">
			연도별 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/monthStatsByKind.jsp">
			월별 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/targetYearStatsByKind.jsp">
			특정년도의 월별 수입/지출 총액
		</a>
	</div>
	</body>
</html>
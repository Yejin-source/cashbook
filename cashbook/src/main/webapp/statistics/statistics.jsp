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
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
</head>
<body>
	<div class="header">
        <h1>📊 수입/지출 통계</h1>
	    <div class="small-links">
		    <a href="/cashbook/index.jsp">🏠 메인 화면으로</a>
		</div>
	 </div>
	<div class="nav">
		<a href="/cashbook/statistics/totalStatsByKind.jsp" style="background-color: #ffeb99;">
			<span class="emoji">💰</span>
			전체 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/yearStatsByKind.jsp" style="background-color: #d0f4de;">
			<span class="emoji">📅</span>
			연도별 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/monthStatsByKind.jsp" style="background-color: #a9def9;">
			<span class="emoji">🗓️</span>
			월별 수입/지출 총액
		</a>
		<a href="/cashbook/statistics/targetYearStatsByKind.jsp" style="background-color: #e4c1f9;">
			<span class="emoji">📈</span>
			특정년도 월별 <br> 수입/지출 총액
		</a>
	</div>
	</body>
</html>
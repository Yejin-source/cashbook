<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<title>Cashbook Home</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
</head>
<body>
	<div class="header">
		<h1>환영합니다 :)</h1>
		<div class="small-links">
			<a href="/cashbook/login/logout.jsp">🚪 로그아웃</a>
			<a href="/cashbook/login/updateAdminPwForm.jsp">🔑 비밀번호 변경</a>
		</div>
	</div>

	<div class="nav">
		<a href="/cashbook/category/categoryList.jsp" style="background-color: #d0f4de;">
			<span class="emoji">📁</span>
			카테고리 목록
		</a>
		<a href="/cashbook/monthList.jsp" style="background-color: #a9def9;">
			<span class="emoji">📅</span>
			가계부 달력
		</a>
		<a href="/cashbook/statistics/statistics.jsp" style="background-color: #e4c1f9;">
			<span class="emoji">📊</span>
			지출/수입 통계
		</a>
	</div>
</body>
</html>
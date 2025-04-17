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
<style>
	/* 기본 폰트 & 리셋 */
	body {
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f2e8ff;
	    color: #333;
	}
	
	/* 헤더 그라데이션 */
	.header {
	    background: linear-gradient(to right, #cce3ff, #e1d8ff, #ffd5e5);
		padding: 0 20px;
	    height: 140px;
	    position: relative;
	    border-bottom: 2px solid #e1d8ff;
	    overflow: hidden;
	}
	
	.header h1 {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    margin: 0;
	    font-size: 2.2em;
	    color: #333;
	}
	
	.header .small-links {
	    position: absolute;
	    bottom: 10px;
	    right: 20px;
	    display: flex;
	    gap: 15px;
	}
	
	.header .small-links a {
	   font-size: 1em;
	   font-weight: 600;
	   color: #2c2c2c;
	   text-decoration: none;
	}
	
	.header .small-links a:hover {
	    text-decoration: underline;
	}
	
	/* 네비게이션 카드 메뉴 */
	.nav {
	    display: flex;
	    justify-content: center;
	    flex-wrap: wrap;
	    gap: 25px;
	    margin: 60px auto;
	    padding: 0 20px;
	    max-width: 900px;
	}
	
	.nav a {
	    text-decoration: none;
	    width: 200px;
	    height: 120px;
	    background-color: #ffe5ec;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    color: #333;
	    border-radius: 15px;
	    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
	    font-size: 1.1em;
	    font-weight: 600;
	    transition: transform 0.2s ease;
	}
	
	.nav a:hover {
	    transform: translateY(-5px);
	    box-shadow: 0 6px 16px rgba(0,0,0,0.1);
	}
	
	/* 이모티콘 */
	.emoji {
	    font-size: 1.5em;
	    margin-bottom: 8px;
	}
</style>
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
		<a href="/cashbook/statistics.jsp" style="background-color: #e4c1f9;">
			<span class="emoji">📊</span>
			지출/수입 통계
		</a>
	</div>
</body>
</html>
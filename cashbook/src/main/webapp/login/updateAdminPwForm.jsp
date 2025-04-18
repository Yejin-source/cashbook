<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id")); // 세션에서 id 키에 저장된 값을 가져옴
	
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForn.jsp");
		return; // 코드 실행 중단
	}
%>


<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
</head>
	<body>
		 <!-- 헤더 영역 -->
	    <div class="header">
	        <h1>비밀번호 변경</h1>
	        <div class="small-links">
	            <a href="/cashbook/index.jsp">🏠 메인 화면으로</a>
	        </div>
	    </div>
	
	    <!-- 카드 영역 -->
	    <div class="card">
	        <form action="/cashbook/login/updateAdminPwAction.jsp" method="post">
	            <label>아이디</label>
	            <input type="text" name="id" required>
	
	            <label>현재 비밀번호</label>
	            <input type="password" name="pw" required>
	
	            <label>새 비밀번호</label>
	            <input type="password" name="newPw" required>
	
	            <label>새 비밀번호 확인</label>
	            <input type="password" name="newPwCheck" required>
	
	            <button type="submit" class="btn-submit mt-3">변경하기</button>
	        </form>
	    </div>
	</body>
</html>
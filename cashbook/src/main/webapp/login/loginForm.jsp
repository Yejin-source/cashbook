<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Controller -->
<%	
	// 로그인 상태 확인 | String 타입으로 다 변경
	String login = (String)(session.getAttribute("id")); // 세션에서 id 키에 저장된 값을 가져옴
	
	if(login != null) { // 로그인 상태라면
		response.sendRedirect("/cashbook/index.jsp");
		return; // 코드 실행 중단
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
	<!-- 부트스트랩 적용 (필요시 버튼/폼 정리용) -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		/* 로그인 버튼 스타일 */
		.login-btn {
		    background-color: #cdb4db;
		    border: none;
		    color: white;
		    padding: 10px;
		    font-size: 16px;
		    border-radius: 8px;
		    transition: background-color 0.3s ease;
		}
		
		/* 로그인 버튼에 마우스 올렸을 때 */
		.login-btn:hover {
		    background-color: #b28dd0; /* 조금 더 진한 보라색으로 변화 */
		    cursor: pointer;
		}
	</style>
</head>
	<body class="bg-light d-flex flex-column align-items-center justify-content-center" style="min-height: 100vh;">
	
		<div class="card p-4 shadow" style="width: 400px; background-color: #ffe5ec;">
		    <h2 class="text-center mb-4">🔒 로그인</h2>
		
		    <form action="/cashbook/login/loginAction.jsp" method="post">
		        <div class="mb-3">
		            <label for="id" class="form-label">아이디</label>
		            <input type="text" name="id" id="id" class="form-control" required>
		        </div>
		
		        <div class="mb-3">
		            <label for="pw" class="form-label">비밀번호</label>
		            <input type="password" name="pw" id="pw" class="form-control" required>
		        </div>
		
		        <div class="d-grid mt-4">
		           <button type="submit" class="login-btn">로그인</button>
		        </div>
	   		 </form>
		</div>
	</body>
</html>
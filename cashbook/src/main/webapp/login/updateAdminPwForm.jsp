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
<style>
    /* 기본 폰트 & 전체 배경 */
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
    
    /* 헤더 오른쪽 작은 링크들 */
    .small-links {
        position: absolute;
        bottom: 10px;
        right: 20px;
        display: flex;
        gap: 15px;
    }

    .small-links a {
        font-size: 1em;
        font-weight: 600;
        color: #2c2c2c;
        text-decoration: none;
    }

    .small-links a:hover {
        text-decoration: underline;
    }
    
    /* 카드 스타일 */
    .card {
        background-color: #ffffff;
        border-radius: 15px;
        padding: 30px;
        margin: 50px auto;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        width: 400px;
    }

    /* 입력 폼 */
    input[type="text"],
    input[type="password"] {
        width: 95%;
        padding: 10px;
        margin-top: 8px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
    }

    /* 버튼 */
    .btn-submit {
        width: 101%;
        background-color: #e1d8ff;
        color: #333;
        border: none;
        padding: 10px;
        border-radius: 8px;
        font-weight: bold;
        font-size: 16px;
        transition: background-color 0.3s ease;
        margin-top: 10px; 
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .btn-submit:hover {
        background-color: #c7b8ea;
        cursor: pointer;
    }

</style>
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
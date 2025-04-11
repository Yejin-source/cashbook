<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Controller -->
<%	
	// 로그인 상태 확인 | String 타입으로 다 변경
	String login = (String)(session.getAttribute("id")); // 세션에서 id 키에 저장된 값을 가져옴
	
	if(login != null) { // 로그인 상태라면
		response.sendRedirect("/cashbook/category/categoryList.jsp");
		return; // 코드 실행 중단
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>로그인</h1>
	<!-- nav.jsp 인클루드 -->
	<div> <!-- 프로젝트명 생략하고 작성 -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<form action="/cashbook/login/loginAction.jsp" method="post">
		<table class="table table-striped table-hover">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>
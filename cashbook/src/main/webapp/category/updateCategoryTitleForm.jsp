<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	// 요청받은 값 가져오기
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	// 받은 값 확인
	System.out.println("updateCategoryTitleForm.jsp categoryNo: " + categoryNo);
	
	
	// 객체 생성
	Category c = new Category();
	CategoryDao categoryDao = new CategoryDao();
	c = categoryDao.selectCategoryOne(categoryNo);

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryTitleForm</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>제목 수정</h1>
	<form action="/cashbook/category/updateCategoryTitleAction.jsp" method="post">
	<input type="hidden" name="categoryNo" value="<%=c.getCategoryNo()%>"> <!-- value 수정 -->
		<table class="table table-striped table-hover">
			<tr>
				<th>번호</th>
				<td><input type="text" name="categoryNo" value="<%=c.getCategoryNo()%>" readonly></td>
			</tr>
			<tr>
				<th>종류</th>
				<td>
					<input type="radio" name="kind" value="expense" <%=c.getKind().equals("expense") ? "checked" : ""%> disabled>지출
					&nbsp;
					<input type="radio" name="kind" value="income" <%=c.getKind().equals("income") ? "checked" : ""%> disabled>수입
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%=c.getTitle()%>"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
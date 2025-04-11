<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	// 페이징 작업
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 15;
	
	// Paging 객체 생성 후 값 설정
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	// CategoryDao 객체 생성 후 값 설정
	CategoryDao categoryDao = new CategoryDao();
	int totalRow = categoryDao.getTotal();
	int lastPage = paging.getLastPage(totalRow);
	ArrayList<Category> list = categoryDao.selectCategoryList(paging);
	
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category List</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<h1>Category List</h1>
	<form method="post">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>종류</th>
					<th>제목</th>
					<th>날짜</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Category c: list) {
				%>
						<tr>
							<td><%=c.getCategoryNo()%></td>
							<td>
								<%
									if(c.getKind().equals("expense")) {
								%>
										지출
								<%		
									} else {
								%>
										수입
								<%		
									}
								%>	
							</td>
							<td><%=c.getTitle()%></td>
							<td><%=c.getCreatedate()%></td>
							<td> <!-- 링크에 값 넘기는 거 그만 까먹기로 해요 우리.............. -->
								<a href="/cashbook/updateCategoryTitleForm.jsp?categoryNo=<%=c.getCategoryNo()%>">[수정]</a> /
								<a href="/cashbook/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">[삭제]</a>
							</td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</form>
</body>
</html>
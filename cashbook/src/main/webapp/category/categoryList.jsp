<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
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
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		/* 수정/삭제 버튼 스타일 */
		.edit-btn, .delete-btn {
		    padding: 4px 10px;
		    font-size: 0.9em;
		    border-radius: 8px;
		    text-decoration: none;
		    font-weight: bold;
		    transition: background-color 0.2s ease;
		}
		
		.edit-btn {
		    background-color: #d0f4de; /* 연초록 */
		    color: #333;
		}
		.edit-btn:hover {
		    background-color: #b2dfdb;
		}
		
		.delete-btn {
		    background-color: #ffd5e5; /* 연분홍 */
		    color: #333;
		    margin-left: 5px;
		}
		.delete-btn:hover {
		    background-color: #f8bbd0;
		}	
	</style>
</head>
<body>
	 <!-- 헤더 영역 -->
    <div class="header">
        <h1>📁 카테고리 목록</h1>
        <div class="small-links">
		    <a href="/cashbook/index.jsp">🏠 메인 화면으로</a>
		    <a href="/cashbook/login/logout.jsp">🚪 로그아웃</a>
		</div>
    </div>
	<form method="post">
		<div style="width: 90%; margin: 20px auto; display: flex; justify-content: flex-start;">
			<a href="/cashbook/category/insertCategoryForm.jsp" class="add-category-link">➕ 카테고리 추가</a>
		</div>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>분류</th>
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
							    <% if(c.getKind().equals("수입")) { %> 
							        💰 <%=c.getKind()%>
							    <% } else { %>
							        💸 <%=c.getKind()%>
							    <% } %>
							</td>
							<td><%=c.getTitle()%></td>
							<td><%=c.getCreatedate().substring(0, 10)%></td>
							<td> <!-- 링크에 값 넘기는 거 그만 까먹기로 해요 우리.............. -->
								<a href="/cashbook/category/updateCategoryTitleForm.jsp?categoryNo=<%=c.getCategoryNo()%>" class="edit-btn">수정</a>
   								<a href="/cashbook/category/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>" class="delete-btn">삭제</a>
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
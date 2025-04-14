<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%
	// dateList.jsp -> 수입/지출 입력(String cashDate) -> 
	String cashDate = request.getParameter("cashDate");
	
	// insertCashForm.jsp -> kind 선택(String kind)
	String kind = request.getParameter("kind");
	ArrayList<Category> list = null;
	if(kind != null) { // insertCashForm.jsp에서 kind 선택 후 재요청
		// DB: 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>수입/지출 이력 추가</h1>
	<form action="/cashbook/cash/insertCashForm.jsp" method="post">
		<input type="hidden" name="cashDate" value="<%=cashDate%>"> <!-- cashDate값이 안 넘어가니까 넘겨주기 -->
		종류
		<select name="kind">
			<option value="">:::선택:::</option> <!-- value값이 없으면 action이 value가 됨 -->
			<option value="수입" <% if(kind != null && kind.equals("수입")) {%> selected <%} %>>수입</option> 
			<option value="지출" <% if(kind != null && kind.equals("지출")) {%> selected <%} %>>지출</option>
		</select>
		<button type="submit">수입/지출 선택</button>
	</form>
	<form action="/cashbook/cash/insertCashForm.jsp" method="post">
		날짜 : <input type="text" name="cashDate" value="<%=cashDate%>" readonly><br>
		카테고리 :
		<select name="categoryNo">
			<%
				if(list != null) {
					for(Category c : list) {
			%>
						<option value="<%=c.getCategoryNo()%>"><%=c.getTitle()%></option>
						
			<%
					}
				}
			%>
		</select>
		<button type="submit">입력</button>
	</form>
</body>
</html>
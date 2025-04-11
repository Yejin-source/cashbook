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
	<h1>수입/지출 선택</h1>
	<form action="/cashbook/insertCashForm.jsp" method="post">
		<input type="hidden" name="cashDate" value="<%=cashDate%>"> <!-- cashDate값이 안 넘어가니까 넘겨주기 -->
		kind
		<select name="kind">
			<option value="">:::선택:::</option>
			<option>수입</option> <!-- value값이 없으면 action이 value가 됨 -->
			<option>지출</option>
		</select>
		<button type="submit">수입/지출 선택</button>
	</form>
	
	<hr>
	
	<h1>수입/지출 이력 추가</h1>
	<form action="/cashbook/insertCashForm.jsp" method="post">
		cashDate : <input type="text" name="cashDate" value="<%=cashDate%>" readonly><br>
		category :
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
		<button type="submit">수입/지출 입력</button>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%
	//로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	
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
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<h1>수입/지출 선택</h1>
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
	
	<hr>
	
	<h1>내역 추가</h1>
	<form action="/cashbook/cash/insertCashAction.jsp" method="post">
		<!-- label 태그: for 속성을 주면, 해당 id를 가진 input 태그와 연결됨 -->
		<label for="cashDate">날짜</label>
		<input type="date" name="cashDate" id="cashDate" value="<%=cashDate%>" readonly><br>
		
		<label for="categoryNo">카테고리</label>
		<select name="categoryNo" id="categoryNo">
		<%
			if (list != null) {
				for (Category c : list) {	
		%>
			<option value="<%=c.getCategoryNo()%>"><%=c.getTitle()%></option>
		
		<%
				}
			}
		%>
		</select>
		<br>
		<label for="amount">금액</label>
		<input type="text" name="amount" id="amount"><br>
		
		<label for="memo">메모</label>
		<input type="text" name="memo" id="memo"><br>

		<label for="color">색상</label>
		<input type="color" name="color" id="color"><br>
		
		<button type="submit">추가</button>
	</form>
</body>
</html>
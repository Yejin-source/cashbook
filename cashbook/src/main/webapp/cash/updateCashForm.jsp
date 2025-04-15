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
	
	
	// 필요한 값 가져오기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	// 값 확인
	System.out.println("updateCashForm.jsp cashNo: " + cashNo);
	System.out.println("updateCashForm.jsp cashDate: " + cashDate);
	
	
	// 객체 형성 및 cashDao 사용
	Cash c = new Cash();
	CashDao cd = new CashDao();
	c = cd.selectCashOne(cashNo);
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<h2><%=cashDate%></h2>
	<h1>[<%=c.getCategory().getKind()%>] <%=c.getCategory().getTitle()%> 정보 수정</h1>
	<form action="/cashbook/cash/updateCashAction.jsp" method="post">
		<table class="table table-striped table-hover">
			<tr>
				<th>가격</th>
				<td><input type="text" name="amount" value="<%=c.getAmount()%>">원</td>					
			</tr>
			<tr>
				<th>메모</th>
				<td><input type="text" name="memo" value="<%=c.getMemo()%>" placeholder="메모 입력"></td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="color" name="color" value="<%=c.getColor()%>"></td>
			</tr>
			<tr>
				<th>생성날짜</th>
				<td><input type="text" name="createdate" value="<%=c.getCreatedate()%>" readonly></td>
			</tr>
			<tr>
				<th>갱신날짜</th>
				<td><input type="text" name="createdate" value="<%=c.getUpdatedate()%>" readonly></td>
			</tr>
		</table>
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<input type="hidden" name="cashDate" value="<%=cashDate%>">
		<button type="submit">수정</button>
	</form>
</body>
</html>
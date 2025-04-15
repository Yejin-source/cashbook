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
	
	
	// cashDate 값 가져오기
	String cashDate = request.getParameter("cashDate");
	// 값 확인
	System.out.println("dateList.jsp cashDate: " + cashDate);
	
	
	// 객체 형성 및 cashDao 사용
	CashDao cd = new CashDao();
	ArrayList<Cash> list = cd.selectCashByDate(cashDate);
%>	
	
<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Date List</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<h1><%=cashDate%> 수입/지출</h1>
	<div>
		<a href="/cashbook/cash/insertCashForm.jsp?cashDate=<%=cashDate%>">내역 추가</a>
	</div>
	<form method="post">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>종류</th>
					<th>제목</th>
					<th>가격</th>
					<th>메모</th>
					<th>상세정보</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Cash c: list) {
				%>
						<tr>
							<td><%=c.getCategory().getKind()%></td>
							<td><%=c.getCategory().getTitle()%></td>
							<td><%=c.getAmount()%>원</td>
							<td><%=c.getMemo()%></td>
							<td><a href="/cashbook/cash/cashOne.jsp?cashNo=<%=c.getCashNo()%>&cashDate=<%=cashDate%>">상세정보</a></td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</form>
</body>
</html>
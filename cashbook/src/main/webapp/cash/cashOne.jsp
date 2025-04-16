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
	System.out.println("cashOne.jsp cashNo: " + cashNo);
	System.out.println("cashOne.jsp cashDate: " + cashDate);
	
	
	// 객체 형성 및 cashDao 사용
	Cash c = new Cash();
	CashDao cd = new CashDao();
	c = cd.selectCashOne(cashNo);
	
	// 객체 형성 및 receitDao 사용
	Receit r = new Receit();
	ReceitDao rd = new ReceitDao();
	r = rd.selectReceitOne(cashNo);
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
	<h1>[<%=c.getCategory().getKind()%>] <%=c.getCategory().getTitle()%> 상세정보</h1>
		<div>
			<a href="/cashbook/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">내역 수정</a>
			<a href="javascript:void(0);" onclick="confirmDelete(<%=cashNo%>, '<%=cashDate%>')">내역 삭제</a>
			<script>
				function confirmDelete(cashNo, cashDate) { // 삭제 확인창 띄우기
					if (confirm("삭제하시겠습니까?")) {
						location.href="/cashbook/cash/deleteCash.jsp?cashNo="+cashNo+"&cashDate="+cashDate;
					}
				}
			</script>
		</div>
		<table class="table table-striped table-hover">
			<tr>
				<th>날짜</th>
				<td><%=cashDate%></td>
			</tr>
			<tr>
				<th>종류</th>
				<td><%=c.getCategory().getKind()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=c.getCategory().getTitle()%></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><%=c.getAmount()%>원</td>					
			</tr>
			<tr>
				<th>메모</th>
				<td><%=c.getMemo()%></td>
			</tr>
			<tr>
				<th>색상</th>
				<td><%=c.getColor()%></td>
			</tr>
			<tr>
				<th>영수증</th>
				<td>
					<%
						if(r.getFilename() == null) {
					%>		
							<!-- 영수증이 없는 경우 -->
							<form action="/cashbook/cash/insertReceitForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" method="post" style="display:inline;">
								<input type="hidden" name="cashNo" value="<%=cashNo%>">
								<input type="hidden" name="cashDate" value="<%=cashDate%>">
								<button type="submit">영수증 입력</button>
							</form>
					
					<%		
						} else {
					%>		
							<!-- 영수증이 있는 경우 -->
							<img src="/cashbook/upload/<%=r.getFilename()%>" alt="영수증" width="100">
							<form action="/cashbook/cash/deleteReceit.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" method="post" style="display:inline;">
								<input type="hidden" name="cashNo" value="<%=cashNo%>">
								<input type="hidden" name="cashDate" value="<%=cashDate%>">
								<button type="submit">영수증 삭제</button>
							</form>		
					<%		
						}
					%>
				</td>
			</tr>
		</table>
			
</body>
</html>
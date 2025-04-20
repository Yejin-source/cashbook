<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

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

	
	// 금액 형식 설정 | java.text.Decimalformat: 숫자 형식 지정하는 클래스
	DecimalFormat formatter = new DecimalFormat("#,###"); 
%>	
	
<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Date List</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		.detail-btn {
		    display: inline-block;
		    padding: 6px 12px;
		    background-color: #e1d8ff;
		    color: #333;
		    border-radius: 8px;
		    font-weight: bold;
		    font-size: 14px;
		    text-decoration: none;
		    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
		    transition: background-color 0.3s;
		}
		
		.detail-btn:hover {
		    background-color: #c7b8ea;
		    color: #2c2c2c;
		}
	</style>
</head>
<body>
	<div class="header">
        <h1><%=cashDate%> 💰수입 / 💸지출</h1>
        <div class="small-links">
		    <a href="/cashbook/category/categoryList.jsp">📁 카테고리 목록</a>
		    <a href="/cashbook/monthList.jsp">📅 가계부 달력</a>
		</div>
    </div>
	<div style="width: 90%; margin: 20px auto 10px auto; display: flex; justify-content: flex-start;">
        <a href="/cashbook/cash/insertCashForm.jsp?cashDate=<%=cashDate%>" class="add-category-link" style="padding: 8px 16px; font-size: 16px; border-radius: 10px;">
            ➕ 내역 추가
        </a>
    </div>
	<form method="post">
		<table>
			<thead>
				<tr>
					<th>분류</th>
					<th>제목</th>
					<th>금액</th>
					<th>메모</th>
					<th>영수증</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Cash c: list) {
				%>
						<tr>
							<td>
							    <%=c.getCategory().getKind().equals("수입") ? "💰 수입" : "💸 지출"%>
							</td>
							<td><%=c.getCategory().getTitle()%></td>
							<td><%=formatter.format(c.getAmount())%>원</td>
							<td><%=c.getMemo()%></td>
							<td>
								<%			
									if(c.getReceit().getFilename() != null) {
								%>
										<p>&#128196; / &#x2705;</p>
										
								<%		
									} else {
								%>		
			
										<p>&#128196; / &#x274C;</p>
								<%
									}
								%>
								
							</td>
							<td>
								<a href="/cashbook/cash/cashOne.jsp?cashNo=<%=c.getCashNo()%>&cashDate=<%=cashDate%>" class="detail-btn">
									상세정보
								</a>
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
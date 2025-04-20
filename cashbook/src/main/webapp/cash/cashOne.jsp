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
	

	// 금액 형식 설정 | java.text.Decimalformat: 숫자 형식 지정하는 클래스
	DecimalFormat formatter = new DecimalFormat("#,###"); 
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cash One</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		.receit-btn {
		    background-color: #e1d8ff;
		    color: #333;
		    padding: 8px 16px;
		    border: none;
		    border-radius: 10px;
		    font-weight: bold;
		    font-size: 14px;
		    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		    transition: all 0.2s ease;
		    cursor: pointer;
		}
		.receit-btn:hover {
		    background-color: #c7b8ea;
		}
			
			
	</style>
</head>
<body>
	<div class="header">
		<h2><%=cashDate%></h2>
        <h1>	
        	[<%=c.getCategory().getKind().equals("수입") ? "💰수입" : "💸지출"%>] 
        	<%=c.getCategory().getTitle()%> 상세정보
        </h1>
        <div class="small-links">
		    <a href="/cashbook/dateList.jsp?cashDate=<%=cashDate%>">↩️ 이전 페이지</a>
		</div>
    </div>
	
	<div style="width: 90%; margin: 20px auto; display: flex; justify-content: flex-start; gap: 20px;">
	    <a href="/cashbook/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" 
	       class="add-category-link" style="background-color: #d0f4de;">
	       📝 내역 수정
	    </a>
	    <a href="/cashbook/cash/deleteCash.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" 
	       class="add-category-link" style="background-color: #ffd5e5;">
	       ❌ 내역 삭제
	    </a>
	</div>
	<!-- 
		<script>
			function confirmDelete(cashNo, cashDate) { // 삭제 확인창 띄우기
				if (confirm("삭제하시겠습니까?")) {
					location.href="/cashbook/cash/deleteCash.jsp?cashNo="+cashNo+"&cashDate="+cashDate;
				}
			}
		</script>
	 -->
	
		<table>
			<tr>
				<th>날짜</th>
				<td><%=cashDate%></td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
				    <%=c.getCategory().getKind().equals("수입") ? "💰 수입" : "💸 지출"%>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=c.getCategory().getTitle()%></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><%=formatter.format(c.getAmount())%>원</td>					
			</tr>
			<tr>
				<th>메모</th>
				<td><%=c.getMemo()%></td>
			</tr>
			<tr>
			    <th>색상</th>
			    <td style="text-align: center;">
			        <div style="display: inline-flex; align-items: center; gap: 8px;">
			            <div style="width: 18px; height: 18px; background-color: <%=c.getColor()%>; border-radius: 6px; border: 1px solid #ccc;"></div>
			            <span><%=c.getColor()%></span>
			        </div>
			    </td>
			</tr>
			<tr>
				<th>영수증</th>
				<td>
					<%
						if(r.getFilename() == null) {
					%>		
							<!-- 영수증이 없는 경우 --> 
							<!-- 단순히 조회하는 경우에는 get 방식으로 충분함 -->
							<a href="/cashbook/cash/insertReceitForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">
								🧾 영수증 입력
							</a>
					
					<%		
						} else {
					%>		
							<!-- 영수증이 있는 경우 -->
							<img src="/cashbook/upload/<%=r.getFilename()%>" alt="영수증" width="100">
							<form action="/cashbook/cash/deleteReceit.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" method="post" style="display:inline;">
								<input type="hidden" name="cashNo" value="<%=cashNo%>">
								<input type="hidden" name="cashDate" value="<%=cashDate%>">
								<button type="submit" class="receit-btn">🗑️ 영수증 삭제</button>
							</form>		
					<%		
						}
					%>
				</td>
			</tr>
		</table>
			
</body>
</html>
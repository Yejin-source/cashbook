<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*" %>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.DecimalFormat" %>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));

	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}

	
	// year 값 구하기
	Calendar cal = Calendar.getInstance();
	
    int year = cal.get(Calendar.YEAR);

    if(request.getParameter("year") != null) {
        year = Integer.parseInt(request.getParameter("year"));
    }

    // 값 확인
    System.out.println("totalStatsByKind.jsp year: " + year);
    
	// Dao 객체 생성
	StatsDao statsDao = new StatsDao();

	// 전체 수입/지출 총액
	ArrayList<HashMap<String, Object>> totalList = statsDao.totalStatsByKind();
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Total Statistics</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
</head>
<body>
	<div class="header">
		<h1>💰 전체 수입/지출 통계</h1>
		<div class="small-links">
		    <a href="/cashbook/statistics/statistics.jsp">📊 이전 페이지</a>
		    <a href="/cashbook/index.jsp">🏠 메인 화면으로</a>
		</div>
	</div>	
		<table>
			<thead>
				<tr>
					<th>분류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>	
			<tbody>
				<%
					for(HashMap<String, Object> map : totalList) {
						ArrayList<String> list = new ArrayList<>();
				%>
						<tr>
							<td><%=map.get("kind").equals("수입") ? "💰 수입" : "💸 지출"%></td>
							<td><%=map.get("cnt")%>건</td>
							<td>
						        <%
									// java.text.Decimalformat: 숫자 형식 지정하는 클래스
									DecimalFormat formatter = new DecimalFormat("#,###");
						        
						            // int amount = (int)map.get("sum"); // map은 Object 타입 -> 형변환 필요
						            // out.print(formatter.format(amount) + "원"); // 웹 브라우저에 출력할 거니까 out.print
						       
						        	if(map.get("kind").equals("수입")) {
								%>		
										<span style="color:blue; font-size: 12px;">▲</span> <%=formatter.format(map.get("sum"))%>원
								<%
									} else {
								%>
										 <span style="color:red; font-size: 12px;">▼</span> <%=formatter.format(map.get("sum"))%>원
								<%		
									}
						        %>
							</td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</body>
</html>
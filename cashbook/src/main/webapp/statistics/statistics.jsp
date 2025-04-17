<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>

<!-- Controller -->
<%	
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}

	
	// year, month 값 구하기
	Calendar cal = Calendar.getInstance();
	
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;

    if(request.getParameter("year") != null) {
        year = Integer.parseInt(request.getParameter("year"));
    }
    if(request.getParameter("month") != null) {
        year = Integer.parseInt(request.getParameter("month"));
    }

    // 값 확인
    System.out.println("statistics.jsp year: " + year);
    System.out.println("statistics.jsp year: " + month);
    
    
	// 객체 생성 후 해당하는 Dao 실행
	StatsDao statsDao = new StatsDao();

	// 전체 수입/지출 총액
	ArrayList<HashMap<String, Object>> totalList = statsDao.totalStatsByKind();
	
	// 연도별 수입/지출 총액
	ArrayList<HashMap<String, Object>> yearList = statsDao.yearStatsByKind(year);
	
	// 월별 수입/지출 총액
	ArrayList<HashMap<String, Object>> monthList = statsDao.monthStatsByKind(month);
	 
	// 특정년도의 월별 수입/지출 총액
	ArrayList<HashMap<String, Object>> targetYearList = statsDao.targetYearStatsByKind(year, month);
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>statistics</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>수입/지출 통계</h1>
		
		<table class="table table-striped table-hover">
			<tr>
				<th>전체 수입/지출 통계</th>
				<th></th><th></th>
			</tr>
			<tr>
				<th>분류</th>
				<th>건수</th>
				<th>총액</th>
			</tr>
			<%
				for (HashMap<String, Object> map : totalList) {
					ArrayList<String> list = new ArrayList<>();
			%>
					<tr>
						<td><%=map.get("kind")%></td>
						<td><%=map.get("cnt")%></td>
						<td><%=map.get("sum")%>원</td>
					</tr>
			<%
				}
			%>
		</table>
		
		<form action="/cashbook/statistics.jsp" method="post">
			<span>연도</span>
			<select name="year">
				<option value="2021" <%if(year == 2021){%> selected <%}%>>2021</option>
				<option value="2022" <%if(year == 2022){%> selected <%}%>>2022</option>
				<option value="2023" <%if(year == 2023){%> selected <%}%>>2023</option>
				<option value="2024" <%if(year == 2024){%> selected <%}%>>2024</option>
				<option value="2025" <%if(year == 2025){%> selected <%}%>>2025</option>
			</select>
			<button type="submit">선택</button>
		</form>
		
		<table class="table table-striped table-hover">
			<tr>
				<th>연도별 수입/지출 통계</th>
			</tr>
			
			<tr>
				<th>분류</th>
				<th>건수</th>
				<th>총액</th>
			</tr>
			<%
				for(HashMap<String, Object> map : yearList) {
					ArrayList<String> list = new ArrayList<>();
			%>
					<tr>
						<td><%=map.get("kind")%></td>
						<td><%=map.get("cnt")%></td>
						<td><%=map.get("sum")%>원</td>
					</tr>
			<%
				}
			%>
		</table>
	</body>
</html>
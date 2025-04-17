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
    System.out.println("targetYearStatsByKind.jsp year: " + year);
    System.out.println("targetYearStatsByKind.jsp year: " + month);
    
    
	// Dao 객체 생성
	StatsDao statsDao = new StatsDao();

	// 특정년도의 월별 수입/지출 총액
	ArrayList<HashMap<String, Object>> targetYearList = statsDao.targetYearStatsByKind(year, month);

	
	// 금액 형식 설정 | java.text.Decimalformat: 숫자 형식 지정하는 클래스
	DecimalFormat formatter = new DecimalFormat("#,###"); 
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
	
	<h1><%=year%>년도 월별 수입/지출 통계</h1>
		<form action="/cashbook/statistics/targetYearStatsByKind.jsp">
		    <select name="year">
		        <% 
		            int targetYear = Calendar.getInstance().get(Calendar.YEAR);
		            // 최근 5년 동안 선택할 수 있도록 설정
		            for(int i = targetYear; i >= targetYear - 5; i--) {
		        %>
		            <option value="<%=i%>" <%=(i == year ? "selected" : "")%>><%=i%>년</option>
		        <% 
		            } 
		        %>
		    </select>
		    <button type="submit">조회</button>
		</form>
	
		<table class="table table-striped table-hover">
			 <thead>
	            <tr>
                    <th>월</th>
                    <th>분류</th> <!-- 수입 or 지출 -->
                    <th>총 건수</th>
                    <th>총액</th>
                </tr>
	        </thead>
	        <tbody>
				<%
                    // 반복문으로 yearList 출력
                    for(HashMap<String, Object> map : targetYearList) {
                %>
						<tr>
							<td><%=map.get("month")%>월</td>
							<td><%=map.get("kind")%></td>
							<td><%=map.get("cnt")%>건</td>
							<td><%=formatter.format(map.get("sum"))%>원</td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<a href="/cashbook/monthList.jsp">달력으로 돌아가기</a>
	</body>
	</body>
</html>
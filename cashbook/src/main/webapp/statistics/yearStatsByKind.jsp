<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*" %>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

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
    System.out.println("yearStatsByKind.jsp year: " + year);
    
    
	// Dao 객체 생성
	StatsDao statsDao = new StatsDao();

	// 연도별 수입/지출 총액
	ArrayList<HashMap<String, Object>> yearList = statsDao.yearStatsByKind(year);
	
	
	// 금액 형식 설정 | java.text.Decimalformat: 숫자 형식 지정하는 클래스
	DecimalFormat formatter = new DecimalFormat("#,###"); 

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
	
	<h1>연도별 수입/지출 통계</h1>
		<table class="table table-striped table-hover">
			 <thead>
	            <tr>
                    <th>연도</th>
                    <th>분류</th> <!-- 수입 or 지출 -->
                    <th>총액</th>
                </tr>
	        </thead>
	        <tbody>
				<%
                    // 반복문으로 yearList 출력
                    for(HashMap<String, Object> map : yearList) {
                %>
						<tr>
							<td><%=map.get("year")%>년</td>
							<td><%=map.get("kind")%></td>
							<td><%=formatter.format(map.get("sum"))%>원</td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<a href="/cashbook/monthList.jsp">달력으로 돌아가기</a>
	</body>
</html>
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
	
	<h1>전체 수입/지출 통계</h1>
		
		<table class="table table-striped table-hover">
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
						<td><%=map.get("cnt")%>건</td>
						<td>
					        <%
								// java.text.Decimalformat: 숫자 형식 지정하는 클래스
								DecimalFormat formatter = new DecimalFormat("#,###");
					        
					            int amount = (int)map.get("sum"); // map은 Object 타입 -> 형변환 필요
					            out.print(formatter.format(amount) + "원"); // 웹 브라우저에 출력할 거니까 out.print
					        %>
						 </td>
					</tr>
			<%
				}
			%>
		</table>
		
		<a href="/cashbook/monthList.jsp">달력으로</a>
		<a href="/cashbook/index.jsp">홈으로</a>
	</body>
</html>
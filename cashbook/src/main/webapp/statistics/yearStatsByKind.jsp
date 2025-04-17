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
	
	
    // 수입 vs 지출 분리
    HashMap<String, Object> incomeMap = new HashMap<>();
    HashMap<String, Object> expenseMap = new HashMap<>();
    
    for(HashMap<String, Object> map : yearList) {
    	if(map.get("kind").equals("수입")) {
       	}
    }
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
			<tr>
				<th>연도</th>
				<th>수입</th>
				<th>총액</th>
				<th>지출</th>
				<th>총액</th>
				<th>합계</th>
			</tr>
			<%
				// java.text.Decimalformat: 숫자 형식 지정하는 클래스
				DecimalFormat formatter = new DecimalFormat("#,###");
			
				for (HashMap<String, Object> map : yearList) {
					ArrayList<String> list = new ArrayList<>();
			%>
					<tr>
						<td><%=map.get("year")%></td>
						<td>
							<%
								if(map.get("kind").equals("수입")) {
									out.print(map.get("kind"));	
								}
							%>	
						</td>
						<td>
							<%
								if(map.get("kind").equals("수입")) {
									out.print(map.get("cnt"));	
								}
							%>	
						<td>
					        <%
					            int amount = (int)map.get("sum"); // map은 Object 타입 -> 형변환 필요
					            out.print(formatter.format(amount) + "원"); // 웹 브라우저에 출력할 거니까 out.print
					        %>
						 </td>
					</tr>
			<%
				}
			%>
		</table>
		
		<button type="submit">달력으로 돌아가기</button>
	</body>
</html>
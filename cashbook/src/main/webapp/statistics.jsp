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
	
	String targetYear = request.getParameter("targetYear");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("stats.jsp targetYear: " + targetYear);
	
	if (targetYear == null) {
		Calendar cal = Calendar.getInstance();
		targetYear = String.valueOf(cal.get(Calendar.YEAR));
	}
	
	// 객체 생성 후 해당하는 Dao 실행
	StatsDao statsDao = new StatsDao();

	// 전체 수입/지출 총액
	ArrayList<HashMap<String, Object>> list = statsDao.totalStatsByKind();
	
	// 연도별 수입/지출 총액
	// ArrayList<HashMap<String, Object>> yearList = statsDao.yearStatsByKind(year);
	
	// 월별 수입/지출 총액
	// ArrayList<HashMap<String, Object>> monthList = statsDao.monthStatsByKind(month);

	// 특정년도의 월별 수입/지출 총액
	// ArrayList<HashMap<String, Object>> targetYearList = statsDao.targetYearStatsByKind(year, month);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>statistics</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	</body>
</html>
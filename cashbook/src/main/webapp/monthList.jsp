<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
<%@ page import="dto.*" %> 
<%@ page import="model.*" %> 

<!-- Controller -->
<%
	//로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	
	// 현재 날짜 기준으로 달력 만들기
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1); // 날짜 기준을 1일로 고정
	
	// 년, 월 매개값이 있다면
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	if(targetYear != null) {
		firstDate.set(Calendar.YEAR, Integer.parseInt(targetYear));
	}
	if(targetMonth != null) {
		firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 마지막 날짜
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	// 요일: 1일의 요일만 구하면 모든 요일을 알 수 있음 | 일(1) ~ 토(7)
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	
	// 달력에서 1일 이전의 빈 칸 수 (일요일이 1 -> 공백 0칸)
	int startBlank = dayOfWeek - 1;
	
	// 달력 끝부분 빈 칸 수 
	int endBlank = 0; // 우선 0으로 초기화
	
	// 달력 총 셀 수 계산
	int total = startBlank + lastDate + endBlank;
	if(total % 7 != 0) {
		endBlank = 7 - (total % 7);
		total = startBlank + lastDate + endBlank;
	}
		
	// 현재 연도 & 달
	int year = firstDate.get(Calendar.YEAR);
	int month = firstDate.get(Calendar.MONTH); // 0 ~ 11
	
	// 이전 달 & 연도
	int prevYear = year;
	int prevMonth = month - 1;
	if(prevMonth < 0) {
		prevMonth = 11;
		prevYear--;
	}
	
	// 다음 달 & 연도
	int nextYear = year;
	int nextMonth = month + 1;
	if(nextMonth > 11) {
		nextMonth = 0;
		nextYear++;
	}

	
	// CashDao 객체 형성
	CashDao csDao = new CashDao();

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Month List</title>
<style>
	table {
	    table-layout: fixed; /* 열 너비 고정 */
	    width: 60%;
	}
	th, td {
    text-align: center;         /* 가로 정렬 */
    vertical-align: middle;     /* 세로 정렬 */
    height: 70px; /* 원하는 고정 높이 값 */
	}
</style>
</head>
<body>
	<h1>
		<%=year%>년 <%=month+1%>월</h1>
	<div>
		<!-- 달력 페이징 네비게이션 -->
		<a href="/cashbook/monthList.jsp?targetYear=<%=prevYear%>&targetMonth=<%=prevMonth%>">[이전 달]</a>
		<a href="/cashbook/monthList.jsp?targetYear=<%=nextYear%>&targetMonth=<%=nextMonth%>">[다음 달]</a>
	</div>
	<form method="post">
		<table border="1">
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<tr>
				<%
					for(int i=1; i<=total; i++) {
				%>
						<td>
							<%
								if(i-startBlank < 1 || i-startBlank > lastDate) {
							%>		
									&nbsp;
							<%		
								} else {
									int date = i-startBlank;
							%>	
									<a href="">
										<%=date%>
									</a><br>
									<%
										ArrayList<Cash> list = new ArrayList<>();
										String cashDate = String.format("%04d-%02d-%02d", year, month+1, date); // yyyy-mm-dd 형식으로 설정
										// %04 -> 총 4자리로 표현, 부족한만큼 앞을 0으로 채우기 | d -> 정수
										list = csDao.selectCashByDate(cashDate);
										
										for(Cash c : list){ // for(자료형 변수 : 배열) -> 배열에 맞는 자료형 작성
									%>
												[<%=c.getCategory().getKind()%>]&nbsp;
												<%=c.getCategory().getTitle()%><br>
									<%
										}
									%>
							<%		
								}
							%>
						</td>	
				<%		
						if(i % 7 == 0) { // 한 행이 7열이 되도록
				%>
							</tr><tr>
				<%				
						}
					}
				%>
			</tr>
		</table>
	</form>
</body>
</html>
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
<title>Target Year Statistics</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		.controls {
		    display: flex;
		    justify-content: flex-start;
		    align-items: center auto;
		    width: 90%;
		    padding-top: 20px;
		    margin: 0 auto 10px auto;
		}
		
		.controls .left form {
		    display: flex;
		    gap: 10px;
		    align-items: center;
		}
		
		.controls a, .controls button {
		    background-color: #d0f4de;
		    padding: 8px 14px;
		    border-radius: 8px;
		    font-weight: bold;
		    color: #333;
		    text-decoration: none;
		    transition: background-color 0.3s;
		    border: none;
		}
		
		.controls a:hover, .controls button:hover {
		    background-color: #bde0fe;
		}
		
		.controls select {
     	    padding: 8px 12px;
	        border-radius: 8px;
	        border: 2px solid #d0f4de;
	        background-color: #ffffff;
	        font-size: 14px;
	        font-weight: bold;
	        color: #333;
	        transition: border-color 0.3s;
	        cursor: pointer;
	    }
	
	    .controls select:hover {
	        border-color: #bde0fe;
	    }
	</style>
</head>
<body>
	<div class="header">
		<h1>📈 <%=year%>년도 월별 수입/지출 통계</h1>
		<div class="small-links">
		    <a href="/cashbook/statistics/statistics.jsp">📊 이전 페이지</a>
		    <a href="/cashbook/index.jsp">🏠 메인 화면으로</a>
		</div>
	</div>
	<div class="controls">
   		<div class="left">
			<form action="/cashbook/statistics/targetYearStatsByKind.jsp" style="text-align: center;">
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
		</div>
	</div>
		<table>
			 <thead>
	            <tr>
                    <th>월</th>
                    <th>분류</th> <!-- 수입 or 지출 -->
                    <th>건수</th>
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
							<td><%=map.get("kind").equals("수입") ? "💰 수입" : "💸 지출"%></td>
							<td><%=map.get("cnt")%>건</td>
							<td>
								<% 
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
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%
	//로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	
	// dateList.jsp -> 수입/지출 입력(String cashDate) -> 
	String cashDate = request.getParameter("cashDate");
	
	// insertCashForm.jsp -> kind 선택(String kind)
	String kind = request.getParameter("kind");
	
	ArrayList<Category> list = new ArrayList<>();
	if(kind != null) { // insertCashForm.jsp에서 kind 선택 후 재요청
		// DB: 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
	}
		
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Cash</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
	    body {
	        background-color: #f2e8ff;
	        font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	        margin: 0;
	        padding: 0;
	    }
	    .container {
	        width: 400px;
	        margin: 40px auto;
	        background: #ffffff;
	        padding: 30px;
	        border-radius: 15px;
	        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
	   	 	position: relative; 
	    }
	    h1 {
	        text-align: center;
	        color: #4b3c72;
	        margin-bottom: 20px;
	    }
	    form {
	        margin-bottom: 30px;
	    }
	    label {
	        display: block;
	        margin: 10px 0 5px;
	        font-weight: bold;
	        color: #333;
	    }
	    input[type="text"], input[type="date"], select {
	        width: 95%;
	        padding: 8px;
	        margin-bottom: 15px;
	        border: 2px solid #d0f4de;
	        border-radius: 8px;
	        background: #f8f9fa;
	        font-size: 14px;
	    }
	    input[type="text"]:focus, input[type="date"]:focus, select:focus {
	        outline: none;
	        border-color: #c7b8ea;
	        background: #f0f8ff;
	    }
	    input[type="color"] {
		    width: 100px;
		    height: 40px;
		    border: 2px solid #d0f4de;
		    border-radius: 12px;
		    padding: 3px;
		    background-color: #fff;
		    cursor: pointer;
		    margin-bottom: 15px;
		}
		
		input[type="color"]::-webkit-color-swatch {
		    border: none;
		    border-radius: 10px;
		}
		
		input[type="color"]::-webkit-color-swatch-wrapper {
		    padding: 5px;
		}
	    
	    button {
	        width: 100%;
	        padding: 10px;
	        background-color: #e1d8ff;
	        color: #333;
	        border: none;
	        border-radius: 8px;
	        font-weight: bold;
	        font-size: 16px;
	        transition: background-color 0.3s;
	        cursor: pointer;
	        margin-top: 10px;
	    }
	    button:hover {
	        background-color: #c7b8ea;
	    }
	    
	    select {
		    width: 100%;
		    height: 40px;
		    border: 2px solid #d0f4de;
		    border-radius: 12px;
		    padding: 5px 10px;
		    background-color: #fff;
		    box-sizing: border-box;
		}
			
		.back-link {
		    position: absolute;
		    top: 15px;
		    right: 20px;
		    font-size: 14px;
		    text-decoration: none;
		    color: #4b3c72;
		    font-weight: bold;
		    transition: color 0.3s;
		}
		
		.back-link:hover {
		    color: #8e7cc3;
		}
		    
	</style>
</head>
<body>
	<div class="container">
	    <a href="/cashbook/dateList.jsp?cashDate=<%=cashDate%>" class="back-link">↩️ 이전 페이지</a>
		<h1>☑️ 수입/지출 선택</h1>

		<form action="/cashbook/cash/insertCashForm.jsp" method="post">
			<input type="hidden" name="cashDate" value="<%=cashDate%>"> <!-- cashDate값이 안 넘어가니까 넘겨주기 -->
			<label for="kind">분류</label>
			<select name="kind" id="kind">
				<option value="">☑️ 선택</option> <!-- value값이 없으면 action이 value가 됨 -->
				<option value="수입" <% if(kind != null && kind.equals("수입")) {%> selected <%} %>>💰 수입</option> 
				<option value="지출" <% if(kind != null && kind.equals("지출")) {%> selected <%} %>>💸 지출</option>
			</select>
			<button type="submit">선택하기</button>
		</form>
	</div>	

	<div class="container">
		<h1>➕ 내역 추가</h1>
		<form action="/cashbook/cash/insertCashAction.jsp" method="post">
			<!-- label 태그: for 속성을 주면, 해당 id를 가진 input 태그와 연결됨 -->
			<label for="cashDate">날짜</label>
			<input type="date" name="cashDate" id="cashDate" value="<%=cashDate%>" readonly><br>
			
			<label for="categoryNo">카테고리</label>
			<select name="categoryNo" id="categoryNo">
			<%
				if (list != null) {
					for (Category c : list) {
			%>
						<option value="<%=c.getCategoryNo()%>"><%=c.getTitle()%></option>
			
			<%
					}
				}
			%>
			</select>
			
			<label for="amount">금액</label>
			<input type="text" name="amount" id="amount"><br>
			
			<label for="memo">메모</label>
			<input type="text" name="memo" id="memo"><br>
	
			<label for="color">색상</label>
			<input type="color" name="color" id="color"><br>
			
			<button type="submit">추가하기</button>
		</form>
	</div>	
</body>
</html>
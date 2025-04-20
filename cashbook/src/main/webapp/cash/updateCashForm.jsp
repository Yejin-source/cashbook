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
	
	
	// 필요한 값 가져오기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	// 값 확인
	System.out.println("updateCashForm.jsp cashNo: " + cashNo);
	System.out.println("updateCashForm.jsp cashDate: " + cashDate);
	
	
	// 객체 형성 및 cashDao 사용
	Cash c = new Cash();
	CashDao cd = new CashDao();
	c = cd.selectCashOne(cashNo);
	
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Cash</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		label {
	        display: block;
	        margin-bottom: 5px;
	        font-weight: bold;
	        color: #333;
	        font-size: 14px;
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
	</style>
</head>
<body>
	<div class="header">
		<h2><%=cashDate%></h2>
		<h1>
			[<%=c.getCategory().getKind().equals("수입") ? "💰수입" : "💸지출"%>] 
			<%=c.getCategory().getTitle()%> 정보 수정
		</h1>
		 <div class="small-links">
		    <a href="/cashbook/cash/cashOne.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">↩️ 이전 페이지</a>
		</div>
	</div>
	 <div class="card">
		<form action="/cashbook/cash/updateCashAction.jsp" method="post">
			<label for="amount">금액</label>
			<input type="text" name="amount" value="<%=c.getAmount()%>">				
			
			<label for="memo">메모</label>
			<input type="text" name="memo" value="<%=c.getMemo()%>" placeholder="메모 입력">
			
			<label for="color">색상</label>
			<input type="color" name="color" value="<%=c.getColor()%>">
			
			<label for="createdate">생성일</label>
			<input type="text" name="createdate" value="<%=c.getCreatedate().substring(0,10)%>" readonly>
			
			<label for="updatedate">갱신일</label>
			<input type="text" name="createdate" value="<%=c.getUpdatedate().substring(0,10)%>" readonly>
				
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			<input type="hidden" name="cashDate" value="<%=cashDate%>">
			<button type="submit">📝 수정하기</button>
		</form>
	</div>
</body>
</html>
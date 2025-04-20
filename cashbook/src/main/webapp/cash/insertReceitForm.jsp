<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

	// 받은 값 확인
	System.out.println("insertReceitForm.jsp cashNo: " + cashNo);
	System.out.println("insertReceitForm.jsp cashDate: " + cashDate);

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Receipt</title>
	<style>
	    body {
	        background-color: #f2e8ff;
	        font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	        margin: 0;
	        padding: 0;
	    }
	    .card {
	        width: 400px;
	        margin: 50px auto;
	        background: #ffffff;
	        padding: 30px;
	        border-radius: 15px;
	        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
	        position: relative;
	    }
	    h1 {
	        text-align: center;
	        color: #4b3c72;
	        margin-bottom: 30px;
	        font-size: 24px;
	    }
	    form {
	        margin-top: 20px;
	    }
	    input[type="file"] {
	        width: 96%;
	        padding: 5px;
	        margin-bottom: 30px;
	        border: 2px solid #d0f4de;
	        border-radius: 8px;
	        background: #f8f9fa;
	        font-size: 14px;
	    }
	    input[type="file"]::file-selector-button {
	        background-color: #e1d8ff;
	        color: #333;
	        border: none;
	        padding: 8px 16px;
	        border-radius: 8px;
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s;
	    }
	    input[type="file"]::file-selector-button:hover {
	        background-color: #c7b8ea;
	    }
	    button {
	        width: 100%;
	        padding: 12px;
	        background-color: #e1d8ff;
	        color: #333;
	        border: none;
	        border-radius: 8px;
	        font-weight: bold;
	        font-size: 16px;
	        transition: background-color 0.3s;
	        cursor: pointer;
	    }
	    button:hover {
	        background-color: #c7b8ea;
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
	<div class="card">
		<a href="/cashbook/dateList.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>" class="back-link">↩️ 이전 페이지</a>
    	<h1>🧾 영수증 등록</h1>
		    <%
		    	if(request.getParameter("msg") != null) {
		    %>
		    		<div><%=request.getParameter("msg")%></div>
		    <%		
		    	}
		    %>
	    <form action="/cashbook/cash/insertReceitAction.jsp" method="post" enctype="multipart/form-data">
	    <!-- enctype="application/x-www-form-urlencoded" -> 디폴트값_문자열 -->
	    	<input type="hidden" name="cashNo" value="<%=cashNo%>">
	    	<input type="hidden" name="cashDate" value="<%=cashDate%>">
	    	
			<input type="file" name="receit">
			
			<button type="submit">등록하기</button>
		</form>
	</div>
</body>
</html>
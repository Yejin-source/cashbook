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
	System.out.println("insertReceitAction.jsp cashNo: " + cashNo);
	System.out.println("deleteReceit.jsp cashDate: " + cashDate);

%>

<!-- View -->
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
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
		<div>영수증: <input type="file" name="receit" /></div>
		<button type="submit">영수증 등록</button>
    </form>
    </body>
</html>
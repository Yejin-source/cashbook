<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Controller -->
<%
	session.invalidate(); // 세션 종료
	response.sendRedirect("/cashbook/login/loginForm.jsp"); // 로그인 페이지로 이동	
%>
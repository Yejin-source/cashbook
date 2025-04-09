<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<!-- Controller -->
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	// 요청받은 값 확인
	System.out.println("loginAction.jsp id: " + id);
	System.out.println("loginAction.jsp pw: " + pw);
	
	// model 객체 생성
	AdminDao adminDao = new AdminDao();
	Admin admin = new Admin();
	// 로그인 메서드 사용
	admin = adminDao.loginAdminPw(id, pw);
	
	if(admin != null) { // 로그인 성공 시 카테고리 목록으로 redirect
		response.sendRedirect("/cashbook/categoryList.jsp");
	} else { // 로그인 실패 시 로그인 홈으로
		System.out.println("아이디 혹은 비밀번호가 일치하지 않습니다.");
		response.sendRedirect("/cashbook/loginForm.jsp");
	}
%>
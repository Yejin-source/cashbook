<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<!-- Controller -->
<%
	// 사용자로부터 입력받은 값 추출
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	// 입력받은 값 확인
	System.out.println("loginAction.jsp id: " + id);
	System.out.println("loginAction.jsp pw: " + pw);
	
	// AdminDao(medel) 호출
	AdminDao adminDao = new AdminDao();
	Admin admin = new Admin();
	
	// 로그인 메서드 실행
	admin = adminDao.loginAdminPw(id, pw);

	// 로그인 실패 시 admin값이 비어 있어서 오류 발생 -> adminDao.loginAdminPw 일부 수정
	if(admin.getId() != null) { // 로그인 성공 시 카테고리 목록으로 redirect
		System.out.println("환영합니다.");
		session.setAttribute("id", admin.getId()); // key값으로 object(value)를 찾는다고 생각하기
		response.sendRedirect("/cashbook/category/categoryList.jsp");
	} else { // 로그인 실패 시 로그인 홈으로
		System.out.println("아이디 혹은 비밀번호가 일치하지 않습니다.");
		response.sendRedirect("/cashbook/login/loginForm.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>

<!-- Controller -->
<%	
	// 사용자로부터 입력받은 값 추출
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String newPw = request.getParameter("newPw");
	String newPwCheck = request.getParameter("newPwCheck");
	
	// 입력받은 값 확인
	System.out.println("updateAdminPwAction.jsp id: " + id);
	System.out.println("updateAdminPwAction.jsp pw: " + pw);
	System.out.println("updateAdminPwAction.jsp newPw: " + newPw);
	System.out.println("updateAdminPwAction.jsp newPwCheck: " + newPwCheck);
	
	
	// 새 비밀번호 확인이 일치하지 않으면
	if(!newPw.equals(newPwCheck)) {
	    response.sendRedirect("/cashbook/updateAdminPwForm.jsp"); // 비밀번호 변경 폼으로 리디렉션
	    return; // 코드 실행 중단
	}
	
	// AdminDao(model) 객체 생성 후 비밀번호 변경 메서드 호출
	AdminDao admindao = new AdminDao();
	admindao.updateAdminPw(id, pw, newPw);

	// 비밀번호 변경 후 로그인 페이지로 redirect
	response.sendRedirect("/cashbook/loginForm.jsp");
%>
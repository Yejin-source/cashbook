<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 사용자로부터 입력받은 값 추출
	int no = Integer.parseInt(request.getParameter("no")); // 오류 수정해야 함
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");

	// 입력받은 값 확인
	System.out.println("updateCategoryTitleAction.jsp no: " + no);
	System.out.println("updateCategoryTitleAction.jsp kind: " + kind);
	System.out.println("updateCategoryTitleAction.jsp title: " + title);
	
	// 객체 생성 후 CategoryDao 실행
	CategoryDao categorydao = new CategoryDao();
	categorydao.updateCategoryTitle(title, no);

	// 수정 완료 시 카테고리 목록으로
	response.sendRedirect("/cashbook/categoryList.jsp");
%>
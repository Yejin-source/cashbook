<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 필요한 값 받아오기
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));

	// 받은 값 확인
	System.out.println("deleteCategory.jsp cetegoryNo: " + categoryNo);
	
	// 객체 생성 후 categoryDao 실행
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategory(categoryNo);
	
	// 삭제 성공 시 카테고리 목록으로
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>
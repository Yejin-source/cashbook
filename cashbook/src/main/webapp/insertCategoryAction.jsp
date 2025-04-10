<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 사용자로부터 입력받은 값 추출
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	// 입력받은 값 확인
	System.out.println("insertCategoryAction.jsp kind: " + kind);
	System.out.println("insertCategoryAction.jsp title: " + title);
	
	// dto 객체 생성
	Category category = new Category();
	category.setKind(kind);
	category.setTitle(title);
	
	// Dao 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	// 카테고리 추가 성공 시 카테고리 목록으로 
	response.sendRedirect("/cashbook/categoryList.jsp");
%>
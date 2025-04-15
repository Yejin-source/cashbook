<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 필요한 값 받아오기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));

	// 받은 값 확인
	System.out.println("deleteCash.jsp cashNo: " + cashNo);
	
	// 객체 생성 후 categoryDao 실행
	CashDao cd = new CashDao();
	cd.deleteCash(cashNo);
	
	// 삭제 성공 시 달력으로
	response.sendRedirect("/cashbook/monthList.jsp");
%>
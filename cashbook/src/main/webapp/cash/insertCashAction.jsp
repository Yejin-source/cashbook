<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- View -->
<%
	// 입력된 값 받아오기
	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.valueOf(request.getParameter("categoryNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");

	// 받은 값 확인
	System.out.println("insertCashAction.jsp cashDate: " + cashDate);
	System.out.println("insertCashAction.jsp categoryNo: " + categoryNo);
	System.out.println("insertCashAction.jsp amount: " + amount);
	System.out.println("insertCashAction.jsp memo: " + memo);
	System.out.println("insertCashAction.jsp color: " + color);
	
	// Cash 객체 생성 후
	Cash c = new Cash();
	c.setCashDate(cashDate);
	c.setCategoryNo(categoryNo);
	c.setAmount(amount);
	c.setMemo(memo);
	c.setColor(color);
	
	// Dao 실행
	CashDao cd = new CashDao();
	cd.insertCash(c);
	
	// cash 추가 성공 시
	response.sendRedirect("/cashbook/dateList.jsp?cashDate="+cashDate);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 입력된 값 받아오기
	String cashDate = request.getParameter("cashDate");
	int cashNo = Integer.valueOf(request.getParameter("cashNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");

	// 받은 값 확인
	System.out.println("updateCashAction.jsp cashDate: " + cashDate);
	System.out.println("updateCashAction.jsp cashNo: " + cashNo);
	System.out.println("updateCashAction.jsp amount: " + amount);
	System.out.println("updateCashAction.jsp memo: " + memo);
	System.out.println("updateCashAction.jsp color: " + color);
	
	// Cash 객체 생성 후
	Cash up = new Cash();
	up.setCashDate(cashDate);
	up.setCashNo(cashNo);
	up.setAmount(amount);
	up.setMemo(memo);
	up.setColor(color);
	
	// Dao 실행
	CashDao cd = new CashDao();
	cd.updateCash(up);
	
	// cash 수정 성공 시
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo="+cashNo+"&cashDate="+cashDate);
%>

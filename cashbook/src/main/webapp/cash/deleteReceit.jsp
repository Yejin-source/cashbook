<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 필요한 값 받아오기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");

	// 받은 값 확인
	System.out.println("deleteReceit.jsp cashNo: " + cashNo);
	System.out.println("deleteReceit.jsp cashDate: " + cashDate);
	
	// 객체 생성 후 ReceitDao 실행
	ReceitDao rd = new ReceitDao();
	rd.deleteReceit(cashNo);
	
	// 삭제 성공 시 기존 페이지로 리다이렉트
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo="+cashNo+"&cashDate="+cashDate);
%>
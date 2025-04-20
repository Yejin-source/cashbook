<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<!-- Controller -->
<%
	// 로그인 상태 확인
	String login = (String)(session.getAttribute("id"));
	if(login == null) { // 로그아웃 상태라면
		response.sendRedirect("/cashbook/login/loginForm.jsp");
		return; // 코드 실행 중단
	}
	
	// 요청받은 값 가져오기
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	// 받은 값 확인
	System.out.println("updateCategoryTitleForm.jsp categoryNo: " + categoryNo);
	
	
	// 객체 생성
	Category c = new Category();
	CategoryDao categoryDao = new CategoryDao();
	c = categoryDao.selectCategoryOne(categoryNo);

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Category Title</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		/* 라디오 버튼 숨기기 */
		input[type="radio"] {
		    display: none;
		}
		
		/* 라디오 스타일 */
	    .radio-label {
	        display: inline-block;
	        border-radius: 8px;
	        padding: 10px 20px;
	        font-weight: bold;
	        margin-right: 10px;
	        background-color: #f2f2f2;
	        color: #666;
	        border: 1px solid #ddd;
	    }
	    
	    input[type="radio"]:checked + .radio-label {
    background-color: #cdb4db; /* 연보라색! */
    color: #333;
    border: 2px solid #b28dd0;
}
	</style>
</head>
<body class="d-flex flex-column align-items-center justify-content-center" style="min-height: 100vh; background-color: #f2e8ff;">

	<div class="card position-relative">
	
	    <!-- 카드 위에 카테고리 목록 링크 -->
	    <div style="width: 400px; margin: 0 auto; display: flex; justify-content: flex-end; margin-bottom: 10px;">
	        <a href="/cashbook/category/categoryList.jsp" class="go-back-link">↩️ 이전 페이지</a>
	    </div>
	
	    <h2 style="margin-top: 10px;">✏️ 카테고리 제목 수정</h2>
	
	    <form action="/cashbook/category/updateCategoryTitleAction.jsp" method="post">
	        <!-- hidden으로 categoryNo 전송 -->
	        <input type="hidden" name="categoryNo" value="<%=c.getCategoryNo()%>">
	
	        <!-- 번호 -->
	        <div class="mb-3">
	            <label class="form-label fw-bold">번호</label>
	            <input type="text" value="<%=c.getCategoryNo()%>" readonly>
	        </div>
	
	        <!-- 분류 -->
	        <div class="mb-3 d-flex align-items-center" style="margin-bottom: 20px;">
	            <label class="form-label fw-bold me-3" style="margin-bottom: 0; margin-right:15px;">분류</label>
	
	            <input type="radio" id="expense" name="kind" value="지출" <%=c.getKind().equals("지출") ? "checked" : ""%> disabled>
	            <label for="expense" class="radio-label">💸 지출</label>
	
	            <input type="radio" id="income" name="kind" value="수입" <%=c.getKind().equals("수입") ? "checked" : ""%> disabled>
	            <label for="income" class="radio-label">💰 수입</label>
	        </div>
	
	        <!-- 제목 -->
	        <div class="mb-3">
	            <label class="form-label fw-bold">제목</label>
	            <input type="text" name="title" value="<%=c.getTitle()%>" required>
	        </div>
	
	        <!-- 수정 버튼 -->
	        <button type="submit" class="btn-submit">수정</button>
	    </form>
	</div>
</body>
</html>
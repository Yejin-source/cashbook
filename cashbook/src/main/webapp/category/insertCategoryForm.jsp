<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Category</title>
	<link rel="stylesheet" type="text/css" href="/cashbook/css/common.css">
	<style>
		input[type="text"]:focus {
		    border: 1px solid #c7b8ea; /* 포커스 시 연보라 테두리 */
		}
		
		/* 라디오 버튼 숨기기 */
		input[type="radio"] {
		    display: none;
		}
		
		/* 라디오 버튼 대신 보이는 박스 스타일 */
		.radio-label {
		    display: inline-block;
		    border-radius: 8px;
		    padding: 10px 20px;
		    font-weight: bold;
		    cursor: pointer;
		    margin-right: 10px;
		    transition: all 0.3s ease;
		    text-align: center;
		}
		
		/* 지출 라디오 스타일 */
		.radio-expense {
		    background-color: #ffd5e5; /* 연분홍 */
		    color: #333;
		    border: 1px solid #ffd5e5;
		}
		
		/* 수입 라디오 스타일 */
		.radio-income {
		    background-color: #d0f4de; /* 연초록 */
		    color: #333;
		    border: 1px solid #d0f4de;
		}
		
		/* hover 효과 */
		.radio-label:hover {
		    opacity: 0.8;
		}
		
		/* 선택됐을 때 (공통) */
		input[type="radio"]:checked + .radio-label {
		    border: 2px solid #999;
		}
		
		/* 돌아가기 링크 카드 왼쪽 위에 */
		.card-top-left {
		    position: absolute;
		    top: 20px;
		    left: 20px;
		}
	</style>
</head>
<body class="d-flex flex-column align-items-center justify-content-center" style="min-height: 100vh; background-color: #f2e8ff;">
		
	<div class="card position-relative">
	
		<div style="width: 400px; margin: 0 auto; display: flex; justify-content: flex-end; margin-bottom: 10px;">
		    <a href="/cashbook/category/categoryList.jsp" class="go-back-link">↩️ 이전 페이지</a>
		</div>
		
	    <h2 style="margin-top: 10px;">➕ 카테고리 추가</h2>
	
	    <form action="/cashbook/category/insertCategoryAction.jsp" method="post">
	        <!-- 분류 -->
	       <div class="mb-3 d-flex align-items-center" style="margin-bottom: 20px;">
			    <label class="form-label fw-bold me-3" style="margin-bottom: 0; margin-right:15px;">분류</label>
		
		        <input type="radio" id="expense" name="kind" value="지출" required>
		        <label for="expense" class="radio-label radio-expense" style="margin-right:15px;">💸 지출</label>
		
		        <input type="radio" id="income" name="kind" value="수입" required>
		        <label for="income" class="radio-label radio-income">💰 수입</label>
			</div>
	
	        <!-- 제목 -->
	        <div class="mb-3">
	            <label class="form-label fw-bold">제목</label>
	            <input type="text" name="title" required>
	        </div>
	
	        <!-- 추가 버튼 -->
	        <button type="submit" class="btn-submit">추가</button>
	    </form>
	</div>
</body>
</html>
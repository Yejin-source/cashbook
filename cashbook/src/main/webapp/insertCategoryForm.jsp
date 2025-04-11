<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<form action="insertCategoryAction.jsp" method="post">
		<table class="table table-striped table-hover">
			<tr>
				<th>종류</th>
				<td>
					<input type="radio" name="kind" value="expense"> 지출 <br>
					<input type="radio" name="kind" value="income"> 수입
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
		</table>
	<button type="submit">추가</button>
	</form>
</body>
</html>
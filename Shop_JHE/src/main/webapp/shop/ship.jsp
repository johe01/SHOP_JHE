<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String root = request.getContextPath();

ProductRepository productDAO = new ProductRepository();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<div class="py-5 text-center">
		<h1 class="fw-bold">배송 정보</h1>

	</div>
	<div class="container shop m-auto mb-5">
		<form action="order.jsp" name="shipForm" method="post"
			enctype="multipart/form-data">

			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">성명</label> <input
					type="text" class="form-control col-md-10" name="name">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">배송일</label> <input
					type="text" class="form-control col-md-10" name="date">
			</div>

			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">국가명</label> <input
					type="text" class="form-control col-md-10" name="country">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">우편번호</label> <input
					type="text" class="form-control col-md-10" name="postnum">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">주소</label> <input
					type="text" class="form-control col-md-10" name="address">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">전화번호</label> <input
					type="text" class="form-control col-md-10" name="telnum" required>
			</div>

			<div class="d-flex justify-content-between mt-5 mb-5">
				<div>
					<a href="<%=root%>/shop/products.jsp" onclick="history.back(); return false;" class="btn btn-success">이전</a>
					<a href="<%=root%>/index.jsp" class="btn btn-danger">취소</a>
				</div>
				<input type="submit" class="btn btn-primary" value="등록" />
			</div>
		</form>

	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
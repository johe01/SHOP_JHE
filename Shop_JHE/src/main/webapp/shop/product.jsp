<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	String productId = request.getParameter("id");
	ProductRepository productDAO = new ProductRepository();
	Product product = productDAO.getProductById(productId);
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
		<h1 class="fw-bold">상품 정보</h1>
		<div>
			<p>Shop 쇼핑몰 입니다.</p>
			<div class="d-flex justify-content-center">
				<button type="button"
					onclick="location.href='<%=root%>/shop/products.jsp';"
					class="btn btn-primary px-4 gap-3">상품 목록</button>
			</div>
		</div>
	</div>
	<div class="container">
	<div class="row">
	<div class="col-sm-6">
		<img src="<%=root %>/<%=product.getFile() %>" class="card-img-top" alt="이미지">
	</div>
	<div class="col-sm-6">
		<h2><%= product.getName() %></h2>
		<div class="pt-5">
			<div class="border-bottom row py-2">
				<div class="col-sm-4">상품ID :</div>
				<div class="col-sm-8"><%= product.getProductId() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">제조사 :</div>
				<div class="col-sm-8"><%= product.getManufacturer() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">분류 :</div>
				<div class="col-sm-8"><%= product.getCategory() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">상태 :</div>
				<div class="col-sm-8"><%= product.getCondition() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">재고 수 :</div>
				<div class="col-sm-8"><%= product.getQuantity() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">가격 :</div>
				<div class="col-sm-8"><%= product.getUnitPrice() %></div>
			</div>
		</div>
		<div class="pt-4 d-flex justify-content-center">
			<button type="button"
				onclick="location.href='<%=root%>/shop/cart.jsp';"
				class="btn btn-warning px-4 gap-3 me-5">장바구니</button>
			<button type="button"
				onclick="location.href='<%=root%>/shop/addCart.jsp';"
				class="btn btn-success px-4 gap-3 me-5">주문하기</button>
		</div>
	</div>
		
	</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
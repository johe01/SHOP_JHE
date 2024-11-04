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
		<h1 class="fw-bold">주문 완료</h1>
	</div>
	<div class="container d-flex justify-content-center px-5 pt-5">
	<div class="row">
	<h2 class="text-center">주문이 완료 되었습니다.</h2>
		<div class="pt-2 pb-3">
			<div class="border-bottom row py-2">
				<div class="col-sm-4">주문 번호 :</div>
				<div class="col-sm-8"><%= product.getProductId() %></div>
			</div>
			<div class="border-bottom row py-2">
				<div class="col-sm-4">배송지 :</div>
				<div class="col-sm-8">부평동 스테이션 타워</div>
			</div>
			
		</div>
		<div class="d-flex justify-content-center">
				<button type="button"
					onclick="location.href='<%=root%>/user/order.jsp';"
					class="btn btn-primary px-4 gap-3">주문내역</button>
			</div>
		
	</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
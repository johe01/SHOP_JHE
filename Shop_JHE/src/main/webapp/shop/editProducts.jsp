<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String root = request.getContextPath();

ProductRepository productDAO = new ProductRepository();
List<Product> productList = productDAO.list();

String keyword = request.getParameter("keyword");
if (keyword != null && !keyword.isEmpty()){
	productList = productDAO.list(keyword);	
}
int count = productList.size();
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
		<h1 class="fw-bold">상품 목록</h1>
		<div>
			<p>쇼핑몰 상품 목록 입니다.</p>
			<div class="d-flex justify-content-center">
				<button type="button"
					onclick="location.href='<%=root%>/shop/add.jsp';"
					class="btn btn-primary px-4 gap-3 me-1">상품 등록</button>
				<button type="button"
					onclick="location.href='<%=root%>/shop/editProducts.jsp';"
					class="btn btn-success px-4 gap-3 me-1">상품 편집</button>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<%	for(int i=0; i<count; i++) {
			%>
			<div class="col-md-6 col-xl-4 col-xxl-3 pb-4 d-flex justify-content-center">
				<div class="card" style="width: 18rem; height: 380px;">
					<img src="<%=root %>/<%=productList.get(i).getFile() %>" class="card-img-top" alt="이미지">
					<div class="card-body d-flex flex-column">
						<h5 class="card-title text-center"><%= productList.get(i).getName() %></h5>
						<p class="card-text"><%= productList.get(i).getDescription() %></p>
						<p class="card-text text-end"><b>&#8361; <%= productList.get(i).getUnitPrice() %></b></p>
						<div class="d-flex justify-content-end mt-auto">
							<a class="btn btn-primary me-2" href="<%=root %>/shop/update.jsp?id=<%= productList.get(i).getProductId() %>" role="button">수정</a>
							<a class="btn btn-danger me-2" href="<%= root %>/shop/delete_pro.jsp?id=<%= productList.get(i).getProductId() %>" role="button">삭제</a>							
						</div>
					</div>
				</div>
			</div>
			<%} %>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
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
		<h1 class="fw-bold">상품 수정</h1>
		<div>
			<p>Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	<div class="container shop m-auto mb-5">
		<form action="update_pro.jsp" name="updateForm" method="post">
			<img class="col-md-12 mb-3" alt="이미지" src="<%=root%>/<%=product.getFile()%>">
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="img">상품 이미지</label>
				<!-- 버튼 넣기 -->
				
				<input
					type="text" class="form-control col-md-10" name="img"
					placeholder="선택된 파일 없음">
			</div>

			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="id">상품 코드</label> <input
					type="text" class="form-control col-md-10" name="id" value="<%= product.getProductId() %>" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="name">상품명</label> <input
					type="text" class="form-control col-md-10" name="name" value="<%= product.getName() %>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="price">가격</label> 
				<input type="text" class="form-control col-md-10" name="price" value="<%= product.getUnitPrice() %>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-12" id="price">상세 정보</label>
			 	<textarea class="form-control col-md-12" name="description" rows="6"><%= product.getDescription() %></textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="manufacturer">제조사</label> <input
					type="text" class="form-control col-md-10" name="manufacturer" value="<%= product.getManufacturer() %>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="category">분류</label> <input
					type="text" class="form-control col-md-10" name="category" value="<%= product.getCategory() %>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="quantity">재고 수</label> <input
					type="text" class="form-control col-md-10" name="quantity" value="<%= product.getQuantity() %>">
			</div>
			<div class="input-group mb-3 row">
				<div class="col-md-2 p-0">
					<label class="input-group-text" id="condition">상태</label>
				</div>
				<div class="col-md-10 d-flex align-items-center justify-content-around">
					<input type="hidden" name="temp-condition" value="<%= product.getCondition() %>"
								   id="temp-condition" />
					<div class="radio-box d-flex">
						<div class="radio-item mx-3">
							<input type="radio" class="form-check-input" name="condition"
								value="NEW" id="condition-new"> <label
								for="condition-new">신규 제품</label>
						</div>

						<div class="radio-item mx-3">
							<input type="radio" class="form-check-input " name="condition"
								value="USED" id="condition-used"> <label
								for="condition-used">중고 제품</label>
						</div>
						<div class="radio-item mx-3">
							<input type="radio" class="form-check-input " name="condition"
								value="PLAY" id="condition-play"> <label
								for="condition-play">재생 제품</label>
						</div>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-between mt-5 mb-5">
				<a href="<%=root %>/shop/products.jsp" class="btn btn-secondary">목록</a> 
				<input type="submit" class="btn btn-success" value="수정" />
			</div>
		</form>

	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
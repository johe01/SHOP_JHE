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
		<h1 class="fw-bold">상품 등록</h1>
		<div>
			<p>Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	<div class="container shop m-auto mb-5">
		<form action="add_pro.jsp" name="addForm" onsubmit="return checkAdd()" method="post" enctype="multipart/form-data">

			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="img">상품 이미지</label>
				
				<input
					type="file" name="imgfile" class="form-control col-md-10"
					placeholder="선택된 파일 없음">
			</div>

			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 코드</label> <input
					type="text" class="form-control col-md-10" name="id" required>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품명</label> <input
					type="text" class="form-control col-md-10" name="name">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">가격</label> 
				<input type="text" class="form-control col-md-10" name="price">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-12" id="">상세 정보</label>
			 	<textarea class="form-control col-md-12" name="description" rows="6"></textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">제조사</label> <input
					type="text" class="form-control col-md-10" name="manufacturer">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">분류</label> <input
					type="text" class="form-control col-md-10" name="category">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label> <input
					type="text" class="form-control col-md-10" name="quantity">
			</div>
			<div class="input-group mb-3 row">
				<div class="col-md-2 p-0">
					<label class="input-group-text" id="condition">상태</label>
				</div>
				<div class="col-md-10 d-flex align-items-center justify-content-around">
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
				<input type="submit" class="btn btn-primary" value="등록" />
			</div>
		</form>

	</div>
	<script>
	function checkAdd() {
		let form = document.addForm
			
		let id = form.id	
		let msg = ''
		
		let idCheck = /^P\d{6}$/
		msg = '상품 코드는 영문자 P로 시작하고, 숫자가 6자리여야 합니다.'
		if (!check(idCheck, id, msg)) return false
		
		return true
	}
	</script>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
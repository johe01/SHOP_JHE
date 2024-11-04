<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
	String root = request.getContextPath();
	// ...
	String loginId = (String) session.getAttribute("loginId");

	boolean login = false;
	if (loginId != null && !loginId.isEmpty()) {
		// response.sendRedirect(root);
		login = true;
	}

	List<Product> cartList = new ArrayList<Product>();
	int cartCount = 0;

	cartList = (List<Product>) session.getAttribute("cartList");
	if (cartList == null) {
		cartList = new ArrayList<>(); // 빈 리스트로 초기화하여 NullPointerException 방지
	}

	cartCount = cartList.size();
	%>

	<jsp:include page="/layout/header.jsp" />

	<div class="row m-0 mypage">
		<div
			class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
			<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary">
				<ul class="nav nav-pills flex-column mb-auto">
					<!-- 로그인 시 -->
					<%
					if (login) {
					%>
					<li class="nav-item"><a href="<%=root%>/user/index.jsp"
						class="nav-link link-body-emphasis"> 마이 페이지 </a></li>
					<li class="nav-item"><a href="<%=root%>/user/update.jsp"
						class="nav-link link-body-emphasis"> 회원정보 수정 </a></li>
					<%
					}
					%>

					<li><a href="#" class="nav-link active" aria-current="page">
							주문내역 </a></li>
				</ul>
				<hr>
			</div>
		</div>

		<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
			<div class="px-4 py-3 my-3 text-center">
				<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
			</div>

			<!-- 주문 내역 영역 -->
			<div class="container shop m-auto mb-5">
				<div class="pt-5">
					<div class="border-bottom row py-2">
						<div class="col-sm-4">주문 형태 :</div>
						<% if(!login) {%>
						<div class="col-sm-8">비회원 주문</div>
						<%} else { %>
						<div class="col-sm-8">회원 주문</div>
						<%} %>
					</div>
					<div class="border-bottom row py-2">
						<div class="col-sm-4">성명 :</div>
						<div class="col-sm-8"><%=request.getAttribute("name")%></div>
					</div>
					<div class="border-bottom row py-2">
						<div class="col-sm-4">우편번호 :</div>
						<div class="col-sm-8"><%=request.getAttribute("postnum")%></div>
					</div>
					<div class="border-bottom row py-2">
						<div class="col-sm-4">주소 :</div>
						<div class="col-sm-8"><%=request.getAttribute("address")%></div>
					</div>
					<div class="border-bottom row py-2">
						<div class="col-sm-4">배송일 :</div>
						<div class="col-sm-8"><%=request.getAttribute("date")%></div>
					</div>
					<div class="border-bottom row py-2">
						<div class="col-sm-4">전화번호 :</div>
						<div class="col-sm-8"><%=request.getAttribute("telnum")%></div>
					</div>
				</div>
				<table
					class="table table-striped table-hover table-bordered text-center align-middle">
					<thead>
						<tr class="table-primary">
							<th>상품</th>
							<th>가격</th>
							<th>수량</th>
							<th>소계</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<%
						int sum = 0;
						for (int i = 0; i < cartCount; i++) {
							Product product = cartList.get(i);
							int total = product.getUnitPrice() * product.getAmount();
							sum += total;
						%>
						<tr>

							<td><%=product.getName()%></td>
							<td><%=product.getUnitPrice()%></td>
							<td><%=product.getAmount()%></td>
							<td><%=total%></td>
							<td></td>
						</tr>
						<%
						}
						%>
					</tbody>
					<tfoot>
						<%
						if (cartList.isEmpty()) {
						%>
						<tr>
							<td colspan="5">추가된 상품이 없습니다.</td>
						</tr>
						<%
						} else {
						%>
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td id="cart-sum"><%=sum%></td>
							<td></td>
						</tr>
						<%
						}
						%>
					</tfoot>
				</table>
				<div class="d-flex justify-content-between mt-5 mb-5">
				<div>
					<a href="<%=root%>/shop/products.jsp" onclick="history.back(); return false;" class="btn btn-success">이전</a>
					<a href="<%=root%>/index.jsp" class="btn btn-danger">취소</a>
				</div>
				<a href="<%=root%>/shop/complete.jsp" class="btn btn-primary" >주문완료</a>
			</div>

			<jsp:include page="/layout/footer.jsp" />
		</div>
	</div>

	<jsp:include page="/layout/script.jsp" />

</body>
</html>

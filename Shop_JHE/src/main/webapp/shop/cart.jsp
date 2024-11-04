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
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% 
		String root = request.getContextPath();	
		// ...
		String loginId = (String) session.getAttribute("loginId");
		
		boolean login = false;
		if( loginId != null && !loginId.isEmpty() ) {
			// response.sendRedirect(root);
			login = true;
		}
		
		List<Product> cartList= new ArrayList<Product>();
		int cartCount=0;

			
		cartList = (List<Product>)session.getAttribute("cartList");
		if (cartList == null) {
			cartList = new ArrayList<>(); // 빈 리스트로 초기화하여 NullPointerException 방지
		}
		
		cartCount = cartList.size();

	%>
	
	<jsp:include page="/layout/header.jsp" />
	
	<div class="row m-0 mypage">
		<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
			<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary">
			    <ul class="nav nav-pills flex-column mb-auto">
			      <!-- 로그인 시 -->
			      <% if( login ) { %>
			      <li class="nav-item">
			        <a href="<%= root %>/user/index.jsp" class="nav-link link-body-emphasis">
			          마이 페이지
			        </a>
			      </li>
			      <li class="nav-item">
			        <a href="<%= root %>/user/update.jsp" class="nav-link link-body-emphasis">
			          회원정보 수정
			        </a>
			      </li>
			      <% }  %>
			      
			      <li>
			        <a href="#" class="nav-link active" aria-current="page" >
			          주문내역
			        </a>
			      </li>
			    </ul>
			    <hr>
			  </div>
		</div>
		
		<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
			<div class="px-4 py-3 my-3 text-center">
				<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
				<div class="col-lg-6 mx-auto">	
						<p class="lead mb-4">장바구니 목록 입니다.</p>
				</div>
			</div>
			
			<!-- 주문 내역 영역 -->
			<div class="container shop m-auto mb-5">
					
				<table class="table table-striped table-hover table-bordered text-center align-middle">
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
							for(int i = 0 ; i < cartCount ; i++) {
								Product product = cartList.get(i);
								int total = product.getUnitPrice() * product.getAmount();
								sum += total;
						%>
						<tr>
										
							<td><%= product.getName() %></td>			
							<td><%= product.getUnitPrice() %></td>			
							<td><%= product.getAmount() %></td>			
							<td><%= total %></td>			
							<td><a class="btn btn-danger" 
							href="<%= root %>/shop/deleteCart.jsp?id=<%= product.getProductId() %>" 
							role="button">삭제</a></td>			
						</tr>
						<%
							}
						%>
					</tbody>
					<tfoot>
						<%
							if( cartList.isEmpty() ) {
						%>
						<tr>
							<td colspan="5">추가된 상품이 없습니다.</td>	
						</tr>
						<% } else { %>
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td id="cart-sum"><%= sum %></td>
							<td></td>
						</tr>
						<%
							}
						%>
					</tfoot>
				</table>
				<div class="d-flex justify-content-between mt-5 mb-5">
					<a class="btn btn-danger" href="<%= root %>/shop/deleteCart.jsp" role="button">전체삭제</a>
					<a class="btn btn-primary" href="<%= root %>/shop/ship.jsp" role="button" onclick="return checkCartAndProceed();">주문하기</a>
				</div>
			</div>
			
			<jsp:include page="/layout/footer.jsp" />
		</div>
	</div>
	<script type="text/javascript">
        // JavaScript로 cartList가 비었는지 여부를 변수에 저장
        var isCartEmpty = <%= cartList.isEmpty() ? "true" : "false" %>;

        // 주문하기 버튼 클릭 시 이벤트 처리
        function checkCartAndProceed() {
            if (isCartEmpty) {
                alert("장바구니에 담긴 상품이 없습니다.");
                return false; // 이동을 막음
            }
            return true; // 이동 허용
        }
    </script>
	<jsp:include page="/layout/script.jsp" />

</body>
</html>

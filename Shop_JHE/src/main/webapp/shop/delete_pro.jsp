<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	ProductRepository productDAO = new ProductRepository();

	String productId = request.getParameter("id");
	
	int result = productDAO.delete(productId);
	
	if (result==1){
		response.sendRedirect(root + "/shop/editProducts.jsp");
	} else {
%>
		<!-- 알림창을 표시하고 이전 페이지로 돌아가는 JavaScript -->
		<script>
			alert("삭제에 실패하였습니다.");
			history.back();
		</script>
<%
	}
%>
<%@page import="java.util.Iterator"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	String productId = request.getParameter("id");
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");
	if(productId!= null && !productId.isEmpty()){
	Iterator<Product> iterator = cartList.iterator();
		while (iterator.hasNext()) {
		    Product cart = iterator.next();
		    if (cart.getProductId().equals(productId)) {
		        iterator.remove(); // 해당 productId를 가진 Product 삭제
		        break; // 원하는 상품을 찾았으므로 반복 종료
		    }
		}
	} else {
		session.removeAttribute("cartList");
	}
	
	response.sendRedirect(root + "/shop/cart.jsp");
%>
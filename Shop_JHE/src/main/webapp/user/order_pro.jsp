<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	// 비회원 주문 내역 세션에 등록 처리
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	OrderRepository orderDAO = new OrderRepository();
	List<Product> orderList = orderDAO.list(phone, orderPw);
	System.out.println(orderList);
	
	if(orderList != null){
		session.setAttribute("orderPhone", phone);
		session.setAttribute("orderList", orderList);		
		response.sendRedirect(root + "/user/order.jsp");
	} else {
%>
		<!-- 알림창을 표시하고 이전 페이지로 돌아가는 JavaScript -->
		<script>
			alert("일치하는 값이 없습니다.");
			history.back();
		</script>
<%	
	}
	
	
	
%>
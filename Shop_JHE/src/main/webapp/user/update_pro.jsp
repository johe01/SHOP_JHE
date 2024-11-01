<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
	
	// 회원 정보 수정 처리
	User user = new User();
	
	user.setId(request.getParameter("id"));
// 	user.setPassword(request.getParameter("pw"));
	user.setName(request.getParameter("name"));
	user.setGender(request.getParameter("gender"));
	
	// 생일
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "/" + month + "/" + day;
	user.setBirth(birth);
	
	// 이메일
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email = email1 + "@" + email2;
	user.setMail(email);
	
	user.setPhone(request.getParameter("phone"));
	user.setAddress(request.getParameter("address"));
	
    int result = userDAO.update(user);
    if (result >0 ){
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }

%>

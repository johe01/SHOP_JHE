<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	User user = new User();
	UserRepository userDAO = new UserRepository();
	
	user.setId(request.getParameter("id"));
	user.setPassword(request.getParameter("pw"));
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
	
	int result = userDAO.insert(user);
	if (result != 1){
		response.sendRedirect(root + "/user/join.jsp");
	} else {
		response.sendRedirect(root+ "/user/complete.jsp?msg=1");
	}
	
%>
    
    

    
    
    
    
    
    
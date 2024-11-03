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
		String loginId = (String) session.getAttribute("loginId");
		String smsg = request.getParameter("msg");
		int msg = Integer.parseInt(smsg);
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5 text-center">
	<%
		if(msg==1) {
	%>
		<div class="fs-2 pb-5">회원 가입이 완료되었습니다.</div>
	<%
		} else if(msg==0) {
		%>
		<div class="fs-2 pb-5"><%= loginId %>님 환영 합니다.</div>		
		<%
	} else if(msg==2) {
	%>
		<div class="fs-2 pb-5">회원 정보가 수정되었습니다.</div>		
	<%
	} else if(msg==3) {
	%>
		<div class="fs-2 pb-5">회원 정보가 삭제되었습니다.</div>		
	<%} %>
		<a class="btn btn-primary" href="<%= root %>" role="button">메인 화면</a>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>








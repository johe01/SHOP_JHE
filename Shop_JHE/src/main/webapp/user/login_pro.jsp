<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if (loginUser == null ) {
		response.sendRedirect("login.jsp?error=0");
		return;
	}
	// 로그인 성공
	// - 세션에 아이디 등록
	session.setAttribute("loginId", loginUser.getId());
	session.setAttribute("loginUser", loginUser);
	
	// 아이디 저장	
	// login.jsp에서 아이디 저장 체크 여부(on) 가져와 rememberId에 저장 
	String rememberId = request.getParameter("remember-id");
	
	// 아이디 저장여부 값이랑 아이디 값 저장할 쿠키 생성
	Cookie cookieRememberId = new Cookie("rememberId", "");
	Cookie cookieUsername = new Cookie("username", "");
	
	// 아이디 저장 체크(on) 시, 쿠키에 아이디 저장여부 값과 아이디 값 저장
	if(rememberId != null && rememberId.equals("on")) {
		cookieRememberId.setValue(URLEncoder.encode(rememberId, "UTF-8"));
		cookieUsername.setValue(URLEncoder.encode(id, "UTF-8"));
	}
	else { // 아이디 저장 체크 해제 시,
		// 쿠키 삭제 - 쿠키 유효시간을 0으로 하고 응답
		cookieRememberId.setMaxAge(0);
		cookieUsername.setMaxAge(0);
	}
	
	// 자동 로그인
	// login.jsp에서 자동 로그인 체크 여부 가져와 rememberMe에 저장
	String rememberMe = request.getParameter("remember-me");
	
	// 아이디 저장 여부와 토큰 값 저장할 쿠키 생성
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	
	// 모든 경로에서 쿠키를 가져올 수 있도록 설정
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	
	// 쿠키 만료시간 설정
	cookieRememberMe.setMaxAge(60*60*24*7); // 초단위
	cookieToken.setMaxAge(60*60*24*7);
	
	// 자동 로그인 체크 시 
	if( rememberMe != null && rememberMe.equals("on")) {
		// 토큰 발행(토큰 리프레쉬)
		
		String refreshToken = userDAO.refreshToken(id);
		String token = null;
		if(refreshToken != null) {
			token = refreshToken;
		}
		// 생성된 쿠키에 값 저장
		cookieRememberMe.setValue(URLEncoder.encode(rememberMe, "UTF-8"));
		cookieToken.setValue(URLEncoder.encode(token, "UTF-8"));
	}
	else {
		// 자동 로그인 미체크 시
		// 쿠키 삭제
		cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
	}
	
	// 쿠키 전달 (응답에 쿠키 등록)
	response.addCookie(cookieRememberId);
	response.addCookie(cookieUsername);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>






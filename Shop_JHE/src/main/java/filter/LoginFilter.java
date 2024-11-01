package filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;


/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {
	
//	PersistenceLoginsService persistenceLoginsService;
//	UserService userService;
	UserRepository userRepository;
	
	public void init(FilterConfig fConfig) throws ServletException {
//    	persistenceLoginsService = new PersistenceLoginsServiceImpl();
//    	userService = new UserServiceImpl();
		userRepository = new UserRepository();
    }
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
	
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = null;		// 자동 로그인 여부
		String token = null;			// 인증 토큰
		
		
		// 쿠키 정보 "rememberMe", "token"을 가져와 변수에 저장
		if( cookies != null ) {
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
				switch(cookieName) {
				case "rememberMe"	: rememberMe = cookieValue; break;
				case "token"	: token = cookieValue; break;
				}
			}
		}
		
		System.out.println("LoginFilter...");
		System.out.println("rememberMe : " + rememberMe);
		System.out.println("token : " + token);
		
		// 로그인 여부를 확인하기 위해 session에서 loginId, loginUser를 가져와 변수에 저장
		HttpSession session = httpRequest.getSession();
		String loginId = (String)session.getAttribute("loginId");
		User loginUser = (User)session.getAttribute("loginUser");
		
		// 로그인이 되어 있는 경우
		if( loginId !=null&& loginUser !=null) {
			chain.doFilter(httpRequest, response);
			System.out.println("로그인되어 있는 사용자 : " + loginId);
			return;
		}
		
		// 쿠키 정보 "rememberMe", "token" 가 모두 존재하는 경우, 자동 로그인
		if( rememberMe != null && token != null) {
//			PersistenceLogins persistenceLogins = persistenceLoginsService.selectByToken(token);
			PersistentLogin persistentLogins = userRepository.selectTokenByToken(token);
			
			if(persistentLogins != null) {
				loginId = persistentLogins.getUserId();
				loginUser = userRepository.getUserById(loginId);
				
				session.setAttribute("loginId", loginId);
				session.setAttribute("loginUser", loginUser);
				System.out.println("자동 로그인 성공 : " + loginUser);
			}
		}
		
		chain.doFilter(request, response);
	} 
	public void destroy () {
	}
}

package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

@WebFilter(
		urlPatterns = { "/*" }, // 모든 경로 URL 매핑
		initParams = { 
				@WebInitParam(name = "encoding", value = "UTF-8", description = "인코딩 설정 값")
		})
public class EncodingFilter implements Filter {
	
	private FilterConfig filterConfig = null;
	private String encoding;
	
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");	// UTF-8(초기 파라미터 가져옴)
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("인코딩 필터 : " + encoding);
		request.setCharacterEncoding(encoding);
		response.setCharacterEncoding(encoding);
		chain.doFilter(request, response);
		
	} 
	
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
}








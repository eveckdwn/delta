package filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminSpringInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//	컨트롤러 실행 전
		HttpSession session = request.getSession();
		
		if(session.getAttribute("auth")==null) {
			session.setAttribute("authlv", "관리자만 이용하실 수 있습니다.<br/>관리자이시면 로그인해주세요.");
			response.sendRedirect("/index");
			return false;
		}else {
			return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//	컨트롤러 실행 후
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//	브라우저 응답직전
		
	}
	

}

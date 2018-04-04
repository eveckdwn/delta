package filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LvLimitFilter extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//	컨트롤러 실행 전
		HttpSession session = request.getSession();
		
		if(session.getAttribute("lv")==null || (int)session.getAttribute("lv") == 0) {
			session.setAttribute("authlv", "여행모임, 실시간 채팅 기능은 회원가입 후 메일 인증을 받으신 유저들만의 공간입니다. 메일 인증을 받아주세요.");
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
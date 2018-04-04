package filter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class DuplicateLoginFilter extends HandlerInterceptorAdapter {

	@Autowired
	ServletContext application;

	@Autowired
	HttpSession session;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 컨트롤러 실행 전
		// index페이지가 아닌 경우
		if (application.getAttribute(session.getId()) == null) {
			// 서버에 세션 아이디를 키값으로 갖는 값이 true일때,
			// 그대로 띄워준다.
			return true;

		} else if (application.getAttribute(session.getId()) != null
				&& (boolean) application.getAttribute(session.getId())) {
			// 서버에 세션 아이디를 키값으로 갖는 값이 없을 때
			// 그대로 띄워준다.
			return true;

		} else {
			// 서버에 세션 아이디를 키값으로 갖는 값이 있는데, 그 값이 false일 때

			// 다를 때 다른 세션에서 로그인을 했다고 alert해주고 로그인 화면으로 보내준다.
			response.sendRedirect("/login/out");
			session.setAttribute("authlv", "다른 세션에서 로그인했습니다.<br/> 계속 사용을 원하시면 다시 로그인해주세요.");

			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 컨트롤러 실행 후
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 브라우저 응답직전

	}

}
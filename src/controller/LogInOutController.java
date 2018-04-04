package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import model.WebSocketMap;
import service.GreetService;
import service.UsersService;

@Controller
@RequestMapping("/login")
public class LogInOutController {
	@Autowired
	GreetService greetService;

	@RequestMapping(method = RequestMethod.GET)
	public String loginHandle(Model model) {
		model.addAttribute("ment", greetService.make());
		return "login";
	}

	@Autowired
	UsersService memberService;

	@Autowired
	WebSocketMap sessions;

	@RequestMapping(method = RequestMethod.POST)
	public String loginPHandle(@RequestParam Map map, HttpSession session, Model model) throws IOException {
		int result = memberService.loginCheck(map);
		switch (result) {
		case 0:
			Map info = memberService.mypageInfo(map);
			session.setAttribute("logon", info.get("ID"));
			session.setAttribute("logonNick", info.get("NICK"));
			BigDecimal bd = (BigDecimal)info.get("LV");
			session.setAttribute("lv", bd.intValue());
			if(session.getAttribute("authlv") != null) {
				session.removeAttribute("authlv");
			}
			if(bd.intValue()==3) {
				session.setAttribute("auth", true);
				return "redirect:/admin";
			}else {
				return "redirect:/";
			}
		case 1:
			model.addAttribute("ment", greetService.make());
			model.addAttribute("err", "회원 정보가 존재하지 않습니다.<br/>회원가입을 해주세요.");
			model.addAttribute("main", "join.jsp");
			return "t_el";
		case 2:
			model.addAttribute("ment", greetService.make());
			model.addAttribute("err", "비밀번호가 틀렸거나 서버응답에 오류가 발생하였습니다.");
			model.addAttribute("main", "login.jsp");
			return "t_el";
		case 3:
			session.setAttribute("logon", map.get("id"));
			session.setAttribute("auth", true);
			return "admin_index";
		default:
			model.addAttribute("ment", greetService.make());
			model.addAttribute("err", "패스워드가 일치하지 않습니다.");
			model.addAttribute("main", "login.jsp");
			return "t_el";
		}
	}

	@RequestMapping("/out")
	public String logoutHandle(HttpSession session, Model model) {
		session.removeAttribute("logon");
		model.addAttribute("ment", greetService.make());
		return "index";
	}
	
	

}
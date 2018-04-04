package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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
	ServletContext application;
	
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
			info.put("session", session.getId());
			session.setAttribute("logon", info.get("ID"));
			session.setAttribute("logonNick", info.get("NICK"));
			BigDecimal bd = (BigDecimal)info.get("LV");
			session.setAttribute("lv", bd.intValue());
			
			//	레벨에 따른 제한 알림 지우기
			if(session.getAttribute("authlv") != null) {
				session.removeAttribute("authlv");
			}
			
			//	중복 로그인 처리
			if(application.getAttribute("userList") == null){
				List<Map> userList = new ArrayList();
				userList.add(info);
				application.setAttribute("userList", userList);	
			}else{
				List<Map> userList = (List<Map>) application.getAttribute("userList");
				Iterator<Map> iter = userList.iterator();
				while(iter.hasNext()){
					Map i = iter.next();
					if( info.get("ID").equals( i.get("ID") ) && !( info.get("session").equals( i.get("session") ) ) ){
						
						if(application.getAttribute((String) i.get("session")) != null){
							application.setAttribute((String) i.get("session"), false);	
						}
						
						iter.remove();
						
					}
				}
				userList.add(info);
				application.setAttribute("userList", userList);
			}
			application.setAttribute((String) info.get("session"), true);
			
			//	페이지 관리자 체크
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
		List<Map> userList = (List<Map>) application.getAttribute("userList");
		Iterator<Map> iter = userList.iterator();
		while (iter.hasNext()) {
			Map u = iter.next();
			if ((u.get("session").equals(session.getId()))) {
				application.removeAttribute((String) u.get("session"));
				iter.remove();
			}
		}
		session.removeAttribute("logon");
		model.addAttribute("ment", greetService.make());
		return "index";
	}
	
	

}
package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

import model.WebSocketMap;
import service.GreetService;
import service.UsersService;

@Controller
@RequestMapping("/join")
public class JoinController {
	@Autowired
	ServletContext application;
	
	@Autowired
	GreetService greetService;

	@Autowired
	UsersService memberService;

	@Autowired
	WebSocketMap sessions;

	@RequestMapping(method = RequestMethod.GET)
	public String joinHandle(Model model, HttpSession session) {
		model.addAttribute("ment", greetService.make());
		return "join";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String joinPostHandle(@RequestParam Map<String, String> param, Model model, HttpSession session) {
		try {
			param.put("ban", null);
			boolean rst = memberService.addNewOne(param);

			if (rst) {
				Map info = memberService.mypageInfo(param);
				info.put("session", session.getId());
				session.setAttribute("logon", info.get("ID"));
				session.setAttribute("logonNick", info.get("NICK"));
				BigDecimal bd = (BigDecimal) info.get("LV");
				session.setAttribute("lv", bd.intValue());

				// 레벨에 따른 제한 알림 지우기
				if (session.getAttribute("authlv") != null) {
					session.removeAttribute("authlv");
				}

				// 중복 로그인 처리
				if (application.getAttribute("userList") == null) {
					List<Map> userList = new ArrayList();
					userList.add(info);
					application.setAttribute("userList", userList);
				} else {
					List<Map> userList = (List<Map>) application.getAttribute("userList");
					Iterator<Map> iter = userList.iterator();
					while (iter.hasNext()) {
						Map i = iter.next();
						if (info.get("ID").equals(i.get("ID")) && !(info.get("session").equals(i.get("session")))) {

							if (application.getAttribute((String) i.get("session")) != null) {
								application.setAttribute((String) i.get("session"), false);
							}

							iter.remove();

						}
					}
					userList.add(info);
					application.setAttribute("userList", userList);
				}
				application.setAttribute((String) info.get("session"), true);
				return "redirect:/";
			} else {
				model.addAttribute("err", "회원가입에 실패하였습니다.");
				model.addAttribute("param", param);
				return "join";
			}
		} catch (Exception e) {
			model.addAttribute("err", "회원가입에 실패하였습니다.<br/>(*)표시가 있는 문항은 모두 입력해주세요.");
			model.addAttribute("param", param);
			return "join";
		}
	}

	@Autowired
	UsersService usersService;

	@RequestMapping("/confirm")
	@ResponseBody
	public boolean confirmHandle(@RequestParam String id) {
		System.out.println(id);
		List confirm = (List) usersService.confirmId(id);
		return 0 == confirm.size();
	}

}
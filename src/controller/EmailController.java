package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.MailService;
import service.UsersService;

@Controller
public class EmailController {
	
	@Autowired
	MailService mailservice;
	@Autowired
	UsersService users;
	
	@RequestMapping(path="/emailConfirm",method=RequestMethod.POST)
	public String emailHandle(@RequestParam String email,HttpSession session,Model model) {
		
		boolean rst = mailservice.sendMail(email,session);
		String id = (String)session.getAttribute("logon");
		Map u =new HashMap<>();
			u.put("id", id);
		
		if(rst) {
			model.addAttribute("su", "이메일 인증키가 가입시 등록한 이메일로 발송 되었습니다.");
			Map user = users.mypageInfo(u);
			model.addAttribute("user", user);
			return "email";
		}else {
			model.addAttribute("er","서버에 오류가 발생하였습니다. 다시 시도하여 주십시오");
			Map user = users.mypageInfo(u);
			model.addAttribute("user", user);
			return "mypage";
		}
	}
	
	@RequestMapping(path="/email/check",method=RequestMethod.POST)
	public String emailSuccHandle(@RequestParam String key, HttpSession session, Model model) {
		
		String serial = (String)session.getAttribute("serial");
		String id = (String)session.getAttribute("logon");
		Map u =new HashMap<>();
			u.put("id", id);
			
		if(key.equals(serial)) {
			if(mailservice.updateLv(id)) 
				model.addAttribute("t","이메일 인증이 완료 되었습니다.");
				Map user = users.mypageInfo(u);
				model.addAttribute("user", user);
				return "mypage";
		}else {
			model.addAttribute("f","이메일 인증이 실패되었습니다. 다시 요청된 인증키를 입력 해주세요.");
			Map user = users.mypageInfo(u);
			model.addAttribute("user", user);
			return "email";
		}
		
	}
}

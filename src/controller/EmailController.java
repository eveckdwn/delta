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
			model.addAttribute("su", "�̸��� ����Ű�� ���Խ� ����� �̸��Ϸ� �߼� �Ǿ����ϴ�.");
			Map user = users.mypageInfo(u);
			model.addAttribute("user", user);
			return "email";
		}else {
			model.addAttribute("er","������ ������ �߻��Ͽ����ϴ�. �ٽ� �õ��Ͽ� �ֽʽÿ�");
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
				model.addAttribute("t","�̸��� ������ �Ϸ� �Ǿ����ϴ�.");
				Map user = users.mypageInfo(u);
				model.addAttribute("user", user);
				return "mypage";
		}else {
			model.addAttribute("f","�̸��� ������ ���еǾ����ϴ�. �ٽ� ��û�� ����Ű�� �Է� ���ּ���.");
			Map user = users.mypageInfo(u);
			model.addAttribute("user", user);
			return "email";
		}
		
	}
}

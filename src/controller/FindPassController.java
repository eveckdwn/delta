package controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.MailService;

@Controller
public class FindPassController {
	
	@Autowired
	MailService mailservice;
	
	@RequestMapping("/findpass")
	public String findPassHandle() {
		
		return "/findpass";
	}
	
	@RequestMapping(path="/findpass/confirm",method=RequestMethod.POST)
	public String passFindHandle(@RequestParam Map<String,String> map, Model model) {
		
		boolean rst = mailservice.findPass(map);
		
		if(rst) {
			model.addAttribute("t","임시 비밀번호가 이메일로 전송이 되었습니다.<br/> 확인 후 로그인을 진행하여 주십시오.");
			return "login";
		}else {
			model.addAttribute("f","아이디와 이메일이 일치하지 않습니다.");
			return "findpass";
		}
	}
}

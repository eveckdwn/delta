package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.GreetService;

@Controller
public class IndexController {
	@Autowired
	GreetService greetService;
	
	@RequestMapping({"/index","/"})
	public String indexHandle(Model model, HttpSession session) {
		if(session.getAttribute("logon")==null) {
			model.addAttribute("ment", greetService.make());
			return "index";
		}else {
			return "logon";
		}
	}
}

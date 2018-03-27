package controller;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@RequestMapping("/main")
	public String Board01(HttpSession session) {
		if(session.getAttribute("logon")== null) {
			
			return"/board/main_NoLogin";
			
		}else {
			return "/board/main_Login";
			
		}
		
	}
	
	
	
	@RequestMapping("/write")
	public String Write() {
		
		return"/board/write";
	}
	
	
	@RequestMapping("/insert")
	public String Insert(Model model ,
			@RequestParam String title , @RequestParam String content) {
		
		model.addAttribute("title", title);
		model.addAttribute("content", content);
		
		
		return"/board/insert";
	}
	
	@RequestMapping("/change")
	public String Change(Model model ,
			@RequestParam(required=false) String no ) {
		// 이걸 no에 해당하는 데이터를 가지고 오고
		model.addAttribute("title", "aaaa");
		model.addAttribute("content", "dasdsadsadsad");
		
		return"/board/change";
	}
	
	
	
}

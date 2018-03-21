package controller;

import java.lang.ProcessBuilder.Redirect;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.UsersService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	UsersService usersService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String adminHandle() {
		return "admin_index";
	}
	
	@RequestMapping("/station")
	public String stationHandle() {
		return "";
	}
	
	@RequestMapping("/travel")
	public String travelHandle() {
		return "";
	}
	


	@RequestMapping("/users")
	public String selectAll(Model model) {
		
			model.addAttribute("select", usersService.selectAll());
			model.addAttribute("foul", usersService.foulUsers());
		return "admin_users";
	}
	
	@RequestMapping("/ban")
	public String BanUsers(Model model, @RequestParam String id) {
		
		try {
			
			
			model.addAttribute("ban" , usersService.banUsers(id));
			
			
			return "/admin/ban";
			
		}catch(Exception e){
			e.printStackTrace();
			return "/admin/fail";
		}
		
	}
	

		
	
	
	
}

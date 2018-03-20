package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import service.UsersService;

@Controller

public class MypageController {
	
	@Autowired
	UsersService users;
	
	@RequestMapping("/mypage")
	public String mypageHandle(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("logon");
		Map userid = new HashMap<>();
			userid.put("id", id);
		Map user = users.mypageInfo(userid);
		
		model.addAttribute("user", user);
		return "mypage";
	}
	
	@RequestMapping(path="/updateUser", method=RequestMethod.POST)
	public String mypageUpdateHandle(@RequestParam(name="photo") MultipartFile photo, @RequestParam Map map , Model model, HttpSession session) throws IOException {
		
		String id = (String)session.getAttribute("logon");
		map.put("id", id);
		Map iid = new HashMap<>();
			iid.put("id", id);
		System.out.println(map.toString());
		
		boolean rst = users.updateAccount(map, photo);
			if(rst) {
				model.addAttribute("succ","정보가 수정되었습니다");
				Map user = users.mypageInfo(iid);
				model.addAttribute("user", user);
				return "mypage";
			}else{
				model.addAttribute("err","정보를 수정하는 중 오류가 생겼습니다.");
				Map user = users.mypageInfo(iid);
				model.addAttribute("user", user);
				return "mypage";
			}
	}
}

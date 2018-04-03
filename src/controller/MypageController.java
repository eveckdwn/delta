package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.Instanceof;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import aj.org.objectweb.asm.Type;
import service.UsersService;

@Controller

public class MypageController {

	@Autowired
	UsersService users;

	@RequestMapping("/mypage")
	public String mypageHandle(HttpSession session, Model model) {

		String id = (String) session.getAttribute("logon");
		Map cnt = new HashMap<>();
		cnt.put("id", id);
		Map userid = new HashMap<>();
		userid.put("id", id);

		Map user = users.mypageInfo(userid);
		Map ban = users.banInfo(cnt);
		if (ban != null) {
			int c = Integer.parseInt(String.valueOf(ban.get("BAN-LASTLOG")));
			if (c > 0) {
				model.addAttribute("ban", ban.values());
			} else {
				users.banOut(id);
			}
		}
		model.addAttribute("user", user);
		return "mypage";
	}

	@RequestMapping(path = "/updateUser", method = RequestMethod.POST)
	public String mypageUpdateHandle(@RequestParam(name = "photo") MultipartFile photo, @RequestParam Map map,
			Model model, HttpSession session) throws IOException {

		String id = (String) session.getAttribute("logon");
		map.put("id", id);
		Map iid = new HashMap<>();
		iid.put("id", id);
		Map cnt = new HashMap<>();
		cnt.put("id", id);
		System.out.println(map.toString());

		boolean rst = users.updateAccount(map, photo);
		if (rst) {
			model.addAttribute("succ", "정보가 수정되었습니다.");
			Map user = users.mypageInfo(iid);
			Map ban = users.banInfo(cnt);
			model.addAttribute("ban", ban);
			model.addAttribute("user", user);
			return "mypage";
		} else {
			model.addAttribute("err", "정보 수정이 실패하였습니다. 다시 시도하여 주십시오.");
			Map user = users.mypageInfo(iid);
			Map ban = users.banInfo(cnt);
			model.addAttribute("ban", ban);
			model.addAttribute("user", user);
			return "mypage";
		}
	}
	
	@RequestMapping("/profile")
	public String profileHandle(@RequestParam String id, HttpSession session, Model model) {

		Map userid = new HashMap<>();
		userid.put("id", id);

		Map user = users.mypageInfo(userid);
		user.remove("PASS"); user.remove("BAN"); user.remove("FOUL"); user.remove("LV");
		model.addAttribute("user", user);
		return "/profile";
	}
}

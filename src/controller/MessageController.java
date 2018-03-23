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
import org.springframework.web.bind.annotation.ResponseBody;

import service.MessageService;
import service.UsersService;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	MessageService messageService;
	@Autowired
	UsersService users;

	@RequestMapping(path = "/send", method = RequestMethod.GET)
	public String sendHandle() {
		return "message/messageSend";
	}

	@RequestMapping(path = "/msend", produces = "application/json", method = RequestMethod.POST)
	@ResponseBody
	public String messageSendHandle(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String logon = (String) session.getAttribute("logon");
		Map log = new HashMap<>();
		log.put("id", logon);
		Map my = users.mypageInfo(log);

		map.put("mnick", (String) my.get("NICK"));
		return String.valueOf(messageService.sendMessage(map));
	}

	@RequestMapping(path = "/view", method = RequestMethod.GET)
	public String getMessage(@RequestParam(name = "mid") String mid, Model model) {
		int nMid = Integer.parseInt(mid);
		messageService.readMessage(nMid);
		Map message = messageService.getMessageByUid(nMid);
		if (message == null) {
			return "message/messageBox";
		} else {

			model.addAttribute("msg", message);
			return "message/messageView";
		}
	}

	@RequestMapping(path = "/box")
	public String getMessagesByUser(HttpSession session, Model model) {

		String logon = (String) session.getAttribute("logon");
		Map log = new HashMap<>();
		log.put("id", logon);
		Map my = users.mypageInfo(log);

		model.addAttribute("msgs", messageService.getMessagesByReceiver((String) my.get("NICK")));
		return "message/messageBox";
	}

	@RequestMapping(path = "/del", produces = "application/json", method = RequestMethod.POST)
	@ResponseBody
	public String delMessage(@RequestParam(name = "mid[]") String[] mid) {
		System.out.println(mid[1]);
		return String.valueOf(messageService.delMessage(mid));
	}

}

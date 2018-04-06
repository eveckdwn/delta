package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

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

	// 답장으로 보낼때 sendController
	@RequestMapping(path = "/rsend", method = RequestMethod.GET)
	public String resendHandle(@RequestParam(name = "receiver") String receiver, Model model) {
		model.addAttribute("re", receiver);
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
	public String getMessagesByUser(@RequestParam String page, HttpSession session, Model model) {

		String logon = (String) session.getAttribute("logon");
		Map log = new HashMap<>();
		log.put("id", logon);
		Map my = users.mypageInfo(log);

		List msgs = messageService.getMessagesByReceiver((String) my.get("NICK"));

		int p = Integer.parseInt(page);
		int p2 = msgs.size() / 5 + 1;
		int other = msgs.size() % 5;
		session.setAttribute("all_page", p2);
		if (p < p2) {
			model.addAttribute("msgbox", msgs.subList((p - 1) * 5, (p - 1) * 5 + 5));
			session.setAttribute("now_page", p);
		} else {
			model.addAttribute("msgbox", msgs.subList((p2 - 1) * 5, (p2 - 1) * 5 + other));
			session.setAttribute("now_page", p2);
		}
		
		model.addAttribute("msgs", messageService.getMessagesByReceiver((String) my.get("NICK")));
		return "message/messageBox";
	}

	@RequestMapping(path = "/del", produces = "application/json", method = RequestMethod.POST)
	@ResponseBody
	// public String delMessage(@RequestParam MultiValueMap<String,String> multiMap)
	// {
	// System.out.println(multiMap.get("mid[]"));
	// return String.valueOf(messageService.delMessage(multiMap));
	// }
	public String delMessage(@RequestParam(name = "mid[]") String[] mid) {
		return String.valueOf(messageService.delMessage(mid));
	}

	@RequestMapping(path = "/resend", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String messageResendHandle(@RequestParam(name = "receiver") String receiver, Model model) {
		System.out.println(receiver);
		Map map = new HashMap<>();
		map.put("receiver", receiver);
		Gson g = new Gson();
		return g.toJson(map);
	}

	@RequestMapping(path = "/cnt", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String messageCntHandle(@RequestParam(name = "id") String id) {
		Map log = new HashMap<>();
		log.put("id", id);
		Map my = users.mypageInfo(log);

		Gson g = new Gson();
		List<Map> map2 = (List<Map>) messageService.getMessagesByReceiver((String) my.get("NICK"));
		int cnt = 0;
		for (int i = 0; i < map2.size(); i++) {
			if (Integer.parseInt(String.valueOf(map2.get(i).get("STATUS"))) == 0) {
				cnt++;
			}
		}
		Map count = new HashMap<>();
		count.put("cnt", cnt);
		return g.toJson(count);

	}

}

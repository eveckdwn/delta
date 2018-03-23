package controller;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.MessageService;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	MessageService messageService;
	
	@RequestMapping(path="/send", method=RequestMethod.GET)
	public String sendHandle(@RequestParam Map<String, String> param, Model model) {
		model.addAttribute("reciever", param.get("reciever"));
		return "message/messageSend";
	}
	
	@RequestMapping(path="/send", method=RequestMethod.POST)
	public String messageSendHandle(@RequestParam Map<String, String> param, Model model) {
		param.put("nick", "유저2"); // 유저 설정
		if (messageService.sendMessage(param)) {
			return "redirect:/";
		} else {
			model.addAttribute("err", "전송 실패");
			return "message/messageSend";
		}
	}
	
	@RequestMapping(path="/view", method=RequestMethod.GET)
	public String getMessage(@RequestParam(name = "mid") String mid, Model model) {
		int nMid = Integer.parseInt(mid);
		messageService.readMessage(nMid);
		Map message = messageService.getMessageByUid(nMid);
		if (message == null) {
			return "";
		} else if (!message.get("RECEIVER").equals("유저2")) { // 받는 유저가 지금 접속한 유저가 맞는가?
			return "";
		}
		model.addAttribute("msg", message);
		return "message/messageView";
	}
	
	@RequestMapping(path="/box")
	public String getMessagesByUser(Model model) {
		model.addAttribute("msgs", messageService.getMessagesByReceiver("유저2"));
		return "message/messageBox";
	}
	
	@RequestMapping(path="/del",produces="application/json",method=RequestMethod.POST)
	@ResponseBody
	public String delMessage(@RequestParam(name="mid[]") String[] mid) {
		System.out.println(mid[1]);
		return String.valueOf(messageService.delMessage(mid));
	}
	
	
}

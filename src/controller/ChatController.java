package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import service.StationService;
import service.UsersService;

@RequestMapping("/chat")
@Controller
public class ChatController extends TextWebSocketHandler {

	@Autowired
	UsersService users;

	@Autowired
	StationService stationService;

	private LinkedHashMap<String, List<WebSocketSession>> connectedUsers;

	public ChatController() {
		connectedUsers = new LinkedHashMap<String, List<WebSocketSession>>();

		connectedUsers.put("1", new ArrayList<>());
	}

	@RequestMapping(method = RequestMethod.GET)
	public String chat(HttpSession session, Model model) {
		List stations = stationService.readAllStation();
		model.addAttribute("station", stations);
		return "chat";
	}

	@RequestMapping(path = "/chatroom")
	public String chatRoom(HttpSession session, @RequestParam String id, Model model) {
		model.addAttribute("crid", id);
		return "chatroom";
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";
		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());

		List<WebSocketSession> channel = connectedUsers.get(crid);
		channel.add(session);
		for (WebSocketSession webSocketSession : channel) {
			if (!session.getId().equals(webSocketSession.getId())) {
				webSocketSession.sendMessage(new TextMessage(addUser(name)));
			} else {
				// webSocketSession.sendMessage(new TextMessage(createUserList(crid))); // 접속중
				// 유저 리스트
			}
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";

		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid);
		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(createJsonMessage(name, message.getPayload())));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";

		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid);
		channel.remove(session);
		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(delUser(name)));
		}
	}

	public String getName(Map map) { // ㅁㄴㅇㄹ
		String logon = (String) map.get("logon");
		Map log = new HashMap<>();
		log.put("id", logon);
		System.out.println(log);
		Map my = users.mypageInfo(log);
		return (String) my.get("NICK");
	}

	public String createJsonMessage(String name, String message) {
		Map data = new HashMap();
		data.put("type", "message");
		data.put("name", name);
		data.put("time", System.currentTimeMillis());
		data.put("message", message);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String createUserList(String crid) {
		Map data = new HashMap();
		data.put("type", "userlist");
		data.put("names", new ArrayList<>());
		List<WebSocketSession> channel = connectedUsers.get(crid);
		for (WebSocketSession webSocketSession : channel) {
			((ArrayList) data.get("names")).add(getName(webSocketSession.getAttributes())); // 될려나?
		}
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String addUser(String name) {
		Map data = new HashMap();
		data.put("type", "userAdd");
		data.put("name", name);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String delUser(String name) {
		Map data = new HashMap();
		data.put("type", "userDel");
		data.put("name", name);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

}
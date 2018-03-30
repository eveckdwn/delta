package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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


class ChatRoom {
	String name;
	ArrayList<WebSocketSession> sessions;
	ArrayList<String> users;
	
	ChatRoom(String name) {
		this.name = name;
		sessions = new ArrayList<WebSocketSession>();
		users = new ArrayList<String>();
	}
}

public class ChatController extends TextWebSocketHandler {

	@Autowired
	UsersService users;

	@Autowired
	StationService stationService;

	private LinkedHashMap<String, ChatRoom> connectedUsers;

	public ChatController() {
		connectedUsers = new LinkedHashMap<String, ChatRoom>();
	}

	@PostConstruct
	public void init() {
		List<HashMap> stations = stationService.readAllStation();
		for (HashMap station : stations) {
			connectedUsers.put((String) station.get("NAME"), new ChatRoom(station.get("NAME") + " 채팅방"));
		}
	}

	
	@RequestMapping(method = RequestMethod.GET)
	public String chat(HttpSession session, Model model) {
		List stations = stationService.readAllStation();
		model.addAttribute("station", stations);
		return "chat";
	}

	@RequestMapping(path = "/chatroom")
	public String chatRoom(HttpSession session, @RequestParam String id, Model model) {
		if (connectedUsers.get(id) == null) {
			return "";
		}
		model.addAttribute("crid", id);
		model.addAttribute("crname", connectedUsers.get(id).name);
		return "chatroom";
	}
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";
		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		channel.add(session);
		String message = addUser(crid, name);

		for (WebSocketSession webSocketSession : channel) {
			if (!session.getId().equals(webSocketSession.getId())) {
				webSocketSession.sendMessage(new TextMessage(message));
			} else {
				webSocketSession.sendMessage(new TextMessage(createUserList(crid))); // 접속중 유저 리스트
			}
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";

		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(createJsonMessage(name, message.getPayload())));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// System.out.println("로그인 한 닉네임 : " + getName(session.getAttributes()));
		String name = "닉네임";

		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		channel.remove(session);
		String message = delUser(crid, name);

		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(message));
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
		SimpleDateFormat sdf = new SimpleDateFormat("a hh:mm");
		data.put("time", sdf.format(new Date(System.currentTimeMillis())));
		data.put("message", message);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String createUserList(String crid) {
		Map data = new HashMap();
		data.put("type", "userlist");
		data.put("names", connectedUsers.get(crid).users);

		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String addUser(String crid, String name) {
		connectedUsers.get(crid).users.add(name);
		Map data = new HashMap();
		data.put("type", "userAdd");
		data.put("name", name);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String delUser(String crid, String name) {
		connectedUsers.get(crid).users.remove(name);
		Map data = new HashMap();
		data.put("type", "userDel");
		data.put("name", name);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

}
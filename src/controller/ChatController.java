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


class ChatRoom {
	String name;
	ArrayList<WebSocketSession> sessions;
	ArrayList<String> users;
	ArrayList<String> ids;
	
	ChatRoom(String name) {
		this.name = name;
		sessions = new ArrayList<WebSocketSession>();
		users = new ArrayList<String>();
		ids = new ArrayList<String>();
	}
}

@RequestMapping("/chat")
@Controller
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
		int n = 0;
		for (HashMap station : stations) {
			connectedUsers.put(Integer.toString(n++), new ChatRoom(station.get("NAME") + " 채팅방"));
		}
	}

	
	@RequestMapping(method = RequestMethod.GET)
	public String chat(HttpSession session, Model model) {
		List stations = stationService.readAllStation();
		model.addAttribute("station", stations);
		
		if(session.getAttribute("logon") == null) {
			model.addAttribute("ment", "채팅서비스는 로그인 후 이용이 가능합니다.");
			return "index";
		}else {
			return "chat";
		}
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
		String id = (String) session.getAttributes().get("logon");
		String name = getName(id);
		
		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		channel.add(session);
		String message = addUser(crid, name, id);

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
		String id = (String) session.getAttributes().get("logon");
		String name = getName(id);
		
		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(createJsonMessage(name, id, message.getPayload())));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String id = (String) session.getAttributes().get("logon");
		String name = getName(id);
		
		String crid = session.getUri().getQuery().substring(3, session.getUri().getQuery().length());
		List<WebSocketSession> channel = connectedUsers.get(crid).sessions;
		channel.remove(session);
		String message = delUser(crid, name, id);

		for (WebSocketSession webSocketSession : channel) {
			webSocketSession.sendMessage(new TextMessage(message));
		}
	}

	public String getName(String id) { // ㅁㄴㅇㄹ
		Map log = new HashMap<>();
		log.put("id", id);
		Map my = users.mypageInfo(log);
		return (String) my.get("NICK");
	}

	public String createJsonMessage(String name, String id, String message) {
		Map data = new HashMap();
		data.put("type", "message");
		data.put("name", name);
		data.put("id", id);
		SimpleDateFormat sdf = new SimpleDateFormat("a hh:mm");
		data.put("time", sdf.format(new Date(System.currentTimeMillis())));
		data.put("message", message);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String createUserList(String crid) {
		Map data = new HashMap();
		data.put("type", "userList");
		data.put("names", connectedUsers.get(crid).users);
		data.put("ids", connectedUsers.get(crid).ids);

		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String addUser(String crid, String name, String id) {
		connectedUsers.get(crid).users.add(name);
		connectedUsers.get(crid).ids.add(id);
		Map data = new HashMap();
		data.put("type", "userAdd");
		data.put("name", name);
		data.put("id", id);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

	public String delUser(String crid, String name, String id) {
		connectedUsers.get(crid).users.remove(name);
		connectedUsers.get(crid).ids.remove(id);
		Map data = new HashMap();
		data.put("type", "userDel");
		data.put("name", name);
		data.put("id", id);
		Gson gson = new Gson();
		return gson.toJson(data);
	}

}
package controller;

import java.util.*;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

/*
 * ws 통신을 제어할용도의 컨트롤러 구현
 * 	1. WebSocketHandler (I) 를 implements 걸어서 목적에 개조해서 사용.
 * 	2. 목적에 맞는 WebSocketHandler를 extends 걸어서 사용
 * 		- TextWebSocketHandler  / BinaryWebSocketHandler
 * 
 *  WebSocket Handler 의 매핑은, spring 설정파일에.
 */

@Controller("wsController")	//scan 으로 등록되는 빈은 클래스명으로 등록됨. 바꿀수 있음.	 
public class WSController extends TextWebSocketHandler {
	
	Set<WebSocketSession> wsSessions;
	
	@PostConstruct	//	init-method
	public void init() {
		wsSessions = new LinkedHashSet<>();
	}

	@Override	//	클라측에서 웹소켓 연결되었을 때
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//	System.out.println("afterConnectionEstablished.." + session.getId());
		//	System.out.println(session.getRemoteAddress().getAddress().getHostAddress());	//	접속자 IP주소
		if(!wsSessions.contains(session)) {
			wsSessions.add(session);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("cnt", wsSessions.size());
		map.put("info", session.getRemoteAddress().getAddress().getHostAddress() + "에서 접속합니다.");
		//	port가 달라서 cnt가 올라감.
		//	확인 : map.put("info", session.getRemoteAddress().toString() + "에서 접속합니다.");
				
		
		Gson gson = new Gson();
		
		for(WebSocketSession ws : wsSessions) {
			ws.sendMessage(new TextMessage(gson.toJson(map)));
		}
		//	System.out.println("current size : " + wsSessions.size());
		
	}

	@Override	//	클라측에서 메세지가 들어올 때
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage.." + session +" / " + message);
	}

	@Override	//	클라측과 연결이 해제될 때 	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//	System.out.println("afterConnectionClosed.." + session);
		wsSessions.remove(session);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cnt", wsSessions.size());
		map.put("info", session.getRemoteAddress().getAddress().getHostAddress() + "에서 접속을 종료합니다.");
		Gson gson = new Gson();
		
		for(WebSocketSession ws : wsSessions) {
			ws.sendMessage(new TextMessage(gson.toJson(map)));
		}
		
	}
}
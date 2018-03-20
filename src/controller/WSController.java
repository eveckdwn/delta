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
 * ws �넻�떊�쓣 �젣�뼱�븷�슜�룄�쓽 而⑦듃濡ㅻ윭 援ы쁽
 * 	1. WebSocketHandler (I) 瑜� implements 嫄몄뼱�꽌 紐⑹쟻�뿉 媛쒖“�빐�꽌 �궗�슜.
 * 	2. 紐⑹쟻�뿉 留욌뒗 WebSocketHandler瑜� extends 嫄몄뼱�꽌 �궗�슜
 * 		- TextWebSocketHandler  / BinaryWebSocketHandler
 * 
 *  WebSocket Handler �쓽 留ㅽ븨��, spring �꽕�젙�뙆�씪�뿉.
 */

@Controller("wsController")	//scan �쑝濡� �벑濡앸릺�뒗 鍮덉� �겢�옒�뒪紐낆쑝濡� �벑濡앸맖. 諛붽��닔 �엳�쓬.	 
public class WSController extends TextWebSocketHandler {
	
	Set<WebSocketSession> wsSessions;
	
	@PostConstruct	//	init-method
	public void init() {
		wsSessions = new LinkedHashSet<>();
	}

	@Override	//	�겢�씪痢≪뿉�꽌 �쎒�냼耳� �뿰寃곕릺�뿀�쓣 �븣
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//	System.out.println("afterConnectionEstablished.." + session.getId());
		//	System.out.println(session.getRemoteAddress().getAddress().getHostAddress());	//	�젒�냽�옄 IP二쇱냼
		if(!wsSessions.contains(session)) {
			wsSessions.add(session);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("cnt", wsSessions.size());
		map.put("info", session.getRemoteAddress().getAddress().getHostAddress() + "이 접속하였습니다.");
		//	port媛� �떖�씪�꽌 cnt媛� �삱�씪媛�.
		//	�솗�씤 : map.put("info", session.getRemoteAddress().toString() + "�뿉�꽌 �젒�냽�빀�땲�떎.");
				
		
		Gson gson = new Gson();
		
		for(WebSocketSession ws : wsSessions) {
			ws.sendMessage(new TextMessage(gson.toJson(map)));
		}
		//	System.out.println("current size : " + wsSessions.size());
		
	}

	@Override	//	�겢�씪痢≪뿉�꽌 硫붿꽭吏�媛� �뱾�뼱�삱 �븣
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage.." + session +" / " + message);
	}

	@Override	//	�겢�씪痢↔낵 �뿰寃곗씠 �빐�젣�맆 �븣 	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//	System.out.println("afterConnectionClosed.." + session);
		wsSessions.remove(session);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cnt", wsSessions.size());
		map.put("info", session.getRemoteAddress().getAddress().getHostAddress() + "이 접속을 해제하였습니다.");
		Gson gson = new Gson();
		
		for(WebSocketSession ws : wsSessions) {
			ws.sendMessage(new TextMessage(gson.toJson(map)));
		}
		
	}
}
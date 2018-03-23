package service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
	@Autowired
	SqlSessionTemplate template;
	
	public boolean sendMessage(Map map) {
		return template.insert("message.sendMessage", map) == 1;
	}
	
	public List<Map> getMessagesByReceiver(String receiver) {
		return template.selectList("message.getMessagesByReceiver", receiver);
	}
	
	public Map getMessageByUid(int mid) {
		return template.selectOne("message.getMessageByUid", mid);
	}
	
	public boolean readMessage(int mid) {
		return template.update("message.readMessage", mid) == 1;
	}
}

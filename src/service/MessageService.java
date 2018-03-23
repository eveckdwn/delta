package service;

import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
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
	
	public boolean delMessage(String[] mid) {
		int[] m = (int[]) new IntegerArrayConverter().convert(null, mid);
		System.out.println(m[0] + " , " + m[1]);
		int r = template.delete("message.delMassage", m);
		return mid.length == r;
	}
}

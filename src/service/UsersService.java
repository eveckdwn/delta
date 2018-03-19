package service;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersService {
	@Autowired
	SqlSessionTemplate template;
	
	public UsersService(SqlSessionTemplate template) {
		this.template = template;
	}
	
	public Map confirmId(String id) {
		return template.selectOne("users.checkId", id);
	}
	
	public boolean addNewOne(Map map) {
		return template.insert("users.addNewOne", map)==1;
	}
	
	public int loginCheck(Map map) {
		Map users = template.selectOne("users.checkId", map.get("id"));
		if(users == null) {
			return 1;
		}else if(map.get("pass").equals(users.get("PASS"))) {
			return 0;
		}else {
			return 2;
		}
	}
	
	public Map readId(String id) {
		return template.selectOne("users.checkId", id);
	}
	

}

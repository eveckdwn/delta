package service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
		return template.insert("users.addNewOne", map) == 1;
	}

	public int loginCheck(Map map) {
		Map users = template.selectOne("users.checkId", map.get("id"));
		if (users == null) {
			return 1;
		} else if (map.get("pass").equals(users.get("PASS"))) {
			return 0;
		} else {
			return 2;
		}
	}

	public Map readId(String id) {
		return template.selectOne("users.checkId", id);
	}

	public List<Map> selectAll() {

		return template.selectList("users.select");

	}

	public List<Map> foulUsers() {

		return template.selectList("users.FoulUsers");
	}

	public boolean banUsers(String id) {
		Date today = new Date();
		Date d = new Date(today.getTime ( ) + (long) ( 1000 * 60 * 60 * 24 * 3 ));
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String date=dd.format(d);
		
		Map ban =new HashMap<>();
		 ban.put("id", id);
		 ban.put("ban", date);
		
		return template.update("users.BanUsers", ban) == 1;
	}
	


}



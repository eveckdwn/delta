package service;

import java.util.List;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UsersService {
	@Autowired
	SqlSessionTemplate template;
	@Autowired
	ServletContext ctx;

	public UsersService(SqlSessionTemplate template) {
		this.template = template;
	}

	public Map confirmId(String id) {
		return template.selectOne("users.checkId", id);
	}

	public boolean addNewOne(Map map) {
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String date = dd.format(d);
		System.out.println(date);
		map.put("lastlog", date);

		return template.insert("users.addNewOne", map) == 1;
	}

	public int loginCheck(Map map) {
		Date d = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String date = dd.format(d);

		String id = (String) map.get("id");

		Map log = new HashMap<>();
		log.put("lastlog", date);
		log.put("id", id);
		int rst = template.update("users.lastlogUpdate", log);
		if (rst == 1) {
			Map users = template.selectOne("users.loginInfo", map.get("id"));
			if (users == null) {
				return 1;
			} else if (map.get("pass").equals(users.get("PASS"))) {
				return 0;
			} else {
				return 2;
			}
		} else {
			return 3;
		}
	}

	

	public Map mypageInfo(Map map) {

		Map myinfo = template.selectOne("users.loginInfo", map);
		return myinfo;
	}

	public Map banInfo(Map map) {
		Map ban = template.selectOne("users.banCnt", map);
		if (ban != null) {
			return ban;
		} else {
			return null;
		}
	}

	public int banOut(String id) {

		int out = template.update("users.banOut", id);

		return out;
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

	public int banUsers(String id) {

		return template.update("users.BanUsers", id);
	}

	public boolean updateAccount(Map map, MultipartFile photo) throws IOException {

		if (!photo.isEmpty()) {
			File savedir = new File(ctx.getRealPath("/photo"), (String) map.get("id"));
			if (!savedir.exists()) {
				savedir.mkdirs();
			}

			String filename = String.valueOf(map.get("id"));
			photo.transferTo(new File(savedir, filename));
			map.put("photo", filename);
		}
		return template.update("users.updateAccount", map) == 1;
	}

}

/*
 * package service;
 * 
 * import java.util.List; import java.util.Map;
 * 
 * import org.mybatis.spring.SqlSessionTemplate; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Service;
 * 
 * @Service public class UsersService {
 * 
 * @Autowired SqlSessionTemplate template;
 * 
 * 
 * public List<Map> selectAll () {
 * 
 * return template.selectList("users.select");
 * 
 * }
 * 
 * public List<Map> FoulUsers() {
 * 
 * return template.selectList("users.FoulUsers"); }
 * 
 * 
 * public int BanUsers(String id) {
 * 
 * return template.update("users.BanUsers", id); }
 * 
 * 
 * 
 * }
 */

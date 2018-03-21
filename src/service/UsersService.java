package service;

import java.io.File;
import java.io.IOException;
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
		return template.insert("users.addNewOne", map) == 1;
	}

	public int loginCheck(Map map) {
		Map users = template.selectOne("users.loginInfo", map.get("id"));
		if (users == null) {
			return 1;
		} else if (map.get("pass").equals(users.get("PASS"))) {
			return 0;
		} else {
			return 2;
		}
	}

	public Map mypageInfo(Map map) {
		Map myinfo = template.selectOne("users.loginInfo", map);
		return myinfo;
	}

	public Map readId(String id) {
		return template.selectOne("users.checkId", id);
	}

	public boolean updateAccount(Map map, MultipartFile photo) throws IOException {

		if(!photo.isEmpty()) {
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

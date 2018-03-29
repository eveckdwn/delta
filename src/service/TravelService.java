package service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelService {
	@Autowired
	SqlSessionTemplate template;
	
	public TravelService(SqlSessionTemplate template) {
		this.template = template;
	}

	public boolean addTravel(Map param) {
		return template.insert("travel.add", param) == 1;
	}
	
	public List readAllTravel() {
		return template.selectList("travel.readAll");
	}
	
	
	public List readSome(String sname) {
		return template.selectList("travel.readSome", sname);
	}

	public boolean updateTravel(Map param) {
		return template.update("travel.update", param) == 1;
	}

	public boolean deleteTravel(Map param) {
		return template.delete("travel.delete", param) == 1;
	}
	
	public List readAllC(String tname) {
		return template.selectList("travel.readAllC", tname);
	}
	
	public boolean addTcomments(Map param) {
		return template.insert("travel.addC", param) == 1;
	}
	
	public boolean updateTcomments(Map param) {
		return template.update("travel.updateC", param) == 1;
	}
	
	public boolean deleteTcomments(Map param) {
		return template.delete("travel.deleteC", param) == 1;
	}

}

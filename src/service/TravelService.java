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
	
	public Map readTravel(String id) {
		return template.selectOne("travel.readOne", id);
	}

	public boolean updateTravel(Map param) {
		return template.update("travel.update", param) == 1;
	}

	public boolean deleteTravel(Map param) {
		return template.delete("travel.delete", param) == 1;
	}

}

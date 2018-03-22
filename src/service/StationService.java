package service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StationService {
	@Autowired
	SqlSessionTemplate template;
	
	public StationService(SqlSessionTemplate template) {
		this.template = template;
	}

	public boolean addStation(Map param) {
		return template.insert("station.add", param) == 1;
	}
	
	public List readAllStation() {
		return template.selectList("station.readAll");
	}
	
	public Map readStation(String id) {
		return template.selectOne("station.readOne", id);
	}

	public boolean updateStation(Map param) {
		System.out.println(param);
		return template.update("station.update", param) == 1;
	}

	public boolean deleteStation(Map param) {
		return template.delete("station.delete", param) == 1;
	}

}

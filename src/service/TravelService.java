package service;

import java.math.BigDecimal;
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
	
	public Map readOne(String tname) {
		return template.selectOne("travel.readOne", tname);
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
	
	public List readAllC(BigDecimal trano) {
		return template.selectList("travel.readAllC", trano.intValue());
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
	
	public String getCommentWriter(Map param) {
		return template.selectOne("travel.getCommentWriter", param);
	}

}

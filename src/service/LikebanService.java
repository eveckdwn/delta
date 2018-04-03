package service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikebanService {
@Autowired 
SqlSessionTemplate template;
@Autowired
BoardService boardservice;
	
public LikebanService(SqlSessionTemplate template) {
	this.template = template;
}

	public boolean like (Map param) {
		
		return template.insert("likeboard.insert", param) == 1;
	}
	
	public List number (String likeid) {
		
		return template.selectList("likeboard.select", likeid);
	}
	
	
	public boolean report(Map param) {
		
		return template.insert("report.re" , param) == 1;
	}
}
 
package service;

import java.util.Enumeration;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import model.Board;

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
	
	public Map number (String likeid) {
		
		return template.selectOne("likeboard.select", likeid);
	}
	
	
	public boolean report(Map param) {
		
		return template.insert("report.re" , param) == 1;
	}
}
 
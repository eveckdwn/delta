package service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.mongodb.client.result.UpdateResult;

@Service
public class LikebanService {
	
	//	Oracle DB 처리
	@Autowired
	SqlSessionTemplate template;
	@Autowired
	BoardService boardservice;
	
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	MongoOperations mongoOperation;
	
	public LikebanService(SqlSessionTemplate template, MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
		mongoOperation = (MongoOperations) mongoTemplate;
		this.template = template;
	}
	
	public boolean like(Map param) {

		return template.insert("likeboard.insert", param) == 1;
	}

	public List number(String likeid) {

		return template.selectList("likeboard.select", likeid);
	}

	public boolean report(Map param) {
		
		return template.insert("report.re", param) == 1;
	}
	

	public boolean updateLike(Map param) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is((String) param.get("likeid")));
		Update update = new Update();
		int like = (int) param.get("like");
		update.set("like", String.valueOf(like));
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}

}

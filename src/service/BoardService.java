package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;

import model.Board;

@Service
public class BoardService {
	@Autowired
	MongoTemplate mongoTemplate;
	MongoOperations mongoOperation;
	
	Board board;
	
	public BoardService(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
		mongoOperation = (MongoOperations)mongoTemplate;
	}
	
	public List findAll() {
		//Query q = new Query();
		//q.addCriteria(new Criteria().where("name").is("루피"));
		//List hero = mongoOperation.find(q, Hero.class, "hero");	//	조건 검색
		List hero = mongoOperation.findAll(Board.class, "board");	//	전체 검색
		return hero;
	}
	
	public List find() {
		Query q = new Query();
		q.addCriteria(new Criteria().where("id"));
		List find = mongoOperation.find(q, Board.class, "board");
		
		return find;
	}
	
	
	public void insert(Map param) {
		board = new Board(param);
		mongoOperation.insert(board);
	}
	
	public boolean delete(String id) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is(id));
		DeleteResult ds = mongoOperation.remove(q, Board.class, "board");
		return ds.getDeletedCount() == 1;
	}
	
	public boolean update(Map param) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is((String)param.get("id")));
		Update update = new Update();
		update.set("title", (String)param.get("title"));
		update.set("content", (String)param.get("context"));
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}

}

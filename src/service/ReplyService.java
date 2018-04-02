package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.mongodb.client.result.DeleteResult;

import model.Board;
import model.Reply;

@Service
public class ReplyService {
	@Autowired
	MongoTemplate mongoTemplate;
	MongoOperations mongoOperation;
	
	
	Reply reply;
	
	public ReplyService(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
		mongoOperation = (MongoOperations)mongoTemplate;
	}
	
	public List findAll() {
		List find = mongoOperation.findAll(Reply.class, "reply");
		
		return find;
	}
	
	public List find(String code) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("code").is(code));
		List find = mongoOperation.find(q, Board.class, "reply");
		
		return find;
	}
	
	
	
	
	
	public void insert(Map pop) {
		reply = new Reply(pop);
		mongoOperation.insert(reply);
	}
	
	public boolean delete(String id) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is(id));
		DeleteResult ds = mongoOperation.remove(q, Reply.class, "reply");
		return ds.getDeletedCount() == 1;
	}
	
}

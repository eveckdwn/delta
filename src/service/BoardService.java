package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;

import model.Board;

@Service
public class BoardService {
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	MongoOperations mongoOperation;
	@Autowired
	ServletContext ctx;
	
	@Autowired
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
	
	public List find(String id) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is(id));
		List find = mongoOperation.find(q, Board.class, "board");
		
		return find;
	}
	
	

	public void insert(Map param, MultipartFile[] photos) throws IllegalStateException, IOException {
		System.out.println(photos.length);
		System.out.println(photos[0].isEmpty());
		System.out.println(param.get("writer"));
		System.out.println(ctx.getRealPath("/board"));
		if (!photos[0].isEmpty()) {
			File savedir = new File(ctx.getRealPath("/board"), (String)param.get("writer"));
			System.out.println(savedir);
			if (!savedir.exists()) {
				savedir.mkdirs();
			}
			List<String> list = new ArrayList<>();
			for (MultipartFile file : photos) {
				String time = String.valueOf(System.currentTimeMillis());
				String filename = time;
				file.transferTo(new File(savedir, filename));
				list.add(filename);
			}
			String[] p = list.toArray(new String[list.size()]);
			param.put("photos",p);
		}
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
		update.set("content", (String)param.get("content"));
		update.set("wdate", new Date());
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}

}

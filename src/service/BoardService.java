package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.mail.search.IntegerComparisonTerm;
import javax.servlet.ServletContext;

import org.bson.types.ObjectId;
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
	LikebanService likebanservice;
	
	Board board;

	public BoardService(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
		mongoOperation = (MongoOperations) mongoTemplate;
	}

	public List findAll() {
		// Query q = new Query();
		// q.addCriteria(new Criteria().where("menu").is("menu"));
		// List hero = mongoOperation.find(q, Board.class, "board"); // 조건 검색
		List hero = mongoOperation.findAll(Board.class, "board"); // 전체 검색

		return hero;
	}

	public Board find(String id) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is(id));
		Board find = mongoOperation.findOne(q, Board.class, "board");

		return find;
	}
	
	public List findTypeNotGeneral(String menu, String type) {
		//	공지, 이벤트 글 받아오기
		Query q = new Query();
		q.addCriteria(new Criteria().where("menu").is(menu).and("type").ne(type));
		List find = mongoOperation.find(q, Board.class, "board");

		return find;
	}
	
	public List findTypeGeneral(String menu, String type) {
		//	일반 글 받아오기
		Query q = new Query();
		q.addCriteria(new Criteria().where("menu").is(menu).and("type").is(type));
		List find = mongoOperation.find(q, Board.class, "board");
		
		return find;
	}
	
	public List Search(String menu,String mode, String value) {
		Query q = new Query();
		q.addCriteria(new Criteria().and("menu").is(menu).and(mode).regex(value));

		List find = mongoOperation.find(q, Board.class, "board");

		return find;
	}

	public void insert(Map param, MultipartFile[] photos) throws IllegalStateException, IOException {
		System.out.println(photos.length);
		System.out.println(photos[0].isEmpty());
		System.out.println(param.get("writer"));
		System.out.println(ctx.getRealPath("/board"));
		if (!photos[0].isEmpty()) {
			File savedir = new File(ctx.getRealPath("/board"), (String) param.get("writer"));
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
				try {
					Thread.sleep(10);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			String[] p = list.toArray(new String[list.size()]);
			param.put("photos", p);
		} else {
			String[] ph = new String[10];
			param.put("photos", ph);
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

	public boolean deletePhoto(String id, String photos) {
		Query q = new Query();
		System.out.println(id + " / " + photos);
		q.addCriteria(new Criteria().where("_id").is(id).and("photos").is(photos));
		List find = mongoOperation.find(q, Board.class, "board");
		Board board = (Board) find.get(0);
		String[] photo = board.getPhotos();

		ArrayList<String> p = new ArrayList<String>(Arrays.asList(photo));
		List<String> pp = new ArrayList<String>();
		pp.add(photos);

		p.removeAll(pp);

		String[] ph = p.toArray(new String[p.size()]);

		Update update = new Update();
		update.set("photos", ph);
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}

	public boolean update(Map param, MultipartFile[] photos) throws IllegalStateException, IOException {
		String[] p = null;
		UpdateResult us = null;
		List<String> list = new ArrayList();
		if (!photos[0].isEmpty()) {
			File savedir = new File(ctx.getRealPath("/board"), (String) param.get("writer"));
			System.out.println(savedir);
			if (!savedir.exists()) {
				savedir.mkdirs();
			}
			for (MultipartFile file : photos) {
				String time = String.valueOf(System.currentTimeMillis());
				String filename = time;
				file.transferTo(new File(savedir, filename));
				list.add(filename);
				try {
					Thread.sleep(10);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			Query q = new Query();
			System.out.println(param.toString());

			q.addCriteria(new Criteria().where("_id").is((String) param.get("id")));
			Update update = new Update();
			update.set("menu", (String) param.get("menu"));
			update.set("type", (String) param.get("type"));
			update.set("tab", (String) param.get("tab"));
			update.set("title", (String) param.get("title"));
			update.set("context", (String) param.get("context"));
			update.set("wdate", (String) param.get("wdate"));
			for(int i = 0; i < list.size(); i++) {
				update.push("photos", list.get(i));
				us = mongoOperation.updateFirst(q, update, "board");
			}
		}else {
			Query q = new Query();
			System.out.println(param.toString());

			q.addCriteria(new Criteria().where("_id").is((String) param.get("id")));
			Update update = new Update();
			update.set("menu", (String) param.get("menu"));
			update.set("type", (String) param.get("type"));
			update.set("tab", (String) param.get("tab"));
			update.set("title", (String) param.get("title"));
			update.set("context", (String) param.get("context"));
			update.set("wdate", (String) param.get("wdate"));
			us = mongoOperation.updateFirst(q, update, "board");
		}

		
		return us.getModifiedCount() == 1;
	}

	public boolean updateReadnum(Map param) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is((ObjectId)param.get("id")));
		Update update = new Update();
	//	System.out.println((String)param.get("readnum"));
		int read = Integer.parseInt((String)param.get("readnum")) + 1;
		update.set("readnum", String.valueOf(read));
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}
	
/*	public boolean updatelike(Map param, String likeid) {
		Query q = new Query();
		q.addCriteria(new Criteria().where("_id").is((ObjectId)param.get("id")));
		Update update = new Update();
		System.out.println(likebanservice.number(likeid));
		List like = likebanservice.number(likeid);
		update.set("like", Integer.valueOf);
		UpdateResult us = mongoOperation.updateFirst(q, update, "board");
		return us.getModifiedCount() == 1;
	}
*/	
	
	
	

}

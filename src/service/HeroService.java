package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import model.Hero;

@Service
public class HeroService {
	@Autowired
	MongoTemplate mongoTemplate;
	MongoOperations mongoOperation;
	
	Hero hero;
	
	public HeroService(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
		mongoOperation = (MongoOperations)mongoTemplate;
	}
	
	public List findAll() {
		//Query q = new Query();
		//q.addCriteria(new Criteria().where("name").is("루피"));
		//List hero = mongoOperation.find(q, Hero.class, "hero");	//	조건 검색
		List hero = mongoOperation.findAll(Hero.class, "hero");	//	전체 검색
		return hero;
	}
	
	public void insertOnd(Map param) {
		hero = new Hero(param);
		mongoOperation.save(hero);
	}

}

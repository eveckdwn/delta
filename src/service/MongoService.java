package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service
public class MongoService {
@Autowired
MongoTemplate mongoTemplate;




	public MongoService() {

		String mongoContextPath = "/WEB-INF/app-config";
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext(mongoContextPath);

		mongoTemplate = (MongoTemplate) ctx.getBean("mongoTemplate");

	}
}

package service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import vo.MongoVo;

@Service
public class MongoService {
@Autowired
MongoTemplate mongoTemplate;




	public MongoService() {

		String mongoContextPath = "/WEB-INF/app-config.xml";
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext(mongoContextPath);

		mongoTemplate = (MongoTemplate) ctx.getBean("mongoTemplate");

	}
	
	
	public  void insertTestdata() {
		MongoVo testVo = new MongoVo();
		
		Date today = new Date();
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat time = new SimpleDateFormat("hh:mm:ss a");
		
		testVo.setSeq(1);
		testVo.setWriter("Tester");
		testVo.setTitle("테스트한다.");
		testVo.setContext("되는가.");
		testVo.setReadnum(0);
		testVo.setLike(0);
		testVo.setWdate(date+"/"+time);
		
		
	}
	
}

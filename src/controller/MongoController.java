package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import vo.MongoVo;

@Controller
@RequestMapping("/tt")
public class MongoController {
@Autowired
MongoTemplate mongotemplate;
@Autowired
MongoVo mongovo;
	public String insert(Model model) {
		try {
			mongotemplate.insert(mongovo, "test1");
			
			return "/view/test";
		
		}catch(Exception e) {
			e.printStackTrace();
			return "/admin/fail";
		}
		
	}
}

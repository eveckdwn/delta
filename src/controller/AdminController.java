package controller;

import org.omg.CORBA.Request;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.support.RequestContext;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@RequestMapping(method=RequestMethod.GET)
	public String adminHandle() {
		return "admin_index";
	}
	
	@RequestMapping("/station")
	public String stationHandle() {
		return "";
	}
	
	@RequestMapping("/travel")
	public String travelHandle() {
		return "";
	}
	
	@RequestMapping("/user")
	public String userHandle() {
		return "";
	}

}

package controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import service.StationService;
import service.TravelService;

@Controller
@RequestMapping("/travel")
public class TravelController {
	@Autowired
	StationService stationService;
	
	@Autowired
	TravelService travelService;
	
	String[] mid = new String[5];
	
	
	@RequestMapping("/station")
	public String stationHandle(@RequestParam String page, Model model, HttpSession session) {
		List stations = stationService.readAllStation();
		
		int p = Integer.parseInt(page);		//	현재 페이지
		int split = stations.size() / 5;	//	전체 데이터 / 보여 줄 만큼의 양 = 페이지수 
		int remain = stations.size() % 5;	//	나머지 데이터
			session.setAttribute("all_page", split);
		if(p <= split) {
			model.addAttribute("station", stations.subList((p-1)*5, (p-1)*5+5));
			session.setAttribute("now_page", p);
		}else {
			model.addAttribute("station", stations.subList(split*5, split*5+remain));
			session.setAttribute("now_page", split);
		}
		
		return "service_travel";
	}
	
	@RequestMapping(path="/travel", produces="application/json")
	@ResponseBody
	public String travelHandle(@RequestParam String sname) {
		List travels = travelService.readSome(sname);
		Gson gson = new Gson();
		return gson.toJson(travels);
	}
	
	
	@RequestMapping("/detail")
	public String detailHandle() {
		
		return "service_travel_detail";
	}
}

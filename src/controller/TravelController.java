package controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

		int p = Integer.parseInt(page); // 현재 페이지
		int division = 5;	//	페이지당 보여줄 컨텐츠 수
		int split = stations.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
		int remain = stations.size() % division; // 나머지 데이터
		session.setAttribute("all_page", split);
		if (p < split) {
			model.addAttribute("station", stations.subList((p - 1) * division, (p - 1) * division + division));
			session.setAttribute("now_page", p);
		}else {
			model.addAttribute("station", stations.subList((split - 1) * division, (split - 1) * division + remain));
			session.setAttribute("now_page", split);
		}

		if (session.getAttribute("logon") == null) {
			return "service_travel_default";
		} else {
			return "service_travel_logons";
		}
	}

	@RequestMapping(path = "/travel", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String travelHandle(@RequestParam String sname) {
		List travels = travelService.readSome(sname);
		Gson gson = new Gson();
		return gson.toJson(travels);
	}

	@RequestMapping(path = "/detail", method = RequestMethod.GET)
	public String detailGetHandle(@RequestParam Map param, Model model, HttpSession session) {
		Map travel = travelService.readOne((String)param.get("tname"));
		List travelC = travelService.readAllC((BigDecimal)travel.get("TID"));
		model.addAttribute("travel", travel);
		model.addAttribute("travelC", travelC);
		model.addAttribute("commentSize", travelC.size());
		if(param.get("info") != null) {
			model.addAttribute("info", (String) param.get("info"));
		}
		
		if (session.getAttribute("logon") == null) {
			return "service_travel_detail_default";
		} else {
			return "service_travel_detail_logons";
		}
	}

	@RequestMapping(path = "/detail", method = RequestMethod.POST)
	public String detailPostHandle(@RequestParam Map param, Model model, HttpSession session) {
		if (travelService.addTcomments(param)) {
			model.addAttribute("info", "장소 평가를 성공적으로 마쳤습니다.");
		} else {
			model.addAttribute("info", "장소 평가에 실패했습니다.");
		}
		model.addAttribute("tname", param.get("tname"));

		return "redirect:/travel/detail";
	}
	
	@RequestMapping(path="/comment_update", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String commentUpdateHandle(@RequestParam Map param) {
		return new Gson().toJson(travelService.updateTcomments(param));
	}
	
	@RequestMapping(path="/comment_delete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String commentDeleteHandle(@RequestParam Map param) {
		return new Gson().toJson(travelService.deleteTcomments(param));
	}
}

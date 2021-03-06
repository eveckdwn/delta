package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.RequestContext;

import service.StationService;
import service.TravelService;
import service.UsersService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	UsersService usersService;

	@Autowired
	StationService stationService;

	@Autowired
	TravelService travelService;

	@RequestMapping(method = RequestMethod.GET)
	public String adminGetHandle(HttpSession session) {
		return "admin_index";
	}


	@RequestMapping(path = "/station_add", method = RequestMethod.GET)
	public String addstationGetHandle(HttpSession session) {
		return "admin_addstation";
	}

	@RequestMapping(path = "/station_add", method = RequestMethod.POST)
	public String addStationPostHandle(@RequestParam Map param, Model model) {
		if (stationService.addStation(param)) {
			model.addAttribute("info", "기차역 정보가 성공적으로 입력되었습니다.");
		} else {
			model.addAttribute("info", "기차역 정보가 입력하는데 실패했습니다.\n다음과 같은 상황이 반복될 경우, 개발자에게 문의해주세요.");
		}
		return "admin_addstation";
	}

	@RequestMapping("/station_manage")
	public String manageStationHandle(HttpSession session, Model model) {
		List station = stationService.readAllStation();
		model.addAttribute("station", station);
		return "admin_managestation";
	}

	@RequestMapping(path = "/station_update", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateStationHandle(@RequestParam Map param) {
		return String.valueOf(stationService.updateStation(param));
	}

	@RequestMapping(path = "/station_delete", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteStationHandle(@RequestParam Map param) {
		return String.valueOf(stationService.deleteStation(param));
	}

	@RequestMapping(path = "/travel_add", method = RequestMethod.GET)
	public String addTravelGetHandle(HttpSession session, Model model) {
		List station = stationService.readAllStation();
		model.addAttribute("station", station);
		return "admin_addtravel";
	}

	@RequestMapping(path = "/travel_add", method = RequestMethod.POST)
	public String addTravelPostHandle(@RequestParam Map param, Model model) {
		List station = stationService.readAllStation();
		model.addAttribute("station", station);

		if (travelService.addTravel(param)) {
			model.addAttribute("info", "여행지 정보가 성공적으로 입력되었습니다.");
		} else {
			model.addAttribute("info", "여행지 정보가 입력하는데 실패했습니다.\n다음과 같은 상황이 반복될 경우, 개발자에게 문의해주세요.");
		}
		return "admin_addtravel";
	}

	@RequestMapping("/travel_manage")
	public String manageTravelHandle(@RequestParam String page, HttpSession session, Model model) {
		List travel = travelService.readAllTravel();

		int p = Integer.parseInt(page); // 현재 페이지
		int split = travel.size() / 5; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
		int remain = travel.size() % 5; // 나머지 데이터
		session.setAttribute("all_page", split);
		if (p <= split) {
			model.addAttribute("travel", travel.subList((p - 1) * 5, (p - 1) * 5 + 5));
			session.setAttribute("now_page", p);
		} else {
			model.addAttribute("travel", travel.subList(split * 5, split * 5 + remain));
			session.setAttribute("now_page", split);
		}

		return "admin_managetravel";
	}

	@RequestMapping(path = "/travel_update", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateTravelHandel(@RequestParam Map param) {
		return String.valueOf(travelService.updateTravel(param));
	}

	@RequestMapping(path = "/travel_delete", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteTravel(@RequestParam Map param) {
		return String.valueOf(travelService.deleteTravel(param));
	}

	@RequestMapping("/users")
	public String selectAll(HttpSession session, Model model) {
		model.addAttribute("select", usersService.selectAll());
		model.addAttribute("foul", usersService.foulUsers());
		return "admin_users";
	}

	@RequestMapping(path = "/ban", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String BanUsers(@RequestParam String id) {
		return String.valueOf(usersService.banUsers(id));
	}

}

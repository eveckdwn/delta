package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.StationService;
import service.UsersService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	UsersService usersService;

	@Autowired
	StationService stationService;

	@RequestMapping(method = RequestMethod.GET)
	public String adminHandle() {
		return "admin_index";
	}

	@RequestMapping(path = "/station_add", method = RequestMethod.GET)
	public String addstationGetHandle() {
		return "admin_addstation";
	}

	@RequestMapping(path = "/station_add", method = RequestMethod.POST)
	public String addStationPostHandle(@RequestParam Map param, Model model) {
		if (stationService.addStation(param)) {
			model.addAttribute("info", "기차역정보가 성공적으로 입력되었습니다.");
		} else {
			model.addAttribute("info", "기차역정보가 입력하는데 실패했습니다.\n다음과 같은 상황이 반복될 경우, 개발자에게 문의해주세요.");
		}
		return "admin_addstation";
	}

	@RequestMapping("/station_manage")
	public String manageStationHandle(Model model) {
		List station = stationService.readAllStation();
		model.addAttribute("station", station);
		return "admin_managestation";
	}

	@RequestMapping(path = "/station_update", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateStation(@RequestParam Map param) {

		String rst = String.valueOf(stationService.updateStation(param));
		System.out.println(rst);
		return rst;
	}

	@RequestMapping(path = "/station_delete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteStation(@RequestParam Map param) {
		return String.valueOf(stationService.deleteStation(param));
	}

	@RequestMapping(path = "/travel_add", method = RequestMethod.GET)
	public String addTravelGetHandle() {
		return "admin_addtravel";
	}

	@RequestMapping(path = "/travel_add", method = RequestMethod.POST)
	public String addTravelPostHandle() {
		return "admin_addtravel";
	}

	@RequestMapping("/travel_manage")
	public String manageTravelHandle() {
		return "admin_managestation";
	}

	@RequestMapping("/users")
	public String selectAll(Model model) {

		model.addAttribute("select", usersService.selectAll());
		model.addAttribute("foul", usersService.foulUsers());
		return "admin_users";
	}

	@RequestMapping(path = "/ban", produces = "application/json")
	@ResponseBody
	public String BanUsers(@RequestParam String id) {

		return String.valueOf(usersService.banUsers(id));

	}

}

package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.BoardService;
import service.StationService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	StationService stationservice;

	@Autowired
	BoardService boardService;

	@RequestMapping("/main")
	public String Board01(@RequestParam String page, Model model, HttpSession session) {
		List board = boardService.findAll();

		int p = Integer.parseInt(page); // 현재 페이지
		int division = 10; // 페이지당 보여줄 컨텐츠 수
		int split = board.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
		int remain = board.size() % division; // 나머지 데이터
		
		model.addAttribute("division", division);

		session.setAttribute("all_page", split);
		if (p < split) {
			model.addAttribute("board", board.subList((p - 1) * division, (p - 1) * division + division));
			session.setAttribute("now_page", p);
		} else {
			model.addAttribute("board", board.subList((split - 1) * division, (split - 1) * division + remain));
			session.setAttribute("now_page", split);
		}

		if (session.getAttribute("logon") == null) {
			return "board_default";
		} else {
			return "board_logon";

		}

	}

	@RequestMapping(path = "/write", method = RequestMethod.GET)
	public String WriteGET(Model model, @RequestParam(required = false) String id, HttpSession session, HttpServletRequest request) {

		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("find", boardService.find(id));

		if (session.getAttribute("logon") == null) {
			return "write_default";
		} else {
			return "write_logon";

		}

	}

	@RequestMapping(path = "/write", method = RequestMethod.POST)
	public String WritePOST(@RequestParam(name="page") String page, @RequestParam Map param, Model model, String id, HttpSession session) {

		try {
			boardService.insert(param);

			List board = boardService.findAll();

			int p = Integer.parseInt(page); // 현재 페이지
			int division = 10; // 페이지당 보여줄 컨텐츠 수
			int split = board.size() / division == 0 ? 1 : board.size() / division; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
			int remain = board.size() % division; // 나머지 데이터

			model.addAttribute("division", division);

			session.setAttribute("all_page", split);
			if (split == 1) {
				if (remain == 0) {
					model.addAttribute("board", board.subList(0, division));
				} else {
					model.addAttribute("board", board.subList(0, remain));
				}
				session.setAttribute("now_page", p);
			} else if (p < split) {
				model.addAttribute("board", board.subList((p - 1) * division, (p - 1) * division + division));
				session.setAttribute("now_page", p);
			} else {
				model.addAttribute("board", board.subList(split * division, split * division + remain));
				session.setAttribute("now_page", split);
			}

			return "board_logon";

		} catch (Exception e) {

			e.printStackTrace();

			return "admin/fail";
		}

	}

	@RequestMapping("/read")
	public String Read(Model model, @RequestParam String id, HttpSession session) {

		model.addAttribute("read", boardService.find(id));

		if (session.getAttribute("logon") == null) {
			return "read_default";
		} else {
			return "read_logon";

		}
	}

	@RequestMapping("/change")
	public String Change(Model model, @RequestParam(required = false) String no) {
		// 이걸 no에 해당하는 데이터를 가지고 오고
		model.addAttribute("title", "aaaa");
		model.addAttribute("content", "dasdsadsadsad");

		return "/board/change";
	}

}


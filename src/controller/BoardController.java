package controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import service.BoardService;
import service.ReplyService;
import service.StationService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	StationService stationservice;

	@Autowired
	BoardService boardService;

	@Autowired
	ReplyService replyService;

	@RequestMapping(path = "/main", method = RequestMethod.GET)
	public String Board01(@RequestParam String page, Model model, HttpSession session, @RequestParam String menu) {

		model.addAttribute("menu", menu);

		List board = (List) boardService.findMenu(menu);

		int p = Integer.parseInt(page); // 현재 페이지
		int division = 10; // 페이지당 보여줄 컨텐츠 수
		int split = board.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
		int remain = board.size() % division; // 나머지 데이터

		switch (menu) {

		default:
			return "/admin/fail";

		case "1": {

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

		case "2": {

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

		case "3": {

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

		}

	}

	@RequestMapping(path = "/main", method = RequestMethod.POST)
	public String Search(Model model, HttpSession session, @RequestParam String menu, @RequestParam String mode,
			@RequestParam String value, @RequestParam String page) {

		int p = Integer.parseInt(page); // 현재 페이지
		model.addAttribute("menu", menu);
		model.addAttribute("page", p);
		switch (menu) {

		default:
			return "/admin/fail";

		case "1": {

			List board2 = (List) boardService.Search(menu, mode, value);

			int division = 10; // 페이지당 보여줄 컨텐츠 수
			int split = board2.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
			int remain = board2.size() % division; // 나머지 데이터

			model.addAttribute("division", division);
			session.setAttribute("all_page", split);
			if (p < split) {
				model.addAttribute("board", board2.subList((p - 1) * division, (p - 1) * division + division));
				session.setAttribute("now_page", p);
			} else {
				model.addAttribute("board", board2.subList((split - 1) * division, (split - 1) * division + remain));
				session.setAttribute("now_page", split);
			}

			if (session.getAttribute("logon") == null) {
				return "board_default";
			} else {
				return "board_logon";

			}

		}

		case "2": {

			List board2 = (List) boardService.Search(menu, mode, value);

			int division = 10; // 페이지당 보여줄 컨텐츠 수
			int split = board2.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
			int remain = board2.size() % division; // 나머지 데이터

			model.addAttribute("division", division);
			session.setAttribute("all_page", split);
			if (p < split) {
				model.addAttribute("board", board2.subList((p - 1) * division, (p - 1) * division + division));
				session.setAttribute("now_page", p);
			} else {
				model.addAttribute("board", board2.subList((split - 1) * division, (split - 1) * division + remain));
				session.setAttribute("now_page", split);
			}

			if (session.getAttribute("logon") == null) {
				return "board_default";
			} else {
				return "board_logon";

			}

		}

		case "3": {

			List board2 = (List) boardService.Search(menu, mode, value);

			int division = 10; // 페이지당 보여줄 컨텐츠 수
			int split = board2.size() / division + 1; // 전체 데이터 / 보여 줄 만큼의 양 = 페이지수
			int remain = board2.size() % division; // 나머지 데이터

			model.addAttribute("division", division);
			session.setAttribute("all_page", split);
			if (p < split) {
				model.addAttribute("board", board2.subList((p - 1) * division, (p - 1) * division + division));
				session.setAttribute("now_page", p);
			} else {
				model.addAttribute("board", board2.subList((split - 1) * division, (split - 1) * division + remain));
				session.setAttribute("now_page", split);
			}

			if (session.getAttribute("logon") == null) {
				return "board_default";
			} else {
				return "board_logon";

			}

		}

		}

	}

	@RequestMapping(path = "/write", method = RequestMethod.GET)
	public String WriteGET(Model model, HttpSession session, HttpServletRequest request, @RequestParam String menu) {

		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("findAll", boardService.findAll());

		model.addAttribute("menu", menu);
		if (session.getAttribute("logon") == null) {
			return "write_default";
		} else {
			return "write_logon";

		}

	}

	@RequestMapping(path = "/write", method = RequestMethod.POST)
	public String WritePOST(@RequestParam(name = "photos") MultipartFile[] photos, @RequestParam Map param, Model model,
			String id, HttpSession session) {
		try {
			boardService.insert(param, photos);
			model.addAttribute("succ", "글이 작성되었습니다.");
			model.addAttribute("menu", param.get("menu"));
			model.addAttribute("page", 1);
			return "redirect:/board/main";
		} catch (Exception e) {
			model.addAttribute("err", "글 작석이 실패하였습니다.");
			e.printStackTrace();
			return "board_logon";
		}
	}

	@RequestMapping(path = "/read", method = RequestMethod.GET)
	public String ReadGET(Model model, @RequestParam String id, HttpSession session, @RequestParam Map param,
			@RequestParam String code) {

		try {
			//	System.out.println(code);

			//	TODO : 조회스 증가
			
			model.addAttribute("read", boardService.find(id));
			model.addAttribute("length", replyService.find(code).size());
			model.addAttribute("reply", replyService.find(code));
			if (session.getAttribute("logon") == null) {
				return "read_default";
			} else {
				return "read_logon";

			}
		} catch (Exception e) {
			e.printStackTrace();

			return "admin/fail";
		}

	}

	@RequestMapping(path = "/read", method = RequestMethod.POST)
	public String ReadPOST(Model model, HttpSession session, @RequestParam Map pop) {
		System.out.println(pop);
		try {
			replyService.insert(pop);
			model.addAttribute("id", (String) pop.get("id"));
			model.addAttribute("code", (String) pop.get("code"));
			return "redirect:/board/read";

		} catch (Exception e) {
			e.printStackTrace();

			return "admin/fail";
		}

	}

	@RequestMapping("/change")
	public String Change(Model model, @RequestParam(required = false) String no) {
		// 이걸 no에 해당하는 데이터를 가지고 오고
		model.addAttribute("title", "aaaa");
		model.addAttribute("content", "dasdsadsadsad");

		return "/board/change";
	}

	@RequestMapping(path = "/boardDel", method =RequestMethod.GET)
	public String Delete(@RequestParam String id, @RequestParam String menu, Model model,HttpSession session) {
		System.out.println(id);
		boolean rst = boardService.delete(id);

		if (rst) {
			model.addAttribute("find",boardService.findAll());
			model.addAttribute("succ", "게시물이 삭제 되었습니다.");
			model.addAttribute("menu", menu);
			model.addAttribute("page", 1);
			return "redirect:/board/main";
		} else {
			model.addAttribute("read",boardService.find(id));
			return "read_logon";
		}

	}
	
	@RequestMapping(path="/Bedit", method=RequestMethod.GET)
	public String GetEdit(@RequestParam String id, Model model) {
		
		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("read", boardService.find(id));
		
		return "board_edit";
	}
	
	@RequestMapping(path="/Bedit", method=RequestMethod.POST)
	public String PostEdit(@RequestParam Map map,@RequestParam(name="photos") MultipartFile[] photos, Model model) throws IllegalStateException, IOException {
		System.out.println(map.toString());
		boolean rst = boardService.update(map,photos);
		if(rst) {
			model.addAttribute("menu", map.get("menu"));
			model.addAttribute("page", 1);
			return "redirect:/board/main";
		}else {
			model.addAttribute("menu", map.get("menu"));
			model.addAttribute("page", 1);
			return "err";
		}
	}
	
	@RequestMapping(path="/podel",  produces = "application/json", method=RequestMethod.POST)
	@ResponseBody
	public String photoDel(@RequestParam String photos, @RequestParam String id) {
		boolean rst = boardService.deletePhoto(id,photos);
		return String.valueOf(rst);
	}

}

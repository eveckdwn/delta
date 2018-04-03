package controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import model.Board;
import service.BoardService;
import service.LikebanService;
import service.ReplyService;
import service.StationService;
import service.UsersService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	StationService stationservice;

	@Autowired
	BoardService boardService;

	@Autowired
	ReplyService replyService;
	@Autowired
	LikebanService likebanService;
	@Autowired
	UsersService userservice;

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
			model.addAttribute("page", 1);
			model.addAttribute("menu", param.get("menu"));
			return "redirect:/board/main";
		} catch (Exception e) {
			model.addAttribute("err", "글 작석이 실패하였습니다.");
			e.printStackTrace();
			return "board_logon";
		}
	}

	@RequestMapping(path = "/read", method = RequestMethod.GET)
	public String ReadGET(Model model, @RequestParam(name="id") String id,
			HttpSession session, @RequestParam(name="code") String code, @RequestParam String likeid) {

		
		model.addAttribute("read", boardService.find(id));
		model.addAttribute("length", replyService.find(code).size());
		model.addAttribute("reply", replyService.find(code));
		try {
			Board data = (Board) boardService.find(id);
			Map map = new HashMap<>();
			map.put("id", data.getId());
			map.put("readnum", data.getReadnum());
			
			boardService.updateReadnum(map);
			
			// System.out.println(code);

			// TODO : 조회수 증가
			/*
			 * 1. likebanService에서 insert (seq_adjfasklfj.nextval(),내 아이디, 게시글 ObjectId)
			 * 2. likebanService.number(likeid)를 몽고에 업데이트
			 * 3. query key : id, value : 게시글 아이디 ==> 좋아요 수 update하기
			 * 4. model.addAttribute();	//	이 게시글 읽기 위한 정보 보내주기
			 * 5. return "redirect:/board/read"   
			 */
			
			/*Map pop = new HashMap<>();
			pop.put("id", data.getId());
			pop.put("like", data.getLike());
			
			boardService.updatelike(pop, likeid);*/
			
			
			
			
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
		// System.out.println(pop);
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

	@RequestMapping(path = "/like", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String likeHandle(@RequestParam Map param) {

		return new Gson().toJson(likebanService.like(param));
	}

	@RequestMapping(path = "/report", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String report(@RequestParam Map param, Model model) {
		try {

			boolean declare = likebanService.report(param);

			// TODO : 신고했으면 유저의 foul 1 증가시키기
			
			
			return new Gson().toJson(declare);
		} catch (Exception e) {

			return new Gson().toJson(false);
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

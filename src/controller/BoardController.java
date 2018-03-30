package controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String Board01(Model model, HttpSession session) {

		model.addAttribute("find", boardService.findAll());

		if (session.getAttribute("logon") == null) {
			return "board_default";
		} else {
			return "board_logon";

		}

	}

	@RequestMapping("/write")
	public String WriteGET(Model model, @RequestParam(required = false) String id, HttpSession session) {

		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("find", boardService.find(id));

		if (session.getAttribute("logon") == null) {
			return "write_default";
		} else {
			return "write_logon";

		}

	}

	@RequestMapping("/result")
	public String Result(@RequestParam Map param, @RequestParam(name = "photos") MultipartFile[] photos, Model model,
			String id, HttpSession session) {

		System.out.println(param);
		System.out.println(photos.length);

		try {
			boardService.insert(param, photos);

			model.addAttribute("find", boardService.find(id));

			return "result";

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

	@RequestMapping(path = "/boardDel", method = RequestMethod.POST)
	public String Delete(@RequestParam String id, Model model, HttpSession session) {

		System.out.println(id);
		boolean rst = boardService.delete(id);

		if (rst) {
			model.addAttribute("find", boardService.findAll());
			model.addAttribute("suc", "게시물이 삭제 되었습니다.");
			return "board_logon";
		} else {
			model.addAttribute("read", boardService.find(id));
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

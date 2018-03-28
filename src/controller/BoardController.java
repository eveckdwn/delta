package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/board_list")
	public String BoardHandle(Model model) {
		model.addAttribute("board", boardService.findAll());
		return "test";
	}

	@RequestMapping("/main")
	public String Board01() {

		return "/board/main";

	}

	@RequestMapping("/write")
	public String Write() {

		return "/board/write";
	}

	@RequestMapping("/insert")
	public String Insert(Model model, @RequestParam String title, @RequestParam String content) {

		model.addAttribute("title", title);
		model.addAttribute("content", content);

		return "/board/insert";
	}

	@RequestMapping("/change")
	public String Change(Model model, @RequestParam(required = false) String no) {
		// 이걸 no에 해당하는 데이터를 가지고 오고
		model.addAttribute("title", "aaaa");
		model.addAttribute("content", "dasdsadsadsad");

		return "/board/change";
	}

}

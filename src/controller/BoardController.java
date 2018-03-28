package controller;

import java.util.HashMap;
import java.util.Map;

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


	@RequestMapping("/main")
	public String Board01() {

		return "/board/main";

	}

	@RequestMapping("/write")
	public String Write(@RequestParam Map param, Model model) {
		
		try {
			
			boardService.insert(param);
			
			return "/board/write";
		
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		
		
		
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

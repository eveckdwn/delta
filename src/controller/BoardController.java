package controller;

import java.io.WriteAbortedException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
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
	public String Board01(Model model) {

		model.addAttribute("find", boardService.findAll());

		return "/board/main";

	}

	@RequestMapping("/write")
	public String WriteGET(Model model) {

		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("read", boardService.find());

		return "/board/write";

	}

	@RequestMapping("/result")
	public String Result(@RequestParam Map param) {

		System.out.println(param);

		try {
			boardService.insert(param);

			return "/board/result";
		} catch (Exception e) {

			e.printStackTrace();

			return "admin/fail";
		}

	}
	@RequestMapping("/read")
	public String Read(Model model, @RequestParam Map param) {
		
		model.addAttribute("find", boardService.findAll());
		
		return "/board/read";
	}

	@RequestMapping("/change")
	public String Change(Model model, @RequestParam(required = false) String no) {
		// 이걸 no에 해당하는 데이터를 가지고 오고
		model.addAttribute("title", "aaaa");
		model.addAttribute("content", "dasdsadsadsad");

		return "/board/change";
	}

}

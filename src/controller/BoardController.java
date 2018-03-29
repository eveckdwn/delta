package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@RequestMapping(path="/main", method=RequestMethod.GET)
	public String Board01(Model model, HttpSession session) {

		model.addAttribute("find", boardService.findAll());
		
		if(session.getAttribute("logon") == null) {
			return "board_default";
		}else {
			return "board_logon";
			
		}


	}
	@RequestMapping(path="/main", method=RequestMethod.POST)
	public String Search(Model model, HttpSession session, @RequestParam String mode, @RequestParam String value ) {
		
		List board = boardService.Search(mode, value);
		model.addAttribute("find", board);
			
		if(session.getAttribute("logon") == null) {
			return "board_default";
		}else {
			return "board_logon";
			
		}
		
	}

	@RequestMapping("/write")
	public String WriteGET(Model model, @RequestParam(required=false) String id, HttpSession session) {

		model.addAttribute("station", stationservice.readAllStation());
		model.addAttribute("find", boardService.find(id));
		
		if(session.getAttribute("logon") == null) {
			return "write_default";
		}else {
			return "write_logon";
			
		}

	}

	@RequestMapping("/result")
	public String Result(@RequestParam Map param, Model model, String id, HttpSession session) {

		System.out.println(param);
		
		try {
			boardService.insert(param);
			
			model.addAttribute("find", boardService.find(id));
			
			return "result";

		} catch (Exception e) {

			e.printStackTrace();

			return "admin/fail";
		}

	}
	
	@RequestMapping(path="/read", method=RequestMethod.GET)
	public String ReadGET(Model model, @RequestParam String id, HttpSession session , @RequestParam Map param) {

		
		try {
			
			
			
			model.addAttribute("read", boardService.find(id));
			
			if(session.getAttribute("logon") == null) {
				return "read_default";
			}else {
				return "read_logon";
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			
			return "admin/fail";
		}
		
	}
	@RequestMapping(path="/read", method=RequestMethod.POST)
	public String ReadPOST(Model model, @RequestParam String id, HttpSession session , @RequestParam Map param) {
		
		
		try {
			
			replyService.insert(param);
			
			
			model.addAttribute("read", boardService.find(id));
			
			if(session.getAttribute("logon") == null) {
				return "read_default";
			}else {
				return "read_logon";
				
			}
		}catch(Exception e) {
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

}

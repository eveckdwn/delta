package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.HeroService;

@Controller
public class HeroController {
	@Autowired
	HeroService heroService;
	
	@RequestMapping("/hero")
	public String HeroHandle(Model model) {
		model.addAttribute("hero", heroService.findAll());
		return "test";
	}

}

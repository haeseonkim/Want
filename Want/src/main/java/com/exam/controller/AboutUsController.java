package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AboutUsController {
	
	// about us
	@RequestMapping(value = "/aboutUs.do")
	public String aboutUs(Model model) {
		return "aboutUs";
	}
	

}

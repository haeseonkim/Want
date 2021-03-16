package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class MyController {
	
	@RequestMapping(value = "/my_list.do")
	public String my_list(Model model) {
		return "my/my_list";
	}

}
